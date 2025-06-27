FROM ubuntu:24.04

# Base system packages
RUN apt update && apt install -y \
    curl wget git build-essential unzip \
    libgmp-dev m4 sudo zlib1g-dev \
    python3.12 python3-pip \
    openjdk-8-jdk openjdk-17-jdk maven \
    vim autoconf pkg-config rsync \
    libsqlite3-dev libmpfr-dev sqlite3 subversion

# Use bash shell
SHELL ["/bin/bash", "-c"]

# Install OPAM 2.0.9 manually
RUN wget https://github.com/ocaml/opam/releases/download/2.0.9/opam-2.0.9-x86_64-linux \
    -O /usr/local/bin/opam && chmod +x /usr/local/bin/opam

# Setup OPAM + OCaml 4.11.1 + packages
RUN opam init -y --disable-sandboxing && \
    opam switch create ocaml-variants.4.11.1+flambda && \
    echo "eval \$(opam env)" >> /root/.bashrc && \
    eval "$(opam env)" && \
    opam update && \
    # mtime-1.2.0
    cd /tmp && \
    wget https://erratique.ch/software/mtime/releases/mtime-1.2.0.tbz && \
    tar -xf mtime-1.2.0.tbz && \
    opam pin add mtime ./mtime-1.2.0 -n && \
    opam pin add core v0.14.0 -y && \
    opam pin add atd 2.2.1 -y && \
    opam pin add ocamlgraph 1.8.8 -y && \
    opam pin add sawja 1.5.8 -y && \
    opam install -y fmt mtime core atd ocamlgraph sawja

# Env
ENV INFER_HOME="/app/analyzer"
ENV D4J_HOME="/app/d4j-2.0"
ENV D4J_MOD_HOME="/app/d4j-1.3-mod"
ENV PATH="/usr/lib/jvm/java-8-openjdk-amd64/bin:$D4J_HOME/framework/bin:$D4J_HOME:$PATH"

# Setup workdir
WORKDIR /app

# Copy requirements first for pip cache optimization
COPY requirements.txt /app/
RUN pip3 install --break-system-packages --no-cache-dir -r /app/requirements.txt

# Copy all other code
COPY . /app

# Install cpanm & D4J
RUN curl -L https://cpanmin.us | perl - --self-upgrade && \
    git clone --branch v2.0.0 https://github.com/rjust/defects4j.git d4j-2.0 && \
    git clone --branch v1.3.0 https://github.com/rjust/defects4j.git d4j-1.3-mod && \
    cp -arf /app/experiment/tools/PatchSim/tool/defects4j-mod/framework /app/d4j-1.3-mod && \
    cd /app/d4j-1.3-mod && cpanm --installdeps . && ./init.sh && \
    cd /app/d4j-2.0 && cpanm --installdeps . && ./init.sh


CMD ["/bin/bash"]
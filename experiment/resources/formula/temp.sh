for dir in */; do
  find "$dir" -type f -name "formula_prism_*.pkl" | while read file; do
    new_file="${file/prism/sem}"
    mv "$file" "$new_file"
  done
done

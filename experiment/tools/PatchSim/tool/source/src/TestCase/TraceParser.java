package TestCase;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.wickedsource.diffparser.api.DiffParser;
import org.wickedsource.diffparser.api.UnifiedDiffParser;
import org.wickedsource.diffparser.api.model.Diff;
import org.wickedsource.diffparser.api.model.Hunk;
import org.wickedsource.diffparser.api.model.Line;


import DefectRepairing.jPickle;
public class TraceParser {
	
	public static int diff(ArrayList<Integer>spec1,ArrayList<Integer>spec2){
		int difftype = 1;
                Iterator<Integer> it1 = spec1.iterator(), it2 = spec2.iterator();
                int f[][]= new int[2][spec2.size()+1];
		int min = spec2.size() < spec1.size() ? spec2.size() : spec1.size();
		for (int i = 1; it1.hasNext(); i++) {
			Integer l1 = it1.next();
			it2=spec2.iterator();
			for (int j = 1; it2.hasNext(); j++) {
				Integer l2 = it2.next();
                                boolean isEqual;
                                if (l1 == null && l2 == null) {
                                        isEqual = true;
                                } else if (l1 == null || l2 == null) {
                                        isEqual = false;
                                } else {
                                        isEqual = (l1.compareTo(l2) == 0);
                                }
				if (isEqual) {
					f[i%2][j] = f[(i - 1)%2][j - 1] + 1;
				} else if (f[(i - 1)%2][j] <= f[i%2][j - 1]) {// 优先让spec2失配
					f[i%2][j] = f[i%2][j - 1];
				} else {
					f[i%2][j] = f[(i - 1)%2][j];
				}
			}
		}
		return f[spec1.size()%2][spec2.size()];
	}
	
	public static ArrayList<Integer> form(BufferedReader reader) throws IOException{
		ArrayList<Integer> spec = new ArrayList<Integer>();
		for (String line = reader.readLine(); line != null; line = reader.readLine()) {
			line=line.trim();
			if(line.startsWith("---")){
				line=line.split(":")[1];
				spec.add(Integer.valueOf(line));
			}
		}
		return spec;
	}
	
	public static ArrayList<Integer> form(BufferedReader reader, Map<Integer, Integer> LNMap) throws IOException{
		ArrayList<Integer> spec = new ArrayList<Integer>();
		for (String line = reader.readLine(); line != null; line = reader.readLine()) {
			line=line.trim();
			if(line.startsWith("---")){
				line=line.split(":")[1];
				spec.add(LNMap.get(Integer.valueOf(line)));
			}
		}
		return spec;
	}
	
	public static Map<Integer, Integer> getLineMap(int alllines, String filepath) {
		DiffParser parser = new UnifiedDiffParser();
		InputStream in = null;
		try {
			in = new FileInputStream(filepath);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
		List<Diff> diff = parser.parse(in);
		Diff d = diff.get(0);
		Map<Integer, Integer> lnmap = new HashMap<Integer, Integer>();
		List<Hunk> hunks = d.getHunks();
		int fromp = -1, top = -1;
		for (Iterator<Hunk> it = hunks.iterator(); it.hasNext();) {
			Hunk h = it.next();
			List<Line> lines = h.getLines();
			Iterator<Line> lit = lines.iterator();

			if (fromp != -1) {
				while (fromp < h.getFromFileRange().getLineStart() - 1) {
					lnmap.put(++top, ++fromp);
				}
			} else {
				fromp = h.getFromFileRange().getLineStart() - 1;
				top = h.getToFileRange().getLineStart() - 1;
			}
			while (lit.hasNext()) {
				Line l = lit.next();
				switch (l.getLineType()) {
				case FROM:
					fromp++;
					break;
				case TO:
					lnmap.put(++top, -1);
					break;
				case NEUTRAL:
					lnmap.put(++top, ++fromp);
					break;
				}
			}
		}
		while (top < alllines) {
			lnmap.put(++top, ++fromp);
		}
		for(int i=1;i<=alllines;i++)
		{
			if(!lnmap.containsKey(i)){
				lnmap.put(i, i);
			}
			
		}
		return lnmap;
	}

	
	public static void getFilelist(String DirPath, List<String> FileList) {
		File RootDir = new File(DirPath);
		File[] files = RootDir.listFiles();
                
		for (File f : files) {
			if (f.isDirectory()) {
				getFilelist(f.getAbsolutePath(), FileList);
			} else {
				if (true)
					FileList.add(f.getAbsolutePath());
			}
		}
	}
	public static String[] split(String s){
		String[] s_a=null;
		if(s.contains("::"))
			s_a=s.split("::");
		else if(s.contains(":"))
			s_a=s.split(":");
		else if(s.contains("__"))
			s_a=s.split("__");
		return s_a;
	}
	
	public static boolean in_list(List<String>l,String s){
		String[] s_a=split(s);
		
		for(String s0:l){
			String[] s0_a=split(s0);
			if(s_a[0].equals(s0_a[0])&&s_a[1].equals(s0_a[1])){
				return true;
			}
		}
		
		return false;
	}
	
	public static void main(String args[]) throws FileNotFoundException, IOException {
                String[] splitArray = args[0].split(",");
                
                List<String> failing_tests = new ArrayList<>();
                for (String test : splitArray) {
                failing_tests.add(test);
                }
		String tracedir=args[1];
                String patch_path=args[2];
                String out_dir=args[3];
		run(failing_tests, tracedir, patch_path, out_dir);
	}
	
	public static void run(List<String> failing_tests, String tracedir, String patch_path, String out_dir) throws FileNotFoundException, IOException{
                List<String>l_buggy=new ArrayList<String>();
                List<String>l_patched=new ArrayList<String>();
                String tracedir_buggy=new File(tracedir, "buggy_e").toString();
                String tracedir_patched=new File(tracedir, "patched_e").toString();
                getFilelist(tracedir_buggy,l_buggy);
                getFilelist(tracedir_patched,l_patched);
                
                //Match traces of tests in both patched and buggy version
                List<String>l=new ArrayList<String>();
                for(String s:l_buggy){
                        String[] a=s.split("/");
                        String testname=a[a.length-1];
                        for(String s1:l_patched){
                                if(s1.endsWith(testname)){
                                        
                                        l.add(testname);
                                        break;
                                }
                        }
                        
                }
                
                int len=l.size();
                double[][] dis=new double[len][len];
                String[] dict=new String[len];//index to string
                Set<Integer> pass=new TreeSet<Integer>();
                Set<Integer> gen=new TreeSet<Integer>();
                Set<Integer> fail=new TreeSet<Integer>();
                int index=0;
                for(String s:l){
                        dict[index]=s;
                        if(s.startsWith("Randoop")){
                                gen.add(index);
                        }
                        else if(in_list(failing_tests,s)){
                                fail.add(index);
                        }
                        else {
                                pass.add(index);
                        }
                        index++;
                }
                
                List<Integer>remove_list=new ArrayList<Integer>();
                ArrayList[] SpecArray_buggy=new ArrayList[len];
                ArrayList[] SpecArray_patched=new ArrayList[len];
                
                for(int i=0;i<len;i++) {
                        
                        String TraceFile=new File(tracedir_buggy, dict[i]).toString();
                        
                        try {
                                SpecArray_buggy[i]=form(new BufferedReader(new FileReader(TraceFile)));
                        } catch (Exception e) {
                                e.printStackTrace();
                                remove_list.add(i);
                                continue;
                        }
                        
                        Map<Integer, Integer> LNMap = getLineMap(3000,new File(patch_path).toString());
                        
                        
                        TraceFile=new File(tracedir_patched, dict[i]).toString();
                        
                        try {
                                SpecArray_patched[i]=form(new BufferedReader(new FileReader(TraceFile)),LNMap);
                        } catch (Exception e) {
                                e.printStackTrace();
                                remove_list.add(i);
                                continue;
                        }
                }
                for(int i=0;i<len;i++){
                        for(int j=0;j<len;j++){
                                if(i==j){
                                        dis[i][j]=0.0;
                                        continue;
                                }
                                        
                                double Length=Math.max(SpecArray_buggy[i].size(),SpecArray_buggy[j].size());
                                if(Length==0){
                                        dis[i][j]=1;
                                        continue;
                                }
                                double LCS;
                                if(SpecArray_buggy[i].size()*SpecArray_buggy[j].size()>2147483647){
                                        remove_list.add(i);
                                        continue;
                                }
                                try{
                                        LCS=diff(SpecArray_buggy[i],SpecArray_buggy[j]);
                                } catch(Exception e){
                                        e.printStackTrace();
                                        remove_list.add(i);
                                        continue;
                                }
                                dis[i][j]=1-LCS/Length;
                                                
                        }
                }
                
                //System.out.println(4+" "+remove_list);
                //System.out.println(remove_list);
                double length_array[]=new double[len];
                double LCS_array[]=new double[len];
                double[] dis_2=new double[len];
                for(int i=0;i<len;i++){
                        if(remove_list.contains(i)){
                                continue;
                        }
                        ArrayList<Integer> spec1=null;
                        String TraceFile=new File(new File(tracedir, "buggy").toString(), dict[i]).toString();
                        //System.out.println(TraceFile);
                        try{
                                spec1=form(new BufferedReader(new FileReader(TraceFile)));
                        } catch(Exception e){
                                e.printStackTrace();
                                System.out.println(i);
                                System.out.println(TraceFile);
                                remove_list.add(i);
                                continue;
                        }
                        
                        
                        ArrayList<Integer> spec2=null;
                        TraceFile=new File(new File(tracedir, "patched").toString(), dict[i]).toString();
                        try{
                                spec2=form(new BufferedReader(new FileReader(TraceFile)),getLineMap(3000,new File(patch_path).toString()));
                        } catch(Exception e){
                                e.printStackTrace();
                                
                                remove_list.add(i);
                                continue;
                        }
                        if((double)spec1.size()*(double)spec2.size()>5e9 && ! (fail.contains(i) && fail.size()==1)){
                                remove_list.add(i);
                                continue;
                        }
                        double Length=Math.max(spec1.size(),spec2.size());
                        double LCS=diff(spec1,spec2);
                        dis_2[i]=1-LCS/Length;
                        length_array[i]=Length;
                        LCS_array[i]=LCS;
                }
                
                for (Integer j:remove_list){
                        if(pass.contains(j))
                                pass.remove(j);
                        if(fail.contains(j))
                                fail.remove(j);
                        if(gen.contains(j))
                                gen.remove(j);
                }
              jPickle.dump(pass, out_dir+"/pass");
              jPickle.dump(fail, out_dir+"/fail");
              jPickle.dump(gen, out_dir+"/gen");
              jPickle.dump(dis, out_dir+"/dis");
              jPickle.dump(dis_2, out_dir+"/dis_2");
              jPickle.dump(dict, out_dir+"/dict");
              jPickle.dump(length_array, out_dir+"/Length_array");
              jPickle.dump(LCS_array, out_dir+"/LCS_array");  
                
                double dis_pass=0,dis_fail=0,w_pass=0,w_fail=0;
                if(pass.size()!=0&&fail.size()!=0){
                        for(int i:pass){
                                dis_pass+=dis_2[i];
                                w_pass+=1;
                        }
                        for(int i:fail){
                                dis_fail+=dis_2[i]/fail.size();
                                w_fail+=1;
                        }
                        if(gen.size()!=0){
                                for(int i:gen){
                                        double dis_p=1,dis_f=1;
                                        for(int j:pass){
                                                if(dis_2[j]<dis_p)
                                                        dis_p=dis[i][j];
                                        }
                                        for(int j:fail){
                                                if(dis_2[j]<dis_f)
                                                        dis_f=dis[i][j];
                                        }
                                        if(dis_p<dis_f){
                                                //pass
                                                dis_pass+=dis_2[i]*(1-dis_p);
                                                w_pass+=1-dis_p;
                                        } else {
                                                //fail
                                                dis_fail+=dis_2[i]*(1-dis_f);
                                                w_fail+=1-dis_f;
                                        }
                                }
                        }
                }
                
                dis_pass=dis_pass/w_pass;
                dis_fail=dis_fail/w_fail;
                
                if(dis_pass>dis_fail){
                        System.out.println("Incorrect");
                } else System.out.println("Correct");
                System.out.printf("%.4f %.4f\n",dis_pass,dis_fail);
        }
        
}


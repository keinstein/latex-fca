program cxt2csc;
type
   name = string[80];
var
   infile,outfile : text;
   ifname,zeile	  : name;
   gnum,mnum,i	  : integer;
   gnam		  : array[1..20] of name;
   eol		  : char;

procedure write_info;
begin
   writeln;
   writeln;
   writeln('About this program:');
   writeln;
   writeln('  cxt2fca converts Conimps .cxt format to LaTeX fca.sty.');
   writeln('  Conimp is a program for Formal Concept Analysis.');
   writeln('  fca.sty is a style file for the LaTex typesetting system.');
   writeln('  fca.sty is freely available from the author of this program.');
   writeln;
   writeln('  This is version 1, written by B. Ganter, TU Dresden, Feb 2004.');
   writeln('  Invoke with >> cxt2fca filename <<. The output is filename.tex');
   writeln('  ');
   writeln('  Bug reports to ganter@math.tu-dresden.de.');
   writeln('  The latest version can be found on');
   writeln('  www.math.tu-dresden.de/~ganter.');
   writeln;
end; { write_info }

function open_files : boolean;
var ii	 : integer;
   zeile : name;
begin
   if ParamCount =0 then
   begin
      writeln('This is cxt2fca version 1.0. ');
      write('Type a name of a .cxt-file or --help for information: ');
      readln(ifname);
   end else
      ifname:=ParamStr(1);
   if ifname = '--help' then
   begin
      write_info;
      open_files:=false;
   end else
   begin
      open_files := true;
      ii:= 1;
      while (ii<= length(ifname)) and (ifname[ii]<>'.') do ii:=succ(ii);
      if ii <= length(ifname) then
	 {ReadStr(ifname[1..pred(ii)],ifname);}
	 ifname:=Copy(ifname,1,pred(ii));
      assign(infile,ifname+'.cxt');
      reset(infile);
      readln(infile,zeile);
      if zeile[1]<>'B' then
      begin
	 write('Error: File ',ifname,'.cxt does not');
      writeln(' begin with >>B<<');
	 open_files:=false;
      end else
      begin
	 assign(outfile,ifname+'.tex');
	 rewrite(outfile);
      end;
   end;
end; { open_files }

procedure read_zeile;
begin
	 readln(infile,zeile);
	 if zeile[length(zeile)]=eol then
	    zeile:=Copy(zeile,1,pred(length(zeile)));
end; { read_zeile }


begin
   eol:=char(13);
   if open_files then
   begin
      writeln(outfile,'\documentclass{article}');
      writeln(outfile,'\usepackage{a4,fca}');
      writeln(outfile,'\usepackage[latin1]{inputenc}');
      writeln(outfile,'\begin{document}\vspace*{\fill}');
      readln(infile,zeile);
      readln(infile,gnum);
      readln(infile,mnum);
      readln(infile);
      if mnum > 20 then
	 writeln(outfile,'Too many attributes for fca.sty! (max = 20)!')
   else begin
      writeln(outfile,'\begin{cxt}%');
      writeln(outfile,'\cxtName{',zeile,'}%');
      for i := 1 to gnum do
      begin
	 read_zeile;
	 gnam[i]:=zeile;
      end;
      for i:= 1 to mnum do
      begin
	 read_zeile;
	 writeln(outfile,'\atr{',zeile,'}%');
      end;
      for i := 1 to gnum do
      begin
	 read_zeile;
	 writeln(outfile,'\obj{',zeile,'}{',gnam[i],'}');
      end;
      writeln(outfile,'\end{cxt}');
   end;
      writeln(outfile,'\vspace*{\fill}\end{document}');
      close(outfile);
      close(infile);
   end;
end.













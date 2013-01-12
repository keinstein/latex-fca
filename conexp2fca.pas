program conexp2fca; { Converts ConExp diagram data to LaTeX fca.sty }
type
   name = string[80];
var conexpfile, latexfile   : text;
   ifname,zeile,wort	    : name;
   eof			    : boolean;
   count,i,j		    : integer;
   xmax, ymax,xcent,xx,xmin : real;
   shift, scalefactor,ymin  : real;
   xcoord,ycoord	    : array[0..50] of real;
   code			    : word;
   
procedure write_info;
begin
end;
function open_files	  : boolean;
var ii			  : integer;
begin
    if ParamCount =0 then
   begin
      writeln('This is conexp2fca version 1.0. ');
      write('Type a name of a .txt-file or --help for information: ');
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
      if ii <= length(ifname) then   ifname:=Copy(ifname,1,pred(ii));
      assign(conexpfile,ifname+'.txt');
      reset(conexpfile);
      assign(latexfile,ifname+'.tex');
      rewrite(latexfile);
   end;
end; { open_files }

function getnextword(var wort : name; var jj : integer) : boolean;
var kk,ll :  integer;
begin
   while(jj < length(zeile)) and (ord(zeile[jj])=32) do jj:= succ(jj);
   kk := jj; 
   if jj <= length(zeile) then
   begin
      while ((jj <= length(zeile)) and (ord(zeile[jj])<>32))  do jj:=succ(jj);
      ll := jj-kk;
      if(ord(zeile[pred(jj)])=44) then ll:=pred(ll);
      wort:=Copy(zeile,kk,ll);
      getnextword := true;
   end else  getnextword := false;
end; { getnextword }

function f(var yy :  real) : real;
begin
   f := (yy-shift)*scalefactor;
end; { f }

function g(var yy :  real) : real;
begin
   g := yy*scalefactor;
end; { g }

function getfirstword(var wort : name; var jj : integer) : boolean;
begin
   jj:=1;
   getfirstword := getnextword(wort,jj);
end; { getfirstword }

begin
   if open_files then
   eof := false;
   count:=0;
   xmax:=0;
   xmin:=1;
   ymin:=1;
   ymax:=0;
   xcent:=0;
   repeat
       readln(conexpfile,zeile);
      if getfirstword(wort,j) then
      begin
	 if wort='Node:' then
	 begin
	    count:=succ(count);
	    getnextword(wort,j);
	    getnextword(wort,j);
	    Val(wort,xcoord[count],code);
	    if xcoord[count]>xmax then xmax:=xcoord[count];
	    if xcoord[count]<xmin then xmin:=xcoord[count];
	    getnextword(wort,j);
	    Val(wort,ycoord[count],code);
	    if ycoord[count]>ymax then
		  ymax:=ycoord[count];
	    if ycoord[count]>ymin then
	       begin
		  ymin:=ycoord[count];
		  xcent:=xcoord[count];
	       end;
	 end else eof := true;
      end else eof := true;
   until eof;
   if xmin<>xmax then
   begin
      scalefactor:= 100./(xmax-xmin);
      shift := xmin;
   end else begin
      scalefactor := 1.;
      shift := 0.;
   end;
   for i := 1 to count do
   begin
      xcoord[i]:=f(xcoord[i]);
      xx:=ymax-ycoord[i];
      ycoord[i]:=g(xx);
   end;
   xcent:=f(xcent);
   writeln(latexfile,'\documentclass{article}');
   writeln(latexfile,'\usepackage{fca}');
   writeln(latexfile,'\begin{document}');
   writeln(latexfile,'\unitlength 1mm');
   writeln(latexfile,'\begin{diagram}{',f(xmax):5:2,'}{',g(ymax):5:2,'}');
   writeln(latexfile,'\Numbers');
{   writeln(latexfile,'\CircleSize{20}');}
  for i := 1 to count do 
      writeln(latexfile,'\Node{',i,'}{',xcoord[i]:5:2,'}{',ycoord[i]:5:2,'}'); 
   writeln(xcent:5:2);
   repeat
      if not eof then readln(conexpfile,zeile) else eof := false;
      if getfirstword(wort,j) then
      begin
	 if wort='Edge:' then
	 begin
	    getnextword(wort,j);
	    write(latexfile,'\Edge{',wort,'}');
	    getnextword(wort,j);
	    writeln(latexfile,'{',wort,'}');	    
	 end;
	 If wort='Object:' then
	 begin
	    getnextword(wort,j);
	    Val(wort,xx,code);
	    if xcoord[round(xx)]< xcent then 
	       write(latexfile,'\leftObjbox{')
	    else
	       write(latexfile,'\rightObjbox{');
	    write(latexfile,wort,'}{12}{12}{');
	    j:=succ(j);
	    wort:=Copy(zeile,j,length(zeile)-j+1);
	    writeln(latexfile,wort,'}');
	 end;
	 if wort='Attribute:' then
	 begin
	    getnextword(wort,j);
	    Val(wort,xx,code);
	    if xcoord[round(xx)]<= xcent then 
	       write(latexfile,'\leftAttbox{')
	    else
	       write(latexfile,'\rightAttbox{');
	    write(latexfile,wort,'}{12}{12}{');
	    j:=succ(j);
	    wort:=Copy(zeile,j,length(zeile)-j+1);
	    writeln(latexfile,wort,'}');
	 end;
	 if wort='EOF' then eof:= true;
      end else eof:=true;
   until eof;
   writeln(latexfile,'\end{diagram}');
   writeln(latexfile,'\end{document}');
   close(latexfile);
end.

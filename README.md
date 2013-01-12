latex-fca
=========



For typesettig papers on Formal Concept Analysis with LaTeX, the style file fca.sty may be useful. It offers support for making cross-tables and lattice diagrams and contains macros for some frequently used FCA symbols. Version 2 of fca.sty was written for better compatibility with pdfLaTeX. It no longer uses eepic; instead, it uses the packages pict2e and calc. These should be available for most LaTeX installations, e.g. for the TeX Live distribution. Moreover, a self-made newdrawline.sty is provided replacing eepic's \drawline command. Should you have problems with version 2.1, you may try the old one. There is a documentation file fcadoc, available as .ps or as .pdf, but also in .tex format. If you download fca.sty and fcadoc.tex, you should be able to LaTeX the latter and view the documentation.

I have also written small programs (in old fashioned PASCAL) named cxt2fca and conexp2fca. The program cxt2fca takes as input a formal context in Burmeister's .cxt format, as is generated e.g. by the CONIMP program. As output, it generates a LaTeX file for the formal context. There is a bash shell script named cxtview which invokes cxt2fca, LaTeXes the file and displays the .ps output. The program conexp2fca takes as input the diagram data of Sergei Yevtushenko's CONEXP program (in .txt format) and outputs a LaTeX file. These files usually need some handwork afterwards.

All these files were written for my personal use. It is very likely that they contain errors. They come without warranty.

fca.sty: The LaTeX style file. Requires newdrawline.sty (see next line).
newdrawline.sty:Another style file needed by fca.sty.
fcadoc.ps, fcadoc.pdf,fcadoc.tex:The documentation (postscript, Adobe PDF, LaTeX).
Bfcadoc.ps, Bfcadoc.pdf: Booklet versions of the documentation.
Changelog: Changes wrt. an older version of fca.sty.
How to use fca.sty: Hints for installing.
cxt2fca: The compiled version of the .cxt --> LaTeX program (Linux). It is rather unlikely that this will run on your computer. If not, you may try to compile
cxt2fca.pas: The Pascal source of the cxt2fca program (written for Linux Free Pascal).
cxtview: A bash shell script that calls cxt2fca, then LaTeX, then dvips, then gv to show the result.
conexp2fca:The compiled version of the CONEXP --> LaTeX program (Linux). Again, you may have to compile
conexp2fca.pas: The Free Pascal source code of the program.

Installation
============
How to use fca.sty

It is assumed that LaTeX runs on your computer. Download fca.sty,
newdrawline.sty, and fcadoc.tex. Put the three files in the same folder and run
LaTeX or pdfLaTeX on fcadoc.tex. This should run without errors, and the
resulting file will give you instructions of how to use fca.sty. If LaTeX does
not compile fcadoc.tex, you need an expert.

With pdfLaTeX the output will be in .pdf format, and can be displayed with kpdf
or the Adobe Reader.

As the result of running LaTeX on your .tex-file, you get a .dvi-file. Note
that fcadoc.tex uses some special effects that most .dvi-viewers cannot handle
(like colour, rotated text, and white fill). To get a better impression of your
results, use dvips to translate your file to a .ps-file. Afterwards, you may
use ps2pdf to obtain a .pdf-file.

If you use fca.sty more often, you should put it somewhere where LaTeX finds
it.

  • Under Linux, you may e.g. create a folder ~/texmf/tex/fcastyle and put the
    files fca.sty and newdrawline.sty in there. LaTeX should find them
    automatically.
  • Mac users may try the same for ~/library/texmf/tex/latex/fcastyle .
  • For Windows, the path depends on your LaTeX distribution.


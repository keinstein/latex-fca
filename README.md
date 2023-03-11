[![deployfca](https://github.com/keinstein/latex-fca/actions/workflows/latex1.yml/badge.svg?branch=master)](https://github.com/keinstein/latex-fca/actions/workflows/latex1.yml)

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

The package uses `pgf.sty` so PGF must be installed. This is typically
the case for modern TeX distributions.

There are two ways to use the package:

- You can put everything into the same folder where your document resides. This is useful, when you want
  to evaluate the package, or when you want to bundle the package with
  your document.
- You can install the package in the TeX tree for use in different
  documents. Either in your local TeX tree for your personal usage or
  in the global TeX tree for all users of the corresponding computer.


Direct usage
------------

Download
https://raw.githubusercontent.com/keinstein/latex-fca/master/source/latex/fca/latex-fca.dtx
and put it into the same folder as your document resides. Then you
must run
```
latex latex-fca.dtx
```
at least once in order to generate all necessary files and the
documentation. Instead of `latex` you can also use `pdflatex`,
`xelatex`, `lualatex` or whatever your LaTeX command is called.

Installation in the TeX tree
----------------------------

At first you must download the repository. There are two options:
1. You can clone the repository. For that you must have git installed
   on your computer. In the command line you can enter
   ```
   git clone https://github.com/keinstein/latex-fca.git
   ```
   and git will download the repository and check out the master
   branch.

   In a GUI tool you have to use
   https://github.com/keinstein/latex-fca.git as the repository
   address.

2. You can download
   https://github.com/keinstein/latex-fca/archive/refs/heads/master.zip
   and unzip the file with you favourite file compression tool.

The repository is structured according to the TDS. You can copy the
subdirs into your user specific tex tree. You can find it by issuing
the command
```
kpsexpand '$TEXMFHOME'
```
in a suitable shell that knows about your TeX installation.
On MacOS, Linux, Unix and similar systems this should be the case out
of the box. On Wndows systems such a shell can be usually found in the
Application menu in the folder of the (La)TeX installation.

Note that the user TeX directory tree starting with the above
mentioned `$TEXMFHOME` is not necessarily empty. You
can merge the trees of different packages in that case. Just create
the necessary subfolders and put the corresponding files into them.

**Tip:** You can check out the repository and put symbolic links to
         the folders

After copying the files you should make shure that the package can be
loaded. Some TeX trees contain a file named `ls-R`. This is an index of
all relevant files in that tree. You can safely remove that index. In
that case TeX will search the tree instead of the index file for files
and packages. This can be very time consuming when you have a very
large textree in `TEXMFHOME`. In that case you can regenerate the index
by issuing the command
```
mktexlsr /path/to/TEMFHOME
```
when you have a *nix shell, the complete command would look like
```
mktexlsr "$(kpsexpand '$TEXMFHOME')"
```
Remember, that you have to regenerate that index everytime you install
a package in your local tex tree.

Now, you can go into the folder `source/latex/latex-fca` and run
```
pdflatex latex-fca.dtx
```
this should generate some files in the current folder and the
documentation
```
latex-fca.pdf
```


Development
===========

For development you should use git:
```
git clone https://github.com/keinstein/latex-fca
cd latex-fca
```

For the following commands we assume, you are inside the base
directory of the repository.

It is advised to clone the GitHub repository and add it
as a remote repository. Please, refer to the git documentation
about remote repositories.

Now you should create the necessary folders:
```
mkdir -p "$(kpsexpand '$TEXMFHOME')"/{source,tex,doc}/latex/fca
```

Now you should configure `docstrip.sty` to use this structure. You are
doing so by creating a file named `docstrip.cfg`. This file depends on
your TeX installation. That's why we assume a *nix TDS installation
e.g. TeXLive. In the shell you could generate this file using the
following commands:
```
TDSBASEDIR="$(kpsexpand '$TEXMFHOME')"
cat >docstrip.cfg <<EOF
\BaseDirectory{$TSDBASEDIR}
\UseTDS
EOF
```
It remains to make the necessary files available:
```
ln -s source/latex/latex-fca.dtx .
ln -s "$(kpsexpand '$TEXMFHOME')"/doc/latex/fca/formula1.cxt .
```

When all these preparations are done you can install the updated
package and generate the documentation with:
```
latex latex-fca.dtx
```

There is only one file to edit: `source/latex/latex-fca.dtx`
all other files are generated from this single file. So if you want to
make changes you must edit `source/latex/latex-fca.dtx`.

You can submit your changes to the maintainer in two ways:
1. You can make a unified diff file between the original
   `latex-fca.dtx` and your changed version. Then you can open a new
   issue on https://github.com/keinstein/latex-fca/issues/new and
   attach the diff file.

2. It is preferred to push your changes with the help of git to GitHub
   and open a pull request on
   https://github.com/keinstein/latex-fca/compare. This makes it easy
   to discuss and merge the changes. Once the changes in
   `latex-fca.dtx` are merged it is easy to regenerate the whole TDS
   structure from that commit.

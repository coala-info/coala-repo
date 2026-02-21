# Splancs

This directory contains the code for Splancs - Spatial Point-Pattern
Analysis code in Splus.

All programs here are supplied with no warranty or support available.

Any problems will be dealt with on a best-effort basis.

## Source Code and Docs

Download the following using the `Save Link As...' option of your web browser:

* [**splancs.ps**](splancs.ps) A PostScript file of
  the report/guide.* [**Sp2doc.ps**](Sp2doc.ps) A PostScript file
    documenting the space-time and raised incidence functions
    introduced in Splancs version 2.* [**splancs**](splancs.tar) A tar file of
      the Splancs source code.* [**SHelp.ps**](SHelp.ps) A PostScript file of the
        help files for Splancs functions.* [**install.tex**](install.tex) Splancs
          installation guide (LaTeX format)* <install.ps> Splancs installation guide
            (PostScript format)

For people who have problems viewing and printing PostScript files, I
have converted the report/guide and the help files to Adobe PDF
format. Download [The Guide](splancs.pdf) or [the help pages](SHelp.pdf) here, but be warned, they are both
about 3 megabytes big - the PostScript files are a tenth of that!

## Solaris 2 Systems

If you have trouble compiling the source on Solaris 2 systems, try the
following:

* <splancs.o> Compiled fortran code for
  Solaris 2 machines.
  If you have problems compiling the Fortran (for example, if you
  dont have a Fortran compiler!) then download this code. You will
  also need to modify some other Splancs
  functions.
  1. Delete any calls to `mathlib.dynam` and
     `library.dynam` in the `*.S` files.* Replace `First.lib.S` with the code from [`new.first.S`](new.first.S)* [`splancs.sol.tar`](splancs.sol.tar) A complete tar file
    of the `splancs` library directory for Solaris 2.5
    systems as used at Lancaster. Download this if you have
    problems compiling or running `splancs` for Solaris
    2. Simply copy to the $SHOME/library directory and untar it.

## Splancs for Splus 5

Here are two binary distributions of Splancs for Splus version 5.1 on
Linux and Solaris systems. Just unzip and untar the files in your
library directory.

As usual, these files come with no warranty of any kind.

* [Splancs for Linux](splancs.linux.tar.gz)* [Splancs for Solaris](splancs.solaris.tar.gz)

## PC Splancs - Splus 3

This file is highly experimental. It should work with Splus for
Windows version 3.1, and I think it needs a little modification for
newer versions (`dyn.load.lib` has changed, I think).

* [PC Splancs Zip file](PC/splancs.zip)

## PC Splancs - Splus 4 / Windows 95/NT

This is a development from Steven Reader of University of South
Florida:

* [Go to info and download page](Florida)

---

[Baz<B.Rowlingson@lancaster.ac.uk>](http://www.maths.lancs.ac.uk/~rowlings/)

Last modified: Mon Apr 23 15:04:10 BST 2001
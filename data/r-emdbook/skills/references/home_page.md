# Ecological Models and Data in R

This is the web site for a book published by Princeton
University Press (ISBN
0691125228). It is
available from [Princeton
University Press](http://press.princeton.edu/titles/8709.html) and [Amazon.com](http://www.amazon.com/Ecological-Models-Data-Benjamin-Bolker/dp/0691125228).

|  |  |
| --- | --- |
| [![book cover: Ecological Models and Data in R](neongoby.gif)](http://en.wikipedia.org/wiki/Image%3AElacatinus_evelynae.jpg) | More up-to-date information for the book lives on the book [wiki/](http://emdbolker.wikidot.com/): this has [errata](http://emdbolker.wikidot.com/errata) and added [notes for each chapter](http://emdbolker.wikidot.com/chapters), among other stuff. If you have suggestions for improvements in the R code, or you think you've found an error, please check the wiki and/or contact me (e-mail to bolker "at" mcmaster.ca).   The book is based on a class I taught several times at the University of Florida, covering the nitty-gritty of constructing and fitting simple (statistical) ecological models to real data sets. Here is the material for the labs I used in that class; more lab material can be found on the wiki, and I will be likely to update more of it there. (*This material is slightly out of date; if you're teaching a course based on the book or otherwise interested, please bug me for updated versions!)* Exercises:  * 1:   [pdf](lab1.pdf),   [html](lab1.html),   [Rnw](lab1.Rnw),   [R](lab1.R)   (solutions):   [pdf](lab1A.pdf)   [html](lab1A.html)   [xml](lab1A.xml)   [Rnw](lab1A.Rnw)   [R](lab1A.R) * 2: [pdf](lab2.pdf)   [html](lab2.html)   [xml](lab2.xml)   [Rnw](lab2.Rnw)   [R](lab2.R) (solutions):   [pdf](lab2A.pdf)   [html](lab2A.html)   [xml](lab2A.xml)   [Rnw](lab2A.Rnw)   [R](lab2A.R) * 3: [pdf](lab3.pdf)   [html](lab3.html)   [xml](lab3.xml)   [Rnw](lab3.Rnw)   [R](lab3.R) (solutions): [pdf](lab3A.pdf)   [html](lab3A.html)   [xml](lab3A.xml)   [Rnw](lab3A.Rnw)   [R](lab3A.R) * 4: [pdf](lab4.pdf)   [html](lab4.html)   [xml](lab4.xml)   [Rnw](lab4.Rnw)   [R](lab4.R) (solutions):   [pdf](lab4A.pdf)   [html](lab4A.html)   [xml](lab4A.xml)   [Rnw](lab4A.Rnw)   [R](lab4A.R) * 5: [pdf](lab5.pdf)   [html](lab5.html)   [xml](lab5.xml)   [Rnw](lab5.Rnw)   [R](lab5.R) (solutions):   [pdf](lab5A.pdf)   [html](lab5A.html)   [xml](lab5A.xml)   [Rnw](lab5A.Rnw)   [R](lab5A.R) * 6: [pdf](lab6.pdf)   [html](lab6.html)   [xml](lab6.xml)   [Rnw](lab6.Rnw)   [R](lab6.R) (solutions): [pdf](lab6A.pdf)   [html](lab6A.html)   [xml](lab6A.xml)   [Rnw](lab6A.Rnw)   [R](lab6A.R)  (The PDF and HTML files are self-explanatory; XML may render math better in some browsers. The R files are raw R code (open them in a text editor), and the Rnw files are "Sweave files", a mixture of LaTeX and R code. You probably only want the Rnw files if you're planning on modifying the labs for your own use.) |

Data and scripts for labs:

* (lab 1) [Chlorella
  growth
  data](Chlorellagrowth.txt)
* (lab 1) <Intro1.R>
* (lab 1) <Intro2.R>
* (lab 2) <ewcitmeas.dat>
* (lab 2) <seedpred.dat>
* <duncan_10m.csv>
* <duncan_25m.csv>

### Other data and scripts:

Most of the data for the book are available in the emdbook package on
CRAN. If you would like the goby data (in the emdbookx package),
please contact me (bolker at ufl.edu).
R scripts for each chapter: [1](chap1.R)
[2](chap2.R)
[3](chap3.R)
[4](chap4.R)
[5](chap5.R)
[6](chap6.R)
[7](chap7.R)
[8](chap8.R)
[9](chap9.R)
[10](chap10.R)
[11](chap11.R)
 (these are R
scripts, with extension ".R": open them with a text editor such as
(Windows) Wordpad, Tinn-R, (MacOS) TextWrangler, BBEdit, or the R
script editor). These have some gory details, but should
reproduce exactly
the code chunks and figures in the text.
(Note that you may also need to install the Hmisc package
from CRAN for generating some of the tabular output.
You may also want <chapskel.R>,
a "chapter skeleton"
file with miscellaneous setup code.)

Most of the R code for doing things in the book is now in the two
packages [bbmle](http://cran.r-project.org/web/packages/bbmle/index.html)
(also available in a [development
version](http://r-forge.r-project.org/projects/bbmle)) [and
emdbook](http://cran.r-project.org/web/packages/emdbook/index.html),
both available from R archive (CRAN) or via `install.packages`
from inside R.

Other miscellaneous R code: [pdf](miscR.pdf)
[html](miscR.html)
[xml](miscR.xml)
[Rnw](miscR.Rnw)
[R](miscR.R)

---

Warning: everything below here
may be somewhat out of date ...
If you want to see the existing notes for the
course, start
[here](http://www.zoology.ufl.edu/bolker/emd).

### Old PDFs

* An old draft: 3 August 2007
  ([PDF](book.pdf), 6 MB).
* [Queries/questions for
  readers](queries.pdf)
* [Changes](ChangeLog.txt)
  since 16 Jan draft

### Individual chapters

**Last update: 27 December 2006**

Formats: PDF, Rnw (Sweave -- original "source code"),
R (R code only)

* [proposal](book3a.pdf)
* 1: Introduction [pdf](chap1A.pdf)
  [Rnw](chap1.Rnw)
  [R](chap1.R)
* 2: getting data into R (troubleshooting, exploratory data
  analysis & graphics)
  [pdf](chap2A.pdf) [Rnw](chap2.Rnw)
  [R](chap2.R)
* 3: basics of mathematical models for ecology
  [pdf](chap3A.pdf) [Rnw](chap3.Rnw)
  [R](chap3.R)
* 4: basics of statistical models for ecology
  [pdf](chap4A.pdf) [Rnw](chap4.Rnw)
  [R](chap4.R)
* 5: stochastic simulation, power, randomization tests
  [pdf](chap5A.pdf) [Rnw](chap5.Rnw)
  [R](chap5.R)
* 6: likelihood and all that
  [pdf](chap6A.pdf) [Rnw](chap6.Rnw)
  [R](chap6.R)
* 7: the gory details of model fitting
  [pdf](chap7A.pdf) [Rnw](chap7.Rnw)
  [R](chap7.R)
* 8: worked likelihood estimation examples
  [pdf](chap8A.pdf) [Rnw](chap8.Rnw)
  [R](chap8.R)
* 9: classical statistics revisited
  [pdf](chap9A.pdf) [Rnw](chap9.Rnw)
  [R](chap9.R)
* 10: modeling variance
  [pdf](chap10A.pdf) [Rnw](chap10.Rnw)
  [R](chap10.R)
* 11: dynamic models
  [pdf](chap11A.pdf) [Rnw](chap11.Rnw)
  [R](chap11.R)
* Appendix: notes on algebra etc. [pdf](algnotes.pdf)
  [Rnw](algnotes.Rnw)
  [R](algnotes.R)

---

last modified 31 July 2010
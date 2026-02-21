agricolae tutorial (Version 1.3-7)

F elipe de M endiburu(1)

2023-10-22

1

Preface

The following document was developed to facilitate the use of agricolae package in R, it is understood
that the user knows the statistical methodology for the design and analysis of experiments and through
the use of the functions programmed in agricolae facilitate the generation of the (cid:28)eld book experimental
design and their analysis. The (cid:28)rst part document describes the use of graph.freq role is complemen-
tary to the hist function of R functions to facilitate the collection of statistics and frequency table,
statistics or grouped data histogram based training grouped data and graphics as frequency polygon
or ogive; second part is the development of experimental plans and numbering of the units as used in
an agricultural experiment; a third part corresponding to the comparative tests and (cid:28)nally provides
agricolae miscellaneous additional functions applied in agricultural research and stability functions,
soil consistency, late blight simulation and others.

1

Introduction

The package agricolae o(cid:27)ers a broad functionality in the design of experiments, especially for experi-
ments in agriculture and improvements of plants, which can also be used for other purposes. It contains
the following designs: lattice, alpha, cyclic, balanced incomplete block designs, complete randomized
blocks, Latin, Graeco-Latin, augmented block designs, split plot and strip plot. It also has several
procedures of experimental data analysis, such as the comparisons of treatments of Waller-Duncan,
Bonferroni, Duncan, Student-Newman-Keuls, Sche(cid:27)e, Ryan, Einot and Gabriel and Welsch multiple
range test or the classic LSD and Tukey; and non-parametric comparisons, such as Kruskal-Wallis,
Friedman, Durbin, Median and Waerden, stability analysis, and other procedures applied in genetics,
as well as procedures in biodiversity and descriptive statistics, De Mendiburu (2009)

1.1

Installation

The main program of R should be already installed in the platform of your computer (Windows, Linux
or MAC). If it is not installed yet, you can download it from the R project http://www.R-project.org
of a repository CRAN, R Core Team (2020).

> install.packages("agricolae") Once the agricolae package is installed, it needs to be made

accessible to the current R session by the command:

1Profesor Principal del Departamento Academico de Estad(cid:237)stica e InformÆtica de la Facultad de Econom(cid:237)a y Plani(cid:28)-

caci(cid:243)n. Universidad Nacional Agraria La Molina-PERU

1

> library(agricolae)

For online help facilities or the details of a particular command (such as the function waller.test)
you can type:

> help(package="agricolae")
> help(waller.test)

For a complete functionality, agricolae requires other packages

MASS: for the generalized inverse used in the function PBIB.test
nlme: for the methods REML and LM in PBIB.test
Cluster: for the use of the function consensus
algDesign: for the balanced incomplete block designdesign.bib

1.2 Use in R

Since agricolae is a package of functions, these are operational when they are called directly from
the console of R and are integrated to all the base functions of R. The following orders are frequent:

> detach(package:agricolae) # detach package agricole
> library(agricolae) # Load the package to the memory
> designs<-apropos("design")
> designs[substr(designs,1,6)=="design"]

[1] "design.ab"
[4] "design.crd"
[7] "design.graeco"

[10] "design.mat"
[13] "design.strip"

"design.bib"
"design.alpha"
"design.cyclic"
"design.dau"
"design.lattice" "design.lsd"
"design.rcbd"
"design.youden"

"design.split"

For the use of symbols that do not appear in the keyboard in Spanish, such as:

~, [, ], &, ^, |. <, >, {, }, \% or others, use the table ASCII code.

> library(agricolae) # Load the package to the memory:

In order to continue with the command line, do not forget to close the open windows with any R order.
For help:

help(graph.freq)
? (graph.freq)
str(normal.freq)
example(join.freq)

1.3 Data set in agricolae

> A<-as.data.frame(data(package="agricolae")$results[,3:4])
> A[,2]<-paste(substr(A[,2],1,35),"..",sep=".")
> head(A)

2

Item
CIC
Chz2006
ComasOxapampa

1
2
3
4
5 Glycoalkaloids
Hco2006
6

Title
Data for late blight of potatoes...
Data amendment Carhuaz 2006...
Data AUDPC Comas - Oxapampa...
DC Data for the analysis of carolina g...
Data Glycoalkaloids...
Data amendment Huanuco 2006...

2 Descriptive statistics

The package agricolae provides some complementary functions to the R program, speci(cid:28)cally for the
management of the histogram and function hist.

2.1 Histogram

The histogram is constructed with the function graph.freq and is associated to other functions: poly-
gon.freq, table.freq, stat.freq. See Figures: 1, 2 and 3 for more details.

Example. Data generated in R . (students’ weight).

> weight<-c( 68, 53, 69.5, 55, 71, 63, 76.5, 65.5, 69, 75, 76, 57, 70.5, 71.5, 56, 81.5,
+
> print(summary(weight))

69, 59, 67.5, 61, 68, 59.5, 56.5, 73, 61, 72.5, 71.5, 59.5, 74.5, 63)

Min. 1st Qu.
59.88

53.00

Median
68.00

Mean 3rd Qu.
71.50

66.45

Max.
81.50

2.2 Statistics and Frequency tables

Statistics: mean, median, mode and standard deviation of the grouped data.

> stat.freq(h1)

$variance
[1] 51.37655

$mean
[1] 66.6

$median
[1] 68.36

$mode

mode
[1,] 67.4 72.2 70.45455

[-

-]

Frequency tables: Use table.freq, stat.freq and summary

The table.freq is equal to summary()

3

ylab="Frequency")

> oldpar<-par(mfrow=c(1,2),mar=c(4,4,0,1),cex=0.6)
> h1<- graph.freq(weight,col=colors()[84],frequency=1,las=2,density=20,ylim=c(0,12),
+
> x<-h1$breaks
> h2<- plot(h1, frequency =2, axes= FALSE,ylim=c(0,0.4),xlab="weight",ylab="Relative (%)")
> polygon.freq(h2, col=colors()[84], lwd=2, frequency =2)
> axis(1,x,cex=0.6,las=2)
> y<-seq(0,0.4,0.1)
> axis(2, y,y*100,cex=0.6,las=1)
> par(oldpar)

Figure 1: Absolute and relative frequency with polygon.

Limits class: Lower and Upper

Class point: Main

Frequency: Frequency

Percentage frequency: Percentage

Cumulative frequency: CF

Cumulative percentage frequency: CPF

> print(summary(h1),row.names=FALSE)

CPF
Lower Upper Main Frequency Percentage CF
16.7
5
16.7
33.3
16.7 10
10.0 13
43.3
33.3 23 76.7
96.7
20.0 29
3.3 30 100.0

57.8 55.4
62.6 60.2
67.4 65.0
72.2 69.8
77.0 74.6
81.8 79.4

53.0
57.8
62.6
67.4
72.2
77.0

5
5
3
10
6
1

2.3 Histogram manipulation functions

You can extract information from a histogram such as class intervals inter.freq, attract new intervals
with the sturges.freq function or to join classes with join.freq function. It is also possible to repro-
duce the graph with the same creator graph.freq or function plot and overlay normal function with
normal.freq be it a histogram in absolute scale, relative or density . The following examples illustrates
these properties.

4

weightFrequency53.057.862.667.472.277.081.8024681012weightRelative (%)53.057.862.667.472.277.081.8010203040> sturges.freq(weight)

$maximum
[1] 81.5

$minimum
[1] 53

$amplitude
[1] 29

$classes
[1] 6

$interval
[1] 4.8

$breaks
[1] 53.0 57.8 62.6 67.4 72.2 77.0 81.8

> inter.freq(h1)

lower upper
57.8
62.6
67.4
72.2
77.0
81.8

53.0
57.8
62.6
67.4
72.2
77.0

[1,]
[2,]
[3,]
[4,]
[5,]
[6,]

> join.freq(h1,1:3) -> h3
> print(summary(h3))

Lower Upper Main Frequency Percentage CF
43.3 13
33.3 23
20.0 29

67.4 60.2
72.2 69.8
77.0 74.6
81.8 79.4

CPF
43.3
76.7
96.7
3.3 30 100.0

53.0
67.4
72.2
77.0

13
10
6
1

1
2
3
4

2.4 hist() and graph.freq() based on grouped data

The hist and graph.freq have the same characteristics, only f2 allows build histogram from grouped
data.

0-10 (3)
10-20 (8)
20-30 (15)
30-40 (18)
40-50 (6)

5

> oldpar<-par(mfrow=c(1,2),mar=c(4,4,0,1),cex=0.8)
> plot(h3, frequency=2,col=colors()[84],ylim=c(0,0.6),axes=FALSE,xlab="weight",ylab="%",border=0)
> y<-seq(0,0.6,0.2)
> axis(2,y,y*100,las=2)
> axis(1,h3$breaks)
> normal.freq(h3,frequency=2,col=colors()[90])
> ogive.freq(h3,col=colors()[84],xlab="weight")

weight

RCF
53.0 0.0000
67.4 0.4333
72.2 0.7667
77.0 0.9667
81.8 1.0000
86.6 1.0000

1
2
3
4
5
6

> par(oldpar)

Figure 2: Join frequency and relative frequency with normal and Ogive.

6

weight%020406053.067.477.0weight53.067.477.086.60.00.20.40.60.81.0> oldpar<-par(mfrow=c(1,2),mar=c(4,3,2,1),cex=0.6)
> h4<-hist(weight,xlab="Classes (h4)")
> table.freq(h4)
> # this is possible
> # hh<-graph.freq(h4,plot=FALSE)
> # summary(hh)
> # new class
> classes <- c(0, 10, 20, 30, 40, 50)
> freq <- c(3, 8, 15, 18, 6)
> h5 <- graph.freq(classes,counts=freq, xlab="Classes (h5)",main="Histogram grouped data")
> par(oldpar)

Figure 3: hist() function and histogram de(cid:28)ned class

> print(summary(h5),row.names=FALSE)

Lower Upper Main Frequency Percentage CF CPF
6
3
22
16 11
52
30 26
36 44
88
12 50 100

3
8
15
18
6

5
15
25
35
45

0
10
20
30
40

10
20
30
40
50

6

3 Experiment designs

The package agricolae presents special functions for the creation of the (cid:28)eld book for experimental
designs. Due to the random generation, this package is quite used in agricultural research.

For this generation, certain parameters are required, as for example the name of each treatment, the
number of repetitions, and others, according to the design, Cochran and Cox (1957); kueh (2000);
Le Clerg and Leonard and Erwin and Warren and Andrew (1992); Montgomery (2002). There are
other parameters of random generation, as the seed to reproduce the same random generation or the
generation method (See the reference manual of agricolae).

http://cran.at.r-project.org/web/packages/agricolae/agricolae.pdf

Important parameters in the generation of design:

series: A constant that is used to set numerical tag blocks , eg number = 2, the labels will be : 101,
102, for the (cid:28)rst row or block, 201, 202, for the following , in the case of completely randomized design,
the numbering is sequencial.

7

Histogram of weightClasses (h4)Frequency505560657075808502468Histogram grouped dataClasses (h5)0102030405005101520design: Some features of the design requested agricolae be applied speci(cid:28)cally to design.ab(factorial)
or design.split (split plot) and their possible values are: "rcbd", "crd" and "lsd".

seed: The seed for the random generation and its value is any real value, if the value is zero, it has
no reproducible generation, in this case copy of value of the outdesign$parameters.

kinds: the random generation method, by default "Super-Duper".

(cid:28)rst: For some designs is not required random the (cid:28)rst repetition, especially in the block design, if
you want to switch to random, change to TRUE.

randomization: TRUE or FALSE. If false, randomization is not performed

Output design:

parameters: the input to generation design, include the seed to generation random, if seed=0, the
program generate one value and it is possible reproduce the design.

book: (cid:28)eld book

statistics: the information statistics the design for example e(cid:30)ciency index, number of treatments.

sketch: distribution of treatments in the (cid:28)eld.

The enumeration of the plots

zigzag is a function that allows you to place the numbering of the plots in the direction of serpentine:
The zigzag is output generated by one design: blocks, Latin square, graeco, split plot, strip plot, into
blocks factorial, balanced incomplete block, cyclic lattice, alpha and augmented blocks.

(cid:28)eldbook: output zigzag, contain (cid:28)eld book.

3.1 Completely randomized design

It generates completely a randomized design with equal or di(cid:27)erent repetition. "Random" uses the
methods of number generation in R.The seed is by set.seed(seed, kinds). They only require the names
of the treatments and the number of their repetitions and its parameters are:

> str(design.crd)

function (trt, r, serie = 2, seed = 0, kinds = "Super-Duper",

randomization = TRUE)

> trt <- c("A", "B", "C")
> repeticion <- c(4, 3, 4)
> outdesign <- design.crd(trt,r=repeticion,seed=777,serie=0)
> book1 <- outdesign$book
> head(book1)

plots r trt
C
1 1
A
2 1
B
3 1
A
4 2
A
5 3
C
6 2

1
2
3
4
5
6

Excel:write.csv(book1,"book1.csv",row.names=FALSE)

8

3.2 Randomized complete block design

It generates (cid:28)eld book and sketch to Randomized Complete Block Design. "Random" uses the meth-
ods of number generation in R.The seed is by set.seed(seed, kinds). They require the names of the
treatments and the number of blocks and its parameters are:

> str(design.rcbd)

function (trt, r, serie = 2, seed = 0, kinds = "Super-Duper",
first = TRUE, continue = FALSE, randomization = TRUE)

> trt <- c("A", "B", "C","D","E")
> repeticion <- 4
> outdesign <- design.rcbd(trt,r=repeticion, seed=-513, serie=2)
> # book2 <- outdesign$book
> book2<- zigzag(outdesign) # zigzag numeration
> print(outdesign$sketch)

[,1] [,2] [,3] [,4] [,5]
"D"
"D"
"A"
"E"

"B"
"A"
"E"
"C"

"A"
"C"
"B"
"B"

"C"
"E"
"D"
"A"

[1,] "E"
[2,] "B"
[3,] "C"
[4,] "D"

> print(matrix(book2[,1],byrow = TRUE, ncol = 5))

[,1] [,2] [,3] [,4] [,5]
105
103
201
203
305
303
401
403

102
204
302
404

104
202
304
402

101
205
301
405

[1,]
[2,]
[3,]
[4,]

3.3 Latin square design

It generates Latin Square Design. "Random" uses the methods of number generation in R.The seed
is by set.seed(seed, kinds). They require the names of the treatments and its parameters are:

> str(design.lsd)

function (trt, serie = 2, seed = 0, kinds = "Super-Duper",

first = TRUE, randomization = TRUE)

> trt <- c("A", "B", "C", "D")
> outdesign <- design.lsd(trt, seed=543, serie=2)
> print(outdesign$sketch)

[,1] [,2] [,3] [,4]

[1,] "B"
[2,] "D"
[3,] "C"
[4,] "A"

"C"
"A"
"D"
"B"

"A"
"C"
"B"
"D"

"D"
"B"
"A"
"C"

9

Serpentine enumeration:

> book <- zigzag(outdesign)
> print(matrix(book[,1],byrow = TRUE, ncol = 4))

[,1] [,2] [,3] [,4]
104
201
304
401

102
203
302
403

101
204
301
404

103
202
303
402

[1,]
[2,]
[3,]
[4,]

3.4 Graeco-Latin designs

A graeco - latin square is a KxK pattern that permits the study of k treatments simultaneously with
three di(cid:27)erent blocking variables, each at k levels. The function is only for squares of the odd numbers
and even numbers (4, 8, 10 and 12). They require the names of the treatments of each factor of study
and its parameters are:

> str(design.graeco)

function (trt1, trt2, serie = 2, seed = 0, kinds = "Super-Duper",

randomization = TRUE)

> trt1 <- c("A", "B", "C", "D")
> trt2 <- 1:4
> outdesign <- design.graeco(trt1,trt2, seed=543, serie=2)
> print(outdesign$sketch)

[,1]

[,2]

[,3]

[,4]

[1,] "D 2" "B 4" "A 3" "C 1"
[2,] "B 3" "D 1" "C 2" "A 4"
[3,] "A 1" "C 3" "D 4" "B 2"
[4,] "C 4" "A 2" "B 1" "D 3"

Serpentine enumeration:

> book <- zigzag(outdesign)
> print(matrix(book[,1],byrow = TRUE, ncol = 4))

[,1] [,2] [,3] [,4]
104
201
304
401

102
203
302
403

103
202
303
402

101
204
301
404

[1,]
[2,]
[3,]
[4,]

3.5 Youden design

Such designs are referred to as Youden squares since they were introduced by Youden (1937) after
Yates (1936) considered the special case of column equal to number treatment minus 1. "Random"
uses the methods of number generation in R. The seed is by set.seed(seed, kinds). They require the
names of the treatments of each factor of study and its parameters are:

10

> str(design.youden)

function (trt, r, serie = 2, seed = 0, kinds = "Super-Duper",

first = TRUE, randomization = TRUE)

> varieties<-c("perricholi","yungay","maria bonita","tomasa")
> r<-3
> outdesign <-design.youden(varieties,r,serie=2,seed=23)
> print(outdesign$sketch)

[,1]

[,2]

[1,] "maria bonita" "tomasa"
[2,] "yungay"
[3,] "perricholi"
[4,] "tomasa"

"maria bonita" "tomasa"
"yungay"
"perricholi"

"maria bonita"
"yungay"

[,3]
"perricholi"

> book <- outdesign$book
> print(book) # field book.

plots row col

1
2
3
4
5
6
7
8
9
10
11
12

101
102
103
201
202
203
301
302
303
401
402
403

1
1
1
2
2
2
3
3
3
4
4
4

varieties
1 maria bonita
2
tomasa
perricholi
3
1
yungay
2 maria bonita
3
tomasa
perricholi
1
2
yungay
3 maria bonita
1
tomasa
perricholi
2
yungay
3

> print(matrix(as.numeric(book[,1]),byrow = TRUE, ncol = r))

[,1] [,2] [,3]
103
102
203
202
303
302
403
402

101
201
301
401

[1,]
[2,]
[3,]
[4,]

Serpentine enumeration:

> book <- zigzag(outdesign)
> print(matrix(as.numeric(book[,1]),byrow = TRUE, ncol = r))

[,1] [,2] [,3]
103
102
201
202
303
302
401
402

101
203
301
403

[1,]
[2,]
[3,]
[4,]

11

3.6 Balanced Incomplete Block Designs

Creates Randomized Balanced Incomplete Block Design. "Random" uses the methods of number
generation in R. The seed is by set.seed(seed, kinds). They require the names of the treatments and
the size of the block and its parameters are:

> str(design.bib)

function (trt, k, r = NULL, serie = 2, seed = 0, kinds = "Super-Duper",

maxRep = 20, randomization = TRUE)

> trt <- c("A", "B", "C", "D", "E" )
> k <- 4
> outdesign <- design.bib(trt,k, seed=543, serie=2)

Parameters BIB
==============
Lambda
: 3
treatmeans : 5
Block size : 4
Blocks
: 5
Replication: 4

Efficiency factor 0.9375

<<< Book >>>

> book5 <- outdesign$book
> outdesign$statistics

values

lambda treatmeans blockSize blocks r Efficiency
0.9375

5 4

5

4

3

> outdesign$parameters

$design
[1] "bib"

$trt
[1] "A" "B" "C" "D" "E"

$k
[1] 4

$serie
[1] 2

$seed
[1] 543

$kinds
[1] "Super-Duper"

12

According to the produced information, they are (cid:28)ve blocks of size 4, being the matrix:

> outdesign$sketch

[,1] [,2] [,3] [,4]

[1,] "B"
[2,] "C"
[3,] "A"
[4,] "E"
[5,] "D"

"C"
"D"
"D"
"C"
"C"

"E"
"B"
"E"
"D"
"E"

"A"
"A"
"B"
"B"
"A"

It can be observed that the treatments have four repetitions. The parameter lambda has three repe-
titions, which means that a couple of treatments are together on three occasions. For example, B and
E are found in the blocks I, II and V.

Serpentine enumeration:

> book <- zigzag(outdesign)
> matrix(book[,1],byrow = TRUE, ncol = 4)

[,1] [,2] [,3] [,4]
104
201
304
401
504

102
203
302
403
502

101
204
301
404
501

103
202
303
402
503

[1,]
[2,]
[3,]
[4,]
[5,]

3.7 Cyclic designs

They require the names of the treatments, the size of the block and the number of repetitions. This
design is used for 6 to 30 treatments. The repetitions are a multiple of the size of the block; if they
are six treatments and the size is 3, then the repetitions can be 6, 9, 12, etc. and its parameters are:

> str(design.cyclic)

function (trt, k, r, serie = 2, rowcol = FALSE, seed = 0,

kinds = "Super-Duper", randomization = TRUE)

> trt <- c("A", "B", "C", "D", "E", "F" )
> outdesign <- design.cyclic(trt,k=3, r=6, seed=543, serie=2)

cyclic design
Generator block basic:
1 2 4
1 3 2

Parameters
===================
treatmeans : 6
Block size : 3
Replication: 6

13

> book6 <- outdesign$book
> outdesign$sketch[[1]]

[,1] [,2] [,3]
"D"
"B"
"E"
"E"
"F"
"A"

"C"
"E"
"A"
"F"
"C"
"D"

[1,] "F"
[2,] "C"
[3,] "D"
[4,] "B"
[5,] "A"
[6,] "B"

> outdesign$sketch[[2]]

[,1] [,2] [,3]
"F"
"C"
"F"
"D"
"D"
"C"

"E"
"B"
"B"
"E"
"F"
"B"

[1,] "A"
[2,] "A"
[3,] "A"
[4,] "C"
[5,] "E"
[6,] "D"

12 blocks of 4 treatments each have been generated. Serpentine enumeration:

> book <- zigzag(outdesign)
> array(book$plots,c(3,6,2))->X
> t(X[,,1])

[,1] [,2] [,3]
103
102
104
105
109
108
110
111
115
114
116
117

101
106
107
112
113
118

[1,]
[2,]
[3,]
[4,]
[5,]
[6,]

> t(X[,,2])

[,1] [,2] [,3]
203
202
204
205
209
208
210
211
215
214
216
217

201
206
207
212
213
218

[1,]
[2,]
[3,]
[4,]
[5,]
[6,]

3.8 Lattice designs

SIMPLE and TRIPLE lattice designs.
number of treatments of a perfect square; for example 9, 16, 25, 36, 49, etc. and its parameters are:

It randomizes treatments in k x k lattice. They require a

14

> str(design.lattice)

function (trt, r = 3, serie = 2, seed = 0, kinds = "Super-Duper",

randomization = TRUE)

They can generate a simple lattice (2 rep.) or a triple lattice (3 rep.) generating a triple lattice design
for 9 treatments 3x3

> trt<-letters[1:9]
> outdesign <-design.lattice(trt, r = 3, serie = 2, seed = 33,
+

kinds = "Super-Duper")

Lattice design, triple

3 x 3

Efficiency factor
(E ) 0.7272727

<<< Book >>>

> book7 <- outdesign$book
> outdesign$parameters

$design
[1] "lattice"

$type
[1] "triple"

$trt
[1] "a" "b" "c" "d" "e" "f" "g" "h" "i"

$r
[1] 3

$serie
[1] 2

$seed
[1] 33

$kinds
[1] "Super-Duper"

> outdesign$sketch

$rep1

[,1] [,2] [,3]
"c"
"b"
"e"

"a"
"h"
"d"

[1,] "g"
[2,] "f"
[3,] "i"

15

$rep2

[,1] [,2] [,3]
"f"
"h"
"b"

"i"
"d"
"e"

[1,] "g"
[2,] "a"
[3,] "c"

$rep3

[,1] [,2] [,3]
"h"
"f"
"b"

"e"
"d"
"i"

[1,] "g"
[2,] "c"
[3,] "a"

> head(book7)

plots r block trt
g
c
a
f
b
h

101 1
102 1
103 1
104 1
105 1
106 1

1
1
1
2
2
2

1
2
3
4
5
6

Serpentine enumeration:

> book <- zigzag(outdesign)
> array(book$plots,c(3,3,3)) -> X
> t(X[,,1])

[,1] [,2] [,3]
103
102
104
105
109
108

101
106
107

[1,]
[2,]
[3,]

> t(X[,,2])

[,1] [,2] [,3]
203
202
204
205
209
208

201
206
207

[1,]
[2,]
[3,]

> t(X[,,3])

[,1] [,2] [,3]
303
302
304
305
309
308

301
306
307

[1,]
[2,]
[3,]

16

3.9 Alpha designs

Generates an alpha designs starting from the alpha design (cid:28)xing under the series formulated by Pat-
terson and Williams. These designs are generated by the alpha arrangements. They are similar to the
lattice designs, but the tables are rectangular s by k (with s blocks and k<s columns. The number
of treatments should be equal to s*k and all the experimental units r*s*k (r replications) and its
parameters are:

> str(design.alpha)

function (trt, k, r, serie = 2, seed = 0, kinds = "Super-Duper",

randomization = TRUE)

> trt <- letters[1:15]
> outdesign <- design.alpha(trt,k=3,r=2,seed=543)

Alpha Design (0,1) - Serie I

Parameters Alpha Design
=======================
Treatmeans : 15
Block size : 3
Blocks
: 5
Replication: 2

Efficiency factor
(E ) 0.6363636

<<< Book >>>

> book8 <- outdesign$book
> outdesign$statistics

values

treatments blocks Efficiency
5 0.6363636

15

> outdesign$sketch

$rep1

[,1] [,2] [,3]
"g"
"o"
"j"
"c"
"l"

"m"
"h"
"b"
"k"
"d"

[1,] "i"
[2,] "f"
[3,] "n"
[4,] "a"
[5,] "e"

$rep2

[,1] [,2] [,3]
"f"
"j"

"k"
"a"

[1,] "g"
[2,] "e"

17

[3,] "m"
[4,] "n"
[5,] "i"

"c"
"d"
"h"

"l"
"o"
"b"

> # codification of the plots
> A<-array(book8[,1], c(3,5,2))
> t(A[,,1])

[,1] [,2] [,3]
103
102
106
105
109
108
112
111
115
114

101
104
107
110
113

[1,]
[2,]
[3,]
[4,]
[5,]

> t(A[,,2])

[,1] [,2] [,3]
203
202
206
205
209
208
212
211
215
214

201
204
207
210
213

[1,]
[2,]
[3,]
[4,]
[5,]

Serpentine enumeration:

> book <- zigzag(outdesign)
> A<-array(book[,1], c(3,5,2))
> t(A[,,1])

[,1] [,2] [,3]
103
102
104
105
109
108
110
111
115
114

101
106
107
112
113

[1,]
[2,]
[3,]
[4,]
[5,]

> t(A[,,2])

[,1] [,2] [,3]
203
202
204
205
209
208
210
211
215
214

201
206
207
212
213

[1,]
[2,]
[3,]
[4,]
[5,]

3.10 Augmented block designs

These are designs for two types of treatments: the control treatments (common) and the increased
treatments. The common treatments are applied in complete randomized blocks, and the increased

18

treatments, at random. Each treatment should be applied in any block once only. It is understood
that the common treatments are of a greater interest; the standard error of the di(cid:27)erence is much
smaller than when between two increased ones in di(cid:27)erent blocks. The function design.dau() achieves
this purpose and its parameters are:

> str(design.dau)

function (trt1, trt2, r, serie = 2, seed = 0, kinds = "Super-Duper",

name = "trt", randomization = TRUE)

> rm(list=ls())
> trt1 <- c("A", "B", "C", "D")
> trt2 <- c("t","u","v","w","x","y","z")
> outdesign <- design.dau(trt1, trt2, r=5, seed=543, serie=2)
> book9 <- outdesign$book
> with(book9,by(trt, block,as.character))

block: 1
[1] "C" "B" "v" "D" "t" "A"
---------------------------------------------
block: 2
[1] "D" "u" "A" "B" "x" "C"
---------------------------------------------
block: 3
[1] "B" "y" "C" "A" "D"
---------------------------------------------
block: 4
[1] "A" "B" "C" "D" "w"
---------------------------------------------
block: 5
[1] "z" "A" "C" "D" "B"

Serpentine enumeration:

> book <- zigzag(outdesign)
> with(book,by(plots, block, as.character))

block: 1
[1] "101" "102" "103" "104" "105" "106"
---------------------------------------------
block: 2
[1] "206" "205" "204" "203" "202" "201"
---------------------------------------------
block: 3
[1] "301" "302" "303" "304" "305"
---------------------------------------------
block: 4
[1] "405" "404" "403" "402" "401"
---------------------------------------------
block: 5
[1] "501" "502" "503" "504" "505"

19

> head(book)

plots block trt
C
B
v
D
t
A

101
102
103
104
105
106

1
1
1
1
1
1

1
2
3
4
5
6

For augmented ompletely randomized design, use the function design.crd().

3.11 Split plot designs

These designs have two factors, one is applied in plots and is de(cid:28)ned as trt1 in a randomized complete
block design; and a second factor as trt2 , which is applied in the subplots of each plot applied at
random. The function design.split() permits to (cid:28)nd the experimental plan for this design and its
parameters are:

> str(design.split)

function (trt1, trt2, r = NULL, design = c("rcbd",

"crd", "lsd"), serie = 2, seed = 0, kinds = "Super-Duper",
first = TRUE, randomization = TRUE)

Aplication

> trt1<-c("A","B","C","D")
> trt2<-c("a","b","c")
> outdesign <-design.split(trt1,trt2,r=3,serie=2,seed=543)
> book10 <- outdesign$book
> head(book10)

plots splots block trt1 trt2
b
a
c
a
b
c

101
101
101
102
102
102

1
1
1
1
1
1

1
2
3
1
2
3

D
D
D
B
B
B

1
2
3
4
5
6

> p<-book10$trt1[seq(1,36,3)]
> q<-NULL
> for(i in 1:12)
+ q <- c(q,paste(book10$trt2[3*(i-1)+1],book10$trt2[3*(i-1)+2], book10$trt2[3*(i-1)+3]))

In plots:

> print(t(matrix(p,c(4,3))))

20

[,1] [,2] [,3] [,4]

[1,] "D"
[2,] "B"
[3,] "D"

"B"
"C"
"B"

"A"
"A"
"A"

"C"
"D"
"C"

In sub plots (split plot)

> print(t(matrix(q,c(4,3))))

[,1]

[,2]

[,3]

[,4]

[1,] "b a c" "a b c" "c a b" "c b a"
[2,] "b c a" "a b c" "b c a" "a c b"
[3,] "c a b" "b c a" "c a b" "a c b"

Serpentine enumeration:

> book <- zigzag(outdesign)
> head(book,5)

plots splots block trt1 trt2
b
a
c
a
b

101
101
101
102
102

D
D
D
B
B

1
1
1
1
1

1
2
3
1
2

1
2
3
4
5

3.12 Strip-plot designs

These designs are used when there are two types of treatments (factors) and are applied separately
in large plots, called bands, in a vertical and horizontal direction of the block, obtaining the divided
blocks. Each block constitutes a repetition and its parameters are:

> str(design.strip)

function (trt1, trt2, r, serie = 2, seed = 0, kinds = "Super-Duper",

randomization = TRUE)

Aplication

> trt1<-c("A","B","C","D")
> trt2<-c("a","b","c")
> outdesign <-design.strip(trt1,trt2,r=3,serie=2,seed=543)
> book11 <- outdesign$book
> head(book11)

plots block trt1 trt2
b
1
a
1
c
1
b
1
a
1
c
1

101
102
103
104
105
106

D
D
D
B
B
B

1
2
3
4
5
6

21

> t3<-paste(book11$trt1, book11$trt2)
> B1<-t(matrix(t3[1:12],c(4,3)))
> B2<-t(matrix(t3[13:24],c(3,4)))
> B3<-t(matrix(t3[25:36],c(3,4)))
> print(B1)

[,1]

[,2]

[,3]

[,4]

[1,] "D b" "D a" "D c" "B b"
[2,] "B a" "B c" "A b" "A a"
[3,] "A c" "C b" "C a" "C c"

> print(B2)

[,1]

[,2]

[,3]

[1,] "C b" "C a" "C c"
[2,] "B b" "B a" "B c"
[3,] "A b" "A a" "A c"
[4,] "D b" "D a" "D c"

> print(B3)

[,1]

[,2]

[,3]

[1,] "A c" "A b" "A a"
[2,] "B c" "B b" "B a"
[3,] "D c" "D b" "D a"
[4,] "C c" "C b" "C a"

Serpentine enumeration:

> book <- zigzag(outdesign)
> head(book)

plots block trt1 trt2
b
1
a
1
c
1
b
1
a
1
c
1

101
102
103
106
105
104

D
D
D
B
B
B

1
2
3
4
5
6

> array(book$plots,c(3,4,3))->X
> t(X[,,1])

[,1] [,2] [,3]
103
102
104
105
109
108
110
111

101
106
107
112

[1,]
[2,]
[3,]
[4,]

> t(X[,,2])

22

[,1] [,2] [,3]
203
202
204
205
209
208
210
211

201
206
207
212

[1,]
[2,]
[3,]
[4,]

> t(X[,,3])

[,1] [,2] [,3]
303
302
304
305
309
308
310
311

301
306
307
312

[1,]
[2,]
[3,]
[4,]

3.13 Factorial

The full factorial of n factors applied to an experimental design (CRD, RCBD and LSD) is common
and this procedure in agricolae applies the factorial to one of these three designs and its parameters
are:

> str(design.ab)

function (trt, r = NULL, serie = 2, design = c("rcbd",
"crd", "lsd"), seed = 0, kinds = "Super-Duper",
first = TRUE, randomization = TRUE)

To generate the factorial, you need to create a vector of levels of each factor, the method automatically
generates up to 25 factors and "r" repetitions.

> trt <- c (4,2,3) # three factors with 4,2 and 3 levels.

to crd and rcbd designs, it is necessary to value "r" as the number of repetitions, this can be a vector
if unequal to equal or constant repetition (recommended).

> trt<-c(3,2) # factorial 3x2
> outdesign <-design.ab(trt, r=3, serie=2)
> book12 <- outdesign$book
> head(book12) # print of the field book

plots block A B
1 2 2
1 2 1
1 3 2
1 1 2
1 1 1
1 3 1

101
102
103
104
105
106

1
2
3
4
5
6

Serpentine enumeration:

23

> book <- zigzag(outdesign)
> head(book)

plots block A B
1 2 2
1 2 1
1 3 2
1 1 2
1 1 1
1 3 1

101
102
103
104
105
106

1
2
3
4
5
6

factorial 2 x 2 x 2 with 5 replications in completely randomized design.

> trt<-c(2,2,2)
> crd<-design.ab(trt, r=5, serie=2,design="crd")
> names(crd)

[1] "parameters" "book"

> crd$parameters

$design
[1] "factorial"

$trt
[1] "1 1 1" "1 1 2" "1 2 1" "1 2 2" "2 1 1" "2 1 2" "2 2 1"
[8] "2 2 2"

$r
[1] 5 5 5 5 5 5 5 5

$serie
[1] 2

$seed
[1] 1923434691

$kinds
[1] "Super-Duper"

[[7]]
[1] TRUE

$applied
[1] "crd"

> head(crd$book)

plots r A B C
101 1 2 2 2

1

24

2
3
4
5
6

102 2 2 2 2
103 1 2 1 1
104 1 1 2 1
105 1 1 1 1
106 2 1 2 1

3.14 Experimental design matrix

Generate the design matrix from the (cid:28)eld book generated by an experimental plan or a data table for
analysis and its parameters are:

> str(design.mat)

function (book, locations)

To generate the matrix, it is necessary to extract the (cid:28)eld book of the design generated by agricolae.
The matrix can also be generated if you have a table for experimental analysis.

For example, analyze the sweetpotato experiment using the design matrix.

> data(sweetpotato)
> X <- design.mat(sweetpotato,1)
> n<-nrow(X)
> print(X)

constant cc fc ff oo
0
1
0
1
0
1
0
0
0
0
0
0
0
0
0
0
0
0
0 1
0
0 1
0
0 1
0

0 0
0 0
0 0
1 0
1 0
1 0
0 1
0 1
0 1
0
0
0

1
1
1
1
1
1
1
1
1
1
1
1

1
2
3
4
5
6
7
8
9
10
11
12

Matrix X is of incomplete range, to (cid:28)nd an estimate, the restriction of condition of the e(cid:27)ects is added,
for example the weighted sum for repetitions of the e(cid:27)ects is zero to the matrix X and thus it is
complete, in this way the estimators are found.

> X<- rbind(X,c(0,3,3,3,3))
> y<-sweetpotato[,2]
> Y<- c(y,0)
> XX<-t(X)%*%X
> XY<-t(X)%*%Y
> YY<-t(Y)%*%Y
> beta<-solve(XX,XY)

25

> e<-Y-X%*%beta
> tau<- beta[-1,]
> print(tau) #Efectos de tratamientos

fc
-3.225000 -14.758333

cc

ff
8.708333

oo
9.275000

Unadjusted sums of squares

> SCtot<-t(Y)%*%Y
> SCb<-t(beta)%*%XX%*%beta
> SCe<-t(e)%*%e
> SS<-rbind(SCtot,SCb,SCe)
> dimnames(SS)<-list(c("Total","model","Error"),"SC")
> print(SS)

SC
Total 10507.8100
model 10327.8967
179.9133
Error

Adjusted sum of squares and mean square

> trt<-tau
> t<-length(trt)
> XX1<-XX[2:5,2:5]
> SCtot<-t(Y)%*%Y-beta[1,1]%*%XX[1,1]%*%beta[1,1] ; GLtotal<- n-1
> SCt<-trt%*%XX1%*%trt ; GLt <- t-1; GLe<-GLtotal - GLt
> SC<-cbind(c(GLtotal,GLt,GLe),c(SCtot,SCt,SCe))
> MS<-cbind(SC,SC[,2]/SC[,1])
> dimnames(MS)<-list(c("Total","trt","Error"),c("Gl","SC","CM"))
> print(MS)

Gl

SC

CM
Total 11 1350.1225 122.73841
3 1170.2092 390.06972
trt
22.48917
8
Error

179.9133

4 Multiple comparisons

For the analyses, the following functions of agricolae are used: LSD.test, HSD.test, duncan.test,
sche(cid:27)e.test, waller.test, SNK.test, REGW.test, Steel and Torry and Dickey (1997); Hsu (1996) and
d urbin.test, kruskal, friedman, waerden.test and Median.test, Conover (1999).

For every statistical analysis, the data should be organized in columns. For the demonstration, the
agricolae database will be used.

The sweetpotato data correspond to a completely random experiment in (cid:28)eld with plots of 50 sweet
potato plants, subjected to the virus e(cid:27)ect and to a control without virus (See the reference manual
of the package).

26

> data(sweetpotato)
> model<-aov(yield~virus, data=sweetpotato)
> cv.model(model)

[1] 17.1666

> with(sweetpotato,mean(yield))

[1] 27.625

Model parameters: Degrees of freedom and variance of the error:

> df<-df.residual(model)
> MSerror<-deviance(model)/df

4.1 The Least Signi(cid:28)cant Di(cid:27)erence (LSD)

It includes the multiple comparison through the method of the minimum signi(cid:28)cant di(cid:27)erence (Least
Signi(cid:28)cant Di(cid:27)erence), Steel and Torry and Dickey (1997).

> # comparison <- LSD.test(yield,virus,df,MSerror)
> LSD.test(model, "virus",console=TRUE)

Study: model ~ "virus"

LSD t Test for yield

Mean Square Error: 22.48917

virus,

means and individual ( 95 %) CI

yield

std r

Min
cc 24.40000 3.609709 3 2.737953 18.086268 30.71373 21.7
fc 12.86667 2.159475 3 2.737953
6.552935 19.18040 10.6
ff 36.33333 7.333030 3 2.737953 30.019601 42.64707 28.0
oo 36.90000 4.300000 3 2.737953 30.586268 43.21373 32.1

UCL

LCL

se

Q50

Max

Q75
Q25
cc 28.5 22.35 23.0 25.75
fc 14.9 11.85 13.1 14.00
ff 41.8 33.60 39.2 40.50
oo 40.4 35.15 38.2 39.30

Alpha: 0.05 ; DF Error: 8
Critical Value of t: 2.306004

least Significant Difference: 8.928965

Treatments with the same letter are not significantly different.

27

yield groups
a
a
b
c

oo 36.90000
ff 36.33333
cc 24.40000
fc 12.86667

In the function LSD.test, the multiple comparison was carried out. In order to obtain the probabilities
of the comparisons, it should be indicated that groups are not required; thus:

> # comparison <- LSD.test(yield, virus,df, MSerror, group=FALSE)
> outLSD <-LSD.test(model, "virus", group=FALSE,console=TRUE)

Study: model ~ "virus"

LSD t Test for yield

Mean Square Error: 22.48917

virus,

means and individual ( 95 %) CI

yield

std r

Min
cc 24.40000 3.609709 3 2.737953 18.086268 30.71373 21.7
fc 12.86667 2.159475 3 2.737953
6.552935 19.18040 10.6
ff 36.33333 7.333030 3 2.737953 30.019601 42.64707 28.0
oo 36.90000 4.300000 3 2.737953 30.586268 43.21373 32.1

LCL

UCL

se

Q50

Max

Q75
Q25
cc 28.5 22.35 23.0 25.75
fc 14.9 11.85 13.1 14.00
ff 41.8 33.60 39.2 40.50
oo 40.4 35.15 38.2 39.30

Alpha: 0.05 ; DF Error: 8
Critical Value of t: 2.306004

Comparison between treatments means

difference pvalue signif.
*
cc - fc
11.5333333 0.0176
* -20.862299
cc - ff -11.9333333 0.0151
cc - oo -12.5000000 0.0121
* -21.428965
fc - ff -23.4666667 0.0003
fc - oo -24.0333333 0.0003
-0.5666667 0.8873
ff - oo

UCL
2.604368 20.462299
-3.004368
-3.571035
*** -32.395632 -14.537701
*** -32.962299 -15.104368
8.362299

-9.495632

LCL

Signif. codes:

0 *** 0.001 ** 0.01 * 0.05 . 0.1 ’ ’ 1

> options(digits=2)
> print(outLSD)

28

$statistics

MSerror Df Mean CV t.value LSD
2.3 8.9
28 17

22

8

$parameters

test p.ajusted name.t ntr alpha
4 0.05

virus

none

Fisher-LSD

$means

yield std r

se

24 3.6 3 2.7 18.1
13 2.2 3 2.7 6.6 19
36 7.3 3 2.7 30.0
37 4.3 3 2.7 30.6

LCL UCL Min Max Q25 Q50 Q75
26
28
14
15
40
42
39
40

31 22
11
43 28
43 32

23
13
39
38

22
12
34
35

cc
fc
ff
oo

$comparison

difference pvalue signif.
*
* -20.9
* -21.4

11.53 0.0176
-11.93 0.0151
-12.50 0.0121
-23.47 0.0003
-24.03 0.0003
-0.57 0.8873

UCL
LCL
2.6 20.5
-3.0
-3.6
*** -32.4 -14.5
*** -33.0 -15.1
8.4
-9.5

cc - fc
cc - ff
cc - oo
fc - ff
fc - oo
ff - oo

$groups
NULL

attr(,"class")
[1] "group"

4.2 holm, hommel, hochberg, bonferroni, BH, BY, fdr

With the function LSD.test we can make adjustments to the probabilities found, as for example the
adjustment by Bonferroni, holm and other options see Adjust P-values for Multiple Comparisons,
function p.adjust(stats), ?.

> LSD.test(model, "virus", group=FALSE, p.adj= "bon",console=TRUE)

Study: model ~ "virus"

LSD t Test for yield
P value adjustment method: bonferroni

Mean Square Error: 22

virus,

means and individual ( 95 %) CI

yield std r

se

24 3.6 3 2.7 18.1
13 2.2 3 2.7 6.6 19

LCL UCL Min Max Q25 Q50 Q75
26
28
14
15

31 22
11

23
13

22
12

cc
fc

29

ff
oo

36 7.3 3 2.7 30.0
37 4.3 3 2.7 30.6

43 28
43 32

42
40

34
35

39
38

40
39

Alpha: 0.05 ; DF Error: 8
Critical Value of t: 3.5

Comparison between treatments means

difference pvalue signif.

cc - fc
cc - ff
cc - oo
fc - ff
fc - oo
ff - oo

11.53 0.1058
-11.93 0.0904
-12.50 0.0725
-23.47 0.0018
-24.03 0.0015
-0.57 1.0000

LCL

. -25.4
. -26.0

UCL
-1.9 25.00
1.54
0.97
** -36.9 -10.00
** -37.5 -10.56
12.90

-14.0

> out<-LSD.test(model, "virus", group=TRUE, p.adj= "holm")
> print(out$group)

yield groups
a
a
b
c

37
36
24
13

oo
ff
cc
fc

> out<-LSD.test(model, "virus", group=FALSE, p.adj= "holm")
> print(out$comparison)

cc - fc
cc - ff
cc - oo
fc - ff
fc - oo
ff - oo

difference pvalue signif.
*
*
*
**
**

11.53 0.0484
-11.93 0.0484
-12.50 0.0484
-23.47 0.0015
-24.03 0.0015
-0.57 0.8873

Other comparison tests can be applied, such as duncan, Student-Newman-Keuls, tukey and waller-
duncan

For Duncan, use the function duncan.test; for Student-Newman-Keuls, the function SNK.test; for
Tukey, the function HSD.test; for Sche(cid:27)e, the function sche(cid:27)e.test and for Waller-Duncan, the function
waller.test. The arguments are the same. Waller also requires the value of F-calculated of the ANOVA
treatments. If the model is used as a parameter, this is no longer necessary.

4.3 Duncan’s New Multiple-Range Test

It corresponds to the Duncan’s Test, Steel and Torry and Dickey (1997).

> duncan.test(model, "virus",console=TRUE)

30

Study: model ~ "virus"

’

Duncan
for yield

s new multiple range test

Mean Square Error: 22

virus,

means

yield std r

24 3.6 3 2.7 22 28
13 2.2 3 2.7 11 15
36 7.3 3 2.7 28 42
37 4.3 3 2.7 32 40

se Min Max Q25 Q50 Q75
26
14
40
39

22
12
34
35

23
13
39
38

cc
fc
ff
oo

Alpha: 0.05 ; DF Error: 8

Critical Range
3

4
8.9 9.3 9.5

2

Means with the same letter are not significantly different.

yield groups
a
a
b
c

37
36
24
13

oo
ff
cc
fc

4.4 Student-Newman-Keuls

Student, Newman and Keuls helped to improve the Newman-Keuls test of 1939, which was known as
the Keuls method, Steel and Torry and Dickey (1997).

> # SNK.test(model, "virus", alpha=0.05,console=TRUE)
> SNK.test(model, "virus", group=FALSE,console=TRUE)

Study: model ~ "virus"

Student Newman Keuls Test
for yield

Mean Square Error: 22

virus,

means

yield std r

24 3.6 3 2.7 22 28
13 2.2 3 2.7 11 15
36 7.3 3 2.7 28 42

se Min Max Q25 Q50 Q75
26
14
40

23
13
39

22
12
34

cc
fc
ff

31

oo

37 4.3 3 2.7 32 40

35

38

39

Comparison between treatments means

cc - fc
cc - ff
cc - oo
fc - ff
fc - oo
ff - oo

difference pvalue signif.
*
* -20.9
* -23.6

11.53 0.0176
-11.93 0.0151
-12.50 0.0291
-23.47 0.0008
-24.03 0.0012
-0.57 0.8873

LCL
UCL
2.6 20.5
-3.0
-1.4
*** -34.5 -12.4
** -36.4 -11.6
8.4

-9.5

4.5 Ryan, Einot and Gabriel and Welsch

Multiple range tests for all pairwise comparisons, to obtain a con(cid:28)dent inequalities multiple range
tests, Hsu (1996).

> # REGW.test(model, "virus", alpha=0.05,console=TRUE)
> REGW.test(model, "virus", group=FALSE,console=TRUE)

Study: model ~ "virus"

Ryan, Einot and Gabriel and Welsch multiple range test
for yield

Mean Square Error: 22

virus,

means

yield std r

24 3.6 3 2.7 22 28
13 2.2 3 2.7 11 15
36 7.3 3 2.7 28 42
37 4.3 3 2.7 32 40

se Min Max Q25 Q50 Q75
26
14
40
39

23
13
39
38

22
12
34
35

cc
fc
ff
oo

Comparison between treatments means

cc - fc
cc - ff
cc - oo
fc - ff
fc - oo
ff - oo

difference pvalue signif.
*
* -23.00
* -24.90

11.53 0.0350
-11.93 0.0360
-12.50 0.0482
-23.47 0.0006
-24.03 0.0007
-0.57 0.9873

LCL

UCL
0.91 22.16
-0.87
-0.10
*** -34.09 -12.84
*** -35.10 -12.97
10.06

-11.19

4.6 Tukey’s W Procedure (HSD)

This studentized range test, created by Tukey in 1953, is known as the Tukey’s HSD (Honestly Signif-
icant Di(cid:27)erences), Steel and Torry and Dickey (1997).

32

> outHSD<- HSD.test(model, "virus",console=TRUE)

Study: model ~ "virus"

HSD Test for yield

Mean Square Error: 22

virus,

means

yield std r

24 3.6 3 2.7 22 28
13 2.2 3 2.7 11 15
36 7.3 3 2.7 28 42
37 4.3 3 2.7 32 40

se Min Max Q25 Q50 Q75
26
14
40
39

22
12
34
35

23
13
39
38

cc
fc
ff
oo

Alpha: 0.05 ; DF Error: 8
Critical Value of Studentized Range: 4.5

Minimun Significant Difference: 12

Treatments with the same letter are not significantly different.

yield groups
a
ab
bc
c

37
36
24
13

oo
ff
cc
fc

> outHSD

$statistics

MSerror Df Mean CV MSD
28 17 12

22

8

$parameters

test name.t ntr StudentizedRange alpha
0.05

virus

4.5

Tukey

4

$means

yield std r

24 3.6 3 2.7 22 28
13 2.2 3 2.7 11 15
36 7.3 3 2.7 28 42
37 4.3 3 2.7 32 40

se Min Max Q25 Q50 Q75
26
14
40
39

23
13
39
38

22
12
34
35

cc
fc
ff
oo

$comparison
NULL

$groups

yield groups

33

oo
ff
cc
fc

37
36
24
13

a
ab
bc
c

attr(,"class")
[1] "group"

4.7 Tukey (HSD) for di(cid:27)erent repetition

Include the argument unbalanced = TRUE in the function. Valid for group = TRUE/FALSE

> A<-sweetpotato[-c(4,5,7),]
> modelUnbalanced <- aov(yield ~ virus, data=A)
> outUn <-HSD.test(modelUnbalanced, "virus",group=FALSE, unbalanced = TRUE)
> print(outUn$comparison)

cc - fc
cc - ff
cc - oo
fc - ff
fc - oo
ff - oo

difference pvalue signif. LCL
0.252
0.386
0.196
0.040
0.022
0.917

UCL
-8 30.6
-28 10.1
6.8
-32
* -40 -1.2
* -43 -4.5
-23 16.0

11.3
-9.2
-12.5
-20.5
-23.8
-3.3

> outUn <-HSD.test(modelUnbalanced, "virus",group=TRUE, unbalanced = TRUE)
> print(outUn$groups)

yield groups
a
a
ab
b

37
34
24
13

oo
ff
cc
fc

If this argument is not included, the probabilities of signi(cid:28)cance will not be consistent with the choice
of groups.

Illustrative example of this inconsistency:

> outUn <-HSD.test(modelUnbalanced, "virus",group=FALSE)
> print(outUn$comparison[,1:2])

cc - fc
cc - ff
cc - oo
fc - ff
fc - oo
ff - oo

difference pvalue
0.317
11.3
0.297
-9.2
0.096
-12.5
0.071
-20.5
0.033
-23.8
0.885
-3.3

34

> outUn <-HSD.test(modelUnbalanced, "virus",group=TRUE)
> print(outUn$groups)

yield groups
a
ab
ab
b

37
34
24
13

oo
ff
cc
fc

4.8 Waller-Duncan’s Bayesian K-Ratio T-Test

Duncan continued the multiple comparison procedures, introducing the criterion of minimizing both
experimental errors; for this, he used the Bayes’ theorem, obtaining one new test called Waller-Duncan,
Waller and Duncan (1969); Steel and Torry and Dickey (1997).

> # variance analysis:
> anova(model)

Analysis of Variance Table

Response: yield

Df Sum Sq Mean Sq F value

Pr(>F)

3
8

1170
180

virus
Residuals
---
Signif. codes:
0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

17.3 0.00073 ***

390
22

> with(sweetpotato,waller.test(yield,virus,df,MSerror,Fc= 17.345, group=FALSE,console=TRUE))

Study: yield ~ virus

Waller-Duncan K-ratio t Test for yield

This test minimizes the Bayes risk under additive loss and certain other assumptions

K ratio
Error Degrees of Freedom
Error Mean Square
F value
Critical Value of Waller

......
100.0
8.0
22.5
17.3
2.2

virus,

means

yield std r

24 3.6 3 2.7 22 28
13 2.2 3 2.7 11 15
36 7.3 3 2.7 28 42
37 4.3 3 2.7 32 40

se Min Max Q25 Q50 Q75
26
14
40
39

23
13
39
38

22
12
34
35

cc
fc
ff
oo

35

Comparison between treatments means

cc - fc
cc - ff
cc - oo
fc - ff
fc - oo
ff - oo

Difference significant
TRUE
TRUE
TRUE
TRUE
TRUE
FALSE

11.53
-11.93
-12.50
-23.47
-24.03
-0.57

In another case with only invoking the model object:

> outWaller <- waller.test(model, "virus", group=FALSE,console=FALSE)

The found object outWaller has information to make other procedures.

> names(outWaller)

[1] "statistics" "parameters" "means"
[5] "groups"

"comparison"

> print(outWaller$comparison)

cc - fc
cc - ff
cc - oo
fc - ff
fc - oo
ff - oo

Difference significant
TRUE
TRUE
TRUE
TRUE
TRUE
FALSE

11.53
-11.93
-12.50
-23.47
-24.03
-0.57

It is indicated that the virus e(cid:27)ect "(cid:27)" is not signi(cid:28)cant to the control "oo".

> outWaller$statistics

Mean Df CV MSerror F.Value Waller CriticalDifference
8.7

8 17

2.2

17

22

28

4.9 Sche(cid:27)e’s Test

This method, created by Sche(cid:27)e in 1959, is very general for all the possible contrasts and their con(cid:28)-
dence intervals. The con(cid:28)dence intervals for the averages are very broad, resulting in a very conservative
test for the comparison between treatment averages, Steel and Torry and Dickey (1997).

> # analysis of variance:
> scheffe.test(model,"virus", group=TRUE,console=TRUE,
+ main="Yield of sweetpotato\nDealt with different virus")

36

Study: Yield of sweetpotato
Dealt with different virus

Scheffe Test for yield

Mean Square Error

: 22

virus,

means

yield std r

24 3.6 3 2.7 22 28
13 2.2 3 2.7 11 15
36 7.3 3 2.7 28 42
37 4.3 3 2.7 32 40

se Min Max Q25 Q50 Q75
26
14
40
39

23
13
39
38

22
12
34
35

cc
fc
ff
oo

Alpha: 0.05 ; DF Error: 8
Critical Value of F: 4.1

Minimum Significant Difference: 14

Means with the same letter are not significantly different.

yield groups
a
a
ab
b

37
36
24
13

oo
ff
cc
fc

The minimum signi(cid:28)cant value is very high. If you require the approximate probabilities of comparison,
you can use the option group=FALSE.

> outScheffe <- scheffe.test(model,"virus", group=FALSE, console=TRUE)

Study: model ~ "virus"

Scheffe Test for yield

Mean Square Error

: 22

virus,

means

yield std r

24 3.6 3 2.7 22 28
13 2.2 3 2.7 11 15
36 7.3 3 2.7 28 42
37 4.3 3 2.7 32 40

se Min Max Q25 Q50 Q75
26
14
40
39

22
12
34
35

23
13
39
38

cc
fc
ff
oo

Alpha: 0.05 ; DF Error: 8
Critical Value of F: 4.1

Comparison between treatments means

37

cc - fc
cc - ff
cc - oo
fc - ff
fc - oo
ff - oo

UCL
Difference pvalue sig LCL
25.1
.
-2
1.6
. -25
1.0
. -26
** -37
-9.9
** -38 -10.5
13.0

11.53 0.0978
-11.93 0.0855
-12.50 0.0706
-23.47 0.0023
-24.03 0.0020
-0.57 0.9991

-14

4.10 Multiple comparison in factorial treatments

In a factorial combined e(cid:27)ects of the treatments. Comparetive tests: LSD, HSD, Waller-Duncan,
Duncan, Sche(cid:27)Ø, SNK can be applied.

> # modelABC <-aov (y ~ A * B * C, data)
> # compare <-LSD.test (modelABC, c ("A", "B", "C"),console=TRUE)

The comparison is the combination of A:B:C.

Data RCBD design with a factorial clone x nitrogen. The response variable yield.

"6 7 9 13 16 20 8 8 9

7 8 8 12 17 18 10 9 12
9 9 9 14 18 21 11 12 11
8 10 10 15 16 22 9 9 9 "

> yield <-scan (text =
+
+
+
+
+
> block <-gl (4, 9)
> clone <-rep (gl (3, 3, labels = c ("c1", "c2", "c3")), 4)
> nitrogen <-rep (gl (3, 1, labels = c ("n1", "n2", "n3")), 12)
> A <-data.frame (block, clone, nitrogen, yield)
> head (A)

)

block clone nitrogen yield
6
7
9
13
16
20

c1
c1
c1
c2
c2
c2

n1
n2
n3
n1
n2
n3

1
1
1
1
1
1

1
2
3
4
5
6

> outAOV <-aov (yield ~ block + clone * nitrogen, data = A)

> anova (outAOV)

Analysis of Variance Table

Response: yield

block

3

21

6.9

5.82 0.00387 **

Df Sum Sq Mean Sq F value

Pr(>F)

38

2
clone
nitrogen
2
clone:nitrogen 4
24
Residuals
---
Signif. codes:
0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

248.9
27.0
10.8
1.2

498
54
43
29

209.57 6.4e-16 ***
22.76 2.9e-06 ***
9.11 0.00013 ***

> outFactorial <-LSD.test (outAOV, c("clone", "nitrogen"),
+ main = "Yield ~ block + nitrogen + clone + clone:nitrogen",console=TRUE)

Study: Yield ~ block + nitrogen + clone + clone:nitrogen

LSD t Test for yield

Mean Square Error: 1.2

clone:nitrogen,

means and individual ( 95 %) CI

yield

Q50
7.5
8.5
9.0

se
std r
7.5 1.29 4 0.54
8.5 1.29 4 0.54
9.0 0.82 4 0.54

Q75
LCL UCL Min Max Q25
8.2
8.6
6.8
6.4
9.2
7.4
7.8
9.6
10 8.8
9.2
7.9 10.1
15 12.8 13.5 14.2
13.5 1.29 4 0.54 12.4 14.6
18 16.0 16.5 17.2
16.8 0.96 4 0.54 15.6 17.9
22 19.5 20.5 21.2
20.2 1.71 4 0.54 19.1 21.4
9.5 10.2
11 8.8
8.4 10.6
9.0
12 8.8
8.4 10.6
9.8
9.0 10.0 11.2
12
9.1 11.4

9
6
7 10
8
12
16
18
8
8
9

9.5 1.29 4 0.54
9.5 1.73 4 0.54
10.2 1.50 4 0.54

c1:n1
c1:n2
c1:n3
c2:n1
c2:n2
c2:n3
c3:n1
c3:n2
c3:n3

Alpha: 0.05 ; DF Error: 24
Critical Value of t: 2.1

least Significant Difference: 1.6

Treatments with the same letter are not significantly different.

yield groups
a
b
c
d
de
de
def
ef
f

20.2
16.8
13.5
10.2
9.5
9.5
9.0
8.5
7.5

c2:n3
c2:n2
c2:n1
c3:n3
c3:n1
c3:n2
c1:n3
c1:n2
c1:n1

> oldpar<-par(mar=c(3,3,2,0))
> pic1<-bar.err(outFactorial$means,variation="range",ylim=c(5,25), bar=FALSE,col=0,las=1)
> points(pic1$index,pic1$means,pch=18,cex=1.5,col="blue")

39

> axis(1,pic1$index,labels=FALSE)
> title(main="average and range\nclon:nitrogen")
> par(oldpar)

4.11 Analysis of Balanced Incomplete Blocks

This analysis can come from balanced or partially balanced designs. The function B IB.test is for
balanced designs, and B IB.test, for partially balanced designs. In the following example, the agricolae
data will be used, Joshi (1987).

> # Example linear estimation and design of experiments. (Joshi)
> # Institute of Social Sciences Agra, India
> # 6 varieties of wheat in 10 blocks of 3 plots each.
> block<-gl(10,3)
> variety<-c(1,2,3,1,2,4,1,3,5,1,4,6,1,5,6,2,3,6,2,4,5,2,5,6,3,4,5,3, 4,6)
> Y<-c(69,54,50,77,65,38,72,45,54,63,60,39,70,65,54,65,68,67,57,60,62,
+ 59,65,63,75,62,61,59,55,56)
> head(cbind(block,variety,Y))

block variety

[1,]
[2,]
[3,]
[4,]
[5,]
[6,]

1
1
1
2
2
2

Y
1 69
2 54
3 50
1 77
2 65
4 38

> BIB.test(block, variety, Y,console=TRUE)

ANALYSIS BIB:
Class level information

Y

Block:
:
Trt

1 2 3 4 5 6 7 8 9 10
1 2 3 4 5 6

Number of observations:

30

Analysis of Variance Table

Response: Y

Df Sum Sq Mean Sq F value Pr(>F)
0.547
0.016 *

block.unadj 9
trt.adj
5
Residuals
15
---
Signif. codes:
0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

51.9
231.3
57.5

467
1156
863

0.90
4.02

coefficient of variation: 13 %
Y Means: 60

40

variety,

statistics

Y mean.adj

1 70
2 60
3 59
4 55
5 61
6 56

std Min Max
SE r
77
63
5.1
75 3.7 5
65
54
59 3.7 5
4.9
75
45
59 3.7 5 12.4
62
38
9.8
55 3.7 5
65
54
60 3.7 5
4.5
67
39
54 3.7 5 10.8

: 5.4
: 0.05
: 11

LSD test
Std.diff
Alpha
LSD
Parameters BIB
: 2
Lambda
treatmeans : 6
Block size : 3
Blocks
Replication: 5

: 10

Efficiency factor 0.8

<<< Book >>>

Comparison between treatments means
Difference pvalue sig.
**
16.42 0.0080
**
16.58 0.0074
**
20.17 0.0018
*
15.08 0.0132
20.75 0.0016
**
0.17 0.9756
3.75 0.4952
-1.33 0.8070
4.33 0.4318
3.58 0.5142
-1.50 0.7836
4.17 0.4492
-5.08 0.3582
0.58 0.9148
5.67 0.3074

1 - 2
1 - 3
1 - 4
1 - 5
1 - 6
2 - 3
2 - 4
2 - 5
2 - 6
3 - 4
3 - 5
3 - 6
4 - 5
4 - 6
5 - 6

Treatments with the same letter are not significantly different.

Y groups
a
b
b
b

1 75
5 60
2 59
3 59

41

4 55
6 54

b
b

function (block, trt, Y, test = c("lsd", "tukey", "duncan", "waller", "snk"), alpha = 0.05,
group = TRUE) LSD, Tukey Duncan, Waller-Duncan and SNK, can be used. The probabilities of
the comparison can also be obtained. It should only be indicated: group=FALSE, thus:

> out <-BIB.test(block, trt=variety, Y, test="tukey", group=FALSE, console=TRUE)

ANALYSIS BIB:
Class level information

Y

Block:
:
Trt

1 2 3 4 5 6 7 8 9 10
1 2 3 4 5 6

Number of observations:

30

Analysis of Variance Table

Response: Y

Df Sum Sq Mean Sq F value Pr(>F)
0.547
0.016 *

block.unadj 9
trt.adj
5
Residuals
15
---
Signif. codes:
0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

51.9
231.3
57.5

467
1156
863

0.90
4.02

coefficient of variation: 13 %
Y Means: 60

variety,

statistics

Y mean.adj

std Min Max
SE r
77
63
5.1
75 3.7 5
65
54
59 3.7 5
4.9
75
45
59 3.7 5 12.4
62
38
9.8
55 3.7 5
65
54
60 3.7 5
4.5
67
39
54 3.7 5 10.8

1 70
2 60
3 59
4 55
5 61
6 56

: 0.05
: 3.8
: 17

Tukey
Alpha
Std.err
HSD
Parameters BIB
Lambda
: 2
treatmeans : 6
Block size : 3
Blocks
Replication: 5

: 10

42

Efficiency factor 0.8

<<< Book >>>

Comparison between treatments means
Difference pvalue sig.
.
.
*

*

1 - 2
1 - 3
1 - 4
1 - 5
1 - 6
2 - 3
2 - 4
2 - 5
2 - 6
3 - 4
3 - 5
3 - 6
4 - 5
4 - 6
5 - 6

16.42
16.58
20.17
15.08
20.75
0.17
3.75
-1.33
4.33
3.58
-1.50
4.17
-5.08
0.58
5.67

0.070
0.067
0.019
0.110
0.015
1.000
0.979
1.000
0.962
0.983
1.000
0.967
0.927
1.000
0.891

> names(out)

[1] "parameters" "statistics" "comparison" "means"
[5] "groups"

> rm(block,variety)

bar.group: out$groups

bar.err: out$means

4.12 Partially Balanced Incomplete Blocks

The function PBIB.test Joshi (1987), can be used for the lattice and alpha designs.

Consider the following case: Construct the alpha design with 30 treatments, 2 repetitions, and a block
size equal to 3.

> # alpha design
> Genotype<-paste("geno",1:30,sep="")
> r<-2
> k<-3
> plan<-design.alpha(Genotype,k,r,seed=5)

Alpha Design (0,1) - Serie I

Parameters Alpha Design
=======================

43

Treatmeans : 30
Block size : 3
Blocks
Replication: 2

: 10

Efficiency factor
(E ) 0.62

<<< Book >>>

The generated plan is plan$book. Suppose that the corresponding observation to each experimental
unit is:

> yield <-c(5,2,7,6,4,9,7,6,7,9,6,2,1,1,3,2,4,6,7,9,8,7,6,4,3,2,2,1,1,
+

2,1,1,2,4,5,6,7,8,6,5,4,3,1,1,2,5,4,2,7,6,6,5,6,4,5,7,6,5,5,4)

The data table is constructed for the analysis. In theory, it is presumed that a design is applied and
the experiment is carried out; subsequently, the study variables are observed from each experimental
unit.

> data<-data.frame(plan$book,yield)
> # The analysis:
> modelPBIB <- with(data,PBIB.test(block, Genotype, replication, yield, k=3,
+

group=TRUE, console=TRUE))

ANALYSIS PBIB: yield

Class level information
block : 20
Genotype : 30

Number of observations:

60

Estimation Method:

Residual (restricted) maximum likelihood

Parameter Estimates

block:replication
replication
Residual

Variance
3.8e+00
6.1e-09
1.7e+00

AIC
BIC
-2 Res Log Likelihood

Fit Statistics
214
260
-74

Analysis of Variance Table

Response: yield

Df Sum Sq Mean Sq F value Pr(>F)

44

Genotype
29
Residuals 11

69.2
18.7

2.39
1.70

1.4

0.28

Coefficient of variation: 29 %
yield Means: 4.5

Parameters PBIB

.
30
Genotype
block size
3
block/replication 10
2
replication

Efficiency factor 0.62

Comparison test lsd

Treatments with the same letter are not significantly different.

geno10
geno19
geno1
geno9
geno18
geno16
geno26
geno8
geno17
geno29
geno27
geno11
geno30
geno22
geno28
geno5
geno14
geno23
geno15
geno2
geno4
geno3
geno25
geno12
geno6
geno21
geno24
geno13
geno20
geno7

yield.adj groups
a
7.7
ab
6.7
ab
6.7
abc
6.4
abc
6.1
abcd
5.7
abcd
5.2
abcd
5.2
abcd
5.2
abcd
4.9
abcd
4.9
abcd
4.9
abcd
4.8
abcd
4.5
abcd
4.5
abcd
4.2
abcd
4.1
abcd
4.0
abcd
3.9
bcd
3.8
bcd
3.8
bcd
3.7
bcd
3.6
bcd
3.6
bcd
3.6
bcd
3.4
bcd
3.0
cd
2.8
cd
2.7
d
2.3

45

<<< to see the objects: means, comparison and groups. >>>

The adjusted averages can be extracted from the modelPBIB.

head(modelPBIB$means)

The comparisons:

head(modelPBIB$comparison)

The data on the adjusted averages and their variation can be illustrated with the functions plot.group
and bar.err. Since the created object is very similar to the objects generated by the multiple compar-
isons.

Analysis of balanced lattice 3x3, 9 treatments, 4 repetitions.

Create the data in a text (cid:28)le: latice3x3.txt and read with R:

1 1 1 48.76
1 2 8 10.83
1 3 5 12.54
2 4 5 11.07
2 5 2 22.00
2 6 9 47.43
3 7 2 27.67
3 8 7 30.00
3 9 3 13.78
4 10 6 37.00
4 11 4 42.37
4 12 9 39.00

sqr block trt yield
1 1 4 14.46
1 2 6 30.69
1 3 9 42.01
2 4 8 22.00
2 5 7 42.80
2 6 6 28.28
3 7 1 50.00
3 8 5 24.00
3 9 8 24.00
4 10 3 15.42
4 11 2 30.00
4 12 7 23.80

1 1 3 19.68
1 2 7 31.00
1 3 2 23.00
2 4 1 41.00
2 5 3 12.90
2 6 4 49.95
3 7 6 25.00
3 8 4 45.57
3 9 9 30.00
4 10 5 20.00
4 11 8 18.00
4 12 1 43.81

> trt<-c(1,8,5,5,2,9,2,7,3,6,4,9,4,6,9,8,7,6,1,5,8,3,2,7,3,7,2,1,3,4,6,4,9,5,8,1)
> yield<-c(48.76,10.83,12.54,11.07,22,47.43,27.67,30,13.78,37,42.37,39,14.46,30.69,42.01,
+ 22,42.8,28.28,50,24,24,15.42,30,23.8,19.68,31,23,41,12.9,49.95,25,45.57,30,20,18,43.81)
> sqr<-rep(gl(4,3),3)
> block<-rep(1:12,3)
> modelLattice<-PBIB.test(block,trt,sqr,yield,k=3,console=TRUE, method="VC")

ANALYSIS PBIB: yield

Class level information
block : 12
trt : 9

Number of observations:

36

Estimation Method:

Variances component model

Fit Statistics
265
298

AIC
BIC

Analysis of Variance Table

46

Response: yield

Df Sum Sq Mean Sq F value

Pr(>F)
0.69 0.57361
7.24 0.00042 ***
0.71 0.67917

3
8
8
16

133
3749
368
1036

sqr
trt.unadj
block/sqr
Residual
---
Signif. codes:
0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

44
469
46
65

Coefficient of variation: 28 %
yield Means: 29

Parameters PBIB

.
trt
9
block size 3
3
block/sqr
4
sqr

Efficiency factor 0.75

Comparison test lsd

Treatments with the same letter are not significantly different.

yield.adj groups
a
44
ab
39
ab
39
bc
32
bc
31
cd
26
d
18
d
17
d
15

1
9
4
7
6
2
8
5
3

<<< to see the objects: means, comparison and groups. >>>

The adjusted averages can be extracted from the modelLattice.

print(modelLattice$means)

The comparisons:

head(modelLattice$comparison)

4.13 Augmented Blocks

The function DAU.test can be used for the analysis of the augmented block design. The data should
be organized in a table, containing the blocks, treatments, and the response.

47

> block<-c(rep("I",7),rep("II",6),rep("III",7))
> trt<-c("A","B","C","D","g","k","l","A","B","C","D","e","i","A","B", "C",
+ "D","f","h","j")
> yield<-c(83,77,78,78,70,75,74,79,81,81,91,79,78,92,79,87,81,89,96, 82)
> head(data.frame(block, trt, yield))

block trt yield
83
77
78
78
70
75

A
B
C
D
g
k

I
I
I
I
I
I

1
2
3
4
5
6

The treatments are in each block:

> by(trt,block,as.character)

block: I
[1] "A" "B" "C" "D" "g" "k" "l"
---------------------------------------------
block: II
[1] "A" "B" "C" "D" "e" "i"
---------------------------------------------
block: III
[1] "A" "B" "C" "D" "f" "h" "j"

With their respective responses:

> by(yield,block,as.character)

block: I
[1] "83" "77" "78" "78" "70" "75" "74"
---------------------------------------------
block: II
[1] "79" "81" "81" "91" "79" "78"
---------------------------------------------
block: III
[1] "92" "79" "87" "81" "89" "96" "82"

Analysis:

> modelDAU<- DAU.test(block,trt,yield,method="lsd",console=TRUE)

ANALYSIS DAU:
Class level information

yield

Block:
:
Trt

I II III
A B C D e f g h i j k l

48

Number of observations:

20

ANOVA, Treatment Adjusted
Analysis of Variance Table

Response: yield

Df Sum Sq Mean Sq F value Pr(>F)

block.unadj
trt.adj
Control
Control + control.VS.aug.
Residuals

2
11
3
8
6

360
285
53
232
162

180.0
25.9
17.6
29.0
27.0

0.96
0.65
1.08

0.55
0.61
0.48

ANOVA, Block Adjusted
Analysis of Variance Table

Response: yield

Df Sum Sq Mean Sq F value Pr(>F)
11
trt.unadj
2
block.adj
3
Control
Augmented
7
Control vs augmented 1
6
Residuals

52.3
34.8
17.6
72.3
16.9
27.0

576
70
53
506
17
162

1.29
0.65
2.68
0.63

0.34
0.61
0.13
0.46

coefficient of variation: 6.4 %
yield Means: 82

Critical Differences (Between)

Two Control Treatments
Two Augmented Treatments (Same Block)
Two Augmented Treatments(Different Blocks)
A Augmented Treatment and A Control Treatment

Std Error Diff.
4.2
7.3
8.2
6.4

Treatments with the same letter are not significantly different.

yield groups
a
ab
ab
ab
ab
ab
ab
ab
ab
ab
ab
b

94
86
85
83
82
80
79
78
78
77
77
73

h
f
A
D
C
j
B
e
k
i
l
g

49

Comparison between treatments means

<<< to see the objects: comparison and means

>>>

> options(digits = 2)
> modelDAU$means

yield std r Min Max Q25 Q50 Q75 mean.adj SE block

A
B
C
D
e
f
g
h
i
j
k
l

85 6.7 3 79
79 2.0 3 77
82 4.6 3 78
83 6.8 3 78
79
79 NA 1
89
89 NA 1
70
70 NA 1
96
96 NA 1
78
78 NA 1
82
82 NA 1
75
75 NA 1
74
74 NA 1

92
81
87
91
79
89
70
96
78
82
75
74

81
78
80
80
79
89
70
96
78
82
75
74

83
79
81
81
79
89
70
96
78
82
75
74

88
80
84
86
79
89
70
96
78
82
75
74

85 3.0
79 3.0
82 3.0
83 3.0
78 5.2
86 5.2
73 5.2
94 5.2
77 5.2
80 5.2
78 5.2
77 5.2

II
III
I
III
II
III
I
I

> modelDAU<- DAU.test(block,trt,yield,method="lsd",group=FALSE,console=FALSE)
> head(modelDAU$comparison,8)

Difference pvalue sig.

A - B
A - C
A - D
A - e
A - f
A - g
A - h
A - i

5.7
2.7
1.3
6.4
-1.8
11.4
-8.8
7.4

0.23
0.55
0.76
0.38
0.79
0.14
0.24
0.31

5 Non-parametric comparisons

The functions for non-parametric multiple comparisons included in agricolae are: kruskal, waer-
den.test, friedman and durbin.test, Conover (1999).

The post hoc nonparametrics tests (kruskal, friedman, durbin and waerden) are using the criterium
Fisher’s least signi(cid:28)cant di(cid:27)erence (LSD).

The function kruskal is used for N samples (N>2), populations or data coming from a completely
random experiment (populations = treatments).

The function waerden.test, similar to kruskal-wallis, uses a normal score instead of ranges as kruskal
does.

The function friedman is used for organoleptic evaluations of di(cid:27)erent products, made by judges (every
judge evaluates all the products). It can also be used for the analysis of treatments of the randomized
complete block design, where the response cannot be treated through the analysis of variance.

50

The function durbin.test for the analysis of balanced incomplete block designs is very used for sampling
tests, where the judges only evaluate a part of the treatments.

The function Median.test for the analysis the distribution is approximate with chi-squared ditribution
with degree free number of groups minus one. In each comparison a table of 2x2 (pair of groups) and
the criterion of greater or lesser value than the median of both are formed, the chi-square test is applied
for the calculation of the probability of error that both are independent. This value is compared to
the alpha level for group formation.

Montgomery book data, Montgomery (2002). Included in the agricolae package

> data(corn)
> str(corn)

’

’

:

34 obs. of

data.frame
$ method
$ observation: int 83 91 94 89 89 96 91 92 90 91 ...
$ rx

: int 1 1 1 1 1 1 1 1 1 2 ...

3 variables:

11 23 28.5 17 17 31.5 23 26 19.5 23 ...

: num

For the examples, the agricolae package data will be used

5.1 Kruskal-Wallis

It makes the multiple comparison with Kruskal-Wallis. The parameters by default are alpha = 0.05.

> str(kruskal)

function (y, trt, alpha = 0.05, p.adj = c("none", "holm",

"hommel", "hochberg", "bonferroni", "BH", "BY",
"fdr"), group = TRUE, main = NULL, console = FALSE)

Analysis

> outKruskal<-with(corn,kruskal(observation,method,group=TRUE, main="corn", console=TRUE))

Study: corn
Kruskal-Wallis test
Ties or no Ties

’

s

Critical Value: 26
Degrees of freedom: 3
Pvalue Chisq

: 1.1e-05

method,

means of the ranks

r
observation
21.8
9
15.3 10
7
29.6
8
4.8

1
2
3
4

51

Post Hoc Analysis

t-Student: 2
Alpha
Groups according to probability of treatment differences and alpha level.

: 0.05

Treatments with the same letter are not significantly different.

observation groups
a
29.6
b
21.8
c
15.3
d
4.8

3
1
2
4

The object output has the same structure of the comparisons see the functions plot.group(agricolae),
bar.err(agricolae) and bar.group(agricolae).

5.2 Kruskal-Wallis: adjust P-values

To see p.adjust.methods()

> out<-with(corn,kruskal(observation,method,group=TRUE, main="corn", p.adj="holm"))
> print(out$group)

observation groups
a
29.6
b
21.8
c
15.3
d
4.8

3
1
2
4

> out<-with(corn,kruskal(observation,method,group=FALSE, main="corn", p.adj="holm"))
> print(out$comparison)

Difference pvalue Signif.
**
6.5 0.0079
**
-7.7 0.0079
***
17.0 0.0000
***
-14.3 0.0000
***
10.5 0.0003
***
24.8 0.0000

1 - 2
1 - 3
1 - 4
2 - 3
2 - 4
3 - 4

5.3 Friedman

The data consist of b mutually independent k-variate random variables called b blocks. The random
variable is in a block and is associated with treatment.
It makes the multiple comparison of the
Friedman test with or without ties. A (cid:28)rst result is obtained by friedman.test of R.

> str(friedman)

52

function (judge, trt, evaluation, alpha = 0.05, group = TRUE,

main = NULL, console = FALSE)

Analysis

> data(grass)
> out<-with(grass,friedman(judge,trt, evaluation,alpha=0.05, group=FALSE,
+ main="Data of the book of Conover",console=TRUE))

Study: Data of the book of Conover

trt,

Sum of the ranks

evaluation

r
38 12
24 12
24 12
34 12

t1
t2
t3
t4

’

s Test
Friedman
===============
Adjusted for ties
Critical Value: 8.1
P.Value Chisq: 0.044
F Value: 3.2
P.Value F: 0.036

Post Hoc Analysis

Comparison between treatments
Sum of the ranks

t1 - t2
t1 - t3
t1 - t4
t2 - t3
t2 - t4
t3 - t4

difference pvalue signif.
*
*

14.5
13.5
4.0
-1.0
-10.5
-9.5

0.015
0.023
0.483
0.860
0.072
0.102

UCL
LCL
3.0 25.98
2.0 24.98
-7.5 15.48
-12.5 10.48
0.98
1.98

. -22.0
-21.0

5.4 Waerden

A nonparametric test for several independent samples. Example applied with the sweet potato data
in the agricolae basis.

> str(waerden.test)

function (y, trt, alpha = 0.05, group = TRUE, main = NULL,

console = FALSE)

53

Analysis

> data(sweetpotato)
> outWaerden<-with(sweetpotato,waerden.test(yield,virus,alpha=0.01,group=TRUE,console=TRUE))

Study: yield ~ virus
Van der Waerden (Normal Scores) test

’

s

Value : 8.4
Pvalue: 0.038
Degrees of Freedom: 3

virus,

means of the normal score

yield

std r
cc -0.23 0.30 3
fc -1.06 0.35 3
0.69 0.76 3
ff
0.60 0.37 3
oo

Post Hoc Analysis

Alpha: 0.01 ; DF Error: 8

Minimum Significant Difference: 1.3

Treatments with the same letter are not significantly different.

Means of the normal score

score groups
a
a
ab
b

0.69
ff
0.60
oo
cc -0.23
fc -1.06

The comparison probabilities are obtained with the parameter group = FALSE

> names(outWaerden)

[1] "statistics" "parameters" "means"
[5] "groups"

"comparison"

>

To see outWaerden$comparison

> out<-with(sweetpotato,waerden.test(yield,virus,group=FALSE,console=TRUE))

Study: yield ~ virus
Van der Waerden (Normal Scores) test

’

s

54

Value : 8.4
Pvalue: 0.038
Degrees of Freedom: 3

virus,

means of the normal score

yield

std r
cc -0.23 0.30 3
fc -1.06 0.35 3
0.69 0.76 3
ff
0.60 0.37 3
oo

Post Hoc Analysis

Comparison between treatments
mean of the normal score

difference pvalue signif.

cc - fc
cc - ff
cc - oo
fc - ff
fc - oo
ff - oo

0.827 0.0690
-0.921 0.0476
-0.837 0.0664
-1.749 0.0022
-1.665 0.0029
0.084 0.8363

5.5 Median test

UCL
LCL
. -0.082
1.736
* -1.830 -0.013
0.072
. -1.746
** -2.658 -0.840
** -2.574 -0.756
0.993

-0.825

A nonparametric test for several independent samples. The median test is designed to examine whether
several samples came from populations having the same median, Conover (1999). See also Figure 4.

In each comparison a table of 2x2 (pair of groups) and the criterion of greater or lesser value than the
median of both are formed, the chi-square test is applied for the calculation of the probability of error
that both are independent. This value is compared to the alpha level for group formation.

> str(Median.test)

function (y, trt, alpha = 0.05, correct = TRUE, simulate.p.value = FALSE,

group = TRUE, main = NULL, console = TRUE)

> str(Median.test)

function (y, trt, alpha = 0.05, correct = TRUE, simulate.p.value = FALSE,

group = TRUE, main = NULL, console = TRUE)

Analysis

> data(sweetpotato)
> outMedian<-with(sweetpotato,Median.test(yield,virus,console=TRUE))

55

The Median Test for yield ~ virus

Chi Square = 6.7
Median = 28

DF = 3

P.Value 0.083

Median r Min Max Q25 Q75
26
14
40
39

23 3
13 3
39 3
38 3

22
12
34
35

22
11
28
32

28
15
42
40

cc
fc
ff
oo

Post Hoc Analysis

Groups according to probability of treatment differences and alpha level.

Treatments with the same letter are not significantly different.

yield groups
a
a
a
b

39
38
23
13

ff
oo
cc
fc

> names(outMedian)

[1] "statistics" "parameters" "medians"
[5] "groups"

"comparison"

> outMedian$statistics

Chisq Df p.chisq Median
28

0.083

6.7

3

> outMedian$medians

Median r Min Max Q25 Q75
26
14
40
39

23 3
13 3
39 3
38 3

28
15
42
40

22
12
34
35

22
11
28
32

cc
fc
ff
oo

5.6 Durbin

durbin.test; example: Myles Hollander (p. 311) Source: W. Moore and C.I. Bliss. (1942) A multiple
comparison of the Durbin test for the balanced incomplete blocks for sensorial or categorical evaluation.
It forms groups according to the demanded ones for level of signi(cid:28)cance (alpha); by default, 0.05.

> str(durbin.test)

56

> oldpar<-par(mfrow=c(2,2),mar=c(3,3,1,1),cex=0.8)
> # Graphics
> bar.group(outMedian$groups,ylim=c(0,50))
> bar.group(outMedian$groups,xlim=c(0,50),horiz = TRUE)
> plot(outMedian)
> plot(outMedian,variation="IQR",horiz = TRUE)
> par(oldpar)

Figure 4: Grouping of treatments and its variation, Median method

57

ffooccfc01020304050aaabffooccfc01020304050aaabffooccfcGroups and Range1020304050aaabffooccfcGroups and Interquartile range10203040aaabfunction (judge, trt, evaluation, alpha = 0.05, group = TRUE,

main = NULL, console = FALSE)

Analysis

> days <-gl(7,3)
> chemical<-c("A","B","D","A","C","E","C","D","G","A","F","G", "B","C","F",
+ "B","E","G","D","E","F")
> toxic<-c(0.465,0.343,0.396,0.602,0.873,0.634,0.875,0.325,0.330, 0.423,0.987,0.426,
+ 0.652,1.142,0.989,0.536,0.409,0.309, 0.609,0.417,0.931)
> head(data.frame(days,chemical,toxic))

days chemical toxic
A 0.47
B 0.34
D 0.40
A 0.60
C 0.87
E 0.63

1
1
1
2
2
2

1
2
3
4
5
6

> out<-durbin.test(days,chemical,toxic,group=FALSE,console=TRUE,
+ main="Logarithm of the toxic dose")

Study: Logarithm of the toxic dose
Sum of ranks
chemical,

sum
5
5
9
5
5
8
5

A
B
C
D
E
F
G

Durbin Test
===========
Value
DF 1
P-value
Alpha
DF 2
t-Student

: 7.7
: 6
: 0.26
: 0.05
: 8
: 2.3

Least Significant Difference
between the sum of ranks: 5

Parameters BIB
: 1
Lambda
Treatmeans : 7

58

Block size : 3
Blocks
: 7
Replication: 3

Comparison between treatments
Sum of the ranks

difference pvalue signif.

A - B
A - C
A - D
A - E
A - F
A - G
B - C
B - D
B - E
B - F
B - G
C - D
C - E
C - F
C - G
D - E
D - F
D - G
E - F
E - G
F - G

0
-4
0
0
-3
0
-4
0
0
-3
0
4
4
1
4
0
-3
0
-3
0
3

1.00
0.10
1.00
1.00
0.20
1.00
0.10
1.00
1.00
0.20
1.00
0.10
0.10
0.66
0.10
1.00
0.20
1.00
0.20
1.00
0.20

> names(out)

[1] "statistics" "parameters" "means"
[5] "comparison" "groups"

"rank"

> out$statistics

chisq.value p.value t.value LSD
5

0.26

2.3

7.7

6 Graphics of the multiple comparison

The results of a comparison can be graphically seen with the functions bar.group, bar.err and di(cid:27)ograph.

6.1 bar.group

A function to plot horizontal or vertical bar, where the letters of groups of treatments is expressed.
The function applies to all functions comparison treatments. Each object must use the group object
previously generated by comparative function in indicating that group = TRUE.

59

example:

> # model <-aov (yield ~ fertilizer, data = field)
> # out <-LSD.test (model, "fertilizer", group = TRUE)
> # bar.group (out $ group)
> str(bar.group)

function (x, horiz = FALSE, decreasing = TRUE, ...)

See Figure 4. The Median test with option group=TRUE (default) is used in the exercise.

6.2 bar.err

A function to plot horizontal or vertical bar, where the variation of the error is expressed in every
treatments. The function applies to all functions comparison treatments. Each object must use the
means object previously generated by the comparison function, see Figure 5

> # model <-aov (yield ~ fertilizer, data = field)
> # out <-LSD.test (model, "fertilizer", group = TRUE)
> # bar.err(out$means)
> str(bar.err)

function (x, variation = c("SE", "SD", "range", "IQR"),

horiz = FALSE, bar = TRUE, ...)

variation

SE: Standard error

SD: standard deviation

range: max-min

> oldpar<-par(mfrow=c(2,2),cex=0.7,mar=c(3.5,1.5,3,1))
> C1<-bar.err(modelPBIB$means[1:7, ], ylim=c(0,9), col=0, main="C1",
+ variation="range",border=3,las=2)
> C2<-bar.err(modelPBIB$means[8:15,], ylim=c(0,9), col=0, main="C2",
+ variation="range", border =4,las=2)
> # Others graphic
> C3<-bar.err(modelPBIB$means[16:22,], ylim=c(0,9), col=0, main="C3",
+ variation="range",border =2,las=2)
> C4<-bar.err(modelPBIB$means[23:30,], ylim=c(0,9), col=0, main="C4",
+ variation="range", border =6,las=2)
> # Lattice graphics
> par(oldpar)
> oldpar<-par(mar=c(2.5,2.5,1,0),cex=0.6)
> bar.group(modelLattice$group,ylim=c(0,55),density=10,las=1)
> par(oldpar)

60

> oldpar<-par(mfrow=c(2,2),mar=c(3,3,2,1),cex=0.7)
> c1<-colors()[480]; c2=colors()[65]
> bar.err(outHSD$means, variation="range",ylim=c(0,50),col=c1,las=1)
> bar.err(outHSD$means, variation="IQR",horiz=TRUE, xlim=c(0,50),col=c2,las=1)
> plot(outHSD, variation="range",las=1)
> plot(outHSD, horiz=TRUE, variation="SD",las=1)
> par(oldpar)

Figure 5: Comparison between treatments

61

ccfcffoo01020304050−−−−−−−−−−−−−−−−−−−−−−−−ccfcffoo01020304050[][][][]ooffccfcGroups and Range1020304050aabbccooffccfcGroups and Standard deviation1020304050aabbcc> # model : yield ~ virus
> # Important group=TRUE
> oldpar<-par(mfrow=c(1,2),mar=c(3,3,1,1),cex=0.8)
> x<-duncan.test(model, "virus", group=TRUE)
> plot(x,las=1)
> plot(x,variation="IQR",horiz=TRUE,las=1)
> par(oldpar)

Figure 6: Grouping of treatments and its variation, Duncan method

6.3 plot.group

It plot groups and variation of the treatments to compare. It uses the objects generated by a procedure
of comparison like LSD (Fisher), duncan, Tukey (HSD), Student Newman Keul (SNK), Sche(cid:27)e, Waller-
Duncan, Ryan, Einot and Gabriel and Welsch (REGW), Kruskal Wallis, Friedman, Median, Waerden
and other tests like Durbin, DAU, BIB, PBIB. The variation types are range (maximun and minimun),
IQR (interquartile range), SD (standard deviation) and SE (standard error), see Figure 6.

The function: plot.group() and their arguments are x (output of test), variation = c("range", "IQR",
"SE", "SD"), horiz (TRUE or FALSE), xlim, ylim and main are optional plot() parameters and others
plot parameters.

6.4 di(cid:27)ograph

It plots bars of the averages of treatments to compare. It uses the objects generated by a procedure
of comparison like LSD (Fisher), duncan, Tukey (HSD), Student Newman Keul (SNK), Sche(cid:27)e, Ryan,
Einot and Gabriel and Welsch (REGW), Kruskal Wallis, Friedman and Waerden, Hsu (1996), see
Figure 7

7 Stability Analysis

In agricolae there are two methods for the study of stability and the AMMI model. These are: a para-
metric model for a simultaneous selection in yield and stability "SHUKLA’S STABILITY VARIANCE
AND KANG’S", Kang (1993) and a non-parametric method of Haynes, based on the data range.

62

ooffccfcGroups and Range1020304050aabcooffccfcGroups and Interquartile range10203040aabc...)

color3 = "black", cex.axis = 0.8, las = 1, pch = 20,
bty = "l", cex = 0.8, lwd = 1, xlab = "", ylab = "",

> # function (x, main = NULL, color1 = "red", color2 = "blue",
> #
> #
> #
> # model : yield ~ virus
> # Important group=FALSE
> x<-HSD.test(model, "virus", group=FALSE)
> diffograph(x,cex.axis=0.9,xlab="Yield",ylab="Yield",cex=0.9)

Figure 7: Mean-Mean scatter plot representation of the Tukey method

63

1020304010203040yield Comparisons for virusYieldYieldfcffccoofcffccoo11Differences for alpha = 0.05 ( Tukey )SignificantNot significant7.1 Parametric Stability

Use the parametric model, function stability.par.

Prepare a data table where the rows and the columns are the genotypes and the environments, respec-
tively. The data should correspond to yield averages or to another measured variable. Determine the
variance of the common error for all the environments and the number of repetitions that was evalu-
ated for every genotype. If the repetitions are di(cid:27)erent, (cid:28)nd a harmonious average that will represent
the set. Finally, assign a name to each row that will represent the genotype, Kang (1993). We will
consider (cid:28)ve environments in the following example:

> options(digit=2)
> f <- system.file("external/dataStb.csv", package="agricolae")
> dataStb<-read.csv(f)
> stability.par(dataStb, rep=4, MSerror=1.8, alpha=0.1, main="Genotype",console=TRUE)

INTERACTIVE PROGRAM FOR CALCULATING SHUKLA

’

S STABILITY VARIANCE AND KANG

’

S

YIELD - STABILITY (YSi) STATISTICS

Genotype
Environmental index

- covariate

Analysis of Variance

Df

Sum Sq Mean Sq F value Pr(>F)

Total
Genotypes
Environments
Interaction
176
Heterogeneity 16
160
Residual
576
Pooled Error

203 2964.1716
186.9082

11.6818
16
11 2284.0116 207.6374
2.8026
2.8036
2.8025
1.8

493.2518
44.8576
448.3942

4.17 <0.001
115.35 <0.001
1.56 <0.001
1 0.459
1.56 <0.001

Genotype. Stability statistics

Mean Sigma-square . s-square . Ecovalence
25.8
17.4
7.3
27.2
19.9
36.5
36.6
28.2
43.0
23.9
26.7
16.9
35.6
51.9
24.9
35.3
36.1

2.45 ns
1.43 ns
0.63 ns
2.13 ns
2.05 ns
*
3.95
3.96
*
2.12 ns
3.94 *
2.51 ns
2.55 ns
1.73 ns
3.28 ns
4.88 **
2.64 ns
*
3.71
*
3.69

2.47 ns
1.60 ns
0.57 ns
2.61 ns
1.86 ns
*
3.58
3.58
*
2.72 ns
4.25 **
2.27 ns
2.56 ns
1.56 ns
3.48
*
5.16 **
2.38 ns
*
3.45
*
3.53

7.4
6.8
7.2
6.8
7.1
6.9
7.8
7.9
7.3
7.1
6.4
6.9
6.8
7.5
7.7
6.4
6.2

A
B
C
D
E
F
G
H
I
J
K
L
M
N
O
P
Q

64

Signif. codes: 0

’

’

**

0.01

’

’

*

0.05

’

’

ns

1

Simultaneous selection for yield and stability

(++)

Yield Rank Adj.rank Adjusted Stab.var Stab.rating YSi ...
+

A
B
C
D
E
F
G
H
I
J
K
L
M
N
O
P
Q

7.4
6.8
7.2
6.8
7.1
6.9
7.8
7.9
7.3
7.1
6.4
6.9
6.8
7.5
7.7
6.4
6.2

13
4
11
4
9
8
16
17
12
10
3
7
6
14
15
2
1

1
-1
1
-1
1
-1
2
2
1
1
-2
-1
-1
1
2
-2
-3

14
3
12
3
10
7
18
19
13
11
1
6
5
15
17
0
-2

2.47
1.60
0.57
2.61
1.86
3.58
3.58
2.72
4.25
2.27
2.56
1.56
3.48
5.16
2.38
3.45
3.53

0
0
0
0
0
-4
-4
0
-8
0
0
0
-4
-8
0
-4
-4

14
3
12
3
10
3
14
19
5
11
1
6
1
7
17
-4
-6

+

+

+
+

+

+
+

Yield Mean: 7.1
YS
Mean: 6.8
LSD (0.05): 0.45
- - - - - - - - - - -
selected genotype
+
++
Reference: Kang, M. S. 1993. Simultaneous selection for yield
and stability: Consequences for growers. Agron. J. 85:754-757.

For 17 genotypes, the identi(cid:28)cation is made by letters. An error variance of 2 and 4 repetitions is
assumed.

Analysis

> output <- stability.par(dataStb, rep=4, MSerror=2)
> names(output)

[1] "analysis"

"statistics" "stability"

> print(output$stability)

Yield Rank Adj.rank Adjusted Stab.var Stab.rating YSi ...
+

A
B
C
D
E

7.4
6.8
7.2
6.8
7.1

13
4
11
4
9

1
-1
1
-1
1

14
3
12
3
10

2.47
1.60
0.57
2.61
1.86

0
0
0
0
0

14
3
12
3
10

+

+

65

F
G
H
I
J
K
L
M
N
O
P
Q

6.9
7.8
7.9
7.3
7.1
6.4
6.9
6.8
7.5
7.7
6.4
6.2

8
16
17
12
10
3
7
6
14
15
2
1

-1
2
2
1
1
-2
-1
-1
1
2
-2
-2

7
18
19
13
11
1
6
5
15
17
0
-1

3.58
3.58
2.72
4.25
2.27
2.56
1.56
3.48
5.16
2.38
3.45
3.53

-2
-2
0
-4
0
0
0
-2
-8
0
-2
-2

5
16
19
9
11
1
6
3
7
17
-2
-3

+
+
+
+

+

The selected genotypes are: A, C, E, G, H, I, J and O. These genotypes have a higher yield and a
lower variation. to see output$analysis, the interaction is signi(cid:28)cant.

If for example there is an environmental index, it can be added as a covariate In the (cid:28)rst (cid:28)ve locations.
For this case, the altitude of the localities is included.

> data5<-dataStb[,1:5]
> altitude<-c(1200, 1300, 800, 1600, 2400)
> stability <- stability.par(data5,rep=4,MSerror=2, cova=TRUE, name.cov= "altitude",
+ file.cov=altitude)

7.2 Non-parametric Stability

For non-parametric stability, the function in ’agricolae’ is stability.nonpar(). The names of the geno-
types should be included in the (cid:28)rst column, and in the other columns, the response by environments,
Haynes and Lambert and Christ and Weingartner and Douches and Backlund and Secor and Fry and
Stevenson (1998).

Analysis

> data <- data.frame(name=row.names(dataStb), dataStb)
> output<-stability.nonpar(data, "YIELD", ranking=TRUE)
> names(output)

[1] "ranking"

"statistics"

> output$statistics

MEAN es1 es2

1

7.1 5.6

vs1 vs2 chi.ind chi.sum
28

8.8

47

24 0.72

7.3 AMMI

The model AMMI uses the biplot constructed through the principal components generated by the
interaction environment-genotype.
If there is such interaction, the percentage of the two principal
components would explain more than the 50% of the total variation; in such case, the biplot would be
a good alternative to study the interaction environment-genotype, Crossa (1990).

66

The data for AMMI should come from similar experiments conducted in di(cid:27)erent environments. Ho-
mogeneity of variance of the experimental error, produced in the di(cid:27)erent environments, is required.
The analysis is done by combining the experiments.

The data can be organized in columns, thus: environment, genotype, repetition, and variable.

The data can also be the averages of the genotypes in each environment, but it is necessary to consider
a harmonious average for the repetitions and a common variance of the error. The data should be
organized in columns: environment, genotype, and variable.

When performing AMMI, this generates the Biplot, Triplot and In(cid:29)uence graphics, see Figure 8.

For the application, we consider the data used in the example of parametric stability (study):

AMMI structure

>

str(AMMI)

function (ENV, GEN, REP, Y, MSE = 0, console = FALSE,

PC = FALSE)

plot.AMMI structure, plot()

>

str(plot.AMMI)

function (x, first = 1, second = 2, third = 3, number = FALSE,

gcol = NULL, ecol = NULL, angle = 25, lwd = 1.8,
length = 0.1, xlab = NULL, ylab = NULL, xlim = NULL,
ylim = NULL, ...)

> data(plrv)
> model<-with(plrv,AMMI(Locality, Genotype, Rep, Yield, console=FALSE))
> names(model)

"genXenv"

"analysis" "means"

"biplot"

[1] "ANOVA"
[6] "PC"

> model$ANOVA

Analysis of Variance Table

Response: Y

Df Sum Sq Mean Sq F value

Pr(>F)

2.57

257.04 9.1e-12 ***

5 122284
1142
17533
23762
11998

ENV
12
REP(ENV)
27
GEN
ENV:GEN
135
Residuals 324
---
Signif. codes:
0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

24457
95
649
176
37

17.54 < 2e-16 ***
4.75 < 2e-16 ***

0.0029 **

> model$analysis

67

> oldpar<-par(cex=0.4,mar=c(4,4,1,2))
> plot(model,las=1,xlim=c(-5,6))
> par(oldpar)

Figure 8: Biplot

percent acum Df Sum.Sq Mean.Sq F.value

PC1
PC2
PC3
PC4
PC5

56 31 13369
56.3
6428
83 29
27.1
2242
93 27
9.4
1028
4.3
97 25
696
2.9 100 23

431
222
83
41
30

> pc <- model$analysis[, 1]
> pc12<-sum(pc[1:2])
> pc123<-sum(pc[1:3])

Pr.F
11.65 0.0000
5.99 0.0000
2.24 0.0005
1.11 0.3286
0.82 0.7059

In this case, the interaction is signi(cid:28)cant. The (cid:28)rst two components explain 83.4 %; then the biplot
can provide information about the interaction genotype-environment. With the triplot, 92.8% would
be explained.

7.4 AMMI index and yield stability

Calculate AMMI stability value (ASV) and Yield stability index (YSI), Sabaghnia and Sabaghpour
and Dehghani (2008); Purchase (1997).

> data(plrv)
> model<- with(plrv,AMMI(Locality, Genotype, Rep, Yield, console=FALSE))

68

−4−20246−4−2024PC1 (56.3)PC2 (27.1)AyacHyo−02LM−02LM−03SR−02SR−03102.18104.22121.31141.28157.26163.9221.19233.11235.6241.2255.7314.12317.6319.20320.16342.15346.2351.26364.21402.7405.2406.12427.7450.3506.2CanchanDesireeUnica> index<-index.AMMI(model)
> # Crops with improved stability according AMMI.
> print(index[order(index[,3]),])

0.28
402.7
0.72
364.21
0.75
506.2
1.06
233.11
1.15
427.7
1.46
104.22
1.68
241.2
1.80
221.19
2.19
317.6
2.29
121.31
2.56
406.12
2.92
314.12
2.92
342.15
351.26
2.98
Canchan 3.10
3.14
450.3
3.29
157.26
3.32
320.16
3.33
255.7
3.38
102.18
3.76
235.6
3.84
Unica
3.98
405.2
4.43
163.9
4.47
141.28
5.18
346.2
319.20
6.72
Desiree 7.78

ASV YSI rASV rYSI means
27
1
34
2
33
3
29
4
36
5
31
6
26
7
23
8
35
9
30
10
33
11
28
12
26
13
36
14
27
15
36
16
37
17
26
18
31
19
26
20
39
21
39
22
29
23
21
24
40
25
24
26
39
27
16
28

19
10
11
17
7
13
22
26
9
15
12
18
24
8
20
6
5
21
14
23
4
2
16
27
1
25
3
28

20
12
14
21
12
19
29
34
18
25
23
30
37
22
35
22
22
39
33
43
25
24
39
51
26
51
30
56

> # Crops with better response and improved stability according AMMI.
> print(index[order(index[,4]),])

141.28
Unica
319.20
235.6
157.26
450.3
427.7
351.26
317.6
364.21
506.2
406.12
104.22

ASV YSI rASV rYSI means
40
25
39
22
39
27
39
21
37
17
36
16
36
5
36
14
35
9
34
2
33
3
33
11
31
6

4.47
3.84
6.72
3.76
3.29
3.14
1.15
2.98
2.19
0.72
0.75
2.56
1.46

1
2
3
4
5
6
7
8
9
10
11
12
13

26
24
30
25
22
22
12
22
18
12
14
23
19

69

3.33
255.7
2.29
121.31
3.98
405.2
1.06
233.11
2.92
314.12
402.7
0.28
Canchan 3.10
3.32
320.16
1.68
241.2
3.38
102.18
2.92
342.15
5.18
346.2
1.80
221.19
163.9
4.43
Desiree 7.78

33
25
39
21
30
20
35
39
29
43
37
51
34
51
56

19
10
23
4
12
1
15
18
7
20
13
26
8
24
28

14
15
16
17
18
19
20
21
22
23
24
25
26
27
28

31
30
29
29
28
27
27
26
26
26
26
24
23
21
16

8 Special functions

8.1 Consensus of dendrogram

Consensus is the degree or similarity of the vertexes of a tree regarding its branches of the constructed
dendrogram. The function to apply is consensus().

The data correspond to a table, with the name of the individuals and the variables in the rows and
columns respectively. For the demonstration, we will use the "pamCIP" data of ’agricolae’, which
correspond to molecular markers of 43 entries of a germplasm bank (rows) and 107 markers (columns).

The program identi(cid:28)es duplicates in the rows and can operate in both cases. The result is a dendrogram,
in which the consensus percentage is included, see Figure 9.

When the dendrogram is complex, it is convenient to extract part of it with the function hcut(), see
Figure 10.

The obtained object "output" contains information about the process:

> names(output)

[1] "table.dend" "dendrogram" "duplicates"

Construct a classic dendrogram, execute procedure in R

use the previous result ’output’

> dend <- as.dendrogram(output$dendrogram)
> data <- output$table.dend
> head(output$table.dend)

X1
-6 -24
-4
-3
-2
-8
-7 -10
2
3

X2 xaxis height percentage groups
6-24
3-4
2-8
7-10
100 3-4-21
80 2-8-16

7.5 0.029
19.5 0.036
22.5 0.038
10.5
0.038
18.8 0.071
21.8 0.074

1
2
3
4
5 -21
6 -16

60
80
80
60

70

> oldpar<-par(cex=0.6,mar=c(3,3,2,1))
> data(pamCIP)
> rownames(pamCIP)<-substr(rownames(pamCIP),1,6)
> output<-consensus(pamCIP,distance="binary", method="complete", nboot=5)

Duplicates: 18
New data

: 25 Records

Consensus hclust

Method distance: binary
Method cluster : complete
rows and cols
n-bootstrap
Run time

: 25 107
: 5
: 0.47 secs

> par(oldpar)

Figure 9: Dendrogram, production by consensus

71

7026507042297048157042327190837067767026157071327057507026197032587062607010147039737062687067777042317062727023057024437048807020787026317024457059510.00.40.8Cluster Dendrogramhclust (*, "complete")distanciaHeight608080601008010010010040601002040100808080040804080100> oldpar<-par(cex=0.6,mar=c(3,3,1.5,1))
> out1<- hcut(output,h=0.4,group=8,type="t",edgePar = list(lty=1:2, col=colors()[c(42,84)]),
+ main="group 8" ,col.text="blue",cex.text=1,las=1)
> par(oldpar)

Figure 10: Dendrogram, production by hcut()

> oldpar<-par(mar=c(3,3,1,1),cex=0.6)
> plot(dend,type="r",edgePar = list(lty=1:2, col=colors()[c(42,84)]) ,las=1)
> text(data[,3],data[,4],data[,5],col="blue",cex=1)
> par(oldpar)

8.2 Montecarlo

It is a method for generating random numbers of an unknown distribution. It uses a data set and,
through the cumulative behavior of its relative frequency, generates the possible random values that
follow the data distribution. These new numbers are used in some simulation process.

The probability density of the original and simulated data can be compared, see Figure 11.

> data(soil)
> # set.seed(9473)
> simulated <- montecarlo(soil$pH,1000)
> h<-graph.freq(simulated,nclass=7,plot=FALSE)

1000 data was simulated, being the frequency table:

> round(table.freq(h),2)

Lower Upper Main Frequency Percentage
1.9
12.0
23.4
23.3
18.2
17.6

2.8 2.1
4.1 3.5
5.4 4.8
6.7 6.0
8.0 7.3
9.3 8.7
9.9

CPF
CF
1.9
19
13.9
139
37.3
373
60.6
606
78.8
788
96.4
964
3.6 1000 100.0

19
120
234
233
182
176
36

1.5
2.8
4.1
5.4
6.7
8.0
9.3

10.6

1
2
3
4
5
6
7

72

0.000.050.100.150.20group 87062727023057024437048807020787026317024457059516080806010080100100100406010020401008080> oldpar<-par(mar=c(2,0,2,1),cex=0.6)
> plot(density(soil$pH),axes=FALSE,main="pH density of the soil\ncon Ralstonia",xlab="",lwd=4)
> lines(density(simulated), col="blue", lty=4,lwd=4)
> axis(1,0:12)
> legend("topright",c("Original","Simulated"),lty=c(1,4),col=c("black", "blue"), lwd=4)
> par(oldpar)

Figure 11: Distribution of the simulated and the original data

Some statistics, original data:

> summary(soil$pH)

Min. 1st Qu.
4.7

3.8

Median
6.1

Mean 3rd Qu.
7.6

6.2

Max.
8.4

Some statistics, montecarlo simulate data:

> summary(simulated)

Min. 1st Qu.
4.8

1.6

Median
6.1

Mean 3rd Qu.
7.8

6.2

Max.
10.6

8.3 Re-Sampling in linear model

It uses the permutation method for the calculation of the probabilities of the sources of variation
of ANOVA according to the linear regression model or the design used. The principle is that the Y
response does not depend on the averages proposed in the model; hence, the Y values can be permutated
and many model estimates can be constructed. On the basis of the patterns of the random variables
of the elements under study, the probability is calculated in order to measure the signi(cid:28)cance.

For a variance analysis, the data should be prepared similarly. The function to use is:
pling.model()

resam-

> data(potato)
> potato[,1]<-as.factor(potato[,1])
> potato[,2]<-as.factor(potato[,2])

73

pH density of the soilcon RalstoniaDensity1234567891011OriginalSimulated> model<-"cutting~variety + date + variety:date"
> analysis<-resampling.model(model, potato, k=100)
> Xsol<-as.matrix(round(analysis$solution,2))
> print(Xsol,na.print = "")

Df Sum Sq Mean Sq F value Pr(>F) Resampling
0.02
0.19
0.50

0.02
0.18
0.51

7.3
2.0
0.7

1
variety
2
date
variety:date 2
12
Residuals

25.1
13.9
4.8
41.5

25.1
7.0
2.4
3.5

The function resampling.model() can be used when the errors have a di(cid:27)erent distribution from normal

8.4 Simulation in linear model

Under the assumption of normality, the function generates pseudo experimental errors under the
proposed model, and determines the proportion of valid results according to the analysis of variance
found.

The function is: simulation.model(). The data are prepared in a table, similarly to an analysis of
variance.

Considering the example proposed in the previous procedure:

> simModel <- simulation.model(model, potato, k=100,console=TRUE)

Simulation of experiments
Under the normality assumption
- - - - - - - - - - - - - - - -
Proposed model: cutting~variety + date + variety:date
Analysis of Variance Table

Response: cutting

Df Sum Sq Mean Sq F value Pr(>F)

7.26
2.01
0.70

25.1
13.9
4.9
41.5

0.02 *
0.18
0.51

25.09
6.95
2.43
3.46

1
variety
date
2
variety:date 2
12
Residuals
---
Signif. codes:
0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
---
Validation of the analysis of variancia for the proposed model
Simulations: 100

Df F value % Acceptance % Rejection Criterion
40 acceptable
34 acceptable
30 acceptable

7.3
2.0
0.7

60
66
70

1
variety
date
2
variety:date 2
---

74

The validation is referred to the percentage of decision results equal to the result of the ANOVA
decision. Thus, 70% of the results simulated on the interaction variety*date gave the same result of
acceptance or rejection obtained in the ANOVA.

8.5 Path Analysis

It corresponds to the "path analysis" method. The data correspond to correlation matrices of the
independent ones with the dependent matrix (XY) and between the independent ones (XX).

It is necessary to assign names to the rows and columns in order to identify the direct and indirect
e(cid:27)ects.

> corr.x<- matrix(c(1,0.5,0.5,1),c(2,2))
> corr.y<- rbind(0.6,0.7)
> names<-c("X1","X2")
> dimnames(corr.x)<-list(names,names)
> dimnames(corr.y)<-list(names,"Y")
> output<-path.analysis(corr.x,corr.y)

Direct(Diagonal) and indirect effect path coefficients
======================================================

X2
X1
X1 0.33 0.27
X2 0.17 0.53

Residual Effect^2 = 0.43

> output

$Coeff

X2
X1
X1 0.33 0.27
X2 0.17 0.53

$Residual
[1] 0.43

8.6 Line X Tester

It corresponds to a crossbreeding analysis of a genetic design. The data should be organized in a table.
Only four columns are required: repetition, females, males, and response. In case it corresponds to
progenitors, the females or males (cid:28)eld will only be (cid:28)lled with the corresponding one. See the heterosis
data, Singh and Chaudhary (1979).

Example with the heterosis data, locality 2.

Replication
1
1

Male

v2
Female
LT-8
TS-15 2.65
LT-8 TPS-13 2.26

1 Achirana TPS-13 3.55

109
110
...
131

75

132
...
140
...
215

1 Achirana TPS-67 3.05

1 Achirana

<NA> 3.35

3

<NA> TPS-67 2.91

where <NA> is empty.

If it is a progeny, it comes from a "Female" and a "Male." If it is a progenitor, it will only be "Female"
or "Male."

The following example corresponds to data of the locality 2:

24 progenies 8 females 3 males 3 repetitions

They are 35 treatments (24, 8, 3) applied to three blocks.

> rm(list=ls())
> options(digits = 2)
> data(heterosis)
> str(heterosis)

’

’

:

: num

11 variables:

1 2 3 4 5 6 7 8 9 10 ...

324 obs. of
data.frame
$ Place
1 1 1 1 1 1 1 1 1 1 ...
$ Replication: num 1 1 1 1 1 1 1 1 1 1 ...
$ Treatment
$ Factor
$ Female
$ Male
$ v1
$ v2
$ v3
$ v4
$ v5

: num
: Factor w/ 3 levels "Control","progenie",..: 2 2 2 2 2 2 2 2 2 2 ...
: Factor w/ 8 levels "Achirana","LT-8",..: 2 2 2 6 6 6 7 7 7 8 ...
: Factor w/ 3 levels "TPS-13","TPS-67",..: 3 1 2 3 1 2 3 1 2 3 ...
: num
: num
: num
: num
: num

0.948 1.052 1.05 1.058 1.123 ...
1.65 2.2 1.88 2 2.45 2.63 2.75 3 2.51 1.93 ...
17.2 17.8 15.6 16 16.5 ...
9.93 12.45 9.3 12.77 14.13 ...
102.6 107.4 120.5 83.8 90.4 ...

> site2<-subset(heterosis,heterosis[,1]==2)
> site2<-subset(site2[,c(2,5,6,8)],site2[,4]!="Control")
> output1<-with(site2,lineXtester(Replication, Female, Male, v2))

ANALYSIS LINE x TESTER: v2

ANOVA with parents and crosses
==============================

Replications
Treatments
Parents
Parents vs. Crosses
Crosses
Error
Total

Df
2

Sum Sq Mean Sq F value Pr(>F)
9.80 0.0002
0.5192
17.88 0.0000
34 16.1016
29.19 0.0000
10 7.7315
0.19 0.6626
0.0051
23 8.3650
13.73 0.0000
1.8011
68
104 18.4219

0.2596
0.4736
0.7731
0.0051
0.3637
0.0265

1

ANOVA for line X tester analysis

76

================================

7
Lines
2
Testers
Lines X Testers 14
68
Error

Df Sum Sq Mean Sq F value Pr(>F)
0.019
3.6
0.226
1.7
7.4 0.000

4.98
0.65
2.74
1.80

0.711
0.325
0.196
0.026

ANOVA for line X tester analysis including parents
==================================================

1

Df
2

Sum Sq Mean Sq F value Pr(>F)
0.2596
9.80 0.0002
0.5192
0.4736
17.88 0.0000
34 16.1016
0.7731
29.19 0.0000
10 7.7315
0.0051
0.19 0.6626
0.0051
13.73 0.0000
0.3637
23 8.3650
3.63 0.0191
4.9755
0.7108
1.66 0.2256
0.6494 0.3247
0.1957
2.7401
7.39 0.0000
0.0265
1.8011
104 18.4219

7
2
14
68

MF-I
0.199

MF-II
-0.449

Serrana
0.058

TPS-2
-0.047

Replications
Treatments
Parents
Parents vs. Crosses
Crosses
Lines
Testers
Lines X Testers
Error
Total

GCA Effects:
===========
Lines Effects:
Achirana
0.022
TPS-25
0.414

LT-8
-0.338
TPS-7
0.141

Testers Effects:
TPS-13 TPS-67

TS-15
0.046 -0.132

0.087

SCA Effects:
===========

Testers

Lines

Achirana
LT-8
MF-I
MF-II
Serrana
TPS-2
TPS-25
TPS-7

TPS-13 TPS-67

TS-15
0.061
0.059 -0.120
-0.435
0.519 -0.083
-0.122 -0.065
0.187
0.047
-0.194
0.148
0.081
0.032 -0.113
0.197 -0.072 -0.124
0.126 -0.200
0.074
0.336 -0.173 -0.162

Standard Errors for Combining Ability Effects:
=============================================
S.E. (gca for line)
: 0.054
S.E. (gca for tester) : 0.033
: 0.094
S.E. (sca effect)

77

S.E. (gi - gj)line
S.E. (gi - gj)tester
S.E. (sij - skl)tester: 0.13

: 0.077
: 0.047

: 0.057

Genetic Components:
==================
Cov H.S. (line)
Cov H.S. (tester) : 0.0054
Cov H.S. (average): 0.0039
Cov F.S. (average): 0.13
F = 0, Adittive genetic variance: 0.015
F = 1, Adittive genetic variance: 0.0077
F = 0, Variance due to Dominance: 0.11
F = 1, Variance due to Dominance: 0.056

Proportional contribution of lines, testers
and their interactions to total variance
===========================================
Contributions of lines
Contributions of testers: 7.8
Contributions of lxt

: 33

: 59

> options(digits = 7)

8.7 Soil Uniformity

The Smith index is an indicator of the uniformity, used to determine the parcel size for research
purposes. The data correspond to a matrix or table that contains the response per basic unit, a
number of n rows x m columns, and a total of n*m basic units.

For the test, we will use the rice (cid:28)le. The graphic is a result with the adjustment of a model for the
plot size and the coe(cid:30)cient of variation, see Figure 12.

> uniformity <- data.frame(table$uniformity)
> head(uniformity)

Size Width Length plots

1
2
3
4
5
6

1
2
2
3
3
4

1
1
2
1
3
1

1
2
1
3
1
4

Vx

CV
648 9044.539 13.0
324 7816.068 12.1
324 7831.232 12.1
216 7347.975 11.7
216 7355.216 11.7
162 7047.717 11.4

8.8 Con(cid:28)dence Limits In Biodiversity Indices

The biodiversity indices are widely used for measuring the presence of living things in an ecological area.
Many programs indicate their value. The function of ’agricolae’ is also to show the con(cid:28)dence intervals,
which can be used for a statistical comparison. Use the bootstrap procedure. The data are organized in
a table; the species are placed in a column; and in another one, the number of individuals. The indices

78

> oldpar<-par(mar=c(3,3,4,1),cex=0.7)
> data(rice)
> table<-index.smith(rice, col="blue",
+
> par(oldpar)

main="Interaction between the CV and the plot size",type="l",xlab="Size")

Figure 12: Adjustment curve for the optimal size of plot

that can be calculated with the function index.bio() of ’agricolae’ are: "Margalef", "Simpson.Dom",
"Simpson.Div", "Berger.Parker", "McIntosh", and "Shannon."

In the example below, we will use the data obtained in the locality of Paracsho, district of Huasahuasi,
province of Tarma in the department of Junin.

The evaluation was carried out in the parcels on 17 November 2005, without insecticide application.
The counted specimens were the following:

> data(paracsho)
> species <- paracsho[79:87,4:6]
> species

Orden
TIPULIDAE
79
DIPTERA
NOCTUIDAE
80 LEPIDOPTERA
PYRALIDAE
NOCTUIDAE
81
ANTHOCORIDAE
HEMIPTERA
82
TACHINIDAE
DIPTERA
83
DIPTERA
84
ANTHOCORIDAE
DIPTERA SCATOPHAGIDAE
85
SYRPHIDAE
DIPTERA
86
MUSCIDAE
DIPTERA
87

Family Number.of.specimens
3
1
3
1
16
3
5
1
3

The Shannon index is:

> output <- index.bio(species[,3],method="Shannon",level=95,nboot=200)

79

0501001509.010.512.0Interaction between the CV and the plot sizeSizecvMethod: Shannon

The index: 2.541336

95 percent confidence interval:

2.22808 ; 3.07635

8.9 Correlation

The function correlation() of ’agricolae’ makes the correlations through the methods of Pearson, Spear-
man and Kendall for vectors and/or matrices. If they are two vectors, the test is carried out for one
or two lines; if it is a matrix one, it determines the probabilities for a di(cid:27)erence, whether it is greater
or smaller.

For its application, consider the soil data: data(soil)

> data(soil)
> correlation(soil[,2:4],method="pearson")

$correlation

pH

1.00 0.55
pH
EC
0.55 1.00
CaCO3 0.73 0.32

EC CaCO3
0.73
0.32
1.00

$pvalue

pH

CaCO3
1.000000000 0.0525330 0.004797027
pH
0.052532997 1.0000000 0.294159813
EC
CaCO3 0.004797027 0.2941598 1.000000000

EC

$n.obs
[1] 13

> with(soil,correlation(pH,soil[,3:4],method="pearson"))

$correlation

EC CaCO3
0.73

pH 0.55

$pvalue

CaCO3
EC
pH 0.0525 0.0048

$n.obs
[1] 13

8.10

tapply.stat()

Gets a functional calculation of variables grouped by study factors.

80

Application with ’agricolae’ data:

max(yield)-min(yield) by farmer

> data(RioChillon)
> with(RioChillon$babies,tapply.stat(yield,farmer,function(x) max(x)-min(x)))

AugustoZambrano
Caballero

1
2
3
4
Huarangal-1
5
Huarangal-2
6
Huarangal-3
7
8
Huatocay
9 IgnacioPolinario

farmer yield
7.5
13.4
ChocasAlto 14.1
FelixAndia 19.4
9.8
9.1
9.4
19.4
13.1

It corresponds to the range of variation in the farmers’ yield.

The function "tapply" can be used directly or with function.

If A is a table with columns 1,2 and 3 as category, and 5,6 and 7 as variables, then the following
procedures are valid:

tapply.stat(A[,5:7], A[,1:3],mean)

tapply.stat(A[,5:7], A[,1:3],function(x) mean(x,na.rm=TRUE))

tapply.stat(A[,c(7,6)], A[,1:2],function(x) sd(x)*100/mean(x))

8.11 Coe(cid:30)cient of variation of an experiment

If "model" is the object resulting from an analysis of variance of the function aov() or lm() of R, then
the function cv.model() calculates the coe(cid:30)cient of variation.

> data(sweetpotato)
> model <- model<-aov(yield ~ virus, data=sweetpotato)
> cv.model(model)

[1] 17.1666

8.12 Skewness and kurtosis

The skewness and kurtosis results, obtained by ’agricolae’, are equal to the ones obtained by SAS,
MiniTab, SPSS, InfoStat, and Excel.

If x represents a data set:

> x<-c(3,4,5,2,3,4,5,6,4,NA,7)

skewness is calculated with:

> skewness(x)

81

[1] 0.3595431

and kurtosis with:

> kurtosis(x)

[1] -0.1517996

8.13 Tabular value of Waller-Duncan

The function Waller determines the tabular value of Waller-Duncan. For the calculation, value F is
necessary, calculated from the analysis of variance of the study factor, with its freedom degrees and
the estimate of the variance of the experimental error. Value K, parameter of the function is the ratio
between the two types of errors (I and II). To use it, a value associated with the alpha level is assigned.
When the alpha level is 0.10, 50 is assigned to K; for 0.05, K=100; and for 0.01, K=500. K can take
any value.

> q<-5
> f<-15
> K<-seq(10,1000,100)
> n<-length(K)
> y<-rep(0,3*n)
> dim(y)<-c(n,3)
> for(i in 1:n) y[i,1]<-waller(K[i],q,f,Fc=2)
> for(i in 1:n) y[i,2]<-waller(K[i],q,f,Fc=4)
> for(i in 1:n) y[i,3]<-waller(K[i],q,f,Fc=8)

Function of Waller to di(cid:27)erent value of parameters K and Fc The next procedure illustrates
the function for di(cid:27)erent values of K with freedom degrees of 5 for the numerator and 15 for the
denominator, and values of calculated F, equal to 2, 4, and 8.

> oldpar<-par(mar=c(3,3,4,1),cex=0.7)
> plot(K,y[,1],type="l",col="blue",ylab="waller",bty="l")
> lines(K,y[,2],type="l",col="brown",lty=2,lwd=2)
> lines(K,y[,3],type="l",col="green",lty=4,lwd=2)
> legend("topleft",c("2","4","8"),col=c("blue","brown","green"),lty=c(1,8,20),
+ lwd=2,title="Fc")
> title(main="Waller in function of K")
> par(oldpar)

Generating table Waller-Duncan

> K<-100
> Fc<-1.2
> q<-c(seq(6,20,1),30,40,100)
> f<-c(seq(4,20,2),24,30)
> n<-length(q)
> m<-length(f)
> W.D <-rep(0,n*m)

82

> dim(W.D)<-c(n,m)
> for (i in 1:n) {
+ for (j in 1:m) {
+ W.D[i,j]<-waller(K, q[i], f[j], Fc)
+ }}
> W.D<-round(W.D,2)
> dimnames(W.D)<-list(q,f)
> cat("table: Waller Duncan k=100, F=1.2")

table: Waller Duncan k=100, F=1.2

> print(W.D)

8

4

6

20

24

18

16

10

14

12

30
2.85 2.87 2.88 2.89 2.89 2.89 2.89 2.88 2.88 2.88 2.88
6
2.85 2.89 2.92 2.93 2.94 2.94 2.94 2.94 2.94 2.94 2.94
7
2.85 2.91 2.94 2.96 2.97 2.98 2.99 2.99 2.99 3.00 3.00
8
2.85 2.92 2.96 2.99 3.01 3.02 3.03 3.03 3.04 3.04 3.05
9
2.85 2.93 2.98 3.01 3.04 3.05 3.06 3.07 3.08 3.09 3.10
10
2.85 2.94 3.00 3.04 3.06 3.08 3.09 3.10 3.11 3.12 3.14
11
2.85 2.95 3.01 3.05 3.08 3.10 3.12 3.13 3.14 3.16 3.17
12
2.85 2.96 3.02 3.07 3.10 3.12 3.14 3.16 3.17 3.19 3.20
13
2.85 2.96 3.03 3.08 3.12 3.14 3.16 3.18 3.19 3.21 3.23
14
2.85 2.97 3.04 3.10 3.13 3.16 3.18 3.20 3.21 3.24 3.26
15
2.85 2.97 3.05 3.11 3.15 3.18 3.20 3.22 3.24 3.26 3.29
16
2.85 2.98 3.06 3.12 3.16 3.19 3.22 3.24 3.26 3.28 3.31
17
2.85 2.98 3.07 3.13 3.17 3.20 3.23 3.25 3.27 3.30 3.33
18
2.85 2.98 3.07 3.13 3.18 3.22 3.24 3.27 3.29 3.32 3.35
19
2.85 2.99 3.08 3.14 3.19 3.23 3.26 3.28 3.30 3.33 3.37
20
2.85 3.01 3.11 3.19 3.26 3.31 3.35 3.38 3.41 3.45 3.50
30
40
2.85 3.02 3.13 3.22 3.29 3.35 3.39 3.43 3.47 3.52 3.58
100 2.85 3.04 3.17 3.28 3.36 3.44 3.50 3.55 3.59 3.67 3.76

8.14 AUDPC

The area under the disease progress curve (AUDPC), see Figure 13 calculates the absolute and relative
progress of the disease. It is required to measure the disease in percentage terms during several dates,
preferably equidistantly.

> days<-c(7,14,21,28,35,42)
> evaluation<-data.frame(E1=10,E2=40,E3=50,E4=70,E5=80,E6=90)
> print(evaluation)

E1 E2 E3 E4 E5 E6
1 10 40 50 70 80 90

> absolute1 <-audpc(evaluation,days)
> relative1 <-round(audpc(evaluation,days,"relative"),2)

83

Figure 13: Area under the curve (AUDPC) and Area under the Stairs (AUDPS)

8.15 AUDPS

The Area Under the Disease Progress Stairs (AUDPS), see Figure 13. A better estimate of disease
progress is the area under the disease progress stairs (AUDPS). The AUDPS approach improves the
estimation of disease progress by giving a weight closer to optimal to the (cid:28)rst and last observations..

> absolute2 <-audps(evaluation,days)
> relative2 <-round(audps(evaluation,days,"relative"),2)

8.16 Non-Additivity

Tukey’s test for non-additivity is used when there are doubts about the additivity veracity of a model.
This test con(cid:28)rms such assumption and it is expected to accept the null hypothesis of the non-additive
e(cid:27)ect of the model.

For this test, all the experimental data used in the estimation of the linear additive model are required.

Use the function nonadditivity() of ’agricolae’. For its demonstration, the experimental data "potato",
of the package ’agricolae’, will be used. In this case, the model corresponds to the randomized complete
block design, where the treatments are the varieties.

> data(potato)
> potato[,1]<-as.factor(potato[,1])
> model<-lm(cutting ~ date + variety,potato)
> df<-df.residual(model)
> MSerror<-deviance(model)/df
> analysis<-with(potato,nonadditivity(cutting, date, variety, df, MSerror))

’

Tukey
cutting

s test of nonadditivity

P : 15.37166
Q : 77.44441

Analysis of Variance Table

Response: residual

Nonadditivity 1
Residuals

3.051
14 46.330

3.0511
3.3093

Df Sum Sq Mean Sq F value Pr(>F)
0.922 0.3532

84

DaysEvaluation71421283542020406080100Audpc Abs.=2030Audpc Rel.=0.58DaysEvaluation714212835423.510.517.524.531.538.545.5020406080100Audps Abs.=Audps Rel.=According to the results, the model is additive because the p.value 0.35 is greater than 0.05.

8.17 LATEBLIGHT

LATEBLIGHT is a mathematical model that simulates the e(cid:27)ect of weather, host growth and re-
sistance, and fungicide use on asexual development and growth of Phytophthora infestans on potato
foliage, see Figure 14

LATEBLIGHT Version LB2004 was created in October 2004 (Andrade-Piedra et al., 2005a, b and c),
based on the C-version written by B.E. Ticknor (’BET 21191 modi(cid:28)cation of cbm8d29.c’), reported
by Doster et al. (1990) and described in detail by Fry et al. (1991) (This version is referred as LB1990
by Andrade-Piedra et al. [2005a]). The (cid:28)rst version of LATEBLIGHT was developed by Bruhn and
Fry (1981) and described in detail by Bruhn et al. (1980).

> options(digits=2)
> f <- system.file("external/weather.csv", package="agricolae")
> weather <- read.csv(f,header=FALSE)
> f <- system.file("external/severity.csv", package="agricolae")
> severity <- read.csv(f)
> weather[,1]<-as.Date(weather[,1],format = "%m/%d/%Y")
> # Parameters dates
> dates<-c("2000-03-25","2000-04-09","2000-04-12","2000-04-16","2000-04-22")
> dates<-as.Date(dates)
> EmergDate <- as.Date("2000/01/19")
> EndEpidDate <- as.Date("2000-04-22")
> dates<-as.Date(dates)
> NoReadingsH<- 1
> RHthreshold <- 90
> WS<-weatherSeverity(weather,severity,dates,EmergDate,EndEpidDate,
+ NoReadingsH,RHthreshold)
> # Parameters to Lateblight function
> InocDate<-"2000-03-18"
> LGR <- 0.00410
> IniSpor <- 0
> SR <- 292000000
> IE <- 1.0
> LP <- 2.82
> InMicCol <- 9
> Cultivar <- "NICOLA"
> ApplSys <- "NOFUNGICIDE"
> main<-"Cultivar: NICOLA"

85

> oldpar<-par(mar=c(3,3,4,1),cex=0.7)
> #--------------------------
> model<-lateblight(WS, Cultivar,ApplSys, InocDate, LGR,IniSpor,SR,IE,
+ LP,MatTime=
+ xlab="Time (days after emergence)", ylab="Severity (Percentage)")
> par(oldpar)

LATESEASON

,InMicCol,main=main,type="l",xlim=c(65,95),lwd=1.5,

’

’

Figure 14: lateblight: LATESEASON

86

65707580859095020406080100Cultivar: NICOLATime (days after emergence)Severity (Percentage)LATESEASONDisease progress curvesWeather−Severity> head(model$Gfile)

Eval1 2000-03-25
Eval2 2000-04-09
Eval3 2000-04-12
Eval4 2000-04-16
Eval5 2000-04-22

dates nday MeanSeverity StDevSeverity MinObs
0.1
0.1
-3.9
20.8
24.3
57.0
86.0
94.0
93.0
97.0

0
25
33
8
4

66
81
84
88
94

MaxObs
0.1
45.5
89.7
102.0
101.0

Eval1
Eval2
Eval3
Eval4
Eval5

> str(model$Ofile)

’

’

:

94 obs. of

1 2 3 4 5 6 7 8 9 10 ...

13 variables:
data.frame
: Date, format: "2000-01-20" ...
$ Date
: num
$ nday
$ MicCol
: num 0 0 0 0 0 0 0 0 0 0 ...
$ SimSeverity: num 0 0 0 0 0 0 0 0 0 0 ...
$ LAI
$ LatPer
$ LesExInc
$ AttchSp
$ AUDPC
$ rLP
$ InvrLP
$ BlPr
$ Defol

: num
: num 0 2 2 2 2 2 2 2 2 2 ...
0 0 0 0 0 0 0 0 0 0 ...
: num
0 0 0 0 0 0 0 0 0 0 ...
: num
0 0 0 0 0 0 0 0 0 0 ...
: num
: num
0 0 0 0 0 0 0 0 0 0 ...
: num 0 0 0 0 0 0 0 0 0 0 ...
0 0 0 0 0 0 0 0 0 0 ...
: num
0 0 0 0 0 0 0 0 0 0 ...
: num

0.01 0.0276 0.0384 0.0492 0.06 0.086 0.112 0.138 0.164 0.19 ...

LAI LatPer LesExInc
0
0
0
2
0
2
0
2
0
2
0
2

0 0.010
0 0.028
0 0.038
0 0.049
0 0.060
0 0.086

> head(model$Ofile[,1:7])

Date nday MicCol SimSeverity

1 2000-01-20
2 2000-01-21
3 2000-01-22
4 2000-01-23
5 2000-01-24
6 2000-01-25

1
2
3
4
5
6

Repeating graphic

0
0
0
0
0
0

> x<- model$Ofile$nday
> y<- model$Ofile$SimSeverity
> w<- model$Gfile$nday
> z<- model$Gfile$MeanSeverity
> Min<-model$Gfile$MinObs
> Max<-model$Gfile$MaxObs

87

> oldpar<-par(mar=c(3,2.5,1,1),cex=0.7)
> plot(x,y,type="l",xlim=c(65,95),lwd=1.5,xlab="Time (days after emergence)",
+ ylab="Severity (Percentage)")
> points(w,z,col="red",cex=1,pch=19); npoints <- length(w)
> for ( i in 1:npoints)segments(w[i],Min[i],w[i],Max[i],lwd=1.5,col="red")
> legend("topleft",c("Disease progress curves","Weather-Severity"),
+ title="Description",lty=1,pch=c(3,19),col=c("black","red"))
> par(oldpar)

References

Gertrude M. and W. G. Cochran. (1992). Experimental designs Wiley, New York.

Conover, W.J (1999). Practical Nonparametrics Statistics John Wiley & Sons, INC, New York.

Crossa, J. (1990). Statistical analysis of multilocation trials Advances in Agronomy 44:55-85. Mexico

D.F., Mexico.

De Mendiburu, F. (2009). Una herramienta de anÆlisis estad(cid:237)stico para la investigaci(cid:243)n agr(cid:237)cola Uni-

versidad Nacional de Ingenier(cid:237)a (UNI). Lima, Peru.

Haynes, K.G. and Lambert, D.H. and Christ, B.J. and Weingartner, D.P. and Douches, D.S. and Back-
lund, J.E. and Secor, G. and Fry, W. and Stevenson, W. (1998). Phenotypic stability of resistance
to late blight in potato clones evaluated at eight sites in the United Stated 75 5 211(cid:21)217 Springer.

Hsu, J. (1996). Multiple comparisons: theory and methods CRC Press. Printed in the United States

of America.

Joshi, D.D. (1987). Linear estimation and design of experiments Wiley Eastern Limited. New Delhi,

India.

Kang, M.S. (1993). Simultaneous Selection for Yield and Stability: Consequences for Growers Agron-

omy Journal. 85,3:754-757. American Society of Agronomy.

Kuehl, R.O. (2000). Designs of experiments: statistical principles of research design and analysis

Duxbury Press.

Le Clerg, E.L. and Leonard, W.H. and Erwin, L. and Warren, H.L. and Andrew, G.C. Field Plot

Technique Burgess Publishing Company, Minneapolis, Minnesota.

Montgomery, D.C. (2002). Design and Analysis of Experiments John Wiley and Sons.

Patterson, H.D. and E.R. Williams, (1976). Design and Analysis of Experiments Biometrika Printed

in Great Britain.

Purchase, J. L. (1997). Parametric analysis to describe genotype environment interaction and yield
stability in winter wheat Department of Agronomy, Faculty of Agriculture of the University of the
Free State Bloemfontein, South Africa.

R Core Team (2020). A language and environment for statistical computing. R Foundation for Statis-

tical Computing Vienna, Austria. http://www.R-project.org

Sabaghnia N. and S.H.Sabaghpour and H. Dehghani (2008). The use of an AMMI model and its
parameters to analyse yield stability in multienvironment trials Journal of Agricultural Science
Department of Agronomy, Faculty of Agriculture of the University of the Free State. Cambridge
University Press 571 doi:10.1017/S0021859608007831. Printed in the United Kingdom. 146, 571-581.

88

Singh R.K. and B.D. Chaudhary (1979). Biometrical Methods in Quantitative Genetic Analysis

Kalyani Publishers.

Steel and Torry and Dickey, (1997). Principles and Procedures of Statistic a Biometrical Approach

Third Edition. The Mc Graw Hill companies, Inc.

Waller R.A. and Duncan D.B. (1969). A Bayes Rule for the Symmetric Multiple Comparisons Problem

Journal of the American Statistical Association. 64, 328, 1484-1503.

89


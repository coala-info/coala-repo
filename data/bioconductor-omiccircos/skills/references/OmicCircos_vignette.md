The OmicCircos usages by examples

Ying Hu and Chunhua Yan

October 30, 2025

Contents

1 Introduction

2 Input file formats
segment data

.
2.1
.
.
2.2 mapping data .
link data .
2.3
.
.
link polygon data .
2.4

.
.
.

.

.

3 The package functions
.
.
.

sim.circos .
.
segAnglePo .
.
.
circos

3.1
3.2
3.3

.
.
.

.

.

4 Plotting parameters
basic plotting .
.
annotation .
.
.
label .
.
.
.
heatmap .

4.1
4.2
4.3
4.4

.
.
.

.

.
.
.
.

.
.
.

.
.
.
.

.
.
.
.

.
.
.

.
.
.
.

.
.
.
.

.
.
.

.
.
.
.

.
.
.
.

.
.
.

.
.
.
.

.
.
.
.

.
.
.

.
.
.
.

.
.
.
.

.
.
.

.
.
.
.

.
.
.
.

.
.
.

.
.
.
.

.
.
.
.

.
.
.

.
.
.
.

.
.
.
.

.
.
.

.
.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2

2
2
2
3
3

3
3
5
6

6
6
10
13
17

1

1 Introduction

The OmicCircos package generates high-quality circular plots for visualizing variations in omics data. The data can be
gene or chromosome position-based values from mutation, copy number, expression, and methylation analyses. This
package is capable of displaying variations in scatterplots, lines, and text labels. The relationships between genomic
features can be presented in the forms of polygons and curves. By utilizing the statistical and graphic functions in
R/Bioconductor environment, OmicCircos is also able to draw boxplots, histograms, and heatmaps from multiple
sample data. Each track is drawn independently, which allows the use to optimize the track quickly and easily.

In this vignette, we will introduce the package plotting functions using simulation data and TCGA gene expression

and copy number variation (cnv) data (http://www.cancergenome.nih.gov/).

A quick way to load the vignette examples is:

1

v i g n e t t e ( " O m i c C i r c o s " )

2 Input file formats

Four input data files are used in the package: segment data, mapping data, link data and link polygon data. Segment
data are required to draw the anchor circular track. The remaining three data sets are used to draw additional tracks or
connections.

2.1

segment data

The segment data lay out the foundation of a circular graph and typically are used to draw the outmost anchor
track. In the segment data, column 1 should be the segment or chromosome names. Columns 2 and 3 are the start and
end positions of the segment. Columns 4 and 5 are optional which can contain additional description of the segment.
The package comes with the segment data for human (hg18 and hg19) and mouse (mm9 and mm10). Let’s start by
loading the package

1

o p t i o n s ( s t r i n g s A s F a c t o r s = FALSE ) ;
l i b r a r y ( O m i c C i r c o s ) ;

2
3 ## input hg19 cytogenetic band data
4 d a t a ( U C S C. h g 1 9. c h r ) ;
5 h e a d ( U C S C .h g 1 9 . c h r ) ;

chrom chromStart chromEnd

1
2
3
4
5

chr1
chr1
chr1
chr1
chr1

2300000 p36.33
0
5300000 p36.32
2300000
7100000 p36.31
5300000
7100000
9200000 p36.23
9200000 12600000 p36.22

name gieStain
gneg
gpos25
gneg
gpos25
gneg

2.2 mapping data

The mapping data are an R data frame which includes values to be drawn in the graph. In the mapping data,
columns 1 and 2 are segment name and position respectively. Column 3 and beyond is optional which can be the value
or name. In the following example, the third column is the gene symbol. Column 4 and 5 are the gene expression
values for each sample.

o p t i o n s ( s t r i n g s A s F a c t o r s = FALSE ) ;

1
2 # load the OmicCircos-package
3
4 ## TCGA gene expression data

l i b r a r y ( O m i c C i r c o s ) ;

2

5 d a t a ( T C G A . B C . g e n e . e x p . 2 k . 6 0 ) ;
6 h e a d ( T C G A . B C . g e n e . e x p . 2 k . 6 0 [ , c ( 1 : 5 ) ] ) ;

chr

po
10 122272906 PPAPDC1A
SHC4
15
ZNF552
19
IL12RB2
1
ABAT
16

46973079
63014177
67590402
8750130

NAME TCGA.A1.A0SK.01A TCGA.A1.A0SO.01A
0.224
3.656
0.417
4.054
-1.880

-0.809
-0.704
-3.116
3.420
-3.165

282
363
456
15
381

2.3

link data

The link data are for drawing curves between two anchor points. In the link data, columns 1, 2, 3 are the segment
name, position, label of the first anchor point; columns 4, 5, 6 are segment name, position, label of the second anchor
point Column 7 is optional and could be used for the link type description.

o p t i o n s ( s t r i n g s A s F a c t o r s = FALSE ) ;

l i b r a r y ( O m i c C i r c o s ) ;

1
2 # load the OmicCircos-package
3
4 ## TCGA fusion gene data
5 d a t a ( TCGA.BC.fus ) ;
6 h e a d ( TCGA.BC.fus [ , c ( 1 : 6 ) ] ) ;

chr1

gene2
gene1 chr2
po1
37493749 ANKRD30A
10
WDPCP
2 63456333
POTED
14995400
21
18 14563374
PARD6G
CCDC36
3
10 37521495 ANKRD30A
49282645
LRCH4
7 100177212
10 37521495 ANKRD30A
PARD6G
112551
ROCK1
18 18539803

po2

18

1
2
3
4
5

2.4

link polygon data

The link polygon data are for connecting two segments with a polygon graph.
In the link polygon data,
columns 1, 2 and 3 are the name, start and end points for the first segment and columns 4, 5 and 6 are the name,
start and end points for the second segment.

3 The package functions

There are three main functions in the package: sim.circos, segAnglePo and circos. sim.circos generates
simulation data for drawing circular plots. segAnglePo converts the genomic (linear) coordinates (chromosome
base pair positions) to the angle based coordinates along circumference. circos enables users to superimpose graphics
on the circle track.

3.1

sim.circos

The sim.circos function generates four simutatedinput data files, which allows users to preview the graph quickly
with different parameters and design an optimal presentation with desired features. In the following example, there
are 10 segments, 10 individuals, 10 links, and 10 link polygons. Each segment has the value ranging from 20 to 50.
The values will be generated by rnorm(1) + i. The i is the ordinal number of the segments. The values are increased
by the segment order.

3

o p t i o n s ( s t r i n g s A s F a c t o r s = FALSE ) ;

l i b r a r y ( O m i c C i r c o s ) ;

1
2 # load the OmicCircos-package
3
4 # set up the initial parameters
← 1 0 ;
s e g . n u m
5
← 2 0 ;
i n d . n u m
← c ( 2 0 : 5 0 ) ;
s e g . p o
← 1 0 ;
l i n k . n u m
l i n k . p g . n u m ← 1 0 ;

9
10 # run sim.circos function
11

s i m . o u t

8

6

7

← s i m . c i r c o s ( s e g = seg.num , po= s e g . p o ,

i n d = ind.num ,

l i n k = l i n k . n u m ,

l i n k . p g =

l i n k . p g . n u m ) ;

12 # display the data set names
13 names ( s i m . o u t )
14 # display the segment data
15 h e a d ( s i m . o u t $ s e g . f r a m e [ , c ( 1 : 3 ) ] )

seg.name seg.Start seg.End
1
2
3
4
5

chr1
chr1
chr1
chr1
chr1

0
1
2
3
4

1
2
3
4
5

1 # display the mapping data
2 h e a d ( s i m . o u t $ s e g . m a p p i n g [ , c ( 1 : 5 ) ] )

name1 name2
1.432 0.991

name3
seg.name seg.po
1
0.931
2 -0.442 1.65 -0.078
0.128
3
1.372 1.19
4 -0.971 0.415
1.203
0.713 0.482 -1.863
5

chr1
chr1
chr1
chr1
chr1

1
2
3
4
5

1 # display the linking data
2 h e a d ( s i m . o u t $ s e g . l i n k )

seg1 po1 name1 seg2 po2 name2 name3
n1
1
chr2
n2
2 chr10
n3
3 chr10
n4
chr7
4
n5
chr6
5

n1 chr6
2
n2 chr1 31
n3 chr8 10
0
n4 chr2
1
n5 chr7

25
11
1
8
20

n1
n2
n3
n4
n5

1 # display the linking polygon data
2 h e a d ( s i m . o u t $ s e g . l i n k . p g )

seg1 start1 end1
17
1
chr6
3
2 chr10
0
chr4
3
32
chr7
4
27
chr6
5

12
28
13
24
16

seg2 start2 end2
32
chr3
16
chr1
2
chr6
4
chr6
7
chr8

17
3
10
21
4

4

3.2

segAnglePo

The segAnglePo function converts the segment pointer positions (linear coordinates) into angle values (the angle
based coordinates along circumference) and returns a data frame. It specifies the circle size, number of segments, and
segment length.

1

2

l i b r a r y ( O m i c C i r c o s ) ;
o p t i o n s ( s t r i n g s A s F a c t o r s = FALSE ) ;
s e t . s e e d ( 1 2 3 4 ) ;

3
4 ## initial values for simulation data
5

s e g . n u m
i n d . n u m
s e g . p o
l i n k . n u m
l i n k . p g . n u m ← 4 ;

← 1 0 ;
← 2 0 ;
← c ( 2 0 : 5 0 ) ;
← 1 0 ;

9
10 ## output simulation data
11

l i n k . p g = l i n k . p g . n u m ) ;

← s i m . o u t $ s e g . f r a m e ;
← s i m . o u t $ s e g . m a p p i n g ;
← s i m . o u t $ s e g . l i n k

s e g . f
s e g . v
l i n k . v
l i n k . p g . v ← s i m . o u t $ s e g . l i n k . p g
s e g . n u m ← l e n g t h ( unique ( s e g . f [ , 1 ] ) ) ;

17
18 ## select segments
19
20 db

s e g . n a m e ← p a s t e ( " c h r " , 1 : seg.num ,

← s e g A n g l e P o ( s e g . f ,

s e p ="" ) ;
s e g = s e g . n a m e ) ;

6

7

8

12

13

14

15

16

s i m . o u t ← s i m . c i r c o s ( s e g = seg.num , po= s e g . p o ,

i n d = ind.num ,

l i n k = l i n k . n u m ,

seg.name angle.start angle.end seg.sum.start seg.sum.end seg.start

"270"
"317.398"
"363.83"
"405.432"
"430.614"
"478.011"
"500.295"
"547.693"
"579.636"
"600.955"

"315.398" "0"
"361.83"
"47"
"403.432" "93"
"428.614" "134"
"476.011" "158"
"498.295" "205"
"545.693" "226"
"577.636" "273"
"598.955" "304"
"324"
"628"

"47"
"93"
"134"
"158"
"205"
"226"
"273"
"304"
"324"
"352"

"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"
"0"

[1,] "chr1"
[2,] "chr2"
[3,] "chr3"
[4,] "chr4"
[5,] "chr5"
[6,] "chr6"
[7,] "chr7"
[8,] "chr8"
[9,] "chr9"
[10,] "chr10"
seg.end

[1,] "47"
[2,] "46"
[3,] "41"
[4,] "24"
[5,] "47"
[6,] "21"
[7,] "47"
[8,] "31"
[9,] "20"

In the above example, there are 10 segments in a circle. Column 1 is segment name. Columns 2, 3 are the start and
end angles of the segment. Column 4 and 5 are the accumulative start and end positions. Column 6 and 7 are the start
and end position for the segment. The plotting is clockwise starting at 12 o’clock (270 degree).

5

3.3

circos

The circos is the main function to draw different shapes of the circle. For example, expression and CNV data
can be viewed using basic shapes like scatterplots and lines while structural variations such as translocations and
fusion proteins can be viewed using curves and polygons to connect different segments. Additionally, multiple sample
expression and CNV data sets can be displayed as boxplots, histograms, or heatmaps using standard R functions such
as apply. The usage of this function is illustrated in the next section.

4 Plotting parameters

4.1 basic plotting

The input data sets were generated by textttsim.circos function.

1

2

3

4

o p t i o n s ( s t r i n g s A s F a c t o r s = FALSE ) ;
l i b r a r y ( O m i c C i r c o s ) ;
o p t i o n s ( s t r i n g s A s F a c t o r s = FALSE ) ;
s e t . s e e d ( 1 2 3 4 ) ;

8

5
6 # initial
s e g . n u m
7
i n d . n u m
s e g . p o
l i n k . n u m
l i n k . p g . n u m ← 4 ;

9

10

11

← 1 0 ;
← 2 0 ;
← c ( 2 0 : 5 0 ) ;
← 1 0 ;

12

13

14

15

16

17

18

19

20

s i m . o u t ← s i m . c i r c o s ( s e g = seg.num , po= s e g . p o ,

i n d = ind.num ,

l i n k = l i n k . n u m ,

l i n k . p g = l i n k . p g . n u m ) ;

← s i m . o u t $ s e g . f r a m e ;
← s i m . o u t $ s e g . m a p p i n g ;
← s i m . o u t $ s e g . l i n k

s e g . f
s e g . v
l i n k . v
l i n k . p g . v ← s i m . o u t $ s e g . l i n k . p g
s e g . n u m ← l e n g t h ( unique ( s e g . f [ , 1 ] ) ) ;

s e g . n a m e ← p a s t e ( " c h r " , 1 : seg.num ,

21
22 # name segment (option)
23
24 db
25 # set transparent colors
26

c o l o r s ← rainbow ( seg.num ,

← s e g A n g l e P o ( s e g . f ,

a l p h a =0 . 5 ) ;

s e p ="" ) ;
s e g = s e g . n a m e ) ;

To get perfect circle, the output figure should be in square. The output file is the same width and height. The same

line values are in the margin of the graphical parameters.

1 par ( mar=c ( 2 , 2 , 2 , 2 ) ) ;
2 p l o t ( c ( 1 , 8 0 0 ) , c ( 1 , 8 0 0 ) ,
3

t y p e ="n" , a x e s =FALSE , x l a b ="" , y l a b ="" , main="" ) ;

4

5

6

7

8

c i r c o s (R=400 , c i r =db ,
c i r c o s (R=360 , c i r =db , W=40 , mapping = s e g . v ,

c o l = c o l o r s , p r i n t . c h r . l a b =TRUE , W=4 ,
B=TRUE ,

t y p e =" l " ,

c o l . v =3 ,

t y p e =" c h r " ,

s c a l e =TRUE) ;
c o l = c o l o r s [ 1 ] ,

lwd =2 ,

s c a l e =TRUE) ;

c i r c o s (R=320 , c i r =db , W=40 , mapping = s e g . v ,
s c a l e =TRUE) ;
c i r c o s (R=280 , c i r =db , W=40 , mapping = s e g . v ,

lwd =2 ,

[ 9 ] ,

c o l . v =3 ,

t y p e =" l s " , B=FALSE ,

c o l = c o l o r s

c o l . v =3 ,

t y p e =" l h " , B=TRUE ,

c o l = c o l o r s [ 7 ] ,

lwd =2 ,

s c a l e =TRUE) ;

c i r c o s (R=240 , c i r =db , W=40 , mapping = s e g . v ,

c o l . v =19 ,

t y p e ="ml" , B=FALSE ,

c o l = c o l o r s ,

lwd =2 ,

s c a l e =TRUE) ;

6

9

c i r c o s (R=200 , c i r =db , W=40 , mapping = s e g . v ,

c o l . v =19 ,

t y p e ="ml2" , B=TRUE ,

c o l = c o l o r s ,

lwd = 2 ) ;

10

c i r c o s (R=160 , c i r =db , W=40 , mapping = s e g . v ,

c o l . v =19 ,

t y p e ="ml3" , B=FALSE ,

c u t o f f =5 ,

lwd = 2 ) ;

11

12

c i r c o s (R=150 , c i r =db , W=40 , mapping = l i n k . v ,
c i r c o s (R=150 , c i r =db , W=40 , mapping = l i n k . p g . v ,

t y p e =" l i n k " ,

lwd =2 , c o l = c o l o r s [ c ( 1 , 7 ) ] ) ;

t y p e =" l i n k . p g " ,

lwd =2 , c o l = sample (

c o l o r s , l i n k . p g . n u m ) ) ;

Figure 1 from outside to inside: Track is lines; Track 2 is the stair steps; Track 3 is the horizontal lines; Tracks 4,

5 and 6 are the multiple lines, stair steps and horizontal lines for multiple the samples.

Figure 1

1

2

3

o p t i o n s ( s t r i n g s A s F a c t o r s = FALSE ) ;
l i b r a r y ( O m i c C i r c o s ) ;
s e t . s e e d ( 1 2 3 4 ) ;

4
5 ## initial values for simulation data
6

s e g . n u m
i n d . n u m
s e g . p o

7

8

← 1 0 ;
← 2 0 ;
← c ( 2 0 : 5 0 ) ;

7

9

l i n k . n u m
l i n k . p g . n u m ← 4 ;

← 1 0 ;

10
11 ## output simulation data
12

s i m . o u t ← s i m . c i r c o s ( s e g = seg.num , po= s e g . p o ,

i n d = ind.num ,

l i n k = l i n k . n u m ,

13

14

15

16

17

18

19

l i n k . p g = l i n k . p g . n u m ) ;

← s i m . o u t $ s e g . f r a m e ;
← s i m . o u t $ s e g . m a p p i n g ;
← s i m . o u t $ s e g . l i n k

s e g . f
s e g . v
l i n k . v
l i n k . p g . v ← s i m . o u t $ s e g . l i n k . p g
s e g . n u m ← l e n g t h ( unique ( s e g . f [ , 1 ] ) ) ;

20
21 ## select segments
22
23 db
24

s e g . n a m e ← p a s t e ( " c h r " , 1 : seg.num ,

← s e g A n g l e P o ( s e g . f ,

s e p ="" ) ;
s e g = s e g . n a m e ) ;

25

c o l o r s ← rainbow ( seg.num ,

a l p h a =0 . 5 ) ;

1 par ( mar=c ( 2 , 2 , 2 , 2 ) ) ;
2 p l o t ( c ( 1 , 8 0 0 ) , c ( 1 , 8 0 0 ) ,
3

t y p e ="n" , a x e s =FALSE , x l a b ="" , y l a b ="" , main="" ) ;

4

5

6

7

8

9

c i r c o s (R=400 ,
c i r c o s (R=360 , c i r =db , W=40 , mapping = s e g . v ,

t y p e =" c h r " ,

c i r =db ,

c o l = c o l o r s , p r i n t . c h r . l a b =TRUE , W=4 ,

s c a l e =TRUE) ;

c o l . v =8 ,

t y p e ="box" ,

B=TRUE ,

c o l = c o l o r s

[ 1 ] ,

lwd =0 . 1 ,

s c a l e =TRUE) ;

c i r c o s (R=320 , c i r =db , W=40 , mapping = s e g . v ,

c o l . v =8 ,

t y p e =" h i s t " , B=TRUE ,

c o l = c o l o r s

[ 3 ] ,

lwd =0 . 1 ,

s c a l e =TRUE) ;

c i r c o s (R=280 , c i r =db , W=40 , mapping = s e g . v ,

c o l . v =8 ,

t y p e ="ms" , B=TRUE ,

c o l = c o l o r s [ 7 ] ,

lwd =0 . 1 ,

s c a l e =TRUE) ;

c i r c o s (R=240 , c i r =db , W=40 , mapping = s e g . v ,

c o l . v =3 ,

t y p e ="h" , B=FALSE ,

c o l = c o l o r s

[ 2 ] ,

lwd =0 . 1 ) ;

c i r c o s (R=200 , c i r =db , W=40 , mapping = s e g . v ,

c o l . v =3 ,

t y p e =" s " , B=TRUE ,

c o l = c o l o r s ,

lwd

=0 . 1 ) ;

10

c i r c o s (R=160 , c i r =db , W=40 , mapping = s e g . v ,

c o l . v =3 ,

t y p e ="b" , B=FALSE ,

c o l = c o l o r s ,

lwd

=0 . 1 ) ;

11

12

c i r c o s (R=150 , c i r =db , W=40 , mapping = l i n k . v ,
c i r c o s (R=150 , c i r =db , W=40 , mapping = l i n k . p g . v ,

t y p e =" l i n k " ,

lwd =2 , c o l = c o l o r s [ c ( 1 , 7 ) ] ) ;

t y p e =" l i n k . p g " ,

lwd =2 , c o l = sample (

c o l o r s , l i n k . p g . n u m ) ) ;

Figure 2 from outside to inside: Track 1 is the boxplot for the samples from column 8 (col.v=8) to the last column
in the data frame seg.v with the scale; Track 2 and track 3 are the histograms (in horizontal) and the scatter plots for
multiple samples as track 1. Tracks 4, 5 and 6 are the histogram (in vertical), scatter plot and vertical line for just one
sample (column 3 in the data frame seg.v).

1

2

3

o p t i o n s ( s t r i n g s A s F a c t o r s = FALSE ) ;
l i b r a r y ( O m i c C i r c o s ) ;
s e t . s e e d ( 1 2 3 4 ) ;

4
5 ## initial values for simulation data
6

7

8

9

s e g . n u m
i n d . n u m
s e g . p o
l i n k . n u m
l i n k . p g . n u m ← 4 ;

← 1 0 ;
← 2 0 ;
← c ( 2 0 : 5 0 ) ;
← 1 0 ;

10
11 ## output simulation data
12

s i m . o u t ← s i m . c i r c o s ( s e g = seg.num , po= s e g . p o ,

i n d = ind.num ,

l i n k = l i n k . n u m ,

13

l i n k . p g = l i n k . p g . n u m ) ;

8

Figure 2

9

14

15

16

17

18

19

← s i m . o u t $ s e g . f r a m e ;
← s i m . o u t $ s e g . m a p p i n g ;
← s i m . o u t $ s e g . l i n k

s e g . f
s e g . v
l i n k . v
l i n k . p g . v ← s i m . o u t $ s e g . l i n k . p g
s e g . n u m ← l e n g t h ( unique ( s e g . f [ , 1 ] ) ) ;

20
21 ##
22
23 db
24

s e g . n a m e ← p a s t e ( " c h r " , 1 : seg.num ,

← s e g A n g l e P o ( s e g . f ,

s e p ="" ) ;
s e g = s e g . n a m e ) ;

25

c o l o r s ← rainbow ( seg.num ,

a l p h a =0 . 5 ) ;

1 par ( mar=c ( 2 , 2 , 2 , 2 ) ) ;
2 p l o t ( c ( 1 , 8 0 0 ) , c ( 1 , 8 0 0 ) ,
3

t y p e ="n" , a x e s =FALSE , x l a b ="" , y l a b ="" , main="" ) ;

4

5

6

7

8

9

11

12

13

14

15

16

17

18

19

20

21

c i r c o s (R=400 ,
c i r c o s (R=360 , c i r =db , W=40 , mapping = s e g . v ,

t y p e =" c h r " ,

c i r =db ,

c o l = c o l o r s , p r i n t . c h r . l a b =TRUE , W=4 ,

s c a l e =TRUE) ;

c o l . v =8 ,

t y p e =" q u a n t 9 0 " , B=FALSE ,

c o l =

c o l o r s ,

lwd =2 ,

s c a l e =TRUE) ;

c i r c o s (R=320 , c i r =db , W=40 , mapping = s e g . v ,

c o l . v =3 ,

t y p e =" s v " , B=TRUE ,

c o l = c o l o r s [ 7 ] ,

s c a l e =TRUE) ;

c i r c o s (R=280 , c i r =db , W=40 , mapping = s e g . v ,

c o l . v =3 ,

t y p e =" s s " , B=FALSE ,

c o l = c o l o r s [ 3 ] ,

s c a l e =TRUE) ;

c i r c o s (R=240 , c i r =db , W=40 , mapping = s e g . v ,
c i r c o s (R=200 , c i r =db , W=40 , mapping = s e g . v ,

c o l . v =8 ,
c o l . v =3 ,

[ 4 ] ) ;

t y p e =" h e a t m a p " ,
t y p e =" s . s d " , B=FALSE ,

lwd = 3 ) ;

c o l = c o l o r s

10

c i r c o s (R=160 , c i r =db , W=40 , mapping = s e g . v ,

c o l . v =3 ,

t y p e =" c i 9 5 " , B=TRUE ,

c o l = c o l o r s

[ 4 ] ,

lwd = 2) ;

c i r c o s (R=150 , c i r =db , W=40 , mapping = l i n k . v ,
c i r c o s (R=150 , c i r =db , W=40 , mapping = l i n k . p g . v ,

t y p e =" l i n k " ,

lwd =2 , c o l = c o l o r s [ c ( 1 , 7 ) ] ) ;

t y p e =" l i n k . p g " ,

lwd =2 , c o l = sample (

c o l o r s , l i n k . p g . n u m ) ) ;

t h e . c o l 1 =rainbow ( 1 0 , a l p h a =0 . 5 ) [ 3 ] ;
h i g h l i g h t ← c ( 1 6 0 , 4 1 0 , 6 , 2 , 6 , 1 0 ,
t h e . c o l 1 ,
c i r c o s (R=110 , c i r =db , W=40 , mapping = h i g h l i g h t ,

t h e . c o l 1 ) ;
t y p e =" h l " ,

lwd = 1 ) ;

t h e . c o l 1 =rainbow ( 1 0 , a l p h a =0 . 1 ) [ 3 ] ;
t h e . c o l 2 =rainbow ( 1 0 , a l p h a =0 . 5 ) [ 1 ] ;
h i g h l i g h t ← c ( 1 6 0 , 4 1 0 , 3 , 1 2 , 3 , 2 0 ,
c i r c o s (R=110 , c i r =db , W=40 , mapping = h i g h l i g h t ,

t h e . c o l 1 ,

t h e . c o l 2 ) ;

t y p e =" h l " ,

lwd = 2 ) ;

Figure 3 from outside to inside: Track 1 is the three lines for quantile values for the samples from column 8
(col.v=8) to the last column in the data frame seg.v with the scale. The middle line is for the median, the outside line
and the inside line are for 90% and the 10%, respectively; Track 2 is the circle points with the center=median and
radium=variance; Track 3 is the circle plot with the center equal to the mean and scaled value (for example, the range
from 0 to 3); Tracks 4 is the heatmap for the samples from column 8 (col.v=8) to the last column in the data frame
seg.v; Track 5 is the circle plot with the center=median and radius=standard deviation; Track 6 is the 95% confidence
interval of the samples.

4.2

annotation

1

2

3

o p t i o n s ( s t r i n g s A s F a c t o r s = FALSE ) ;
l i b r a r y ( O m i c C i r c o s ) ;
s e t . s e e d ( 1 2 3 4 ) ;

10

Figure 3

11

4
5 ## load mm cytogenetic band data
6 d a t a ( "UCSC.mm10.chr" , package =" O m i c C i r c o s " ) ;
7

r e f
r e f [ , 1 ] ← gsub ( " c h r " , "" ,

← UCSC.mm10.chr ;

8
9 ## initial values for simulation data
10

r e f [ , 1 ] ) ;

c o l o r s ← rainbow ( 1 0 , a l p h a =0 . 8 ) ;
l a b . n ← 5 0 ;
c n v . n ← 2 0 0 ;
a r c . n ← 3 0 ;
f u s . n ← 1 0 ;

11

12

13

14

18

19

i n 1 : a r c . n ) {

15
16 ## make arc data
a r c . d ← c ( ) ;
17
f o r ( i
c h r
c h r . i ← which ( r e f [ , 1 ] = = c h r ) ;
c h r . a r c ← r e f [ c h r . i
a r c . i ← sample ( 1 : nrow ( c h r . a r c ) , 2 ) ;
a r c . d ← r b i n d ( a r c . d , c ( c h r . a r c [ a r c . i [ 1 ] , c ( 1 , 2 ) ] ,

← sample ( 1 : 1 9 , 1 ) ;

, ] ;

21

20

22

colnames ( a r c . d ) ← c ( " c h r " , " s t a r t " , "end" , " v a l u e " ) ;

32

33

30

31

29

i n 1 : f u s . n ) {

← sample ( 1 : 1 9 , 1 ) ;
← sample ( 1 : 1 9 , 1 ) ;

26
27 ## make fusion
f u s . d ← c ( ) ;
28
f o r ( i
c h r 1
c h r 2
c h r 1 . i ← which ( r e f [ , 1 ] = = c h r 1 ) ;
c h r 2 . i ← which ( r e f [ , 1 ] = = c h r 2 ) ;
c h r 1 . f ← r e f [ c h r 1 . i
c h r 2 . f ← r e f [ c h r 2 . i
f u s 1 . i ← sample ( 1 : nrow ( c h r 1 . f ) , 1 ) ;
f u s 2 . i ← sample ( 1 : nrow ( c h r 2 . f ) , 1 ) ;
n1
n2
f u s . d ← r b i n d ( f u s . d , c ( c h r 1 . f [ f u s 1 . i , c ( 1 , 2 ) ] , n1 ,

← p a s t e 0 ( "geneA" ,
← p a s t e 0 ( "geneB" ,

i ) ;
i ) ;

, ] ;
, ] ;

38

34

37

35

39

36

23
24 }
25

40
41 }
42

c h r . a r c [ a r c . i [ 2 ] , c ( 2 , 4 ) ] ) ) ;

c h r 2 . f [ f u s 2 . i , c ( 1 , 2 ) ] , n2 ) ) ;

colnames ( f u s . d ) ← c ( " c h r 1 " , "po1" , " g e n e 1 " , " c h r 2 " , "po2" , " g e n e 2 " ) ;

43

44

45

46

c n v . i ← sample ( 1 : nrow ( r e f ) , c n v . n ) ;
v a l e ← rnorm ( c n v . n ) ;
c n v . d ← d a t a . f r a m e ( r e f [ c n v . i , c ( 1 , 2 ) ] , v a l u e = v a l e ) ;

1 par ( mar=c ( 2 , 2 , 2 , 2 ) ) ;
2 p l o t ( c ( 1 , 8 0 0 ) , c ( 1 , 8 0 0 ) ,
3

t y p e ="n" , a x e s =FALSE , x l a b ="" , y l a b ="" ) ;

4

5

6

7

8

c i r c o s (R=400 ,
c i r c o s (R=340 , c i r ="mm10" , W=60 , mapping = c n v . d ,
c i r c o s (R=340 , c i r ="mm10" , W=60 , mapping = c n v . d ,

t y p e =" c h r " ,

c i r ="mm10" , p r i n t . c h r . l a b =TRUE , W=4 ,

s c a l e =TRUE) ;

t y p e ="b3" , B=TRUE ,
t y p e =" s 2 " , B=FALSE ,

c o l = c o l o r s [ 7 ] ) ;

c o l = c o l o r s [ 1 ] , c e x

=0 . 5 ) ;

c i r c o s (R=280 , c i r ="mm10" , W=60 , mapping = a r c . d ,

t y p e =" a r c 2 " , B=FALSE ,

c o l = c o l o r s ,

lwd

=10 , c u t o f f = 0 ) ;

c i r c o s (R=220 , c i r ="mm10" , W=60 , mapping = c n v . d ,

c o l . v =3 ,

t y p e ="b2" , B=TRUE ,

c u t o f f = −0.2

,

c o l = c o l o r s [ c ( 7 , 9 ) ] ,

lwd = 2 ) ;

12

9

10

c i r c o s (R=160 , c i r ="mm10" , W=60 , mapping = a r c . d ,
lwd =4 ,
c i r c o s (R=150 , c i r ="mm10" , W=10 , mapping = f u s . d ,

c o l o r s [ c ( 1 , 7 ) ] ,

s c a l e =TRUE) ;

c o l . v =4 ,

t y p e =" a r c " , B=FALSE ,

c o l =

t y p e =" l i n k " ,

lwd =2 , c o l = c o l o r s [ c

( 1 , 7 , 9 ) ] ) ;

Figure 4

4.3

label

Figure 4 from outside to inside: Track 1 is the vertical lines with the same length and radius which can be used for the
annotation of SNP positions; Track 2 is the arcs with the same radius which can be used for the segment annotation,
e.g. cnv ( copy number variation); Track 3 is the barplot with positive and negative values; Track 4 is the arcs in the
different radius.

1

2

o p t i o n s ( s t r i n g s A s F a c t o r s = FALSE ) ;
l i b r a r y ( O m i c C i r c o s ) ;

3
4 d a t a ( "TCGA.PAM50_genefu_hg18" ) ;
5 d a t a ( "TCGA.BC.fus" ) ;
6 d a t a ( "TCGA.BC.cnv.2k.60" ) ;

13

7 d a t a ( " T C G A . B C . g e n e . e x p . 2 k . 6 0 " ) ;
8 d a t a ( "TCGA.BC.sample60" ) ;
9 d a t a ( "TCGA.BC_Her2_cnv_exp" ) ;
10

11

12

p v a l u e ← −1 * l o g 1 0 ( TCGA.BC_Her2_cnv_exp [ , 5 ] ) ;
p v a l u e ← c b i n d ( TCGA.BC_Her2_cnv_exp [ , c ( 1 : 3 ) ] , p v a l u e ) ;

13
14 H e r 2 . i ← which ( TCGA.BC.sample60 [ , 2 ] == "Her2" ) ;
15 H e r 2 . n ← TCGA.BC.sample60 [ H e r 2 . i , 1 ] ;
16
17 H e r 2 . j ← which ( colnames ( TCGA.BC.cnv.2k.60 ) %i n% H e r 2 . n ) ;
18

← TCGA.BC.cnv.2k.60 [ , c ( 1 : 3 , H e r 2 . j ) ] ;

cnv
cnv.m ← cnv [ , c ( 4 : n c o l ( cnv ) ) ] ;
cnv.m [ cnv.m >
cnv.m [ cnv.m < −2 ] ← −2 ;
cnv ← c b i n d ( cnv [ , 1 : 3 ] , cnv.m ) ;

2 ] ← 2 ;

19

20

21

22

23
24 H e r 2 . j ← which ( colnames ( T C G A . B C . g e n e . e x p . 2 k . 6 0 ) %i n% H e r 2 . n ) ;
25

g e n e . e x p ← T C G A . B C . g e n e . e x p . 2 k . 6 0 [ , c ( 1 : 3 , H e r 2 . j ) ] ;
c o l o r s ← rainbow ( 1 0 , a l p h a =0 . 5 ) ;

26

1 par ( mar=c ( 2 , 2 , 2 , 2 ) ) ;
2 p l o t ( c ( 1 , 8 0 0 ) , c ( 1 , 8 0 0 ) ,
3

t y p e ="n" , a x e s =FALSE , x l a b ="" , y l a b ="" ) ;

4

5

6

7

8

9

c i r c o s (R=300 ,
c i r c o s (R=310 , c i r ="hg18" , W=20 , mapping =TCGA.PAM50_genefu_hg18 ,

c i r ="hg18" , p r i n t . c h r . l a b =FALSE , W=4 ) ;

t y p e =" c h r " ,

t y p e =" l a b e l " ,

s i d e =" o u t " , c o l =c ( " b l a c k " , " b l u e " , " r e d " ) , c e x =0 . 4 ) ;

c i r c o s (R=250 , c i r ="hg18" , W=50 , mapping =cnv ,

c o l . v =4 ,

t y p e ="ml3" , B=FALSE ,

c o l = c o l o r s

[ 7 ] ,

s c a l e =TRUE) ;
c i r c o s (R=200 , c i r ="hg18" , W=50 , mapping = g e n e . e x p ,

c u t o f f =0 ,

c o l . v =4 ,

t y p e ="ml3" , B=TRUE ,

c o l =

c o l o r s [ 3 ] ,

c u t o f f =0 ,

s c a l e =TRUE) ;

c i r c o s (R=140 , c i r ="hg18" , W=50 , mapping = p v a l u e ,

c o l . v =4 ,

t y p e =" l " , B=FALSE ,

c o l = c o l o r s

[ 1 ] ,

s c a l e =TRUE) ;

10 ## set fusion gene colors
11

c o l s ← rep ( c o l o r s [ 7 ] , nrow ( TCGA.BC.fus ) ) ;
c o l . i ← which ( TCGA.BC.fus [ , 1 ] = = TCGA.BC.fus [ , 4 ] ) ;
c o l s [ c o l . i ] ← c o l o r s [ 1 ] ;
c i r c o s (R=132 , c i r ="hg18" , W=50 , mapping =TCGA.BC.fus ,

12

13

14

Figure 5 is an example of adding outside labels.

t y p e =" l i n k " , c o l = c o l s ,

lwd = 2) ;

4

5

6

7

8

1 par ( mar=c ( 2 , 2 , 2 , 2 ) ) ;
2 p l o t ( c ( 1 , 8 0 0 ) , c ( 1 , 8 0 0 ) ,
3

c i r c o s (R=300 ,
c i r c o s (R=290 , c i r ="hg18" , W=20 , mapping =TCGA.PAM50_genefu_hg18 ,

t y p e =" c h r " ,

t y p e ="n" , a x e s =FALSE , x l a b ="" , y l a b ="" , main="" ) ;
c i r ="hg18" , c o l =TRUE , p r i n t . c h r . l a b =FALSE , W= 4 ) ;

t y p e =" l a b e l " ,

s i d e =" i n

" , c o l =c ( " b l a c k " , " b l u e " ) , c e x =0 . 4 ) ;
c i r c o s (R=310 , c i r ="hg18" , W=50 , mapping =cnv ,

c o l . v =4 ,

t y p e ="ml3" , B=TRUE ,

c o l = c o l o r s

[ 7 ] ,

s c a l e =TRUE) ;
c i r c o s (R=150 , c i r ="hg18" , W=50 , mapping = g e n e . e x p ,

c u t o f f =0 ,

c o l . v =4 ,

t y p e ="ml3" , B=TRUE ,

c o l =

c o l o r s [ 3 ] ,

s c a l e =TRUE) ;
c u t o f f =0 ,
c i r ="hg18" , W=50 , mapping = p v a l u e ,

c o l . v =4 ,

t y p e =" l " , B=FALSE ,

c o l = c o l o r s

c i r c o s (R=90 ,
[ 1 ] ,

s c a l e =TRUE) ;

c i r c o s (R=82 , c i r ="hg18" , W=50 , mapping =TCGA.BC.fus ,

t y p e =" l i n k " , c o l = c o l s ,

lwd = 2 ) ;

Figure 6 is an example of the inside labels.

14

Figure 5

15

Figure 6

16

4.4 heatmap

1

2

o p t i o n s ( s t r i n g s A s F a c t o r s = FALSE ) ;
l i b r a r y ( O m i c C i r c o s ) ;

3
4 d a t a ( "TCGA.PAM50_genefu_hg18" ) ;
5 d a t a ( "TCGA.BC.fus" ) ;
6 d a t a ( "TCGA.BC.cnv.2k.60" ) ;
7 d a t a ( " T C G A . B C . g e n e . e x p . 2 k . 6 0 " ) ;
8 d a t a ( "TCGA.BC.sample60" ) ;
9 d a t a ( "TCGA.BC_Her2_cnv_exp" ) ;
10

11

12

p v a l u e ← −1 * l o g 1 0 ( TCGA.BC_Her2_cnv_exp [ , 5 ] ) ;
p v a l u e ← c b i n d ( TCGA.BC_Her2_cnv_exp [ , c ( 1 : 3 ) ] , p v a l u e ) ;

13
14 H e r 2 . i ← which ( TCGA.BC.sample60 [ , 2 ] == "Her2" ) ;
15 H e r 2 . n ← TCGA.BC.sample60 [ H e r 2 . i , 1 ] ;
16
17 H e r 2 . j ← which ( colnames ( TCGA.BC.cnv.2k.60 ) %i n% H e r 2 . n ) ;
18

← TCGA.BC.cnv.2k.60 [ , c ( 1 : 3 , H e r 2 . j ) ] ;

cnv
cnv.m ← cnv [ , c ( 4 : n c o l ( cnv ) ) ] ;
cnv.m [ cnv.m >
cnv.m [ cnv.m < −2 ] ← −2 ;
cnv ← c b i n d ( cnv [ , 1 : 3 ] , cnv.m ) ;

2 ] ← 2 ;

19

20

21

22

23
24 H e r 2 . j ← which ( colnames ( T C G A . B C . g e n e . e x p . 2 k . 6 0 ) %i n% H e r 2 . n ) ;
25

g e n e . e x p ← T C G A . B C . g e n e . e x p . 2 k . 6 0 [ , c ( 1 : 3 , H e r 2 . j ) ] ;

26

27

c o l o r s ← rainbow ( 1 0 , a l p h a =0 . 5 ) ;

1 par ( mar=c ( 2 , 2 , 2 , 2 ) ) ;
2
3 p l o t ( c ( 1 , 8 0 0 ) , c ( 1 , 8 0 0 ) ,
4

t y p e ="n" , a x e s =FALSE , x l a b ="" , y l a b ="" , main="" ) ;

5

6

7

8

9

10

11

12

13

14

c i r c o s (R=400 , c i r ="hg18" , W=4 ,
c i r c o s (R=300 , c i r ="hg18" , W=100 , mapping = g e n e . e x p ,

t y p e =" c h r " , p r i n t . c h r . l a b =TRUE ,

c o l . v =4 ,

t y p e =" h e a t m a p 2 " ,

s c a l e =TRUE) ;

c l u s t e r =TRUE ,

c o l . b a r =TRUE ,

lwd =0 . 1 ,

c o l =" b l u e " ) ;
c o l . v =4 ,

c i r c o s (R=220 , c i r ="hg18" , W=80 , mapping =cnv ,

t y p e ="ml3" , B=FALSE ,

lwd =1 ,

c u t o f f =0 ) ;

c i r c o s (R=140 , c i r ="hg18" , W=80 , mapping = p v a l u e ,

c o l . v =4 ,

t y p e =" l " ,

B=TRUE ,

lwd

=1 , c o l = c o l o r s [ 1 ] ) ;

← rep ( c o l o r s [ 7 ] , nrow ( TCGA.BC.fus ) ) ;
← which ( TCGA.BC.fus [ , 1 ] = = TCGA.BC.fus [ , 4 ] ) ;

c o l s
c o l . i
c o l s [ c o l . i ] ← c o l o r s [ 1 ] ;
c i r c o s (R=130 , c i r ="hg18" , W=10 , mapping =TCGA.BC.fus ,

t y p e =" l i n k 2 " ,

lwd =2 , c o l = c o l s ) ;

Figure 7: An example of a circular plots generated by OmicCircos showing the expression, CNV and fusion protein
in 15 Her2 subtype samples from TCGA Breast Cancer data. Circular tracks from outside to inside: genome positions
by chromosomes (black lines are cytobands); expression heatmap (red: up-regulated; blue: down-regulated); CNVs
(red: gain; blue: loss); correlation p values between expression and CNVs; fusion genes.

17

Figure 7

18


R Package diagram: visualising simple graphs,
ﬂowcharts, and webs

Karline Soetaert
Royal Netherlands Institute of Sea Research (NIOZ)
Yerseke, The Netherlands

Abstract

This document describes how to use the diagram package (Soetaert 2009a) for plotting

small networks, ﬂow charts, and (food) webs.

Together with R-package shape (Soetaert 2009b) this package has been written to

produce the ﬁgures of the book (Soetaert and Herman 2009b).

The electrical network symbols were added to produce a ﬁgure of the book (Soetaert,

Cash, and Mazzia 2012)

Keywords: diagram, food web, ﬂow chart, arrows, R.

There are three ways in which package diagram can be used:

1. Introduction

(cid:136) function plotmat takes as input a matrix with transition coeﬃcients or interaction
strengths. It plots the corresponding network consisting of (labeled) boxes (the compo-
nents) connected by arrows. Each arrow is labeled with the value of the coeﬃcients.

(cid:136) function plotweb takes as input a matrix with (ﬂow) values, and plots a web. Here the
components are connected by arrows whose thickness is determined by the value of the
coeﬃcients.

(cid:136) Flowcharts can be made by adding separate objects (textboxes) to the ﬁgure and con-

necting these with arrows.

Three datasets have been included:

(cid:136) Rigaweb, the planktonic food web of the Gulf of Riga (Donali, Olli, Heiskanen, and

Andersen 1999).

(cid:136) Takapotoweb, the Takapoto atoll planktonic food web (Niquil, Jackson, Legendre, and

Delesalle 1998).

(cid:136) Teasel, the transition matrix describing the population dynamics of Teasel, a European

perennial weed ((Caswell 2001; Soetaert and Herman 2009b).

2

R Package diagram: visualising simple graphs, ﬂowcharts, and webs

The food webs were generated using R packages LIM and limSolve (Soetaert, Van den Meer-
sche, and van Oevelen 2009; Soetaert and van Oevelen 2009) which contain functions to read
and solve food web problems respectively.

2. plotmat - plotting networks based on matrix input

This is the quickest method of plotting a network. The network is speciﬁed in a matrix, which
gives the magnitudes of the links (from columns to rows).

The position of the elements (boxes) is speciﬁed by argument pos. Thus, setting pos=c(1,2,1)
indicates that the 4 elements will be arranged in three equidistant rows; on the ﬁrst row one
element, on the second row two elements and on the third row one element.

2.1. Simple examples

Below are some simple examples of the use of plotmat. In the ﬁrst graph - four simple boxes
are put; no arrows drawn

The second graph contains round boxes with arrows, labeled ”ﬂow”

The third graph has diamond-shaped boxes including self-arrows.

The fourth graph has hexagonal-shaped boxes, with curved arrows. The arrows are enlarged
and the arrowhead pointing from box 2 to 4 is colored red.

box.lwd = 2, cex.txt = 0.8, box.type = "circle", box.prop = 1.0)

> par(mar = c(1, 1, 1, 1), mfrow = c(2, 2))
> #
> #
> names <- c("A", "B", "C", "D")
> M <- matrix(nrow = 4, ncol = 4, byrow = TRUE, data = 0)
> plotmat(M, pos = c(1, 2, 1), name = names, lwd = 1,
box.lwd = 2, cex.txt = 0.8, box.size = 0.1,
+
+
box.type = "square", box.prop = 0.5)
> #
> M[2, 1] <- M[3, 1] <- M[4, 2] <- M[4, 3] <- "flow"
> plotmat(M, pos = c(1, 2, 1), curve = 0, name = names, lwd = 1,
+
> #
> #
> diag(M) <- "self"
> plotmat(M, pos = c(2, 2), curve = 0, name = names, lwd = 1, box.lwd = 2,
+
+
> M <- matrix(nrow = 4, ncol = 4, data = 0)
> M[2, 1] <- 1 ; M[4, 2] <- 2 ; M[3, 4] <- 3 ; M[1, 3] <- 4
> Col <- M
> Col[] <- "black"
> Col[4, 2] <- "darkred"
> pp <- plotmat(M, pos = c(1, 2, 1), curve = 0.2, name = names, lwd = 1,
+

box.lwd = 2, cex.txt = 0.8, arr.type = "triangle",

cex.txt = 0.8, self.cex = 0.5, self.shiftx = c(-0.1, 0.1, -0.1, 0.1),
box.type = "diamond", box.prop = 0.5)

Karline Soetaert

3

box.size = 0.1, box.type = "hexa", box.prop = 0.25,
arr.col = Col, arr.len = 1)

+
+
> mtext(outer = TRUE, side = 3, line = -1.5, cex = 1.5, "plotmat")
> #
> par(mfrow = c(1, 1))

The contents of pp shows the position of the various items.

Angle Value

rad

ArrowY

ArrowX

TextY
1 0.08333333 0.3085298 0.7169284 0.2843333 0.7346667
2 0.08333333 0.3077450 0.2841193 0.2843333 0.2653333
4 0.08333333 0.6918629 0.7164048 0.7156667 0.7346667
3 0.08333333 0.6910769 0.2825485 0.7156667 0.2653333

TextX

> pp

$arr

row col

1 53.1301
2 -53.1301
3 -53.1301
4 53.1301

1
2
3
4

2
4
1
3

$comp

x

y
[1,] 0.50 0.8333333
[2,] 0.25 0.5000000
[3,] 0.75 0.5000000
[4,] 0.50 0.1666667

$radii

y
x
[1,] 0.1 0.025
[2,] 0.1 0.025
[3,] 0.1 0.025
[4,] 0.1 0.025

$rect

xleft

[1,] 0.40 0.8083333
[2,] 0.15 0.4750000
[3,] 0.65 0.4750000
[4,] 0.40 0.1416667

ybot xright

ytop
0.60 0.8583333
0.35 0.5250000
0.85 0.5250000
0.60 0.1916667

2.2. a schematic representation of an ecosystem model

In the example below, ﬁrst the main components and arrows are drawn (plotmat), and the
output of this function written in list pp. This contains, a.o. the positions of the components
(boxes), arrows, etc.. It is used to draw an arrow from the middle of the arrow connecting
ﬁsh and zooplankton (”ZOO”) to detritus. Function straightarrow (see below) is used to
draw this arrow.

4

R Package diagram: visualising simple graphs, ﬂowcharts, and webs

Figure 1: Four simple examples of plotmat

f

b

d

p n z
0, 1, 0, 0, 0, 0, #p
0, 0, 4, 10, 11, 0, #n
2, 0, 0, 0, 0, 0, #z
8, 0, 13, 0, 0, 12, #d
9, 0, 0, 7, 0, 0, #b
0, 0, 5, 0, 0, 0 #f
))

> names <- c("PHYTO", "NH3", "ZOO", "DETRITUS", "BotDET", "FISH")
> M <- matrix(nrow = 6, ncol = 6, byrow = TRUE, data = c(
+ #
+
+
+
+
+
+
+
> #
> pp <- plotmat(M, pos = c(1, 2, 1, 2), curve = 0, name = names,
+
+
+
+
> #
> phyto
> zoo
> nh3
> detritus <- pp$comp[names=="DETRITUS"]
> fish
> #

<- pp$comp[names=="PHYTO"]
<- pp$comp[names=="ZOO"]
<- pp$comp[names=="NH3"]

<- pp$comp[names=="FISH"]

lwd = 1, box.lwd = 2, cex.txt = 0.8,
box.type = "square", box.prop = 0.5, arr.type = "triangle",
arr.pos = 0.4, shadow.size = 0.01, prefix = "f",
main = "NPZZDD model")

ABCDflowflowflowflowABCDselfflowflowselfflowselfflowselfABCD1243ABCDplotmatKarline Soetaert

5

Figure 2: An NPZZDD model

arr.pos = 0.4, lwd = 1)

> # flow5->detritus
> #
> m2 <- 0.5*(zoo+fish)
> m1 <- detritus
> m1[1] <- m1[1] + pp$radii[4,1]
> mid <- straightarrow (to = m1, from = m2, arr.type = "triangle",
+
> text(mid[1], mid[2]+0.03, "f6", cex = 0.8)
> #
> # flow2->detritus
> #
> m2 <- 0.5*(zoo+phyto)
> m1 <- detritus
> m1[1] <-m1[1] + pp$radii[3,1]*0.2
> m1[2] <-m1[2] + pp$radii[3,2]
> mid <- straightarrow (to = m1, from = m2, arr.type = "triangle",
+
> text(mid[1]-0.01, mid[2]+0.03, "f3", cex = 0.8)

arr.pos = 0.3, lwd = 1)

NPZZDD modelf2f8f9f1f4f13f5f10f7f11f12PHYTONH3ZOODETRITUSBotDETFISHf6f36

R Package diagram: visualising simple graphs, ﬂowcharts, and webs

2.3. Plotting a transition matrix

The next example uses formulae to label the arrows 1. This is done by passing a data.frame
rather than a matrix to function plotmat

<- 6

> # Create population matrix
> #
> Numgenerations
> DiffMat <- matrix(data = 0, nrow = Numgenerations, ncol = Numgenerations)
> AA <- as.data.frame(DiffMat)
> AA[[1,4]] <- "f[3]"
> AA[[1,5]] <- "f[4]"
> AA[[1,6]] <- "f[5]"
> #
> AA[[2,1]] <- "s[list(0,1)]"
> AA[[3,2]] <- "s[list(1,2)]"
> AA[[4,3]] <- "s[list(2,3)]"
> AA[[5,4]] <- "s[list(3,4)]"
> AA[[6,5]] <- "s[list(4,5)]"
> #
> name <- c(expression(Age[0]), expression(Age[1]), expression(Age[2]),
+
expression(Age[3]), expression(Age[4]), expression(Age[5]))
> #
> plotmat(A = AA, pos = 6, curve = 0.7, name = name, lwd = 2,
+
+
+

arr.len = 0.6, arr.width = 0.25, my = -0.2,
box.size = 0.05, arr.type = "triangle", dtext = 0.95,
main = "Age-structured population model 1")

2.4. Another transition matrix

The data set Teasel contains the transition matrix of the population dynamics model of
teasel (Dipsacus sylvestris), a European perennial weed, (Caswell 2001; Soetaert and Herman
2009b)

> Teasel

0.000
DS 1yr
0.966
DS 2yr
R small
0.013
R medium 0.007
0.008
R large
0.000
F

DS 1yr DS 2yr R small R medium R large
0.000
0.000
0.125
0.125
0.038
0.000

F
0.000 322.380
0.000
0.000
0.000
3.448
0.000 30.170
0.862
0.167
0.000
0.750

0.000
0.000
0.000
0.238
0.245
0.023

0.00
0.00
0.01
0.00
0.00
0.00

This dataset is plotted using curved arrows; we specify the curvature in a matrix called
curves.

1This is now possible thanks to Yvonnick Noel, Univ. Rennes, France

Karline Soetaert

7

Figure 3: A transition matrix

> curves <- matrix(nrow = ncol(Teasel), ncol = ncol(Teasel), 0)
> curves[3, 1] <- curves[1, 6] <- -0.35
> curves[4, 6] <- curves[6, 4] <- curves[5, 6] <- curves[6, 5] <- 0.08
> curves[3, 6] <- 0.35
> plotmat(Teasel, pos = c(3, 2, 1), curve = curves,
+
+
+
+
+
+

name = colnames(Teasel), lwd = 1, box.lwd = 2,
cex.txt = 0.8, box.cex = 0.8, box.size = 0.08,
arr.length = 0.5, box.type = "circle", box.prop = 1,
shadow.size = 0.01, self.cex = 0.6, my = -0.075, mx = -0.01,
relsize = 0.9, self.shiftx = c(0, 0, 0.125, -0.12, 0.125, 0),
self.shifty = 0, main = "Teasel population model")

3. plotweb - plotting webs based on matrix input

Given a matrix containing ﬂow values (from rows to columns), function plotweb will plot a
web. The elements are positioned on a circle, and connected by arrows; the magnitude of web
ﬂows determines the thickness of the arrow.

This function is less ﬂexible than plotmat, although it does allow to color the arrows diﬀer-
ently.

> BB <- matrix(nrow = 20, ncol = 20, 1:20)
> diag(BB) <- 0

Age−structured population model 1s0, 1s1, 2s2, 3f3s3, 4f4s4, 5f5Age0Age1Age2Age3Age4Age58

R Package diagram: visualising simple graphs, ﬂowcharts, and webs

Figure 4: The Teasel data set

Teasel population model0.9660.0130.0070.0080.010.1250.1250.0380.2380.2450.0230.1670.75322.383.44830.170.862DS 1yrDS 2yrR smallR mediumR largeFKarline Soetaert

9

NULL

Figure 5: Plotweb

> Col <- BB
> Col[] <- "black"
> Col[BB<10]<- "red"
> plotweb(BB, legend = TRUE, maxarrow = 3, arr.col = Col)

NULL

> par(mfrow = c(1, 1))

3.1. Foodwebs

Dataset Rigaweb ((Donali et al. 1999) contains ﬂow values for the food web of the Gulf of
Riga planktonic system.

> Rigaweb

123456789101112131415161718192020110

R Package diagram: visualising simple graphs, ﬂowcharts, and webs

D

Z

N

B

P1

P1
P2
B
N
Z
D
DOC
31.3182 54.4618
CO2
Sedimentation 0.0000 0.0000

CO2
P2
0.0000 4.12297 10.49431 0.000000 1.565910 17.22501
0.0000 0.0000
0.0000 0.00000 16.79755 4.457164 2.723090 29.95399
0.0000 0.0000
0.0000 9.44000 0.00000 0.000000 0.000000 244.99223
0.0000 0.0000
0.0000 0.00000 0.00000 0.000000 0.000000 13.40297
0.0000 0.0000
0.0000 0.00000 0.00000 3.183226 3.963226 30.19580
0.0000 0.0000
0.00000
0.0000 0.0000
0.0000 0.00000 12.34039 0.000000 0.000000
0.00000
0.0000 0.0000 261.1822 0.00000 0.00000 0.000000 0.000000
0.00000
0.0000 0.00000 0.00000 0.000000 0.000000
0.00000
0.0000 0.00000 0.00000 0.000000 0.000000

DOC

P1
P2
B
N
Z
D
DOC
CO2
Sedimentation

Sedimentation
0.10
0.34
0.00
0.00
0.78
13.92
0.00
0.00
0.00

> plotweb(Rigaweb, main = "Gulf of Riga food web",
sub = "mgC/m3/d", val = TRUE)
+

4. functions to create ﬂow charts

The various functions are given in table (1) 2.
The code below generates a ﬂow chart

<- nrow(fromto)

data = c(1, 2, 2, 3, 2, 4, 4, 7, 4, 8))

> par(mar = c(1, 1, 1, 1))
> openplotmat()
> elpos <- coordinates (c(1, 1, 2, 4))
> fromto <- matrix(ncol = 2, byrow = TRUE,
+
> nr
> arrpos <- matrix(ncol = 2, nrow = nr)
> for (i in 1:nr)
+ arrpos[i, ] <- straightarrow (to = elpos[fromto[i, 2], ],
+
+
> textellipse(elpos[1,], 0.1,
+
> textrect
+

(elpos[2,], 0.15, 0.05,lab = "found term?",

2textparallel was implemented by Michael Folkes, Canada

from = elpos[fromto[i, 1], ],
lwd = 2, arr.pos = 0.6, arr.length = 0.5)

lab = "start",
shadow.col = "darkgreen", shadow.size = 0.005, cex = 1.5)

box.col = "green",

box.col = "blue",

shadow.col = "darkblue", shadow.size = 0.005, cex = 1.5)

Karline Soetaert

11

Figure 6: The Gulf of Riga data set

Gulf of Riga food webmgC/m3/dP1P2BNZDDOCCO2Sedimentation12345678910111213141516171819261.180.11 : 4.1232 : 9.443 : 10.4944 : 16.7985 : 4.45726 : 9.15727 : 1.56598 : 2.72319 : 261.1810 : 3.963211 : 14.09312 : 24.50813 : 244.9914 : 13.40315 : 30.19616 : 0.117 : 0.3418 : 0.7819 : 13.9212

R Package diagram: visualising simple graphs, ﬂowcharts, and webs

Table 1: Summary of ﬂowchart functions

adds a circular self-pointing arrow
adds a branched arrow between several points

Description
creates an empty plot
calculates coordinates of elements, neatly arranged in rows/columns
adds 2-segmented arrow between two points
adds curved arrow between two points

Function
openplotmat
coordinates
bentarrow
curvedarrow
segmentarrow adds 3-segmented arrow between two points
selfarrow
splitarrow
straightarrow adds straight arrow between two points
treearrow
shadowbox
textdiamond
textellipse
textempty
texthexa
textmulti
textparallel
textplain
textrect
textround

adds dendrogram-like branched arrow between several points
adds a box with a shadow to a plot
adds lines of text in a diamond-shaped box to a plot
adds lines of text in a ellipse-shaped box to a plot
adds lines of text on a colored background to a plot
adds lines of text in a hexagonal box to a plot
adds lines of text in a multigonal box to a plot
adds lines of text in a parallelogram to a plot
adds lines of text to a plot
adds lines of text in a rectangular-shaped box to a plot
adds lines of text in a rounded box to a plot

box.col = "blue",

(elpos[4,], 0.15, 0.05,lab = "related?",

shadow.col = "darkblue", shadow.size = 0.005, cex = 1.5)

> textrect
+
> textellipse(elpos[3,], 0.1, 0.1, lab = c("other","term"), box.col = "orange",
shadow.col = "red", shadow.size = 0.005, cex = 1.5)
+
> textellipse(elpos[3,], 0.1, 0.1, lab = c("other","term"), box.col = "orange",
+
shadow.col = "red", shadow.size = 0.005, cex = 1.5)
> textellipse(elpos[7,], 0.1, 0.1, lab = c("make","a link"),box.col = "orange",
+
shadow.col = "red", shadow.size = 0.005, cex = 1.5)
> textellipse(elpos[8,], 0.1, 0.1, lab = c("new","article"),box.col = "orange",
+
shadow.col = "red", shadow.size = 0.005, cex = 1.5)
> #
> dd <- c(0.0, 0.025)
> text(arrpos[2, 1] + 0.05, arrpos[2, 2], "yes")
> text(arrpos[3, 1] - 0.05, arrpos[3, 2], "no")
> text(arrpos[4, 1] + 0.05, arrpos[4, 2] + 0.05, "yes")
> text(arrpos[5, 1] - 0.05, arrpos[5, 2] + 0.05, "no")
> #

The diﬀerent types of text boxes are generated with the following code:

> openplotmat(main = "textbox shapes")
> rx <- 0.1
> ry <- 0.05

Karline Soetaert

13

Figure 7: A ﬂow chart

startfound term?related?othertermothertermmakea linknewarticleyesnoyesno14

R Package diagram: visualising simple graphs, ﬂowcharts, and webs

cex = 2, shadow.col = "red")

cex = 2, shadow.col = "blue")

cex = 2, shadow.col = "darkblue")

cex = 2, shadow.col = "lightblue")

> pos <- coordinates(c(1, 1, 1, 1, 1, 1, 1,1 ), mx = -0.2)
> textdiamond(mid = pos[1,], radx = rx, rady = ry, lab = LETTERS[1],
+
> textellipse(mid = pos[2,], radx = rx, rady = ry, lab = LETTERS[2],
+
> texthexa(mid = pos[3,], radx = rx, rady = ry, lab = LETTERS[3],
+
> textmulti(mid = pos[4,], nr = 7, radx = rx, rady = ry, lab = LETTERS[4],
+
> textrect(mid = pos[5,], radx = rx, rady = ry, lab = LETTERS[5],
+
> textround(mid = pos[6,], radx = rx, rady = ry, lab = LETTERS[6],
+
> textparallel(mid = pos[7,], radx = rx, rady = ry, lab = LETTERS[7],
+
> textempty(mid = pos[8,], lab = LETTERS[8], cex = 2, box.col = "yellow")
> pos[ ,1] <- pos[ ,1] + 0.5
> text(pos[ ,1],pos[ ,2], c("textdiamond", "textellipse", "texthexa",
+
+

"textmulti", "textrect", "textround",
"textparallel", "textempty"))

cex = 2, theta = 40, shadow.col = "black")

cex = 2, shadow.col = "darkred")

cex = 2, shadow.col = "black")

The diﬀerent types of arrows are generated with the following code:

lty = 2, lcol = 2)

(from = elpos[2:3, ], to = elpos[4, ], lty = 4, lcol = 4)

> par(mar = c(1, 1, 1, 1))
> openplotmat(main = "Arrowtypes")
> elpos <- coordinates (c(1, 2, 1), mx = 0.1, my = -0.1)
> curvedarrow(from = elpos[1, ], to = elpos[2, ], curve = -0.5,
+
> straightarrow(from = elpos[1, ], to = elpos[2, ], lty = 3, lcol = 3)
> segmentarrow (from = elpos[1, ], to = elpos[2, ], lty = 1, lcol = 1)
> treearrow
> bentarrow (from = elpos[3, ], to = elpos[3, ]-c(0.1, 0.1),
+
> bentarrow(from = elpos[1, ], to = elpos[3, ], lty = 5, lcol = 5)
> selfarrow(pos = elpos[3, ], path = "R",lty = 6, curve = 0.075, lcol = 6)
> splitarrow(from = elpos[1, ], to = elpos[2:3, ], lty = 1,
+
> for ( i in 1:4)
+
> legend("topright", lty = 1:7, legend = c("segmentarrow",
+
+

"curvedarrow", "straightarrow", "treearrow", "bentarrow",
"selfarrow", "splitarrow"), lwd = c(rep(2, 6), 1), col = 1:7)

textrect (elpos[i, ], 0.05, 0.05, lab = i, cex = 1.5)

lwd = 1, dd = 0.7, arr.side = 1:2, lcol = 7)

arr.pos = 1, lty = 5, lcol = 5)

5. functions to draw electrical networks

Since version 1.6, it is possible to use diagram to draw electrical networks. Below I give an
example of a small transistor circuit.

Karline Soetaert

15

Figure 8: The text boxes

textbox shapesABCDEFGHtextdiamondtextellipsetexthexatextmultitextrecttextroundtextparalleltextempty16

R Package diagram: visualising simple graphs, ﬂowcharts, and webs

Figure 9: The arrow types

Arrowtypes1234segmentarrowcurvedarrowstraightarrowtreearrowbentarrowselfarrowsplitarrowKarline Soetaert

17

arr.pos =1, arr.type = "triangle", lwd = 1)

c(y3, y2, y1))
c(y2, y2, y1))
c(y4, y4, y1))

> layoutmat <- matrix(data = c(rep(1, 12), 2, 3, 4, 5),
nrow = 4, ncol = 4, byrow = TRUE)
+
> nf <- layout(layoutmat, respect = FALSE)
> par(lwd = 1.5)
> par(mar = c(0, 0, 2, 0))
> emptyplot(main = "transistor Amplifier", asp = FALSE,
+
ylim = c(-0.1, 1), xlim = c(-0.1, 1.1))
> x1 <- 0; x2 <- 0.2; x3 <- 0.4; x4 <- 0.6; x5 <- 0.8; x6 <- 1
> y1 <- 0.05; y2 <- 0.4; y3 <- 0.5; y4 <- 0.6; y5 <- 0.95
> x23 <- (x2 + x3)/2
> x56 <- (x5 + x6)/2
> lines(c(x2, x6, x6, x2, x2, x1, x1, x23, x3, x3),
c(y1, y1, y5, y5, y1, y1, y3, y3, y4, y5))
+
> lines(c(x23, x3, x3),
> lines(c(x3, x4, x4),
> lines(c(x3, x5, x5),
> en.Amplifier(c(x23, y3), r = 0.035)
> en.Signal(c(x1, 0.2), lab = expression("U"["in"]))
> en.Signal(c(x6, y2), lab = expression("U"["b"]))
> straightarrow(c(x1 - 0.05, 0.23), c(x1 - 0.05, 0.17),
+
> straightarrow(c(x6 + 0.05, y2 + 0.03), c(x6 + 0.05, y2 - 0.03),
+
> en.Node(c(x1, y3), lab = "u1")
> en.Node(c(x2, y3), lab = "u2")
> en.Node(c(x3, y2), lab = "u3", pos = 1.5)
> en.Node(c(x3, y4), lab = "u4", pos = 2.5)
> en.Node(c(x5, y4), lab = "u5")
> en.Capacitator(c(0.5*(x1 + x2),y3), lab = "C1", vert = FALSE)
> en.Capacitator(c(x4, y4), lab = "C3", vert = FALSE)
> en.Capacitator(c(x4, 0.5*(y1+y2)), lab = "C2", vert = TRUE)
> en.Resistor(c(x1, y2), lab = "R0")
> en.Resistor(c(x2, 0.5*(y1+y2)), lab = "R1")
> en.Resistor(c(x2, 0.5*(y4+y5)), lab = "R2")
> en.Resistor(c(x3, 0.5*(y4+y5)), lab = "R4")
> en.Resistor(c(x3, 0.5*(y1+y2)), lab = "R3")
> en.Resistor(c(x5, 0.5*(y1+y2)), lab = "R5")
> en.Ground(c(1.0, 0.05))
> par(mar=c(2, 2, 2, 2))
> emptyplot(main = "transistor")
> lines(c(0.1, 0.5,0.9), c(0.5, 0.5, 0.9))
> lines(c(0.5, 0.9), c(0.5, 0.1))
> lines(c(0.5, 0.5), c(0.4, 0.6))
> text(0.2, 0.4, "Gate", font = 3)
> text(0.8, 0.9, "Drain", font = 3,adj = 1)
> text(0.8, 0.1, "Source", font = 3,adj = 1)
> en.Amplifier(c(0.5, 0.5), r = 0.15)

arr.pos = 1, arr.type = "triangle", lwd = 1)

18

R Package diagram: visualising simple graphs, ﬂowcharts, and webs

arr.pos = 0.3, arr.length = 0.25, arr.type = "triangle")

arr.length = 0.25, arr.type = "triangle", lwd = 1)

> box(col = "grey")
> emptyplot(main = "capacitator")
> straightarrow(c(0.5, 0.9), c(0.5, 0.1),
+
> en.Capacitator(c(0.5, 0.5), width = 0.075, length = 0.5, vert = TRUE)
> text(0.4, 0.65, "i", font = 3, cex = 2)
> straightarrow(c(0.8, 0.3), c(0.8, 0.77), arr.pos = 1,
+
> text(0.925, 0.65, "v", font = 3, cex = 2)
> text(0.15, 0.5, "C", font = 3, cex = 2)
> box(col = "grey")
> emptyplot(main = "resistor")
> straightarrow(c(0.5, 0.9), c(0.5, 0.1), arr.pos = 0.2,
+
> text(0.4, 0.85, "i", font = 3, cex = 2)
> en.Resistor(c(0.5, 0.5), width = 0.25, length = 0.35 )
> straightarrow(c(0.8, 0.3), c(0.8, 0.77), arr.pos = 1,
+
> text(0.925, 0.65, "v", font = 3, cex = 2)
> text(0.5, 0.5, "R", font = 3, cex = 2)
> box(col = "grey")
> emptyplot(main = "voltage source")
> lines(c(0.5, 0.5), c(0.1, 0.9))
> en.Signal(c(0.5, 0.5), r = 0.15)
> straightarrow(c(0.8, 0.3), c(0.8, 0.77), arr.pos = 1,
+
> text(0.925, 0.65, "v", font = 3, cex = 2)
> box(col = "grey")

arr.length = 0.25, arr.type = "triangle", lwd = 1)

arr.length = 0.25, arr.type = "triangle", lwd = 1)

arr.length = 0.25, arr.type = "triangle", lwd = 1)

This vignette was created using Sweave (Leisch 2002).

The package is on CRAN, the R-archive website ((R Development Core Team 2008))

More examples can be found in the demo’s of package ecolMod (Soetaert and Herman 2009a)

References

Caswell H (2001). Matrix population models: construction, analysis, and interpretation. Sec-

ond edition edition. Sinauer, Sunderland.

Donali E, Olli K, Heiskanen AS, Andersen T (1999). “Carbon ﬂow patterns in the planktonic
food web of the Gulf of Riga, the Baltic Sea: a reconstruction by the inverse method.”
Journal of Marine Systems, 23, 251–268.

Leisch F (2002). “Sweave: Dynamic Generation of Statistical Reports Using Literate Data
Analysis.” In W H¨ardle, B R¨onz (eds.), Compstat 2002 — Proceedings in Computational
ISBN 3-7908-1517-9, URL http://
Statistics, pp. 575–580. Physica Verlag, Heidelberg.
www.stat.uni-muenchen.de/~leisch/Sweave.

Karline Soetaert

19

Figure 10: Drawing an electrical network with package diagram

transistor AmplifierUinUbu1u2u3u4u5C1C3C2R0R1R2R4R3R5transistorGateDrainSourcecapacitatorivCresistorivRvoltage sourcev20

R Package diagram: visualising simple graphs, ﬂowcharts, and webs

Niquil N, Jackson G, Legendre L, Delesalle B (1998). “Inverse model analysis of the planktonic
food web of Takapoto Atoll (French Polynesia).” Marine Ecology Progress Series, 165, 17–
29.

R Development Core Team (2008). R: A Language and Environment for Statistical Computing.
R Foundation for Statistical Computing, Vienna, Austria. ISBN 3-900051-07-0, URL http:
//www.R-project.org.

Soetaert K (2009a). diagram: Functions for visualising simple graphs (networks), plotting

ﬂow diagrams. R package version 1.5.

Soetaert K (2009b). shape: Functions for plotting graphical shapes, colors. R package version

1.2.2.

Soetaert K, Cash JR, Mazzia F (2012). Solving Diﬀerential Equations in R. Springer. In

press.

Soetaert K, Herman PM (2009a). ecolMod: ”A practical guide to ecological modelling - using

R as a simulation platform”. R package version 1.3.

Soetaert K, Herman PMJ (2009b). A Practical Guide to Ecological Modelling. Using R as a

Simulation Platform. Springer. ISBN 978-1-4020-8623-6.

Soetaert K, Van den Meersche K, van Oevelen D (2009).

limSolve: Solving linear inverse

models. R package version 1.5.

Soetaert K, van Oevelen D (2009). LIM: Linear Inverse Model examples and solution methods.

R package version 1.4.

Aﬃliation:

Karline Soetaert
Royal Netherlands Institute of Sea Research (NIOZ)
4401 NT Yerseke, Netherlands E-mail: karline.soetaert@nioz.nl
URL: http://www.nioz.nl


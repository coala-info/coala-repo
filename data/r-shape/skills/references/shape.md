R Package shape: functions for plotting graphical
shapes, colors...

Karline Soetaert
Royal Netherlands Institute of Sea Research
Yerseke, The Netherlands

Abstract

This document describes how to use the shape package for plotting graphical shapes.
Together with R-package diagram (Soetaert 2009a) this package has been written to

produce the ﬁgures of the book (Soetaert and Herman 2009)

Keywords: graphics, shapes, colors, R.

1. Introduction

This vignette is the Sweave application of parts of demo colorshapes in package shape
(Soetaert 2009b).

2. colors

Although one can ﬁnd similar functions in other packages (including the R base package (R
Development Core Team 2008)), shape includes ways to generate color schemes;

• intpalette creates transitions between several colors;

• shadepalette creates a gradient between two colors, useful for shading (see below).

• drapecol drapes colors over a persp plot;

by default the red-blue-yellow (matlab-type) colors are used. The code below demonstrates
these functions (Figure 1)

> par(mfrow = c(2, 2))
> image(matrix(nrow = 1, ncol = 50, data = 1:50),
+
+
+
> #
> shadepalette(n = 10, "white", "black")

main = "intpalette",
col = intpalette(c("red", "blue", "yellow", "green", "black"),
numcol = 50))

[1] "#000000" "#1C1C1C" "#393939" "#555555" "#717171" "#8E8E8E" "#AAAAAA" "#C6C6C6"
[9] "#E3E3E3" "#FFFFFF"

2

R Package shape: functions for plotting graphical shapes, colors...

[1] "#000000" "#1C1C1C" "#393939" "#555555" "#717171" "#8E8E8E" "#AAAAAA" "#C6C6C6"
[9] "#E3E3E3" "#FFFFFF"

intpalette

shadepalette

8
.
0

4
.
0

0
.
0

−1.0

−0.5

0.0

0.5

1.0

−1.0

−0.5

0.0

0.5

1.0

drapecol

8
.
0

4
.
0

0
.
0

Z

Y

volcano

Figure 1: Use of intpalette, shadepalette and drapecol

col = shadepalette(50, "red", "blue"),
main = "shadepalette")

> #
> image(matrix(nrow = 1, ncol = 50, data = 1:50),
+
+
> #
> par(mar = c(0, 0, 0, 0))
> persp(volcano, theta = 135, phi = 30, col = drapecol(volcano),
+

main = "drapecol", border = NA)

3. Rotating

Function rotatexy rotates graphical shapes; it can be used to generate strangely-colored
shapes (Figure 2).

Karline Soetaert

3

title = "angle")

col = i+1, type = "b", pch = 16)

pt.cex = 2, pch = 22, box.lty = 0)

pch = 16, main = "rotatexy", col = 1)

points(rotatexy(xy, mid = c(0, 0), angle = 60*i),

> par(mfrow = c(2, 2), mar = c(3, 3, 3, 3))
> #
> # rotating points on a line
> #
> xy <- matrix(ncol = 2, data = c(1:5, rep(1, 5)))
> plot(xy, xlim = c(-6, 6), ylim = c(-6, 6), type = "b",
+
> for (i in 1:5)
+
+
> points(0, 0, cex = 2, pch = 22, bg = "black")
> legend("topright", legend = 60*(0:5), col = 1:6, pch = 16,
+
> legend("topleft", legend = "midpoint", pt.bg = "black",
+
> #
> # rotating lines..
> #
> x <- seq(0, 2*pi, pi/20)
> y <- sin(x)
> cols <- intpalette(c("blue", "green", "yellow", "red"), n = 125)
> cols <- c(cols, rev(cols))
> plot(x, y, type = "l", ylim = c(-3, 3), main = "rotatexy",
+
> for (i in 2:250)
+
> #
> #
> x <- seq(0, 2*pi, pi/20)
> y <- sin(x*2)
> cols <- intpalette(c("red", "yellow", "black"), n = 125)
> cols <- c(cols, rev(cols))
> plot(x, y, type = "l", ylim = c(-4, 5), main = "rotatexy,
+
> for (i in 2:250)
+
+
> #
> # rotating points
> #
> cols <- femmecol(500)
> plot(x, y, xlim = c(-1, 1), ylim = c(-1, 1), main = "rotatexy",
+
> for (i in 2:500) {
+
+
+ }

lines(rotatexy(cbind(x, y), angle = 0.72*i, asp = TRUE),
col = cols[i], lwd = 2)

xy <- rotatexy(c(0, 1), angle = 0.72*i, mid = c(0, 0))
points(xy[1], xy[2], col = cols[i], pch = ".", cex = 2)

asp = TRUE", col = cols[1], lwd = 2, xlim = c(-1, 7))

col = cols[1], lwd = 2, xlim = c(-1, 7))

col = cols[1], type = "n")

lines(rotatexy(cbind(x, y), angle = 0.72*i), col = cols[i], lwd = 2)

4

R Package shape: functions for plotting graphical shapes, colors...

rotatexy

rotatexy

midpoint

angle

0
60
120
180
240
300

−6 −4 −2

0

2

4

6

xy[,1]
rotatexy,
     asp = TRUE

]
2
,
[
y
x

y

6

4

2

0

2
−

4
−

6
−

4

2

0

2
−

4
−

3

2

1

y

0

1
−

2
−

3
−

0
.
1

5
0

.

0
0

.

.

5
0
−

.

0
1
−

y

0

2

4

6

x
rotatexy

0

2

4

6

−1.0

−0.5

0.0

0.5

1.0

x

x

Figure 2: Four examples of rotatexy

>

4. ellipses

If a suitable shading color is used, function filledellipse creates spheres, ellipses, donuts
with 3-D appearance (Figure 3).

> par(mfrow = c(2, 2), mar = c(2, 2, 2, 2))
> emptyplot(c(-1, 1))
> col <- c(rev(greycol(n = 30)), greycol(30))
> filledellipse(rx1 = 1, rx2 = 0.5, dr = 0.1, col = col)
> title("filledellipse")
> #
> emptyplot(c(-1, 1), c(-1, 1))
> filledellipse(col = col, dr = 0.1)
> title("filledellipse")

Karline Soetaert

5

filledellipse

filledellipse

filledellipse

getellipse

Figure 3: Use of filledellipse, and getellipse

> #
> color <-gray(seq(1, 0.3, length.out = 30))
> emptyplot(xlim = c(-2, 2), ylim = c(-2, 2), col = color[length(color)])
> filledellipse(rx1 = 2, ry1 = 0.4, col = color, angle = 45, dr = 0.1)
> filledellipse(rx1 = 2, ry1 = 0.4, col = color, angle = -45, dr = 0.1)
> filledellipse(rx1 = 2, ry1 = 0.4, col = color, angle = 0, dr = 0.1)
> filledellipse(rx1 = 2, ry1 = 0.4, col = color, angle = 90, dr = 0.1)
> title("filledellipse")
> #
> emptyplot(main = "getellipse")
> col <-femmecol(90)
> for (i in seq(0, 180, by = 2))
+
+

lines(getellipse(0.5, 0.25, mid = c(0.5, 0.5), angle = i, dr = 0.1),

type = "l", col = col[(i/2)+1], lwd = 2)

6

R Package shape: functions for plotting graphical shapes, colors...

5. Cylinders, rectangles, multigonals

The code below draws cylinders, rectangles and multigonals (Figure 4).

mid = c(-0.5, 0), dr = 0.1)

lcol = "black", lcolint = "grey", dr = 0.1)

mid = c(0.9, 0), topcol = col3[10], dr = 0.1)

mid = c(0.45, 0), topcol = col2[10], dr = 0.1)

> par(mfrow = c(2, 2), mar = c(2, 2, 2, 2))
> #
> # simple cylinders
> emptyplot(c(-1.2, 1.2), c(-1, 1), main = "filledcylinder")
> col <- c(rev(greycol(n = 20)), greycol(n = 20))
> col2 <- shadepalette("red", "blue", n = 20)
> col3 <- shadepalette("yellow", "black", n = 20)
> filledcylinder(rx = 0., ry = 0.2, len = 0.25, angle = 0,
col = col, mid = c(-1, 0), dr = 0.1)
+
> filledcylinder(rx = 0.0, ry = 0.2, angle = 90, col = col,
+
> filledcylinder(rx = 0.1, ry = 0.2, angle = 90, col = c(col2, rev(col2)),
+
> filledcylinder(rx = 0.05, ry = 0.2, angle = 90, col = c(col3, rev(col3)),
+
> filledcylinder(rx = 0.1, ry = 0.2, angle = 90, col = "white",
+
> #
> # more complex cylinders
> emptyplot(c(-1, 1), c(-1, 1), main = "filledcylinder")
> col <- shadepalette("blue", "black", n = 20)
> col2 <- shadepalette("red", "black", n = 20)
> col3 <- shadepalette("yellow", "black", n = 20)
> filledcylinder(rx = 0.025, ry = 0.2, angle = 90,
+
+
> filledcylinder(rx = 0.1, ry = 0.2, angle = 00,
+
+
> filledcylinder(rx = 0.075, ry = 0.2, angle = 90,
+
+
> #
> # rectangles
> color <- shadepalette(grey(0.3), "blue", n = 20)
> emptyplot(c(-1, 1), main = "filledrectangle")
> filledrectangle(wx = 0.5, wy = 0.5, col = color,
+
> filledrectangle(wx = 0.5, wy = 0.5, col = color,
+
> filledrectangle(wx = 0.5, wy = 0.5, col = color,
+
> filledrectangle(wx = 0.5, wy = 0.5, col = color,

col = c(col2, rev(col2)), dr = 0.1, mid = c(-0.8, 0),
topcol = col2[10], delt = -1., lcol = "black")

col = c(col3, rev(col3)), dr = 0.1, mid = c(0.8, 0),
topcol = col3[10], delt = 0.0, lcol = "black")

col = c(col, rev(col)), dr = 0.1, mid = c(0.0, 0.0),
topcol = col, delt = -1.2, lcol = "black")

mid = c(-0.5, -0.5), angle = -90)

mid = c(0.5, 0.5), angle = 90)

mid = c(0, 0), angle = 0)

Karline Soetaert

7

col = shadepalette(grey(0.3), "blue", n = 20),
nr = 3, mid = c(0, 0), angle = 0)

+
mid = c(0.5, -0.5), angle = 180)
> filledrectangle(wx = 0.5, wy = 0.5, col = color,
+
mid = c(-0.5, 0.5), angle = 270)
> #
> # multigonal
> color <- shadepalette(grey(0.3), "blue", n = 20)
> emptyplot(c(-1, 1))
> filledmultigonal(rx = 0.25, ry = 0.25,
+
+
> filledmultigonal(rx = 0.25, ry = 0.25,
+
+
> filledmultigonal(rx = 0.25, ry = 0.25,
+
+
> filledmultigonal(rx = 0.25, ry = 0.25, col = "black",
+
> filledmultigonal(rx = 0.25, ry = 0.25, col = "white", lcol = "black",
+
> title("filledmultigonal")
>

col = shadepalette(grey(0.3), "darkgreen", n = 20),
nr = 4, mid = c(0.5, 0.5), angle = 90)

col = shadepalette(grey(0.3), "orange", n = 20),
nr = 5, mid = c(-0.5, -0.5), angle = -90)

nr = 7, mid = c(-0.5, 0.5), angle = 270)

nr = 6, mid = c(0.5, -0.5), angle = 180)

6. Other shapes

Function filledshape is the most ﬂexible drawing function from shape: just specify an inner
and outer shape and ﬁll with a color scheme (Figure 5).

main = "filledshape")

<- seq(-sqrt(a), sqrt(a), by = 0.1)
<- b-b/a*x^2-0.2*b*x+0.2*b/a*x^3

> par(mfrow = c(2, 2), mar = c(2, 2, 2, 2))
> #an egg
> color <- greycol(30)
> emptyplot(c(-3.2, 3.2), col = color[length(color)],
+
> b <- 4
> a <- 9
> x
> g
> g[g<0] <- 0
> x1
> g1
> xouter <- cbind(x1, g1)
> xouter <- rbind(xouter, xouter[1, ])
> filledshape(xouter, xyinner = c(-1, 0), col = color)
> #
> # a mill
> color <- shadepalette(grey(0.3), "yellow", n = 20)

<- c(x, rev(x))
<- c(sqrt(g), rev(-sqrt(g)))

8

R Package shape: functions for plotting graphical shapes, colors...

filledcylinder

filledcylinder

filledrectangle

filledmultigonal

Figure 4: Use of filledcylinder, filledrectangle and filledmultigonal

Karline Soetaert

9

main = "filledshape")

xouter <- rbind(xouter,

> emptyplot(c(-3.3, 3.3), col = color[length(color)],
+
> x <- seq(0, 0.8*pi, pi/20)
> y <- sin(x)
> xouter <- cbind(x, y)
> for (i in seq(0, 360, 60))
+
+
> filledshape(xouter, c(0, 0), col = color)
> #
> # abstract art
> emptyplot(col = "darkgrey", main = "filledshape")
> filledshape(matrix(nc = 2, runif(80)), col = "darkblue")
> #
> emptyplot(col = "darkgrey", main = "filledshape")
> filledshape(matrix(nc = 2, runif(80)),
+

col = shadepalette(20, "darkred", "darkblue"))

rotatexy(cbind(x, y), mid = c(0, 0), angle = i))

7. arrows, arrowheads

As the arrow heads in the R base package are too simple for some applications, there are
some improved arrow heads in shape (Figure 6).

arr.col = rainbow(runif(100, 1, 20)))

> par(mfrow = c(2, 2), mar = c(2, 2, 2, 2))
> xlim <- c(-5 , 5)
> ylim <- c(-10, 10)
> x0<-runif(100, xlim[1], xlim[2])
> y0<-runif(100, ylim[1], ylim[2])
> x1<-x0+runif(100, -2, 2)
> y1<-y0+runif(100, -2, 2)
> size <- 0.4
> plot(0, type = "n", xlim = xlim, ylim = ylim)
> Arrows(x0, y0, x1, y1, arr.length = size, arr.type = "triangle",
+
> title("Arrows")
> #
> # arrow heads
> #
> ang <- runif(100, -360, 360)
> plot(0, type = "n", xlim = xlim, ylim = ylim)
> Arrowhead(x0, y0, ang, arr.length = size, arr.type = "curved",
+
> title("Arrowhead")
> #
> # Lotka-Volterra competition model
> #

arr.col = rainbow(runif(100, 1, 20)))

10

R Package shape: functions for plotting graphical shapes, colors...

filledshape

filledshape

filledshape

filledshape

Figure 5: Use of filledshape

Karline Soetaert

11

# parameters

<- c(0, 1.5)
<- c(0, 2 )

<- 3
> r1
<- 2
> r2
<- 1.5
> K1
> K2
<- 2
> alf12 <- 1
> alf21 <- 2
> xlim
> ylim
> par(mar = c(5, 4, 4, 2))
> plot (0, type = "l", lwd = 3,
+
+
> gx <- seq(0, 1.5, len = 30)
> gy <- seq(0, 2, len = 30)
> N <- as.matrix(expand.grid(x = gx, y = gy))
> dN1 <- r1*N[, 1]*(1-(N[, 1]+alf12* N[, 2])/K1)
> dN2 <- r2*N[, 2]*(1-(N[, 2]+alf21* N[, 1])/K2)
> dt <- 0.01
> Arrows(N[, 1], N[, 2], N[, 1]+dt*dN1, N[, 2]+dt*dN2, arr.len = 0.08,
+ lcol = "darkblue", arr.type = "triangle")
> points(x = c(0, 0, 1.5, 0.5), y = c(0, 2, 0, 1), pch = 22, cex = 2,
+
>

main = "Lotka-Volterra competition",
xlab = "N1", ylab = "N2", xlim = xlim, ylim = ylim)

bg = c("white", "black", "black", "grey"))

# 1st isocline

8. Miscellaneous

Since version 1.3.4, function textflag has been added.

> emptyplot()
> textflag(mid = c(0.5, 0.5), radx = 0.5, rady = 0.2,
+

lcol = "white", lab = "hello", cex = 5, font = 2:3)

9. And ﬁnally

This vignette was created using Sweave (Leisch 2002).

The package is on CRAN, the R-archive website ((R Development Core Team 2008))
More examples can be found in the demo’s of package ecolMod (Soetaert and Herman 2008)

References

Leisch F (2002). “Sweave: Dynamic Generation of Statistical Reports Using Literate Data
Analysis.” In W Härdle, B Rönz (eds.), Compstat 2002 — Proceedings in Computational
ISBN 3-7908-1517-9, URL http://
Statistics, pp. 575–580. Physica Verlag, Heidelberg.
www.stat.uni-muenchen.de/~leisch/Sweave.

12

R Package shape: functions for plotting graphical shapes, colors...

Arrows

Arrowhead

0
1

5

0

5
−

0
1
−

−4

−2

0

2

4

−4

−2

0

2

4

Lotka−Volterra competition

0
1

5

0

5
−

0
1
−

2
N

0
2

.

5
1

.

0
1

.

5
0

.

0
0

.

0.0

0.5

1.0

1.5

N1

Figure 6: Use of Arrows and Arrowhead

Karline Soetaert

13

hello

Figure 7: Use of function textflag

R Development Core Team (2008). R: A Language and Environment for Statistical Computing.
R Foundation for Statistical Computing, Vienna, Austria. ISBN 3-900051-07-0, URL http:
//www.R-project.org.

Soetaert K (2009a). diagram: Functions for visualising simple graphs (networks), plotting

ﬂow diagrams. R package version 1.4.

Soetaert K (2009b). shape: Functions for plotting graphical shapes, colors. R package version

1.2.2.

Soetaert K, Herman PM (2008). ecolMod: "A practical guide to ecological modelling - using

R as a simulation platform". R package version 1.1.

Soetaert K, Herman PMJ (2009). A Practical Guide to Ecological Modelling. Using R as a

Simulation Platform. Springer. ISBN 978-1-4020-8623-6.

Aﬃliation:

Karline Soetaert
Royal Netherlands Institute of Sea Research (NIOZ)
4401 NT Yerseke, Netherlands E-mail: karline.soetaert@nioz.nl
URL: http://www.nioz.nl


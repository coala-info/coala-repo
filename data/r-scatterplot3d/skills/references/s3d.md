Scatterplot3d –
an R package for Visualizing Multivariate Data

Uwe Ligges and Martin Mächler

Fachbereich Statistik

Seminar für Statistik

Universität Dortmund

44221 Dortmund

Germany

ETH Zürich

CH-8092 Zürich

Switzerland

Parts of this vignette have been published previously by the Journal of Statistical

Software:

Ligges, U. and Mächler, M. (2003): Scatterplot3d – an R Package for Visualizing

Multivariate Data. Journal of Statistical Software 8(11), 1–20.

Abstract Scatterplot3d is an R package for the visualization of multivariate data in

a three dimensional space. R is a “language for data analysis and graphics”. In this

paper we discuss the features of the package. It is designed by exclusively making

use of already existing functions of R and its graphics system and thus shows the

extensibility of the R graphics system. Additionally some examples on generated

and real world data are provided, as well as the source code and the help page of

scatterplot3d.

1

1

Introduction

Scatterplot3d is an R package for the visualization of multivariate data in a three

dimensional space. R itself is “A Language and Environment for Statistical Comput-

ing” (R Development Core Team, 2004a) and a freely available statistical software

package implementing that language, see http://www.R-project.org/.

Basically scatterplot3d generates a scatter plot in the 3D space using a parallel

projection. Higher dimensions (fourth, ﬁfth, etc.) of the data can be visualized to

some extent using, e.g. diﬀerent colors, symbol types or symbol sizes.

The following properties of scatterplot3d will be further described and discussed

in the present paper: A plot is generated entirely by using interpreted R graphics

functions, so the appearance of the plot is consistent with other R graphics. Such a

behavior is important for publications. Most features of the R graphics system can

be applied in scatterplot3d, among them are vectorizing of colors or plotting symbols

and mathematical annotation (Murrell and Ihaka, 2000). The latter means whole

formulas with e.g. greek letters and mathematical symbols inside can be added into
plots using a LATEX like syntax. Scatterplot3d can be easily extended e.g., by adding
additional points or drawing regression lines or planes into an already generated

plot (via function closures, see below). The package is platform independent and

can easily be installed, because it only requires an installed version of R.

This paper is structured as follows: In Section 2 the design of scatterplot3d will

be described, followed by remarks on the extensibility of the function in Section 3.

Some examples (including code and results) on generated and real world data are

provided in Section 4. We present other R related 3D “tools” in Section 5, followed

by the conclusion in Section 6. In the Appendix the source code as well as the help

page of scatterplot3d are printed.

R and scatterplot3d are available from CRAN (Common R Archive Network), i.e.

http://CRAN.R-Project.org or one of its mirrors.

2

2 Design

Scatterplot3d is designed to plot three dimensional point clouds by exclusive usage of

functions in the R base package. Advantages of this “R code only” design are the well

known generality and extensibility of the R graphics system, the similar behavior

of arguments and the similar look and feel with respect to common R graphics, as

well as the quality of the graphics, which is extremely important for publications.

Drawbacks are the lack of interactivity, and the missing 3D support (2D design).

While the function persp for plotting surfaces (cf. Section 5) applies a perspective

projection, in scatterplot3d a parallel projection for a better comparison of distances

between diﬀerent points is used.

The ﬁnal implementation of the function and the building of the package was done

according to the “R Language deﬁnition” and “Writing R Extensions” manuals of

the R Development Core Team (in short, ‘R core’), 2004b and 2004c.

2.1 Arguments

The scatterplot3d function has been designed to accept as many common arguments

to R graphics functions as possible, particularly those mentioned in the help pages

of the function par and plot.default (R core, 2004a). In principle, arguments of

par with a particular 2D design are replaced by new arguments in scatterplot3d.

Regularly, values of the corresponding arguments in par for the ﬁrst two dimensions

are read out, and scatterplot3d either “guesses” the value for the third dimension or

has an appropriate default.

A few graphical parameters can only be set as arguments in scatterplot3d but not in

par. For details on which arguments have got a non common default with respect

to other R graphics functions see the “Usage” and “Arguments” sections of the help

page in the Appendix. Other arguments of par may be split into several arguments

in scatterplot3d, e.g.

for speciﬁcation of the line type. Finally, some of the argu-

ments in par do not work, e.g. some of those for axis calculation. As common in

R, additional arguments that are not mentioned on the help page can be passed

through to underlying low level graphics functions by making use of the general

‘...’ argument.

3

2.2 xyz.coords()

As well known from other R functions, vectors x, y and z (for the 3D case) are used

to specify the locations of points.

If x has got an appropriate structure, it can be provided as a single argument. In

this case, an attempt has to be made to interpret the argument in a way suitable for

plotting. For that purpose, we added the function xyz.coords (R core, 2004a) into

the R base package that accept various combinations of x and optionally y and z

arguments. It is a “utility for obtaining consistent x, y and z coordinates and labels

for three dimensional plots” (R core, 2004a). Many ideas used in this function are

taken from the function xy.coords already existing for the 2D case. Even though

xyz.coords was introduced to support scatterplot3d, it is designed to be used by
any 3D plot functions making use of (xi, yi, zi) triples1.

If the argument is a formula of type zvar ~ xvar + yvar (cf. R core (2004b) for

details on formulas), xvar, yvar and zvar are used as x, y and z variables. If the

argument is a list with components x, y and z, these are assumed to deﬁne plotting

coordinates. If it is a matrix with three columns, the ﬁrst is assumed to contain the

x values, etc. Alternatively, two arguments x and y can be be provided, one may

be real, the other complex. In any other case, the arguments are coerced to vectors

and the values plotted against their indices. If no axis labels are given explicitly,

xyz.coords attempts to extract appropriate axis labels xlab, ylab and zlab from

the above mentioned data structures.

Additionally, color vectors contained in a matrix, data frame or list can be detected

by scatterplot3d internally.

2.3 Structure

The R code of scatterplot3d is structured into a few parts:

A quite long list of arguments in the ﬁrst part of the function is followed by some

1The functions persp, image and contour are restricted to use a grid of x, y values and hence

only need n x− and m y− values for n × m z− values.

4

plausibility checks, extraction of characters, conversion of data structures (cf. Sec-

tion 2.2), basic calculations of the angle for displaying the cube, and calculations

regarding the data region limits, as well as data sorting for an optional “3D high-

lighting" feature.

In order to optimize the ﬁt of the data into the plotting region, the second part of

the function deals with optimal scaling of the three axis. This yields a high printout

quality as well known from regular R graphics, but unfortunately it results also in

a static plot, i.e. rotation is not possible. If scatterplot3d s with diﬀerent viewing

angles are put together as a “slide show" to imitate a rotation, each of these “slides"

is individually optimally sized regarding the plotting region, so all in all such a “slide

show" will not work.

After the graphics device is initialized in the third part, axis, tick marks, box, grid

and labels are added to the plot, if it is required. In the last but one part, the data

is plotted and overlayed by the front edges of the box.

Besides the primarily expected result, a drawn plot, four functions are generated

and invisibly returned as Values in the last part of scatterplot3d (cf. the Appendix).

These functions, namely xyz.convert, points3d, plane3d and box3d, are required

to provide extensibility of the three dimensional plot; details are described in Sec-

tion 3.

3 Extensibility

Two kinds of extensibilities will be described in this section. On one hand, regarding

the scatterplot3d design, the extensibility of the R graphics system will be discussed;

it provides the tools and features enabling the programmer to write complex high

level plot functions in a very general manner. On the other hand we describe the

extensibility of scatterplot3d itself.

5

3.1 Extensibility of R graphics

R provides a huge collection of low level graphic functions like those for adding ele-

ments to an existing plot or for computations related to plotting. These functions are

used to build very general high level functions, at least for the two dimensional case,

and without them, the “R code only” design of scatterplot3d would be impossible.

A selection of these low level functions begins with the functions to obtain x, y

(and z) coordinates for plotting, namely xy.coords and xyz.coords (for the 3D

case, cf. Section 2.2). Further on, the functions plot.new and plot.window can be

used to set up the plotting region appropriately, pretty to calculate pretty axis tick

marks, segments to draw line segments between pairs of points, and functions like

title, axis, points, lines, text etc. are self-explanatory.

A huge collection of graphical parameters for R is documented in the help pages for

par and plot.default (cf. R core (2004a)). Almost all low level graphic functions

make use of the argument ‘...’ which allows specifying most of these parameters in

a very general manner. If this argument, ‘...’, is also used in a high level function,

arguments which are not explicitly introduced in the arguments list, can be passed

through to lower level graphic functions as well; this is a powerful feature of the S

language.

Since the R graphics system is designed for two dimensional graphics, it lacks of some

features for the three dimensional case. Unfortunately, the axis function works only

for 2D graphics. Consequently a large amount of code was required to enable oblique

axes for displaying the 3D scatter plot in an arbitrary angle.

Locations in R graphics devices can be addressed with 2D coordinates, Thus the

information on the projection has to be calculated by the 3D graphic functions in-

ternally. As described in Section 2, scatterplot3d uses a parallel projection. Since

the R graphics device does not know anything about the projection, without any

appropriate additional tools it is not possible to add elements into an existing scat-

terplot3d.

6

3.2 Extensibility of scatterplot3d

In Sections 1 and 2 it was emphasized that the scatterplot3d design was intended

to be as general as possible. Some attempts to obtain this generality are described

in Section 2 and its subsections. Because of the missing projection information, the

ability of adding elements to an already existing scatterplot3d would be restricted,

if only the already deﬁned (and for the 2D case general) R functions could be used

(cf. Section 3.1).

For this reason, scatterplot3d (invisibly) returns a list of function closures (cf. Sec-

tion 2.3). A function closure is a function together with an environment, and an

environment is a collection of symbols and associated values (i.e. R variables). Thus

these properties of R’s scoping rules, called Lexical Scoping (Gentleman and Ihaka,

2000), are extensively used in scatterplot3d. Notice that Lexical Scoping is a feature

of R, not deﬁned as such in the S language.

In other words, the values returned by scatterplot3d are functions together with

the environment in which they (and the scatter plot) were created. The beneﬁt

of returning function closures is, that the function somehow “knows” the values of

variables (in the environment) that were assigned to those variables at the time when

the function was created. All in all, we made those functions know details about

the axis scaling and the projection information that are required to add elements to

an existing plot appropriately.

The following functions are returned by scatterplot3d, for details see the Appendix:

xyz.convert: A function which converts 3D coordinates to the 2D parallel projec-

tion of the existing scatterplot3d. It is useful to add arbitrary elements into

the plot.

points3d: A function which draws points or lines into the existing plot.

plane3d: A function which draws a plane into the existing plot:

plane3d(Intercept, x.coef=NULL, y.coef=NULL, lty="dashed", ...).

Instead of an intercept, a vector containing three elements or an (g)lm object

can be speciﬁed.

box3d: This function draws a box (or “refreshes” an existing one) around the plot.

7

xyz.convert is the most important function, because it does the parallel projection

by converting the given 3D coordinates into the 2D coordinates needed for the R

graphics devices. Examples how to use the mentioned function closures are given in

Section 4.

4 Examples

4.1 Feature demonstration

In this section some of the features of scatterplot3d will be demonstrated using

artiﬁcially generated data, well known examples from other R functions and the

(slightly modiﬁed) examples of scatterplot3d ’s help ﬁle (cf. the Appendix). The

presentation starts with the latter, each example printed on an individual page to

obtain lucidity.

this space intentionally left blank

8

4.1.1 Helix

In Figure 1 points of a helix are calculated and plotted using the 3D highlighting

mode (highlight.3d = TRUE) in a blue box with a light blue grid. We produce the

solid look with the point symbol, pch = 20.

z <- seq(-10, 10, 0.01)

x <- cos(z)

y <- sin(z)

scatterplot3d(x, y, z, highlight.3d = TRUE, col.axis = "blue",

col.grid = "lightblue", main = "Helix", pch = 20)

Helix

0
1

5

z

0

5
−

0
1
−

−1

l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
ll
l
ll
l
ll
l
ll
l
ll
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l l
l
l
l l
l
l l
l
l
ll
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
ll
l
ll
l
ll
l
l
ll
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l l
l
l l
l
l l
l
ll
l
ll
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l

−0.5

0

−1

0.5

1

−0.5

0

x

Figure 1: Helix

9

1

y

0.5

4.1.2 Hemisphere

Figure 2 shows points on a hemisphere. Except for angle and the size of axes

annotation, this ﬁgure is generated analogously to Figure 1.

temp <- seq(-pi, 0, length = 50)

x <- c(rep(1, 50) %*% t(cos(temp)))

y <- c(cos(temp) %*% t(sin(temp)))

z <- c(sin(temp) %*% t(sin(temp)))

scatterplot3d(x, y, z, highlight.3d = TRUE, angle = 120,

col.axis = "blue", col.grid = "lightblue", cex.axis = 1.3,

cex.lab = 1.1, main = "Hemisphere", pch = 20)

Hemisphere

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l
l

l
l

l
l

l
l
l

l
l
l

l
l
l

l
l
l

l
l
l

l
l
l
l

l
l
l
l

l
l
l
l

l
ll
l
l
ll
l

l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
lllllllllllllllllllllllll
lllllllllllllllllllllllll
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l

l
ll
l
ll
l

l
ll
l
l

l
l
l
l
l

l
l
l
l
l

ll
l
l

l
l
l

l
l
l

ll
l

l
l

l
l

l
l

l
l

l
l

l
l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

−0.5

−1

−1

l

l
l

ll
ll
ll
l
l
l
l
ll
l
l
l
l
ll
l
l
l
l
ll
l
l
l
l
l
l
l
l
ll
l
l
l
ll
l
l
l
l
l
l
l
l
l
l
l
l
l
ll
l
l
ll
l
l
l
l
l
l
l
l
l
l
l
l
l
l
ll
l
l
ll
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
ll
l
l
l
l
l
ll
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
ll
l
ll
l
l
l
l
l
l
l
l
l
l
l
l
ll
l
ll
l
l
l
l
l
l
l
l
l
l
ll
l
ll
l
l
l
l
ll
l
ll
l
l
l
l
ll
ll
l
l
ll
ll
l
l
l
ll

l
l
l

l
l
l

l
l
l

l
l
l

l
l

l
l

l
l

l
l

l
l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l
ll
l
ll
l

l
ll
l
l
ll
l

l

ll
l

l
l

l
l

l
l

l
l

l

l
l
l
l

l

l

l
l

l

l

l

l

l

l

l

l

l

l
l

l
l

l
l

l
l

l
l

l
l

l

l
l

l
l

l

l

l

l

l
l

l
l

l

l

l
l

l
l
l

l

l

l

l

l
l

l

l

l
l

l

l

l

l

l

l

l

l
l

l
l

l

l
l

l
l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l
l

l
l

l
l

l
l
l

l
l
l

l
l
l
l
l

l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
llllllllllllllllllllllllllllllllllllllllllllllllll
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l

l
ll

l
l
l
l
l

l
ll

l
l
l

l
l
l

l
l
l

ll

ll

ll

ll

ll

l
l

l
l
l

l
ll
l

l
ll
l

l
l

l
l

l
l

l
l

l
l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

ll

l

l

l

l

l

l

l

l

l

ll

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

y

1

0.5

0

−0.5

0

x

0.5

1

Figure 2: Hemisphere

10

1

8
.
0

6
.
0

4
.
0

2
0

.

0

z

4.1.3

3D barplot

With some simple modiﬁcations, it is possible to generate a 3D barplot, as shown

in this example. To make the plot look like a barplot, type = "h" is set to draw

vertical lines to the x–y plane, pch = " " to avoid plotting of point symbols and

lwd = 5 to make the lines looking like bars. Furthermore, instead of three vectors

a data frame is given as the ﬁrst argument to scatterplot3d.

my.mat <- matrix(runif(25), nrow = 5)

dimnames(my.mat) <- list(LETTERS[1:5], letters[11:15])

s3d.dat <- data.frame(columns = c(col(my.mat)),

rows

= c(row(my.mat)), value = c(my.mat))

scatterplot3d(s3d.dat, type = "h", lwd = 5, pch = " ",

x.ticklabs = colnames(my.mat), y.ticklabs = rownames(my.mat),

color = grey(25:1 / 40), main = "3D barplot")

3D barplot

1

8
.
0

6
.
0

4
0

.

2
0

.

e
u
a
v

l

0

k

l

m

n

columns

B

A

o

Figure 3: 3D barplot

11

s
w
o
r

D

C

4.1.4 Adding elements

The importance of Lexical Scoping to generate function closures to provide exten-

sibility of scatterplot3d was discussed in Section 3. An example how to use the

invisibly returned functions is given below on the famous (at least for S users) tree

data.

After the tree data is loaded, it is plotted by scatterplot3d, and the (invisibly re-

turned) result is assigned to the variable s3d. The (blue colored) points are plotted

using type = "h", so one can see the x–y location of those points very clearly.

In the next step, a linear model (assumption: volume depends on girth and height

of the trees) is calculated. Furthermore, this lm object is plotted by the returned

plane3d function (was assigned to s3d before), and it results in a regression plane.

Just for demonstration purposes, in the last step some red colored points (on a

imaginary line crossing the plot) are plotted with an asterisk as its point symbol.

data(trees)

s3d <- scatterplot3d(trees, type = "h", color = "blue",

angle = 55, scale.y = 0.7, pch = 16, main = "Adding elements")

my.lm <- lm(trees$Volume ~ trees$Girth + trees$Height)

s3d$plane3d(my.lm)

s3d$points3d(seq(10, 20, 2), seq(85, 60, -5), seq(60, 10, -10),

col = "red", type = "h", pch = 8)

12

Adding elements

l

l

l

l

ll

l

l

l
l
l

l

l

ll
l

l
ll
ll
l
l

l

l

l

l

l

l

l
l

t
h
g
e
H

i

90

85

80

75

70

65

60

8

10

12

14

16

18

20

22

Girth

Figure 4: Adding elements

e
m
u
o
V

l

0
8

0
7

0
6

0
5

0
4

0
3

0
2

0
1

4.1.5 Bivariate normal distribution

In Figure 5 a surface of the density of a bivariate normal distribution is plotted.

This example is a bit more sophisticated than the examples before and shows the

extensibility of scatterplot3d. Note that scatterplot3d is designed to generate scatter

plots, not to draw surfaces, is not really user friendly for this purpose, for which

we’d typically rather use R’s persp function.

In a ﬁrst step a matrix containing the density is calculated. The call of scatterplot3d

sets up the plot (axes, labels, etc.), but doesn’t draw the surface itself which is

accomplished by the two loops at the end of the code. Additionally, we give an

example of quite sophisticated mathematical annotation.

13

library("mvtnorm")

x1 <- x2 <- seq(-10, 10, length = 51)

dens <- matrix(dmvnorm(expand.grid(x1, x2),

sigma = rbind(c(3, 2), c(2, 3))),

ncol = length(x1))

s3d <- scatterplot3d(x1, x2,

seq(min(dens), max(dens), length = length(x1)),

type = "n", grid = FALSE, angle = 70,

zlab = expression(f(x[1], x[2])),

xlab = expression(x[1]), ylab = expression(x[2]),

main = "Bivariate normal distribution")

text(s3d$xyz.convert(-1, 10, 0.07),

labels = expression(f(x) == frac(1, sqrt((2 * pi)^n *

phantom(".") * det(Sigma[X]))) * phantom(".") * exp * {

bgroup("(", - scriptstyle(frac(1, 2) * phantom(".")) *

(x - mu)^T * Sigma[X]^-1 * (x - mu), ")")}))

text(s3d$xyz.convert(1.5, 10, 0.05),

labels = expression("with" * phantom("m") *

mu == bgroup("(", atop(0, 0), ")") * phantom(".") * "," *

phantom(0) *

{Sigma[X] == bgroup("(", atop(3 * phantom(0) * 2,

2 * phantom(0) * 3), ")")}))

for(i in length(x1):1)

s3d$points3d(rep(x1[i], length(x2)), x2, dens[i,], type = "l")

for(i in length(x2):1)

s3d$points3d(x1, rep(x2[i], length(x1)), dens[,i], type = "l")

14

Bivariate normal distribution

f(x) =

1

(2π)n det(ΣX)

exp

− 1

2 (x − µ)TΣX

−1(x − µ)


)
2
x

,
1
x
(
f

8
0
.
0

6
0
.
0

4
0
.
0

2
0
.
0

0

with µ =

0

 , ΣX =
0






3 2




2 3



10

2
x

5

0

−5

−10

−5

0

x1

5

−10

10

Figure 5: Density of a bivariate normal distribution

4.1.6 RGB color cube

In Figure 6, we visualize the RGB (red–green–blue) color space which R and most

computer screens use for color coding. First, we draw all the named colors available

in R via colors(). Note that it might be interesting to ﬁnd a better background

color here than white. Optimally it would correspond to an RGB location as far

away as possible from all given colors. Second, we show the rainbow() colors in the

RGB space. Here we redraw the points on top of the cube, using the points3d()

closure which is also the basis of our cubedraw() function.

15

cubedraw <- function(res3d, min = 0, max = 255, cex = 2)

{

}

cube01 <- rbind(0,c(1,0,0),c(1,1,0),1,c(0,1,1),c(0,0,1),c(1,0,1),

c(1,0,0),c(1,0,1),1,c(1,1,0),

c(0,1,0),c(0,1,1), c(0,1,0),0)

cub <- min + (max-min)* cube01

res3d$points3d(cub[ 1:11,], cex = cex, type = 'b', lty = 1)

res3d$points3d(cub[11:15,], cex = cex, type = 'b', lty = 3)

crgb <- t(col2rgb(cc <- colors()))

rr <- scatterplot3d(crgb, color = cc, box = FALSE, angle = 24)

cubedraw(rr)

Rrb <- t(col2rgb(rbc <- rainbow(201)))

rR <- scatterplot3d(Rrb, color = rbc, box = FALSE, angle = 24)

cubedraw(rR)

rR$points3d(Rrb, col = rbc, pch = 16)

0
0
3

0
5
2

l

ll

l

l
l

0
0
2

ll
ll

l
l

l
l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

ll

ll

l

l

ll

l
l

l
l

l
l

l
l

l
ll

l
l

l
l

l
l
l

l
l
l

l
l
l
l

l
l

l
l
l
l

l
l
l
l
l

l
l
l
l
l

l
l
l
l
l

ll
ll
l
l

l
l
l
l
l
l
ll
l
l

l
l
l
ll
l
ll

l
ll
l
l
ll
l
l
ll
l
ll
ll
l
ll
l
ll
l
llll
llll
l
ll
l
ll
l
l
l
ll
l
ll
l
l
l
ll
l
l
l
ll
ll
ll
l
lll
l
ll
ll
ll
ll
l
l
l
l
ll
ll
lll
l
l
lll
ll
l
l
l
ll l
ll
l
ll
l
l
l
ll
l
l
ll
l
l
l
ll
ll
ll
l
l
l
l
ll
l
llll
ll
l
l
l
l
l
l
ll
ll
l
l
llll
l
l
ll
l
ll
ll
l
l
l
l
l
ll
l
l
l
ll
ll
l
ll
l
l
ll
l
l
llll
ll
l
l
l
l
l
l
ll
l
ll
ll
l
ll
l
l
l
l
ll
l
ll
ll
l
ll
l
l
ll
l
ll
ll
ll
l
l
l
l
lll
l
l
l
lll
ll
l
ll
ll
l
l
ll
ll
l
l
lll
l
l
l
l
ll
l
ll
l
ll
ll
l
ll
l
llll
l
l
l
l
ll
ll
l
l
ll
l
l
llll
ll
l
l
ll
ll
l
l
ll
l
ll
l
ll
l
ll
ll
l
ll
ll
l
ll
ll
ll
ll
ll
ll
ll
ll
ll
ll
ll
ll
ll
ll
ll
ll
ll
ll
ll
ll
ll
ll
llllll

l
ll
l
l
l
l
l

l
l
l
l

l
l
l
ll

l
l
l
l
l

l
l
l
l
l

l
l
l

l
l
l
l
l

l
l
l

l
l
ll
l
l

l
l

l
ll
l
l

l
l
l
l

100

l
l

l
l

l
l

l
l

l
l

l
l
l

l
l

l
l

l
l

l
l

l
ll

l
l

l
l

l
ll

ll
l

l
l

ll

l
ll

l

l

ll

l

l
l

l

l

l

l

ll

l

l

l

l
l

ll

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

ll

l

l

l

l

l

ll

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

l

 50

ll
l

150

llllll
l
ll
ll
  0

 50

100

l

l
l
150

l
200

l
l
l
l ll
250

  0

300

e
u
b

l

0
5
1

0
0
1

0
5

0

e
u
b

l

0
0
3

0
5
2

0
0
2

0
5
1

0
0
1

0
5

0

300

250

n
e
e
r
g

200

l
l

l
l

lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll

l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
lllllllllllllllllllllllllllllllllll
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
llllllllllllllllllllllllllllllllll
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
l
250

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll

l
l
  0

l
l

150

100

100

200

300

 50

 50

  0

300

250

n
e
e
r
g

200

ll
l

150

red

red

Figure 6: The RGB color cube. On the left, the named colors in R, i.e., colors().

Note the diagonal of gray tones. On the right, the locations and colors of

rainbow(201).

16

4.2 Real world examples

Three real world examples are presented in this section. The data are from the fol-

lowing recent projects of the collaborative research centre 475 (Deutsche Forschungs-

gemeinschaft, SFB 475: “Reduction of complexity in multivariate data structures”):

C3 (Biometrics) Meta–Analysis in Biometry and Epidemiology,

B3 (Econometrics) Multivariate Analysis of Business Cycles, and

C5 (Technometrics) Analysis and Modelling of the Deephole–Drilling–Process with

Methods of Statistics and Neuronal Networks.

4.2.1 Meta–analysis of controlled clinical trials

In the ﬁrst real world example the data from a project on “Meta–Analysis in Biom-

etry and Epidemiology” is taken. The data set contains the results of 13 placebo–

controlled clinical trials which evaluated the eﬃcacy of the Bacillus Calmette–Guérin

(BCG) vaccine for the prevention of tuberculosis (TB). An important task in com-

bining the results of clinical trials is to detect possible sources of heterogeneity which

may inﬂuence the true treatment eﬀect. In the present example, a possible inﬂu-

ential covariate is the distance of each trial from the equator, which may serve as

a surrogate for the presence of environmental mycobacteria that provide a certain

level of natural immunity against TB. Other covariates may be the year the trial

was carried out and the allocation scheme of the vaccination (A = alternate, R =

random, S = systematic). For more details, especially on the choice of the trials

and the meta–analytical methods of combining the results, we refer to Knapp and

Hartung (2003) and the references given therein.

In Figure 7 the estimated risks of TB disease are plotted for the vaccinated group

and the non–vaccinated group, respectively, in the dependence of the year the trial

was carried out, of the absolute distance from the equator and of the allocation

scheme. The color represents the precisions of the estimated risks. Figure 7 clearly

reveals a spatio–temporal trend in the realization of the trials. The former trials

were carried out far away from the equator, and in all these trials one can observe

17

an evident superiority of the BCG vaccine for the prevention of TB. Except one

trial all the other later trials were realized closer to the equator. In these trials, it

is apparently that the estimated risks in the non–vaccinated groups are even rather

low and, consequently, cannot graphically separated from the estimated risks in the

vaccinated groups. Finally, it is worthwhile to note that the later trial which was

carried out far away from the equator has a relative small estimated risk in the

non–vaccinated group compared to the former trials and, hence, does not yield such

an evident superiority of the BCG vaccine.

Three variables are represented by the three dimensions of the cube, while vari-

able “Precision” is represented by color. To realize color representation for metric

variables, some manual tuning is necessary, though.

layout(cbind(1:2, 1:2), heights = c(7, 1))

prc <- hsv((prc <- 0.7 * Prec / diff(range(Prec))) - min(prc) + 0.3)

s3d <- scatterplot3d(Year, Latitude, Risk, mar = c(5, 3, 4, 3),

type = "h", pch = " ", main = "Estimated TB risks")

s3d$points(Year, Latitude, Risk, pch = ifelse(vac, 22, 21), bg = prc,

cex = ifelse(vac, 2, 1.5))

s3d.coords <- s3d$xyz.convert(Year, Latitude, Risk)

al.char <- toupper(substr(as.character(Allocation), 1, 1))

text(s3d.coords$x[!vac], s3d.coords$y[!vac], labels = al.char[!vac],

pos = 2, offset = 0.5)

legend(s3d$xyz.convert(80, 15, 0.21), pch = c("A", "R", "S"), yjust=0,

legend = c("alternate", "random", "systematic"), cex = 1.1)

legend(s3d$xyz.convert(47, 60, 0.24), pch = 22:21, yjust = 0,

legend = c("vaccinated", "not vaccinated"), cex = 1.1)

par(mar=c(5, 3, 0, 3))

plot(seq(min(Prec), max(Prec), length = 100), rep(0, 100), pch = 15,

axes = FALSE, xlab = "color code of variable \"Precision\"",

ylab = "", col = hsv(seq(0.3, 1, length = 100)))

axis(1, at = 4:7, labels = expression(10^4, 10^5, 10^6, 10^7))

18

Two kinds of point symbols stand for the “Vaccinated” variable, and for a sixth

variable, “Allocation”, an appropriate letter is printed additionally close to the “not

vaccinated” symbol.

For each of the latter three variables a legend is desirable. Thus the smaller two

legends are plotted into the scatterplot3d, while the legend for the color coding gets

a single plot. The function layout arranges the two plots suitably on the same

device.

Estimated TB risks

vaccinated
not vaccinated

l

A

l

A
R
S

alternate
random
systematic

R

l

R

l

R

l
S

l

R

l

l

S

l

S
R

l
S

l

A

l

R

l

10

e
d
u
t
i
t
a
L

R

l

60

50

40

30

20

k
s
R

i

3
.
0

5
2
.
0

2
.
0

5
1
.
0

1
.
0

5
0
.
0

0

45

50

55

60

65

70

75

80

Year

104

105

106

107

color code of variable "Precision"

Figure 7: Estimated TB risks

19

4.2.2 Business cycle data

The example in this section shows the plotting of data from a project on “Multi-

variate Analysis of Business Cycles”. One of the main interests of the project is the

prediction of business cycle phases. An extraction of available relevant (concerning

the purposes of this section) variables and its abbreviations is given in Table 1. The

abbreviation ’gr’ stands for growth rates with respect to last year’s corresponding

quarter.

abbr

description

IE

C

Y

L

real investment in equipment (gr)

real private consumption (gr)

real gross national product (gr)

wage and salary earners (gr)

Table 1: Abbreviations

The experts’ classiﬁcation of the data into business cycle phases (“PH”) was done

by Heilemann and Münch (1996) using a 4-phase scheme. These phases are called

lower turning points, upswing, upper turning points, and downswing.

In Figure 8 the three variables C, Y, and L are represented by the three dimensions of

the cube. The variable IE is represented by color, while four diﬀerent point symbols

stand for the four business cycle phases (PH).

For each of the latter two variables, a legend is desirable. Thus the smaller one (for

PH) is plotted into the scatterplot3d, while the legend for the color coding of IE got

a single plot, analogously to the example in Section 4.2.1.

A regression plane is added to the plot to support the visual impression. Obviously

all the plotted variables are highly correlated, with the exception of the class variable

which does not appear to be well predictable by the other variables. Details are

discussed in Theis et al. (1999). In order to provide a correct impression of the

ﬁt, the residuals, i.e. the projection lines to the plane, are drawn in Figure 9 where

diﬀerent color and line types are used for positive and negative residuals respectively.

20

layout(cbind(1:2, 1:2), heights = c(7, 1))

temp <- hsv((temp <- 0.7 * IE / diff(range(IE))) - min(temp) + 0.3)

s3d <- scatterplot3d(L, C, Y, pch = Phase, color = temp,

mar = c(5, 3, 4, 3), main = "Business cycle phases")

legend(s3d$xyz.convert(-2, 0, 16), pch = 1:4, yjust = 0,

legend = c("upswing", "upper turning points",

"downswing", "lower turning points"))

s3d$plane3d(my.lm <- lm(Y ~ L + C), lty = "dotted")

par(mar=c(5, 3, 0, 3))

plot(seq(min(IE), max(IE), length = 100), rep(0, 100), pch = 15,

axes = FALSE, xlab = "color code of variable \"IE\"", ylab = "",

col = hsv(seq(0.3, 1, length = 100)))

axis(1, at = seq(-20, 25, 5))

Business cycle phases

l upswing

upper turning points
downswing
lower turning points

5
1

0
1

Y

5

0

5
−

l

ll

l

l
l
l

l
l
l
l
l

l

l

l

l

l

l

l

l
l
l
ll
l
l
l
l
l

l
l
l

l
lll

l
ll

l

l
l

l
l

l

l

l

l

l

l

15

C

10

5

l

l
l

l
l

l

l

0

−5

2

4

6

l

l

0

L

−6

−4

−2

−20

−15

−10

−5

0

5

10

15

20

25

color code of variable "IE"

Figure 8: Business cycle phases

21

s3d <- scatterplot3d(L, C, Y, pch = 20, mar = c(5, 3, 4, 3),

main = "Residuals")

s3d$plane3d(my.lm, lty = "dotted")

orig <- s3d$xyz.convert(L, C, Y)

plane <- s3d$xyz.convert(L, C, fitted(my.lm))

i.negpos <- 1 + (resid(my.lm) > 0)

segments(orig$x, orig$y, plane$x, plane$y,

col = c("blue", "red")[i.negpos], lty = (2:1)[i.negpos])

Residuals

5
1

0
1

Y

5

0

5
−

l

l

l

l
l

l

l

l
ll
l
l

l

l

l
l

l

l

l
l
l

l

l

l
l
l
l l
l
l
ll
l
l
l
l
l

l
l

l

l

l

l

l

l
l
l

l
l

l
l
l
l
l

l

l
l

ll

l

l
l
l
l
l

l
l

l

l

l
l

l

l

l

l

l

l

l
l

l

l

l

l

l

l

l

l

l
l
l

ll

l
l
l

l
ll

l
l
l
l
l
l
l
l
l
l
l

l
l

l
l
l

l

l
l

l

l l
l

l

l

l

l

l

l
l

l

l

l
l
l

l

l

l

l

l

15

C

10

5

l

l

l

l
l

l
l

−6

−4

−2

l

l

l
l
l
l

l

l

0

L

l

l

l

l

0

−5

2

4

6

Figure 9: Residuals (cf. Figure 8)

22

4.2.3 Deep hole drilling

Our last real world example shows phase spaces (Tong, 1993) of the drilling torque

of a deep hole drilling process. The data is taken from a project on "Analysis and

Modelling of the Deephole–Drilling–Process with Methods of Statistics and Neu-

ronal Networks". More detailed analysis on the data than provided in the following

example was done by, e.g., Busse et al. (2001) and Weinert et al. (2001).

Figure 10 visualizes the phase spaces of the drilling torques of two deep hole drilling

processes, a regular and a chattering one. Obviously the points in the phase space of

the chattering process are very systematically scattered, and the range of the data

is very diﬀerent for the two processes. The magniﬁcation of the regular process in

Figure 11 shows that the points of the regular process are scattered unsystematically.

Note that other lags like 10, 20, 100 would produce a similar plot. This indicates a

sine wave like relationship in the chattering case.

s3d <- scatterplot3d(drill1[1:400], drill1[7:406], drill1[32:431],

color = "red", type = "l", angle = 120, xlab = "drilling torque",

ylab = "drilling torque, lag 6", zlab = "drilling torque, lag 31",

main = "Two deep hole drilling processes")

s3d$points3d(drill2[1:400], drill2[7:406], drill2[32:431],

col = "blue", type = "l")

legend(s3d$xyz.convert(-400, 1000, 950), col= c("blue", "red"),

legend = c("regular process", "chattering process"), lwd = 2,

bg = "white")

scatterplot3d(drill2[1:400], drill2[7:406], drill2[32:431],

color = "blue", type = "l", angle = 120, xlab = "drilling torque",

ylab = "drilling torque, lag 6", zlab = "drilling torque, lag 31",

main = "Magnification of the regular process")

23

Two deep hole drilling processes

regular process
chattering process

6

g
a

l

,
e
u
q
r
o
t

g
n

i
l
l
i
r
d

600

200

−200

−600

0
0
8

0
0
4

0

0
0
4
−

1
3

g
a

l

,
e
u
q
r
o
t

g
n

i
l
l
i
r
d

−400

0

400

800

drilling torque

Figure 10: Phase spaces of the drilling torques of two deep hole drilling processes

Magnification of the regular process

6
g
a

l

,

e
u
q
r
o
t

g
n

i
l
l
i
r
d

280

260

240

220

200

180

160

140

0
8
2

0
6
2

0
4
2

0
2
2

0
0
2

0
8
1

0
6
1

0
4
1

1
3
g
a

l

,
e
u
q
r
o
t

g
n

i
l
l
i
r
d

140

160

180

200

220

240

260

280

drilling torque

Figure 11: Magniﬁcation of the regular process (Figure 10)

24

5 Other 3D tools in R

At the time of writing scatterplot3d, the function persp() in the base package of R

for three dimensional surface plots was available, but there was no way to generate

3D scatter plots in R itself.

The data visualization system xgobi (Swayne et al., 1998) provides interactive visu-

alization of multidimensional data, e.g. brush and spin, higher-dimensional rotation,

grand tour, etc. The R package xgobi (Swayne et al., 1991; we have to distinguish the

visualization system and the package) provides an Interface to xgobi and launches
a xgobi process appropriately. ggobi 2 (Swayne et al., 2002) is the next edition of
xgobi.

Analogously to xgobi a R package Rggobi (Temple Lang and Swayne, 2001) exists in
the Omegahat project3 (Temple Lang, 2000) that allows one to embed ggobi within
R and to both set and query the ggobi contents. All in all, ggobi can be loaded

dynamically into R (as well as into other software products, in principle), and R

into ggobi. This provides interactive, direct manipulation, linked, high-dimensional

graphics within R.

The package rgl 4 by Adler et al., 2003 is a portable R programing interface to
OpenGL. Its features include, e.g., interactive viewpoint navigation, automatic data

focus, up to 8 light sources, alpha-blending (transparency), and environmental ef-
fects like fogging. The package djmrgl 5 (Murdoch, 2001) also provides an R interface
to OpenGL. A huge collection of useful functions to generate, manipulate and in-

teractively rotate 3D objects is available. Eﬀorts are under way to merge these two

packages.

The function cloud in the lattice package is a 3D scatter plot function that works

in the lattice (Sarkar, 2002) (and grid (Murrell, 2001)) environment of R. Lattice is

an implementation of Trellis Graphics, which is a framework for data visualization

2http://www.ggobi.org
3http://www.omegahat.net
4http://wsopuppenkiste.wiso.uni-goettingen.de/~dadler/rgl/
5This package was formerly called rgl, similar to the other mentioned package by Daniel Adler

and Oleg Nenadić. djmrgl is only available for the Windows operating system.

25

developed at the Bell Labs by Becker et al. (1996), extending ideas presented in

Cleveland (1993).

6 Conclusion

In the design (Section 2) of the scatter plot function scatterplot3d emphasis is placed

on generality and extensibility (Section 3). These two properties are demonstrated

in Section 4, as well as the high printout quality. A high printout quality and a

homogeneous appearance with respect of any other R (2D) graphics is extremely

important for publications and presentations. Thus we recommend to use scatter-

plot3d particularly for these purposes.

Other R related 3D “tools” (Section 5) are focused on diﬀerent properties, such as

surface plotting (e.g. function persp), interactivity and online analysis (e.g. ggobi

or RGL).

Acknowledgements

The ﬁnancial support of the Deutsche Forschungsgemeinschaft (SFB 475, “Reduction

of complexity in multivariate data structures") is gratefully acknowledged.

We express our sincere thanks to the following people (in alphabetical order) for

their extensive comments on the features and bugs during the time of development,

as well as for the discussion of the example data:

Ben Bolker, Anja Busse, Ursula Garczarek, Joachim Hartung, Guido Knapp, Win-

fried Theis, Brigitta Voß, and Claus Weihs.

References

Adler, D., O. Nenadic, and W. Zucchini (2003). Rgl: A r-library for 3d visual-

ization with opengl. In Proceedings of the 35th Symposium of the Interface:

Computing Science and Statistics, Salt Lake City.

26

Becker, R. A., W. S. Cleveland, and M. Shyu (1996). The visual design and control

of trellis display. Journal of Computational and Graphical Statistics 5 (2), 123–

155.

Busse, A. M., M. Hüsken, and P. Stagge (2001). Oﬄine-Analyse eines BTA-

Tiefbohrprozesses. Technical Report 16/2001, SFB 475, Department of Statis-

tics, University of Dortmund, Germany. See also: http://www.statistik.

tu-dortmund.de/sfb475/en/tr-e.html.

Cleveland, W. S. (1993). Visualizing Data. Summit, NJ: Hobart Press.

Gentleman, R. and R. Ihaka (2000). Lexical Scope and Statistical Computing.

Journal of Computational and Graphical Statistics 9 (3), 491–508.

Heilemann, U. and H. J. Münch (1996). West German Business Cycles 1963–1994:

A Multivariate Discriminant Analysis. In CIRET–Conference in Singapore,

CIRET–Studien 50.

Knapp, G. and J. Hartung (2003). Improved tests for a random eﬀects meta-

regression with a single covariate. Statistics in Medicine 22 (17), 2693–2710.

Murdoch, D. (2001). RGL: An R Interface to OpenGL. In K. Hornik and

F. Leisch (Eds.), Proceedings of the 2nd International Workshop on Dis-

tributed Statistical Computing, March 15–17, Vienna. Technische Univer-

sität Wien. ISSN 1609-395X, http://www.ci.tuwien.ac.at/Conferences/

DSC-2001/Proceedings/.

Murrell, P. (2001). R Lattice Graphics. In K. Hornik and F. Leisch (Eds.), Pro-

ceedings of the 2nd International Workshop on Distributed Statistical Com-

puting, March 15–17, Vienna. Technische Universität Wien. ISSN 1609-395X,

http://www.ci.tuwien.ac.at/Conferences/DSC-2001/Proceedings/.

Murrell, P. and R. Ihaka (2000). An approach to providing mathematical an-

notation in plots. Journal of Computational and Graphical Statistics 9 (3),

582–599.

R Development Core Team (2004a). R: A language and environment for statistical

computing. Vienna, Austria: R Foundation for Statistical Computing. ISBN

3-900051-07-0.

27

R Development Core Team (2004b). R Language Deﬁnition, Version 2.0.1. R–

Project. ISBN 3-900051-13-5, http://CRAN.R-project.org/manuals.html.

R Development Core Team (2004c). Writing R Extensions, Version 2.0.1. R–

Project. ISBN 3-900051-11-9, http://CRAN.R-project.org/manuals.html.

Sarkar, D. (2002). Lattice: An Implementation of Trellis Graphics in R. R

News 2 (2), 19–23.

Swayne, D. F., A. Buja, and N. Hubbell (1991). XGobi meets S: Integrating

software for data analysis. In Computing Science and Statistics: Proceedings

of the 23rd Symposium on the Interface, Fairfax Station, VA, pp. 430–434.

Interface Foundation of North America, Inc.

Swayne, D. F., D. Cook, and A. Buja (1998). Xgobi: Interactive dynamic graph-

ics in the X window system. Journal of Computational and Graphical Statis-

tics 7 (1), 113–130. See also http://www.research.att.com/areas/stat/

xgobi/.

Swayne, D. F., D. Temple Lang, A. Buja, and D. Cook (2002). GGobi: Evolving

from XGobi into an extensible framework for interactive data visualization.

Journal of Computational and Graphical Statistics. (To appear).

Temple Lang, D. (2000). The Omegahat Environment: New Possibilities for Sta-

tistical Computing. Journal of Computational and Graphical Statistics 9 (3),

423–451.

Temple Lang, D. and D. F. Swayne (2001). GGobi meets R: an extensible environ-

ment for interactive dynamic data visualization. In K. Hornik and F. Leisch

(Eds.), Proceedings of the 2nd International Workshop on Distributed Sta-

tistical Computing, Vienna. Technische Universität Wien. ISSN 1609-395X,

http://www.ci.tuwien.ac.at/Conferences/DSC-2001/Proceedings/.

Theis, W., K. Vogtländer, and C. Weihs (1999). Descriptive studies on styl-

ized facts of the german business cycle. Technical Report 45/1999, SFB

475, Department of Statistics, University of Dortmund, Germany. See also:

http://www.statistik.tu-dortmund.de/sfb475/en/tr-e.html.

Tong, H. (1993). Non-linear Time Series, A Dynamical System Approach. Oxford

Statistical Science Series. New York: Oxford University Press.

28

Weinert, K., O. Webber, A. M. Busse, M. Hüsken, J. Mehnen, and S. P. (2001). In

die Tiefe: Koordinierter Einsatz von Sensorik und Statistik zur Analyse und

Modellierung von BTA-Tiefbohrprozessen. Spur, G. (ed.): ZWF, Zeitschrift

für wirtschaftlichen Fabrikbetrieb 5, 299–314.

29

Appendix – help page

scatterplot3d

3D Scatter Plot

Description

Plots a three dimensional (3D) point cloud.

Usage

scatterplot3d(x, y=NULL, z=NULL, color=par("col"), pch=NULL,

main=NULL, sub=NULL, xlim=NULL, ylim=NULL, zlim=NULL,

xlab=NULL, ylab=NULL, zlab=NULL, scale.y=1, angle=40,

axis=TRUE, tick.marks=TRUE, label.tick.marks=TRUE,

x.ticklabs=NULL, y.ticklabs=NULL, z.ticklabs=NULL,

y.margin.add=0, grid=TRUE, box=TRUE, lab=par("lab"),

lab.z=mean(lab[1:2]), type=par("type"), highlight.3d=FALSE,

mar=c(5,3,4,3)+0.1, col.axis=par("col.axis"),

col.grid="grey", col.lab=par("col.lab"),

cex.symbols=par("cex"), cex.axis=par("cex.axis"),

cex.lab=0.8 * par("cex.lab"), font.axis=par("font.axis"),

font.lab=par("font.lab"), lty.axis=par("lty"),

lty.grid=par("lty"), lty.hide=NULL, log="", ...)

Arguments

x

y

z

the coordinates of points in the plot.

the y coordinates of points in the plot, optional if x is an appropriate

structure.

the z coordinates of points in the plot, optional if x is an appropriate

structure.

color

colors of points in the plot, optional if x is an appropriate structure.

Will be ignored if highlight.3d = TRUE.

30

pch

main

plotting "character", i.e. symbol to use.

an overall title for the plot.

sub
xlim, ylim, zlim

sub-title.

the x, y and z limits (min, max) of the plot. Note that setting enlarged

limits may not work as exactly as expected (a known but unﬁxed bug).

xlab, ylab, zlab

titles for the x, y and z axis.

scale.y

scale of y axis related to x- and z axis.

angle

angle between x and y axis (Attention: result depends on scaling. For

180 < angle < 360 the returned functions xyz.convert and points3d

will not work properly.).

axis

a logical value indicating whether axes should be drawn on the plot.

tick.marks

a logical value indicating whether tick marks should be drawn on the

plot (only if axis = TRUE).

label.tick.marks

a logical value indicating whether tick marks should be labeled on the

plot (only if axis = TRUE and tick.marks = TRUE).

x.ticklabs, y.ticklabs, z.ticklabs

vector of tick mark labels.

y.margin.add add additional space between tick mark labels and axis label of the y

grid

box

lab

lab.z

type

axis

a logical value indicating whether a grid should be drawn on the plot.

a logical value indicating whether a box should be drawn around the

plot.

a numerical vector of the form c(x, y, len). The values of x and y give

the (approximate) number of tickmarks on the x and y axes.

the same as lab, but for z axis.

character indicating the type of plot: "p" for points, "l" for lines, "h"

for vertical lines to x-y-plane, etc.

highlight.3d points will be drawn in diﬀerent colors related to y coordinates (only

if type = "p" or type = "h", else color will be used).

On some devices not all colors can be displayed. In this case try the

postscript device or use highlight.3d = FALSE.

31

mar

A numerical vector of the form c(bottom, left, top, right) which gives

the lines of margin to be speciﬁed on the four sides of the plot.

col.axis, col.grid, col.lab

the color to be used for axis / grid / axis labels.

cex.symbols, cex.axis, cex.lab

the magniﬁcation to be used for point symbols, axis annotation, labels

font.axis, font.lab

relative to the current.

the font to be used for axis annotation / labels.

lty.axis, lty.grid

the line type to be used for axis / grid.

lty.hide

line style used to plot ‘non-visible’ edges (defaults of the lty.axis

style)

Not yet implemented! A character string which contains "x" (if the x

axis is to be logarithmic), "y", "z", "xy", "xz", "yz", "xyz".

more graphical parameters can be given as arguments, pch = 16 or pch

= 20 may be nice.

log

...

Value

xyz.convert

function which converts coordinates from 3D (x, y, z) to 2D-projection

(x, y) of scatterplot3d. Useful to plot objects into existing plot.

points3d

function which draws points or lines into the existing plot.

plane3d

function which

draws

a

plane

into

the

existing

plot:

plane3d(Intercept, x.coef = NULL, y.coef = NULL, lty =

"dashed", lty.box = NULL, ...).

Instead of Intercept a vec-

tor containing 3 elements or an (g)lm object can be speciﬁed.

The argument lty.box allows to set a diﬀerent line style for the

intersecting lines in the box’s walls.

box3d

function which "refreshes" the box surrounding the plot.

Note

Some graphical parameters should only be set as arguments in scatterplot3d but not

in a previous par() call. One of these is mar, which is also non-standard in another way:

32

Users who want to extend an existing scatterplot3d graphic with another function

than points3d, plane3d or box3d, should consider to set par(mar = c(b, l, t, r))

to the value of mar used in scatterplot3d, which defaults to c(5, 3, 4, 3) + 0.1.

Other par arguments may be split into several arguments in scatterplot3d, e.g.,

for specifying the line type. And ﬁnally some of par arguments do not apply here,

e.g., many of those for axis calculation. So we recommend to try the speciﬁcation of

graphical parameters at ﬁrst as arguments in scatterplot3d and only if needed as

arguments in previous par() call.

Author(s)

Uwe

Ligges

<ligges@statistik.tu-dortmund.de>;

http://www.statistik.

tu-dortmund.de/~ligges.

References

Ligges, U., and Maechler, M. (2003): Scatterplot3d – an R Package for Visualizing Mul-

tivariate Data. Journal of Statistical Software 8(11), 1–20. http://www.jstatsoft.

org/

See Also

persp, plot, par.

Examples

## On some devices not all colors can be displayed.

## Try the postscript device or use highlight.3d = FALSE.

## example 1

z <- seq(-10, 10, 0.01)

x <- cos(z)

y <- sin(z)

scatterplot3d(x, y, z, highlight.3d=TRUE, col.axis="blue",

col.grid="lightblue", main="scatterplot3d - 1", pch=20)

33

## example 2

temp <- seq(-pi, 0, length = 50)

x <- c(rep(1, 50) %*% t(cos(temp)))

y <- c(cos(temp) %*% t(sin(temp)))

z <- c(sin(temp) %*% t(sin(temp)))

scatterplot3d(x, y, z, highlight.3d=TRUE,

col.axis="blue", col.grid="lightblue",

main="scatterplot3d - 2", pch=20)

## example 3

temp <- seq(-pi, 0, length = 50)

x <- c(rep(1, 50) %*% t(cos(temp)))

y <- c(cos(temp) %*% t(sin(temp)))

z <- 10 * c(sin(temp) %*% t(sin(temp)))

color <- rep("green", length(x))

temp <- seq(-10, 10, 0.01)

x <- c(x, cos(temp))

y <- c(y, sin(temp))

z <- c(z, temp)

color <- c(color, rep("red", length(temp)))

scatterplot3d(x, y, z, color, pch=20, zlim=c(-2, 10),

main="scatterplot3d - 3")

## example 4

my.mat <- matrix(runif(25), nrow=5)

dimnames(my.mat) <- list(LETTERS[1:5], letters[11:15])

my.mat # the matrix we want to plot ...

s3d.dat <- data.frame(cols=as.vector(col(my.mat)),

rows=as.vector(row(my.mat)),

value=as.vector(my.mat))

scatterplot3d(s3d.dat, type="h", lwd=5, pch=" ",

x.ticklabs=colnames(my.mat), y.ticklabs=rownames(my.mat),

color=grey(25:1/40), main="scatterplot3d - 4")

34

## example 5

data(trees)

s3d <- scatterplot3d(trees, type="h", highlight.3d=TRUE,

angle=55, scale.y=0.7, pch=16, main="scatterplot3d - 5")

# Now adding some points to the "scatterplot3d"

s3d$points3d(seq(10,20,2), seq(85,60,-5), seq(60,10,-10),

col="blue", type="h", pch=16)

# Now adding a regression plane to the "scatterplot3d"

attach(trees)

my.lm <- lm(Volume ~ Girth + Height)

s3d$plane3d(my.lm, lty.box = "solid")

## example 6; by Martin Maechler

cubedraw <- function(res3d, min = 0, max = 255, cex = 2,

text. = FALSE)

{

}

## Purpose: Draw nice cube with corners

cube01 <- rbind(c(0,0,1), 0, c(1,0,0),

c(1,1,0), 1, c(0,1,1), # < 6 outer

c(1,0,1), c(0,1,0))

# <- "inner": fore- & back-ground

cub <- min + (max-min)* cube01

## visibile corners + lines:

res3d$points3d(cub[c(1:6,1,7,3,7,5) ,],

cex = cex, type = 'b', lty = 1)

## hidden corner + lines

res3d$points3d(cub[c(2,8,4,8,6),

],

cex = cex, type = 'b', lty = 3)

if(text.)## debug

text(res3d$xyz.convert(cub), labels=1:nrow(cub),

col='tomato', cex=2)

## 6 a) The named colors in R, i.e. colors()

cc <- colors()

crgb <- t(col2rgb(cc))

35

par(xpd = TRUE)

rr <- scatterplot3d(crgb, color = cc, box = FALSE, angle = 24,

xlim = c(-50, 300), ylim = c(-50, 300), zlim = c(-50, 300))

cubedraw(rr)

## 6 b) The rainbow colors from rainbow(201)

rbc <- rainbow(201)

Rrb <- t(col2rgb(rbc))

rR <- scatterplot3d(Rrb, color = rbc, box = FALSE, angle = 24,

xlim = c(-50, 300), ylim = c(-50, 300), zlim = c(-50, 300))

cubedraw(rR)

rR$points3d(Rrb, col = rbc, pch = 16)

36


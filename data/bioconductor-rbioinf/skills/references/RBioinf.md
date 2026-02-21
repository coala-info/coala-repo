RBioinf Introduction

April 24, 2017

Introduction

The RBioinf package has a handful of functions that support the monograph, R Pro-
gramming for Bioinformatics. It also has a few functions that were developed for a more
in depth study of S4 OOP that were never included in that monograph, but for which
the discussion may be of use to some (and which unfortunately may no longer be correct
as S4 has evolved a lot in recent times).

S4 Classes

Details on S4 classes are given in a number of other locations. This is not a tutorial on
their use, but rather moves quickly to a discussion of the code for computing lineariza-
tions.

0.1 Class Linearization

For many diﬀerent computations, especially method dispatch, an algorithm for specify-
ing a linear order of the class inheritance tree is needed. All object oriented programming
languages support the computation of a linearization. Here we provide a succinct de-
scription of the procedure and give some simple examples.

The methods used to compute a linearization are diﬀerent for diﬀerent languages.
For languages that only support single inheritance the precedence rule that is used is
that a class is more speciﬁc than any of its superclasses. Methods deﬁned for subclasses
will override methods deﬁned for superclasses. When multiple inheritance is supported
then it may not be clear which one of two superclasses is more speciﬁc. The issue arises
when there are two superclasses, and these classes do not themselves have a subclass –
superclass relationship. In S4 the style of linearization named C3 (Barrett et al., 1996)
has been adopted and will be used. An implementation of this linearization is provided
by the computeClassLinearization function with the C3 argument set to TRUE.

In languages with multiple inheritance some mechanism must be provided to resolve
the appropriate order in which to inherit properties. There can be conﬂicts or multiple

1

methods which might be applicable and it is important these issues be resolved. Ideally
they should be resolved at class deﬁnition time, as there will be obvious eﬃciency losses
if this is done at dispatch time.

C++ and Eiﬀel provide programming constructs that allow/require the programmer
to specify the class precedence hierarchy.
In languages such as Common Lisp (and
the CLOS object system) and Dylan the approach that is taken is usually to have an
automatic method of computing a linearization. A linearization of a class hierarchy is a
linear ordering of the class labels contained in the hierarchy, such that each class appears
once. There has been a reasonable amount of research in these automatic methods and
in this section we discuss some of those and propose the one that was recommended in
Barrett et al. (1996).

In most object-oriented languages (especially those with single inheritance) the prece-
dence rule that is used is that a class is more speciﬁc than any of its superclasses. And
methods deﬁned for sub-classes will override methods deﬁned for superclasses. When
multiple inheritance is supported then it may not be clear which one of two superclasses
is more speciﬁc. The issue arises when there are two superclasses, and these classes do
not themselves have a subclass – superclass relationship.

Both CLOS and Dylan use the local precedence order (LPO) the order of the direct
superclasses given in the class deﬁnition in computing the linearization, with earlier
If there are no duplicate class
superclasses considered more speciﬁc than later ones.
labels in the hierarchy then this is then simply a bread-ﬁrst search of the superclass
deﬁnitions. But when one or more classes are inherited from diﬀerent superclasses this
deﬁnition becomes more complicated, and can in fact not be satisﬁed, as we will see
below.

We begin with an example from Barrett et al. (1996) and note that our examples will
mainly be from this reference. We also note that we will make use of the graph, RBGL
and Rgraphviz packages from the Bioconductor project to provide us with the necessary
infrastructure for representing, computing on and drawing the class hierarchies.

> library(RBioinf)
> setClass("object")
> setClass("grid-layout", contains="object")
> setClass("horizontal-grid", contains="grid-layout")
> setClass("vertical-grid", contains="grid-layout")
> setClass("hv-grid", contains=c("horizontal-grid", "vertical-grid"))
> LPO("hv-grid")

[1] "hv-grid"
[5] "object"

>

"horizontal-grid" "vertical-grid"

"grid-layout"

> computeClassLinearization("object")

2

[1] "object"

> computeClassLinearization("grid-layout")

[1] "grid-layout" "object"

> computeClassLinearization("vertical-grid")

[1] "vertical-grid" "grid-layout"

"object"

An inheritance graph can be inconsistent under a given linearization mechanism.
This means that the linearization is over-constrained and thus does not exist for the
given inheritance structure. In the next code segment we create a class, confused , for
which the LPO will attempt to place horizontal-grid before vertical-grid because this is
their order in hv-grid , and it will also attempt to place vertical-grid ahead of horizontal-
grid since this is their order in vh-grid ; but clearly both of these properties cannot be
satisﬁed simultaneously. We use the function LPO to compute the local precedence order.
In the code below, we see that there is no linearization of the classes possible for

confused , which is why it is wrapped in a call to tryCatch.

> setClass("vh-grid", contains=c("vertical-grid", "horizontal-grid"))
> setClass("confused", contains=c("hv-grid", "vh-grid"))
> LPO("vh-grid")

[1] "vh-grid"
[5] "object"

"vertical-grid"

"horizontal-grid" "grid-layout"

> tryCatch(LPO("confused"), error=function(x) "this one failed")

[1] "this one failed"

>

A plot of the class hierarchy graph for the confused class is given here.
In order to fully describe and understand the mechanism used to determine which
method should be applied, for a given argument list, and more fully to specify an or-
dering of methods, we must have a linearization of the class hierarchy. In many regards
determining this hierarchy quickly and according to some widely recognized design prin-
ciples will be essential for eﬃciency and for writing programs that work as their authors
intended. The order in which one class precedes another is often called the class prece-
dence list. In languages with single inheritance it is quite easy to compute but when
multiple inheritance is used some problems can arise. Some of the history, and a detailed
discussion of the issues is given in Barrett et al. (1996). The strategy used in Dylan as
well as an implementation are described in Shalit, 1996, pg. 55.

3

Figure 1: A class hierarchy that cannot be resolved.

4

.GlobalEnv:confused.GlobalEnv:hv−grid.GlobalEnv:vh−grid.GlobalEnv:horizontal−grid.GlobalEnv:vertical−grid.GlobalEnv:grid−layout.GlobalEnv:objectWe begin by considering only the class hierarchy that comes from using the contains
argument when deﬁning classes. Later, we will return to some of the more complex issues
that arise if the setIs function is used to further aﬀect the class hierarchy.

A class deﬁnition speciﬁes a local ordering on that class and its direct superclasses

using the following two rules:

(cid:136) the class precedes all direct superclasses

(cid:136) the superclasses have precedence in the order in which they are provided in the
contains argument in the call to setClass, the ordering is right to left (highest
to lowest).

The class precedence list for a class is total ordering on that class and all of its
superclasses that is consistent with the local ordering and with the class precedence lists
of all of its superclasses. Shalit indicates that two lists are consistent if for every A and
B that are in both lists then either A precedes B in both or B precedes A in both. There
may be several orderings that are consistent – some one of these must be chosen. (this
an implementation detail). There may be no possible orderings and in that case an error
is given on the call to setClass.

The ﬁrst, and most basic rule, is that the ordering on direct superclasses of a class
is deﬁned by the order in which they are given in the contains argument to setClass.
One way of determining the class precedence list is via the function extends which if
called with one argument returns the class precedence list.

We ﬁrst introduce a set of classes that will be used for our initial explorations. In the
code chunk below, we see that the only real diﬀerence between the class c and d is the
order in which they include a and b and that this diﬀerence is reﬂected in the output
from extends.

> setClass("a")
> setClass("b")
> setClass("c", contains = c("a", "b"))
> setClass("d", contains = c("b", "a"))
> extends("c")

[1] "c" "a" "b"

> extends("d")

[1] "d" "b" "a"

> setClass("e", contains=c("c", "d"))
>

5

There are some functions that allow the user to understand the superclass relation-
ships. Function from the methods package include getAllSuperClasses and super-
ClassDepth. In addition we have added another helper function in the RBioinf package
called superClasses which ﬁnds and reports only the direct, or most immediate super-
classes. This last function will be used to build a graph of the class hierarchy for visual
inspection.

> getAllSuperClasses(getClass("e"))

[1] "c" "d" "a" "b"

> cD = superClassDepth(getClass("e"))
> cD$label

[1] "c" "d" "a" "b"

> cD$depth

[1] 1 1 2 2

> superClasses(getClass("e"))

[[1]]
[1] "c"
attr(,"package")

c
".GlobalEnv"

[[2]]
[1] "d"
attr(,"package")

d
".GlobalEnv"

>

We now turn our attention to a more complicated situation, and one in which the
ordering of the classes in the class precedence list might not be so obvious.

> cH = class2Graph("e")
>

6

> setClass("pane", contains="object")
> setClass("editing-mixin", contains="object")
> setClass("scrolling-mixin", contains="object")
> setClass("scrollable-pane", contains=c("pane", "scrolling-mixin"))
> setClass("editable-pane", contains=c("pane", "editing-mixin"))
> setClass("editable-scrollable-pane",
+
>

contains=c("scrollable-pane", "editable-pane"))

For the editable-scrollable-pane class the two linearizations, Dylan-style and C3 pro-
vide diﬀerent answers. It can be argued that the C3 linearization is less surprising since
it puts scrolling-mixin ahead of editing-mixin and that is somewhat sensible since this
would be the same ordering as their direct superclasses.

> LPO("editable-scrollable-pane")

[1] "editable-scrollable-pane" "scrollable-pane"
[3] "editable-pane"
[5] "editing-mixin"
[7] "object"

"pane"
"scrolling-mixin"

> LPO("editable-scrollable-pane", C3=TRUE)

[1] "editable-scrollable-pane" "scrollable-pane"
[3] "editable-pane"
[5] "scrolling-mixin"
[7] "object"

"pane"
"editing-mixin"

>

In the ﬁgure below we see the class graph for the editable-scrollable-pane class.

> eWG = class2Graph("editable-scrollable-pane")
> eWGattrs = makeNodeAttrs(eWG, shape="ellipse", fill="grey", width=4)
> plot(eWG, nodeAttrs=eWGattrs)
>

7

Session Information

The version number of R and packages loaded for generating the vignette were:

R version 3.4.0 (2017-04-21)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.2 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.5-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.5-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8

8

.GlobalEnv:editable−scrollable−pane.GlobalEnv:scrollable−pane.GlobalEnv:editable−pane.GlobalEnv:pane.GlobalEnv:scrolling−mixin.GlobalEnv:editing−mixin.GlobalEnv:object[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] grid
[8] methods

parallel stats
base

graphics grDevices utils

datasets

other attached packages:
[1] Rgraphviz_2.20.0
[4] BiocGenerics_0.22.0

RBioinf_1.36.0

graph_1.54.0

loaded via a namespace (and not attached):
[1] compiler_3.4.0 tools_3.4.0

stats4_3.4.0

References

Kim Barrett, Bob Cassels, Paul Haahr, David A. Moon, Keith Playford, and P. Tucker
Withington. Monotonic superclass linearization for dylan. In Proceedings of the 1996
ACM SIGPLAN Conference on Object-Oriented Programming Systems, Languages &
Applications (OOPSLA 1996). ACM, 1996. URL http://www.webcom.com/haahr/
dylan/linearization-oopsla96.html.

Andrew Shalit. The Dylan Reference Manual. Apple Press, 1996.

9


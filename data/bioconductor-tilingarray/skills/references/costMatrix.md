Calculation of the cost matrix

Wolfgang Huber

October 30, 2025

1 Problem statement and definitions

Let ynj be the data value at position (genomic coordinate) n = 1, . . . , N for
replicate array j = 1, . . . , J. Hence we have J arrays and sequences of length
N . The goal of this note is to describe an O(N J) algorithm to calculate the
cost matrix of a piecewise linear model for the segmentation of the (1, . . . , N )
axis. It is implemented in the function costMatrix in the package tilingArray.
The cost matrix is the input for a dynamic programming algorithm that finds
the optimal (least squares) segmentation.

The cost matrix Gkm is the sum of squared residuals for a segment from

m to m + k − 1 (i. e. including m + k − 1 but excluding m + k),

Gkm :=

J
(cid:88)

m+k−1
(cid:88)

j=1

n=m

(ynj − ˆµkm)2

where 1 ≤ m ≤ m + k − 1 ≤ N and ˆµkm is the mean of that segment,

ˆµkm =

1
Jk

J
(cid:88)

m+k−1
(cid:88)

j=1

n=m

ynj.

(1)

(2)

Sidenote: a perhaps more straightforward definition of a cost matrix
would be ¯Gm′ m = G(m′−m) m, the sum of squared residuals for a segment
from m to m′ − 1. I use version (1) because it makes it easier to use the
condition of maximum segment length (k <= kmax), which I need to get the
algorithm from complexity O(N 2) to O(N ).

1

2 Algebra

with

Gkm =

J
(cid:88)

m+k−1
(cid:88)

j=1

n=m

(ynj − ˆµkm)2

= (cid:88)
n,j

y2
nj −

1
Jk





(cid:88)

n′,j′


2

yn′j′



= (cid:88)
n

qn −

(cid:33)2

1
Jk

(cid:32)

(cid:88)

n′

rn′

qn

rn

:= (cid:88)
j
:= (cid:88)
j

y2
nj

ynj

If y is an N × J matrix, then the N -vectors q and r can be obtained by

q = rowSums(y*y)
r = rowSums(y)

Now define

which be obtained from

c = cumsum(r)
d = cumsum(q)

then (5) becomes

cν =

dν =

ν
(cid:88)

n=1
ν
(cid:88)

n=1

rn

qn

(3)

(4)

(5)

(6)

(7)

(8)

(9)

(cm+k−1 − cm−1)2

(10)

(dm+k−1 − dm−1) −

1
Jk

2


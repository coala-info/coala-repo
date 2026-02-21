The fastcluster package: User’s manual
Version 1.3.0

Daniel Müllner

May 4, 2025

The fastcluster package is a C++ library for hierarchical, agglomerative clustering.
It eﬃciently implements the seven most widely used clustering schemes: single, com-
plete, average, weighted/mcquitty, Ward, centroid and median linkage. The library
currently has interfaces to two languages: R and Python/SciPy. Part of the function-
ality is designed as drop-in replacement for existing routines: linkage in the SciPy
package scipy.cluster.hierarchy, hclust in R’s stats package, and the flashClust
package. Once the fastcluster library is loaded at the beginning of the code, every pro-
gram that uses hierarchical clustering can beneﬁt immediately and eﬀortlessly from
the performance gain. Moreover, there are memory-saving routines for clustering of
vector data, which go beyond what the existing packages provide.

This document describes the usage for the two interfaces for R and Python and is meant
as the reference document for the end user. Installation instructions are given in the ﬁle
INSTALL in the source distribution and are not repeated here. The sections about the
two interfaces are independent and in consequence somewhat redundant, so that users who
need a reference for one interface need to consult only one section.

If you use the fastcluster package for scientiﬁc work, please cite it as:

Daniel Müllner, fastcluster: Fast Hierarchical, Agglomerative Clustering Rou-
tines for R and Python, Journal of Statistical Software, 53 (2013), no. 9, 1–18,
https://doi.org/10.18637/jss.v053.i09.

The “Yule” distance function changed in the Python interface of fastcluster version 1.2.0.
This is following a change in SciPy 1.6.3. The “Jaccard” distance function changed in the
Python interface of fastcluster version 1.3.0. This is following a change in SciPy 1.15.0.
Therefore, the following pairings of SciPy and fastcluster versions are recommended:

SciPy version v

Recommended fastcluster version

v < 1.6.3
1.6.3 ≤ v < 1.15.0
v ≥ 1.15.0

1.1.28
1.2.6
latest (≥ 1.3.0)

1

The R interface does not have the “Yule” and “Jaccard” distance functions, hence is not

aﬀected by these changes.

The fastcluster package is considered stable and will undergo few changes from now on.
If some years from now there have not been any updates, this does not necessarily mean
that the package is unmaintained but maybe it just was not necessary to correct anything.
Of course, please still report potential bugs and incompatibilities to daniel@danifold.net.

Contents

1 The R interface

hclust . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
hclust.vector . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2 The Python interface

linkage . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
single . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
complete . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
average . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
weighted . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
centroid . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
median . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
ward . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
linkage_vector . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Behavior for NaN and inﬁnite values

4 Diﬀerences between the two interfaces

5 References

1 The R interface

Load the package with the following command:

library('fastcluster')

2
3
6

7
8
11
11
11
11
11
11
11
11

15

16

16

The package overwrites the function hclust from the stats package (in the same way as
the flashClust package does). Please remove any references to the flashClust package in
your R ﬁles to not accidentally overwrite the hclust function with the flashClust version.
The new hclust function has exactly the same calling conventions as the old one. You
may just load the package and immediately and eﬀortlessly enjoy the performance im-
provements. The function is also an improvement to the flashClust function from the

2

flashClust package. Just replace every call to flashClust by hclust and expect your
code to work as before, only faster.1 In case the data includes inﬁnite or NaN values, see
Section 3.

If you need to access the old function or make sure that the right function is called,

specify the package as follows:

fastcluster::hclust(...)
flashClust::hclust(...)
stats::hclust(...)

Vector data can be clustered with a memory-saving algorithm with the command:

hclust.vector(...)

The following sections contain comprehensive descriptions of these methods.

hclust (d, method='complete', members=NULL)

Hierarchical, agglomerative clustering on a condensed dissimilarity matrix.

This method has the same speciﬁcations as the method hclust in the package stats
and hclust alias flashClust in the package flashClust. In particular, the print,
plot, rect.hclust and identify methods work as expected.

The argument d is a condensed distance matrix, as it is produced by dist.

The argument method is one of the strings 'single', 'complete', 'average', 'mcquitty',
'centroid', 'median', 'ward.D', 'ward.D2' or an unambiguous abbreviation thereof.

The argument members speciﬁes the sizes of the initial nodes, ie. the number of
observations in the initial clusters. The default value NULL says that all initial nodes
are singletons, ie. have size 1. Otherwise, members must be a vector whose size is the
number of input points. The vector is processed as a double array so that not only
integer cardinalities of nodes can be accounted for but also weighted nodes with real
weights.

The general scheme of the agglomerative clustering procedure is as follows:

1. Start with N singleton clusters (nodes) labeled −1, . . . , −N , which represent the

input points.

2. Find a pair of nodes with minimal distance among all pairwise distances.

3. Join the two nodes into a new node and remove the two old nodes. The new

nodes are labeled consecutively 1, 2, . . .

4. The distances from the new node to all other nodes is determined by the method

parameter (see below).

1If you are using ﬂashClust prior to version 1.01, update it! See the change log for flashClust at

https://cran.r-project.org/web/packages/flashClust/ChangeLog.

3

5. Repeat N − 1 times from step 2, until there is one big node, which contains all

original input points.

The output of hclust is an object of class 'hclust' and represents a stepwise den-
drogram. It contains the following ﬁelds:
merge This is an (N − 1) × 2 array. Row i speciﬁes the labels of the nodes which are

joined step i of the clustering.

height This is a vector of length N − 1. It contains the sequence of dissimilarities at

which every pair of nearest nodes is joined.

order This is a vector of length N . It contains a permutation of the numbers 1, . . . N
for the plot method. When the dendrogram is plotted, this is the order in
which the singleton nodes are plotted as the leaves of a rooted tree. The order
is computed so that the dendrogram is plotted without intersections (except the
case when there are inversions for the 'centroid' and 'median' methods). The
choice of the 'order' sequence follows the same scheme as the stats package does,
only with a faster algorithm. Note that there are many valid choices to order
the nodes in a dendrogram without intersections. Also, subsequent points in the
'order' ﬁeld are not always close in the ultrametric given by the dendrogram.

labels This copies the attribute 'Labels' from the ﬁrst input parameter d. It contains

the labels for the objects being clustered.

method The (unabbreviated) string for the 'method' parameter. See below for a

speciﬁcation of all available methods.

call The full command that produced the result. See match.call.

dist.method This 'method' attribute of the ﬁrst input parameter d. This speciﬁes
which metric was used in the dist method which generated the ﬁrst argument.

The parameter method speciﬁes which clustering scheme to use. The clustering scheme
determines the distance from a new node to the other nodes. Denote the dissimilarities
by d, the nodes to be joined by I, J, the new node by K and any other node by L.
The symbol |I| denotes the size of the cluster I.

method='single': d(K, L) = min(d(I, L), d(J, L))

The distance between two clusters A, B is the closest distance between any two
points in each cluster:

d(A, B) = min

a∈A,b∈B

d(a, b)

method='complete': d(K, L) = max(d(I, L), d(J, L))

The distance between two clusters A, B is the maximal distance between any
two points in each cluster:

d(A, B) = max

a∈A,b∈B

d(a, b)

4

method='average': d(K, L) =

|I| · d(I, L) + |J| · d(J, L)
|I| + |J|

The distance between two clusters A, B is the average distance between the
points in the two clusters:

d(A, B) =

1
|A||B|

∑

a∈A,b∈B

d(a, b)

method='mcquitty': d(K, L) = 1

2 (d(I, L) + d(J, L))

There is no global description for the distance between clusters since the distance
depends on the order of the merging steps.

The following three methods are intended for Euclidean data only, ie. when X contains
the pairwise squared distances between vectors in Euclidean space. The algorithm
will work on any input, however, and it is up to the user to make sure that applying
the methods makes sense.

method='centroid': d(K, L) =

|I| · d(I, L) + |J| · d(J, L)
|I| + |J|

−

|I| · |J| · d(I, J)
(|I| + |J|)2

There is a geometric interpretation: d(A, B) is the distance between the centroids
(ie. barycenters) of the clusters in Euclidean space:

d(A, B) = ∥⃗cA − ⃗cB∥2,

where ⃗cA denotes the centroid of the points in cluster A.

method='median': d(K, L) = 1

2 d(I, L) + 1

2 d(J, L) − 1

4 d(I, J)

Deﬁne the midpoint ⃗wK of a cluster K iteratively as ⃗wK = k if K = {k} is a
singleton and as the midpoint 1
2 ( ⃗wI + ⃗wJ ) if K is formed by joining I and J.
Then we have

d(A, B) = ∥ ⃗wA − ⃗wB∥2

in Euclidean space for all nodes A, B. Notice however that this distance depends
on the order of the merging steps.

method='ward.D': d(K, L) =

(|I| + |L|) · d(I, L) + (|J| + |L|) · d(J, L) − |L| · d(I, J)
|I| + |J| + |L|

The global cluster dissimilarity can be expressed as

d(A, B) =

2|A||B|
|A| + |B|

· ∥⃗cA − ⃗cB∥2,

where ⃗cA again denotes the centroid of the points in cluster A.

5

method='ward.D2': This is the equivalent of 'ward.D', but for input consisting of
untransformed (in particular: non-squared) Euclidean distances.
Internally,
all distances are squared ﬁrst, then method ward.D is applied, and ﬁnally the
square root of all heights in the dendrogram is taken. Thus, global cluster
dissimilarity can be expressed as the square root of that for ward.D, namely

√

d(A, B) =

2|A||B|
|A| + |B|

· ∥⃗cA − ⃗cB∥.

hclust.vector (X, method='single', members=NULL, metric='euclidean', p=NULL)

This performs hierarchical, agglomerative clustering on vector data with memory-
saving algorithms. While the hclust method requires Θ(N 2) memory for clustering
of N points, this method needs Θ(N D) for N points in RD, which is usually much
smaller.

The argument X must be a two-dimensional matrix with double precision values. It
describes N data points in RD as an (N × D) matrix.

The parameter 'members' is the same as for hclust.

The parameter 'method' is one of the strings 'single', 'centroid', 'median', 'ward', or
an unambiguous abbreviation thereof.

If method is 'single', single linkage clustering is performed on the data points with
the metric which is speciﬁed by the metric parameter. The choices are the same as
in the dist method: 'euclidean', 'maximum', 'manhattan', 'canberra', 'binary' and
'minkowski'. Any unambiguous substring can be given. The parameter p is used for
the 'minkowski' metric only.

The call

hclust.vector(X, method='single', metric=[...])

is equivalent to

hclust(dist(X, metric=[...]), method='single')

but uses less memory and is equally fast. Ties may be resolved diﬀerently, ie. if two
pairs of nodes have equal, minimal dissimilarity values at some point, in the speciﬁc
computer’s representation for ﬂoating point numbers, either pair may be chosen for
the next merging step in the dendrogram.

Note that the formula for the 'canberra' metric changed in R 3.5.0: Before R version
3.5.0, the 'canberra' metric was computed as

d(u, v) =

∑

j

|uj − vj|
|uj + vj| .

6

Starting with R version 3.5.0, the formula was corrected to

d(u, v) =

∑

j

|uj − vj|
|uj| + |vj| .

Summands with uj = vj = 0 always contribute 0 to the sum. The second, newer
formula equals SciPy’s deﬁnition.

The fastcluster package detects the R version at runtime and chooses the formula
accordingly, so that fastcluster and the dist method always use the same formula for
a given R version.

If method is one of 'centroid', 'median', 'ward', clustering is performed with respect to
Euclidean distances. In this case, the parameter metric must be 'euclidean'. Notice
that hclust.vector operates on Euclidean distances for compatibility reasons with
the dist method, while hclust assumes squared Euclidean distances for compati-
bility with the stats::hclust method! Hence, the call

hc = hclust.vector(X, method='centroid')

is, aside from the lesser memory requirements, equivalent to

d = dist(X)
hc = hclust(d^2, method='centroid')
hc$height = sqrt(hc$height)

The same applies to the 'median' method. The 'ward' method in hclust.vector
is equivalent to hclust with method 'ward.D2', but to method 'ward.D' only after
squaring as above. Diﬀerences in these algebraically equivalent methods may arise
only from ﬂoating-point inaccuracies and the resolution of ties (which may, however,
in extreme cases aﬀect the entire clustering result due to the inherently unstable
nature of the clustering schemes).

2 The Python interface

The fastcluster package is imported as usual by:

import fastcluster

It provides the following functions:

linkage (X, method='single', metric='euclidean', preserve_input=True)
single (X)
complete (X)
average (X)
weighted (X)
ward (X)

7

centroid (X)
median (X)
linkage_vector (X, method='single', metric='euclidean', extraarg=None)

The following sections contain comprehensive descriptions of these methods.

fastcluster.linkage (X, method='single', metric='euclidean', preserve_input='True')

Hierarchical, agglomerative clustering on a condensed dissimilarity matrix or on vector
data.

Apart from the argument preserve_input, the method has the same input parameters
and output format as the function of the same name in the module scipy.cluster.
hierarchy.

The argument X is preferably a NumPy array with ﬂoating point entries (X.dtype
==numpy.double). Any other data format will be converted before it is processed.
NumPy’s masked arrays are not treated as special, and the mask is simply ignored.

If X is a one-dimensional array, it is considered a condensed matrix of pairwise dis-
similarities in the format which is returned by scipy.spatial.distance.pdist. It
contains the ﬂattened, upper-triangular part of a pairwise dissimilarity matrix. That
is, if there are N data points and the matrix d contains the dissimilarity between the
and is ordered
i-th and j-th observation at position di,j, the vector X has length
as follows:


N
2







(

)

0 d0,1
0

d0,2
d1,2
0








d =

. . . d0,n−1
. . .
. . .
. . .








=








0 X[0]

0

X[1]
X[n − 1]
0

. . . X[n − 2]
. . .
. . .
. . .








0

0

The metric argument is ignored in case of dissimilarity input.

The optional argument preserve_input speciﬁes whether the method makes a working
copy of the dissimilarity vector or writes temporary data into the existing array. If the
dissimilarities are generated for the clustering step only and are not needed afterward,
approximately half the memory can be saved by specifying preserve_input=False.
Note that the input array X contains unspeciﬁed values after this procedure. It is
therefore safer to write

linkage(X, method="...", preserve_input=False)
del X

to make sure that the matrix X is not accessed accidentally after it has been used as
scratch memory. (The single linkage algorithm does not write to the distance matrix
or its copy anyway, so the preserve_input ﬂag has no eﬀect in this case.)

8

If X contains vector data, it must be a two-dimensional array with N observations in
D dimensions as an (N × D) array. The preserve_input argument is ignored in this
case. The speciﬁed metric is used to generate pairwise distances from the input. The
following two function calls yield equivalent output:

linkage(pdist(X, metric), method="...", preserve_input=False)
linkage(X, metric=metric, method="...")

The two results are identical in most cases, but diﬀerences occur if ties are resolved
diﬀerently:
if the minimum in step 2 below is attained for more than one pair of
nodes, either pair may be chosen. It is not guaranteed that both linkage variants
choose the same pair in this case.

The general scheme of the agglomerative clustering procedure is as follows:

1. Start with N singleton clusters (nodes) labeled 0, . . . , N − 1, which represent the

input points.

2. Find a pair of nodes with minimal distance among all pairwise distances.

3. Join the two nodes into a new node and remove the two old nodes. The new

nodes are labeled consecutively N, N + 1, . . .

4. The distances from the new node to all other nodes is determined by the method

parameter (see below).

5. Repeat N − 1 times from step 2, until there is one big node, which contains all

original input points.

The output of linkage is stepwise dendrogram, which is represented as an (N − 1) ×
4 NumPy array with ﬂoating point entries (dtype=numpy.double). The ﬁrst two
columns contain the node indices which are joined in each step. The input nodes are
labeled 0, . . . , N − 1, and the newly generated nodes have the labels N, . . . , 2N − 2.
The third column contains the distance between the two nodes at each step, ie. the
current minimal distance at the time of the merge. The fourth column counts the
number of points which comprise each new node.

The parameter method speciﬁes which clustering scheme to use. The clustering scheme
determines the distance from a new node to the other nodes. Denote the dissimilarities
by d, the nodes to be joined by I, J, the new node by K and any other node by L.
The symbol |I| denotes the size of the cluster I.

method='single': d(K, L) = min(d(I, L), d(J, L))

The distance between two clusters A, B is the closest distance between any two
points in each cluster:

d(A, B) = min

a∈A,b∈B

d(a, b)

9

method='complete': d(K, L) = max(d(I, L), d(J, L))

The distance between two clusters A, B is the maximal distance between any
two points in each cluster:

method='average': d(K, L) =

d(A, B) = max

a∈A,b∈B

d(a, b)

|I| · d(I, L) + |J| · d(J, L)
|I| + |J|

The distance between two clusters A, B is the average distance between the
points in the two clusters:

d(A, B) =

1
|A||B|

∑

a∈A,b∈B

d(a, b)

method='weighted': d(K, L) = 1

2 (d(I, L) + d(J, L))

There is no global description for the distance between clusters since the distance
depends on the order of the merging steps.

The following three methods are intended for Euclidean data only, ie. when X con-
tains the pairwise (non-squared!) distances between vectors in Euclidean space. The
algorithm will work on any input, however, and it is up to the user to make sure that
applying the methods makes sense.

√

method='centroid': d(K, L) =

|I| · d(I, L)2 + |J| · d(J, L)2
|I| + |J|

−

|I| · |J| · d(I, J)2
(|I| + |J|)2

There is a geometric interpretation: d(A, B) is the distance between the centroids
(ie. barycenters) of the clusters in Euclidean space:

d(A, B) = ∥⃗cA − ⃗cB∥,

where ⃗cA denotes the centroid of the points in cluster A.

√

method='median': d(K, L) =

1

2 d(I, L)2 + 1

2 d(J, L)2 − 1

4 d(I, J)2

Deﬁne the midpoint ⃗wK of a cluster K iteratively as ⃗wK = k if K = {k} is a
singleton and as the midpoint 1
2 ( ⃗wI + ⃗wJ ) if K is formed by joining I and J.
Then we have

d(A, B) = ∥ ⃗wA − ⃗wB∥

in Euclidean space for all nodes A, B. Notice however that this distance depends
on the order of the merging steps.

10

method='ward':

√

d(K, L) =

(|I| + |L|) · d(I, L)2 + (|J| + |L|) · d(J, L)2 − |L| · d(I, J)2
|I| + |J| + |L|

The global cluster dissimilarity can be expressed as

√

d(A, B) =

2|A||B|
|A| + |B|

· ∥⃗cA − ⃗cB∥,

where ⃗cA again denotes the centroid of the points in cluster A.

fastcluster.single (X )

Alias for fastcluster.linkage (X, method='single').

fastcluster.complete (X )

Alias for fastcluster.linkage (X, method='complete').

fastcluster.average (X )

Alias for fastcluster.linkage (X, method='average').

fastcluster.weighted (X )

Alias for fastcluster.linkage (X, method='weighted').

fastcluster.centroid (X )

Alias for fastcluster.linkage (X, method='centroid').

fastcluster.median (X )

Alias for fastcluster.linkage (X, method='median').

fastcluster.ward (X )

Alias for fastcluster.linkage (X, method='ward').

fastcluster.linkage_vector (X, method='single', metric='euclidean', extraarg='None')
This performs hierarchical, agglomerative clustering on vector data with memory-
saving algorithms. While the linkage method requires Θ(N 2) memory for clustering
of N points, this method needs Θ(N D) for N points in RD, which is usually much
smaller.

The argument X has the same format as before, when X describes vector data, ie. it is
an (N × D) array. Also the output array has the same format. The parameter method
must be one of 'single', 'centroid', 'median', 'ward', ie. only for these methods there
exist memory-saving algorithms currently. If method, is one of 'centroid', 'median',
'ward', the metric must be 'euclidean'.

Like the linkage method, linkage_vector does not treat NumPy’s masked arrays
as special and simply ignores the mask.

11

For single linkage clustering, any dissimilarity function may be chosen. Basically,
every metric which is implemented in the method scipy.spatial.distance.pdist
is reimplemented here. However, the metrics diﬀer in some instances since a number
of mistakes and typos (both in the code and in the documentation) were corrected in
the fastcluster package.2

Therefore, the available metrics with their deﬁnitions are listed below as a reference.
The symbols u and v mostly denote vectors in RD with coordinates uj and vj respec-
tively. See below for additional metrics for Boolean vectors. Unless otherwise stated,
the input array X is converted to a ﬂoating point array (X.dtype==numpy.double) if
it does has have already the required data type. Some metrics accept Boolean input;
in this case this is stated explicitly below.

'euclidean': Euclidean metric, L2 norm

d(u, v) = ∥u − v∥2 =

√∑

(uj − vj)2

'sqeuclidean': squared Euclidean metric

d(u, v) = ∥u − v∥2

2 =

j

∑

j

(uj − vj)2

'seuclidean': standardized Euclidean metric

√∑

d(u, v) =

j

(uj − vj)2/Vj

The vector V = (V0, . . . , VD−1) is given as the extraarg argument. If no extraarg
is given, Vj is by default the unbiased sample variance of all observations in
− µ(Xj)2). (Here, µ(Xj)
the j-th coordinate, Vj = Vari(Xi,j) = 1
denotes as usual the mean of Xi,j over all rows i.)

i(X 2
i,j

N −1

∑

'mahalanobis': Mahalanobis distance

√

d(u, v) =

(u − v)⊤V (u − v)

Here, V = extraarg, a (D × D)-matrix. If V is not speciﬁed, the inverse of the
covariance matrix numpy.linalg.inv(numpy.cov(X, rowvar=False)) is used:

(V −1)j,k =

1
N − 1

∑

(Xi,j − µ(Xj))(Xi,k − µ(Xk))

i
2Hopefully, the SciPy metric will be corrected in future versions and some day coincide with the fastcluster
deﬁnitions. See the bug reports at https://github.com/scipy/scipy/issues/2009, https://github.
com/scipy/scipy/issues/2011.

12

'cityblock': the Manhattan distance, L1 norm
∑

d(u, v) =

j

|uj − vj|

'chebychev': the supremum norm, L∞ norm

'minkowski': the Lp norm

d(u, v) = max

j

|uj − vj|

d(u, v) =



1/p

|uj − vj|p





∑



j

This metric coincides with the cityblock, euclidean and chebychev metrics for
p = 1, p = 2 and p = ∞ (numpy.inf), respectively. The parameter p is given as
the 'extraarg' argument.

'cosine'

d(u, v) = 1 −

⟨u, v⟩
∥u∥ · ∥v∥ = 1 −

∑

√∑

j ujvj
∑
·

j u2
j

j v2
j

'correlation': This method ﬁrst mean-centers the rows of X and then applies the
cosine distance. Equivalently, the correlation distance measures 1 − (Pearson’s
correlation coeﬃcient).

'canberra'

d(u, v) = 1 −

⟨u − µ(u), v − µ(v)⟩
∥u − µ(u)∥ · ∥v − µ(v)∥ ,

d(u, v) =

∑

j

|uj − vj|
|uj| + |vj|

Summands with uj = vj = 0 contribute 0 to the sum.

'braycurtis'

d(u, v) =

∑
j
∑
j

|uj − vj|
|uj + vj|

(user function): The parameter metric may also be a function which accepts two
NumPy ﬂoating point vectors and returns a number. Eg. the Euclidean distance
could be emulated with

13

fn = lambda u, v:
linkage_vector(X, method='single', metric=fn)

numpy.sqrt(((u-v)*(u-v)).sum())

This method, however, is much slower than the built-in function.

'hamming': The Hamming distance accepts a Boolean array (X.dtype==bool) for

eﬃcient storage. Any other data type is converted to numpy.double.

d(u, v) = |{j | uj ̸= vj}|

The following metrics are designed for Boolean vectors. The input array is converted
to the bool data type if it is not Boolean already. Use the following abbreviations
for the entries of a contingency table:

a = |{j | uj ∧ vj}|
c = |{j | (¬uj) ∧ vj}|

b = |{j | uj ∧ (¬vj)}|
d = |{j | (¬uj) ∧ (¬vj)}|

Recall that D denotes the number of dimensions, hence D = a + b + c + d.

'jaccard'

'yule'

d(u, v) =

b + c
b + c + d

d(0, 0) = 0

d(u, v) =

2bc
ad + bc

d(u, v) = 0

if bc ̸= 0

if bc = 0

Note that the second clause d(u, v) = 0 if bc = 0 was introduced in fastcluster
version 1.2.0. Before, the result was NaN if the denominator in the formula was
zero. fastcluster is following a change in SciPy 1.6.3 here.

'dice'

'rogerstanimoto'

'russellrao'

d(u, v) =

b + c
2a + b + c

d(0, 0) = 0

d(u, v) =

2(b + c)
b + c + D

d(u, v) =

b + c + d
D

14

'sokalsneath'

'kulsinski'

'matching'

d(u, v) =

2(b + c)
a + 2(b + c)

d(0, 0) = 0

d(u, v) =

(

·

1
2

b
a + b

+

c
a + c

)

d(u, v) =

b + c
D

Notice that when given a Boolean array, the matching and hamming distance
are the same. The matching distance formula, however, converts every input to
Boolean ﬁrst. Hence, the vectors (0, 1) and (0, 2) have zero matching distance
since they are both converted to (False, True) but the hamming distance is 0.5.

'sokalmichener' is an alias for 'matching'.

3 Behavior for NaN and inﬁnite values

Whenever the fastcluster package encounters a NaN value as the distance between nodes,
either as the initial distance or as an updated distance after some merging steps, it raises
an error. This was designed intentionally, even if there might be ways to propagate NaNs
through the algorithms in a more or less sensible way. Indeed, since the clustering result
depends on every single distance value, the presence of NaN values usually indicates a
dubious clustering result, and therefore NaN values should be eliminated in preprocessing.
In the R interface for vector input, coordinates with NA value are interpreted as missing
data and treated in the same way as R’s dist function does. This results in valid output
whenever the resulting distances are not NaN. The Python interface does not provide any
way of handling missing coordinates, and data should be processed accordingly and given
as pairwise distances to the clustering algorithms in this case.

The fastcluster package handles node distances and coordinates with inﬁnite values cor-
rectly, as long as the formulas for the distance updates and the metric (in case of vector
input) make sense.
In concordance with the statement above, an error is produced if a
NaN value results from performing arithmetic with inﬁnity. Also, the usual proviso applies:
internal formulas in the code are mathematically equivalent to the formulas as stated in the
documentation only for ﬁnite, real numbers but might produce diﬀerent results for ±∞.
Apart from obvious cases like single or complete linkage, it is therefore recommended that
users think about how they want inﬁnite values to be treated by the distance update and
metric formulas and then check whether the fastcluster code does exactly what they want
in these special cases.

15

4 Diﬀerences between the two interfaces

• The 'mcquitty' method in R is called 'weighted' in Python.

• R and SciPy use diﬀerent conventions for the “Euclidean” methods 'centroid', 'me-
dian'! R assumes that the dissimilarity matrix consists of squared Euclidean dis-
tances, while SciPy expects non-squared Euclidean distances. The fastcluster package
respects these conventions and uses diﬀerent formulas in the two interfaces.

The 'ward' method in the Python interface is identical to 'ward.D2' in the R interface.

If the same results in both interfaces ought to be obtained, then the hclust function in
R must be input the entry-wise square of the distance matrix, d^2, for the 'ward.D',
'centroid' and 'median' methods, and later the square root of the height ﬁeld in
the dendrogram must be taken. The hclust.vector method calculates non-squared
Euclidean distances, like R’s dist method and identically to the Python interface.
See the example in the hclust.vector documentation above.

For the 'average' and 'weighted' alias 'mcquitty' methods, the same, non-squared
distance matrix d as in the Python interface must be used for the same results. The
'single' and 'complete' methods only depend on the relative order of the distances,
hence it does not make a diﬀerence whether the method operates on the distances or
the squared distances.

The code example in the R documentation (enter ?hclust or example(hclust) in
R) contains another instance where the squared distance matrix is generated from
Euclidean data.

• The Python interface is not designed to deal with missing values, and NaN values
in the vector data raise an error message. The hclust.vector method in the R
interface, in contrast, deals with NaN and the (R speciﬁc) NA values in the same way
as the dist method does. Confer the documentation for dist for details.

5 References

NumPy: Scientiﬁc computing tools for Python, http://numpy.org/.

Eric Jones, Travis Oliphant, Pearu Peterson et al., SciPy: Open Source Scientiﬁc Tools for
Python, 2001, https://www.scipy.org.

R: A Language and Environment for Statistical Computing, R Foundation for Statistical
Computing, Vienna, 2011, https://www.r-project.org.

16


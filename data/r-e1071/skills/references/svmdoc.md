Support Vector Machines ∗
The Interface to libsvm in package e1071

by David Meyer
FH Technikum Wien, Austria
mailto:David.Meyer@R-Project.org

December 17, 2025

“Hype or Hallelujah?” is the provocative title used by Bennett & Campbell
(2000) in an overview of Support Vector Machines (SVM). SVMs are currently
a hot topic in the machine learning community, creating a similar enthusiasm at
the moment as Artiﬁcial Neural Networks used to do before. Far from being a
panacea, SVMs yet represent a powerful technique for general (nonlinear) classi-
ﬁcation, regression and outlier detection with an intuitive model representation.
The package e1071 oﬀers an interface to the award-winning1 C++-
implementation by Chih-Chung Chang and Chih-Jen Lin, libsvm (current ver-
sion: 2.6), featuring:

• C- and ν-classiﬁcation

• one-class-classiﬁcation (novelty detection)

• ϵ- and ν-regression

and includes:

• linear, polynomial, radial basis function, and sigmoidal kernels

• formula interface

• k-fold cross validation

For further implementation details on libsvm, see Chang & Lin (2001).

Basic concept

SVMs were developed by Cortes & Vapnik (1995) for binary classiﬁcation. Their
approach may be roughly sketched as follows:

Class separation: basically, we are looking for the optimal separating hyper-
plane between the two classes by maximizing the margin between the
classes’ closest points (see Figure 1)—the points lying on the boundaries
are called support vectors, and the middle of the margin is our optimal
separating hyperplane;

∗A smaller version of this article appeared in R-News, Vol.1/3, 9.2001
1The library won the IJCNN 2001 Challenge by solving two of three problems: the Gen-
eralization Ability Challenge (GAC) and the Text Decoding Challenge (TDC). For more
information, see: https://www.csie.ntu.edu.tw/~cjlin/papers/ijcnn.ps.gz.

1

Overlapping classes: data points on the “wrong” side of the discriminant mar-

gin are weighted down to reduce their inﬂuence (“soft margin”);

Nonlinearity: when we cannot ﬁnd a linear separator, data points are pro-
jected into an (usually) higher-dimensional space where the data points
eﬀectively become linearly separable (this projection is realised via kernel
techniques);

Problem solution: the whole task can be formulated as a quadratic optimiza-

tion problem which can be solved by known techniques.

A program able to perform all these tasks is called a Support Vector Machine.

Margin

{

Separating
Hyperplane

Support Vectors

Figure 1: Classiﬁcation (linear separable case)

Several extensions have been developed; the ones currently included in

libsvm are:

ν-classiﬁcation: this model allows for more control over the number of support
vectors (see Schölkopf et al., 2000) by specifying an additional parameter
ν which approximates the fraction of support vectors;

One-class-classiﬁcation: this model tries to ﬁnd the support of a distribution

and thus allows for outlier/novelty detection;

Multi-class classiﬁcation: basically, SVMs can only solve binary classiﬁca-
tion problems. To allow for multi-class classiﬁcation, libsvm uses the
one-against-one technique by ﬁtting all binary subclassiﬁers and ﬁnding
the correct class by a voting mechanism;

ϵ-regression: here, the data points lie in between the two borders of the margin

which is maximized under suitable conditions to avoid outlier inclusion;

2

ν-regression: with analogue modiﬁcations of the regression model as in the

classiﬁcation case.

Usage in R

The R interface to libsvm in package e1071, svm(), was designed to be as
intuitive as possible. Models are ﬁtted and new data are predicted as usual,
and both the vector/matrix and the formula interface are implemented. As
expected for R’s statistical functions, the engine tries to be smart about the
mode to be chosen, using the dependent variable’s type (y):
if y is a factor,
the engine switches to classiﬁcation mode, otherwise, it behaves as a regression
machine; if y is omitted, the engine assumes a novelty detection task.

Examples

In the following two examples, we demonstrate the practical use of svm() along
with a comparison to classiﬁcation and regression forests as implemented in
randomForest().

Classiﬁcation

In this example, we use the glass data from the UCI Repository of Machine
Learning Databases for classiﬁcation (Blake & Merz, 1998), converted to R
format by Friedrich Leisch in the late 1990s. The current version of the UC
Irvine Machine Learning Repository Glass Identiﬁcation data set is available
from doi:10.24432/C5WW2P.

The task is to predict the type of a glass on basis of its chemical analysis.

We start by splitting the data into a train and test set:

> library(e1071)
> library(randomForest)
> data(Glass, package="mlbench")
> ## split data into a train and test set
<- 1:nrow(Glass)
> index
> N
<- trunc(length(index)/3)
> testindex <- sample(index, N)
> testset
> trainset <- Glass[-testindex,]

<- Glass[testindex,]

Both for SVM and randomForest (via randomForest()), we ﬁt the model and
predict the test set values:

> ## svm
> svm.model <- svm(Type ~ ., data = trainset, cost = 100, gamma = 1)
> svm.pred <- predict(svm.model, testset[,-10])

(The dependent variable, Type, has column number 10. cost is a general pe-
nalizing parameter for C-classiﬁcation and gamma is the radial basis function-
speciﬁc kernel parameter.)

3

> ## randomForest
> rf.model <- randomForest(Type ~ ., data = trainset)
> rf.pred <- predict(rf.model, testset[,-10])

A cross-tabulation of the true versus the predicted values yields:

> ## compute svm confusion matrix
> table(pred = svm.pred, true = testset[,10])

true

pred 1 2
1 19
2
3
5
6
7

3
7 2
3 19 2
1
0 0
0
0 0
0
0 0
0
0 0

5
0
3
0
1
0
0

6 7
0 0
3 3
0 0
0 0
2 0
0 6

> ## compute randomForest confusion matrix
> table(pred = rf.pred, true = testset[,10])

true

pred 1 2
1 19
2
3
5
6
7

3
2 2
3 23 3
0
0 0
0
0 1
0
0 0
0
0 0

5
0
0
0
4
0
0

6 7
0 0
1 1
0 0
0 0
4 0
0 8

Accuracy

Kappa

method
svm
randomForest
svm
randomForest

Min.
0.63
0.66
0.47
0.53

1st Qu. Median Mean
0.68
0.65
0.77
0.75
0.57
0.51
0.68
0.66

0.68
0.76
0.55
0.67

3rd Qu. Max.
0.73
0.7
0.82
0.79
0.64
0.59
0.75
0.71

Table 1: Performance of svm() and randomForest() for classiﬁcation (10 repli-
cations)

Finally, we compare the performance of the two methods by comput-
ing the respective accuracy rates and the kappa indices (as computed by
classAgreement() also contained in package e1071). In Table 1, we summarize
the results of 10 replications—Support Vector Machines show worse results.

Non-linear ϵ-Regression

The regression capabilities of SVMs are demonstrated on the ozone data. Again,
we split the data into a train and test set.

> library(e1071)
> library(randomForest)

4

> data(Ozone, package="mlbench")
> ## split data into a train and test set
<- 1:nrow(Ozone)
> index
> N
<- trunc(length(index)/3)
> testindex <- sample(index, N)
> testset
> trainset <- na.omit(Ozone[-testindex,-3])
> ## svm
> svm.model <- svm(V4 ~ ., data = trainset, cost = 1000, gamma = 0.0001)
> svm.pred <- predict(svm.model, testset[,-3])
> sqrt(crossprod(svm.pred - testset[,3]) / N)

<- na.omit(Ozone[testindex,-3])

[,1]
[1,] 3.504154

> ## random Forest
> rf.model <- randomForest(V4 ~ ., data = trainset)
> rf.pred <- predict(rf.model, testset[,-3])
> sqrt(crossprod(rf.pred - testset[,3]) / N)

[,1]
[1,] 3.551971

Min.
svm 2.98
2.99

randomForest

1st Qu. Median Mean
3.51
3.52

3.32
3.23

3.48
3.52

3rd Qu. Max.
4.21
4.48

3.72
3.66

Table 2: Performance of svm() and randomForest() for regression (Root Mean
Squared Error, 10 replications)

We compare the two methods by the root mean squared error (RMSE)—see
Table 2 for a summary of 10 replications. In this case, svm() does a better job
than randomForest().

Elements of the svm object

The function svm() returns an object of class “svm”, which partly includes the
following components:

SV: matrix of support vectors found;

labels: their labels in classiﬁcation mode;

index: index of the support vectors in the input data (could be used e.g., for

their visualization as part of the data set).

If the cross-classiﬁcation feature is enabled, the svm object will contain some
additional information described below.

5

Other main features

Class Weighting: if one wishes to weight the classes diﬀerently (e.g., in case
of asymmetric class sizes to avoid possibly overproportional inﬂuence of
bigger classes on the margin), weights may be speciﬁed in a vector with
named components. In case of two classes A and B, we could use something
like: m <- svm(x, y, class.weights = c(A = 0.3, B = 0.7))

Cross-classiﬁcation: to assess the quality of the training result, we can per-
form a k-fold cross-classiﬁcation on the training data by setting the pa-
rameter cross to k (default: 0). The svm object will then contain some
additional values, depending on whether classiﬁcation or regression is per-
formed. Values for classiﬁcation:

accuracies: vector of accuracy values for each of the k predictions

tot.accuracy: total accuracy

Values for regression:

MSE: vector of mean squared errors for each of the k predictions

tot.MSE: total mean squared error

scorrcoef: Squared correlation coeﬃcient (of the predicted and the true

values of the dependent variable)

Tips on practical use

• Note that SVMs may be very sensitive to the proper choice of parame-
ters, so allways check a range of parameter combinations, at least on a
reasonable subset of your data.

• For classiﬁcation tasks, you will most likely use C-classiﬁcation with the
RBF kernel (default), because of its good general performance and the
few number of parameters (only two: C and γ). The authors of libsvm
suggest to try small and large values for C—like 1 to 1000—ﬁrst, then to
decide which are better for the data by cross validation, and ﬁnally to try
several γ’s for the better C’s.

• However, better results are obtained by using a grid search over all pa-
rameters. For this, we recommend to use the tune.svm() function in
e1071.

• Be careful with large datasets as training times may increase rather fast.

• Scaling of the data usually drastically improves the results. Therefore,

svm() scales the data by default.

Model Formulations and Kernels

Dual representation of models implemented:

6

• C-classiﬁcation:

min
α
s.t.

α

α

⊤Qα − e⊤

1
2
0 ≤ αi ≤ C, i = 1, . . . , l,
y⊤

α = 0 ,

(1)

where e is the unity vector, C is the upper bound, Q is an l by l positive
semideﬁnite matrix, Qij ≡ yiyjK(xi, xj), and K(xi, xj) ≡ ϕ(xi)⊤ϕ(xj) is
the kernel.

• ν-classiﬁcation:

min
α
s.t.

where ν ∈ (0, 1].

• one-class classiﬁcation:

min
α
s.t.

• ϵ-regression:

α

⊤Qα

1
2
0 ≤ αi ≤ 1/l, i = 1, . . . , l,
e⊤
y⊤

α ≥ ν,

α = 0 .

α

⊤Qα

1
2
0 ≤ αi ≤ 1/(νl), i = 1, . . . , l,
e⊤

α = 1 ,

min
α,α∗

1
2

(α − α

∗

⊤Q(α − α

)

∗

) +

l

ϵ

X
i=1

l

(αi + α

∗
i ) +

yi(αi − α

X
i=1
∗
i ≤ C, i = 1, . . . , l,

∗
i )

s.t.

0 ≤ αi, α

l

X
i=1

(αi − α

∗
i ) = 0 .

• ν-regression:

min
α,α∗
s.t.

Available kernels:

⊤Q(α − α

)

∗

) + z⊤

(αi − α

∗
i )

∗
i ≤ C, i = 1, . . . , l,
∗

∗

(α − α

1
2
0 ≤ αi, α
e⊤
(α − α
e⊤

(α + α

) = 0

∗

) = Cν .

7

(2)

(3)

(4)

(5)

kernel
linear
polynomial
radial basis fct.
sigmoid

formula
u⊤v
(γu⊤v + c0)d
exp{−γ|u − v|2}
tanh{γu⊤v + c0}

parameters
(none)
γ, d, c0
γ
γ, c0

Conclusion

We hope that svm provides an easy-to-use interface to the world of SVMs, which
nowadays have become a popular technique in ﬂexible modelling. There are
some drawbacks, though: SVMs scale rather badly with the data size due to
the quadratic optimization algorithm and the kernel transformation. Further-
more, the correct choice of kernel parameters is crucial for obtaining good re-
sults, which practically means that an extensive search must be conducted on
the parameter space before results can be trusted, and this often complicates
the task (the authors of libsvm currently conduct some work on methods of
eﬃcient automatic parameter selection). Finally, the current implementation
is optimized for the radial basis function kernel only, which clearly might be
suboptimal for your data.

References

Bennett, K. P. & Campbell, C. (2000). Support vector machines: Hype or hal-
lelujah? SIGKDD Explorations, 2(2). http://www.acm.org/sigs/sigkdd/
explorations/issue2-2/bennett.pdf.

Blake, C.L. & Merz, C.J. (1998).

ing Databases.
ment of Information and Computer Science.
http://www.ics.uci.edu/ mlearn/MLRepository.html.

Irvine, CA: University of California,

UCI Repository of Machine Learn-
Irvine, Depart-
Formerly available from

Chang, C.-C. & Lin, C.-J. (2001). LIBSVM: a library for support vector
machines. Software available at https://www.csie.ntu.edu.tw/~cjlin/
libsvm/, detailed documentation (algorithms, formulae, . . . ) can be found
in https://www.csie.ntu.edu.tw/~cjlin/papers/libsvm.ps.gz

Cortes, C. & Vapnik, V. (1995). Support-vector network. Machine Learning,

20, 1–25.

Schölkopf, B., Smola, A., Williamson, R. C., & Bartlett, P. (2000). New support

vector algorithms. Neural Computation, 12, 1207–1245.

Vapnik, V. (1998). Statistical learning theory. New York: Wiley.

8


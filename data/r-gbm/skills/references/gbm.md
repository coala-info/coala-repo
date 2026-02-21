Generalized Boosted Models:
A guide to the gbm package

Greg Ridgeway

January 22, 2026

Boosting takes on various forms with different programs using different loss
functions, different base models, and different optimization schemes. The gbm
package takes the approach described in [3] and [4]. Some of the terminology
differs, mostly due to an effort to cast boosting terms into more standard sta-
tistical terminology (e.g. deviance). In addition, the gbm package implements
boosting for models commonly used in statistics but not commonly associated
with boosting. The Cox proportional hazard model, for example, is an incred-
ibly useful model and the boosting framework applies quite readily with only
slight modification [7]. Also some algorithms implemented in the gbm package
differ from the standard implementation. The AdaBoost algorithm [2] has a
particular loss function and a particular optimization algorithm associated with
it. The gbm implementation of AdaBoost adopts AdaBoost’s exponential loss
function (its bound on misclassification rate) but uses Friedman’s gradient de-
scent algorithm rather than the original one proposed. So the main purposes of
this document is to spell out in detail what the gbm package implements.

1 Gradient boosting

This section essentially presents the derivation of boosting described in [3]. The
gbm package also adopts the stochastic gradient boosting strategy, a small but
important tweak on the basic algorithm, described in [4].

1.1 Friedman’s gradient boosting machine

Friedman (2001) and the companion paper Friedman (2002) extended the work
of Friedman, Hastie, and Tibshirani (2000) and laid the ground work for a new
generation of boosting algorithms. Using the connection between boosting and
optimization, this new work proposes the Gradient Boosting Machine.

In any function estimation problem we wish to find a regression function,
ˆf (x), that minimizes the expectation of some loss function, Ψ(y, f ), as shown
in (4).

1

Initialize ˆf (x) to be a constant, ˆf (x) = arg minρ
For t in 1, . . . , T do

(cid:80)N

i=1 Ψ(yi, ρ).

1. Compute the negative gradient as the working response

zi = −

∂
∂f (xi)

Ψ(yi, f (xi))|f (xi)= ˆf (xi)

2. Fit a regression model, g(x), predicting zi from the covariates xi.

3. Choose a gradient descent step size as

ρ = arg min

ρ

N
(cid:88)

i=1

Ψ(yi, ˆf (xi) + ρg(xi))

4. Update the estimate of f (x) as

ˆf (x) ← ˆf (x) + ρg(x)

(1)

(2)

(3)

Figure 1: Friedman’s Gradient Boost algorithm

2

ˆf (x) = arg min
f (x)

Ey,xΨ(y, f (x))

= arg min
f (x)

Ex

(cid:104)

Ey|xΨ(y, f (x))

(cid:12)
(cid:105)
(cid:12)
(cid:12)x

We will focus on finding estimates of f (x) such that

ˆf (x) = arg min
f (x)

Ey|x [Ψ(y, f (x))|x]

(4)

(5)

Parametric regression models assume that f (x) is a function with a finite number
of parameters, β, and estimates them by selecting those values that minimize a
loss function (e.g. squared error loss) over a training sample of N observations
on (y, x) pairs as in (6).

ˆβ = arg min
β

N
(cid:88)

i=1

Ψ(yi, f (xi; β))

(6)

When we wish to estimate f (x) non-parametrically the task becomes more dif-
ficult. Again we can proceed similarly to [5] and modify our current estimate
of f (x) by adding a new function f (x) in a greedy fashion. Letting fi = f (xi),
we see that we want to decrease the N dimensional function

J(f ) =

=

N
(cid:88)

i=1

N
(cid:88)

i=1

Ψ(yi, f (xi))

Ψ(yi, Fi).

(7)

The negative gradient of J(f ) indicates the direction of the locally greatest
decrease in J(f ). Gradient descent would then have us modify f as

ˆf ← ˆf − ρ∇J(f )

(8)

where ρ is the size of the step along the direction of greatest descent. Clearly,
this step alone is far from our desired goal. First, it only fits f at values of
x for which we have observations. Second, it does not take into account that
observations with similar x are likely to have similar values of f (x). Both these
problems would have disastrous effects on generalization error. However, Fried-
man suggests selecting a class of functions that use the covariate information
to approximate the gradient, usually a regression tree. This line of reasoning
produces his Gradient Boosting algorithm shown in Figure 1. At each itera-
tion the algorithm determines the direction, the gradient, in which it needs to
improve the fit to the data and selects a particular model from the allowable
class of functions that is in most agreement with the direction. In the case of

3

squared-error loss, Ψ(yi, f (xi)) = (cid:80)N
exactly to residual fitting.

i=1(yi −f (xi))2, this algorithm corresponds

There are various ways to extend and improve upon the basic framework
suggested in Figure 1. For example, Friedman (2001) substituted several choices
in for Ψ to develop new boosting algorithms for robust regression with least
absolute deviation and Huber loss functions. Friedman (2002) showed that
a simple subsampling trick can greatly improve predictive performance while
simultaneously reduce computation time. Section 2 discusses some of these
modifications.

2

Improving boosting methods using control of
the learning rate, sub-sampling, and a decom-
position for interpretation

This section explores the variations of the previous algorithms that have the
potential to improve their predictive performance and interpretability. In par-
ticular, by controlling the optimization speed or learning rate, introducing low-
variance regression methods, and applying ideas from robust regression we can
produce non-parametric regression procedures with many desirable properties.
As a by-product some of these modifications lead directly into implementations
for learning from massive datasets. All these methods take advantage of the
general form of boosting

ˆf (x) ← ˆf (x) + E(z(y, ˆf (x))|x).

(9)

So far we have taken advantage of this form only by substituting in our favorite
regression procedure for Ew(z|x). I will discuss some modifications to estimating
Ew(z|x) that have the potential to improve our algorithm.

2.1 Decreasing the learning rate

As several authors have phrased slightly differently, “...boosting, whatever fla-
vor, seldom seems to overfit, no matter how many terms are included in the
additive expansion”. This is not true as the discussion to [5] points out.

In the update step of any boosting algorithm we can introduce a learning

rate to dampen the proposed move.

ˆf (x) ← ˆf (x) + λE(z(y, ˆf (x))|x).

(10)

By multiplying the gradient step by λ as in equation 10 we have control on the
rate at which the boosting algorithm descends the error surface (or ascends the
likelihood surface). When λ = 1 we return to performing full gradient steps.
Friedman (2001) relates the learning rate to regularization through shrinkage.
The optimal number of iterations, T , and the learning rate, λ, depend on
each other. In practice I set λ to be as small as possible and then select T by

4

cross-validation. Performance is best when λ is as small as possible performance
with decreasing marginal utility for smaller and smaller λ. Slower learning rates
do not necessarily scale the number of optimal iterations. That is, if when
λ = 1.0 and the optimal T is 100 iterations, does not necessarily imply that
when λ = 0.1 the optimal T is 1000 iterations.

2.2 Variance reduction using subsampling

Friedman (2002) proposed the stochastic gradient boosting algorithm that sim-
ply samples uniformly without replacement from the dataset before estimating
the next gradient step. He found that this additional step greatly improved
performance. We estimate the regression E(z(y, ˆf (x))|x) using a random sub-
sample of the dataset.

2.3 ANOVA decomposition

Certain function approximation methods are decomposable in terms of a “func-
tional ANOVA decomposition”. That is a function is decomposable as

f (x) =

(cid:88)

j

fj(xj) +

(cid:88)

jk

fjk(xj, xk) +

(cid:88)

jkℓ

fjkℓ(xj, xk, xℓ) + · · · .

(11)

This applies to boosted trees. Regression stumps (one split decision trees) de-
pend on only one variable and fall into the first term of 11. Trees with two splits
fall into the second term of 11 and so on. By restricting the depth of the trees
produced on each boosting iteration we can control the order of approximation.
Often additive components are sufficient to approximate a multivariate function
well, generalized additive models, the na¨ıve Bayes classifier, and boosted stumps
for example. When the approximation is restricted to a first order we can also
produce plots of xj versus fj(xj) to demonstrate how changes in xj might affect
changes in the response variable.

2.4 Relative influence

Friedman (2001) also develops an extension of a variable’s “relative influence” for
boosted estimates. For tree based methods the approximate relative influence
of a variable xj is

ˆJ 2
j =

(cid:88)

I 2
t
splits on xj

(12)

where I 2
t is the empirical improvement by splitting on xj at that point. Fried-
man’s extension to boosted models is to average the relative influence of variable
xj across all the trees generated by the boosting algorithm.

5

Select

(cid:136) a loss function (distribution)

(cid:136) the number of iterations, T (n.trees)

(cid:136) the depth of each tree, K (interaction.depth)

(cid:136) the shrinkage (or learning rate) parameter, λ (shrinkage)

(cid:136) the subsampling rate, p (bag.fraction)

Initialize ˆf (x) to be a constant, ˆf (x) = arg minρ
For t in 1, . . . , T do

(cid:80)N

i=1 Ψ(yi, ρ)

1. Compute the negative gradient as the working response

zi = −

∂
∂f (xi)

Ψ(yi, f (xi))|f (xi)= ˆf (xi)

(13)

2. Randomly select p × N cases from the dataset

3. Fit a regression tree with K terminal nodes, g(x) = E(z|x). This tree is

fit using only those randomly selected observations

4. Compute the optimal terminal node predictions, ρ1, . . . , ρK, as

ρk = arg min

ρ

(cid:88)

xi∈Sk

Ψ(yi, ˆf (xi) + ρ)

(14)

where Sk is the set of xs that define terminal node k. Again this step uses
only the randomly selected observations.

5. Update ˆf (x) as

ˆf (x) ← ˆf (x) + λρk(x)
where k(x) indicates the index of the terminal node into which an obser-
vation with features x would fall.

(15)

Figure 2: Boosting as implemented in gbm()

6

3 Common user options

This section discusses the options to gbm that most users will need to change
or tune.

3.1 Loss function

The first and foremost choice is distribution. This should be easily dic-
tated by the application. For most classification problems either bernoulli or
adaboost will be appropriate, the former being recommended. For continuous
outcomes the choices are gaussian (for minimizing squared error), laplace (for
minimizing absolute error), and quantile regression (for estimating percentiles
of the conditional distribution of the outcome). Censored survival outcomes
should require coxph. Count outcomes may use poisson although one might
also consider gaussian or laplace depending on the analytical goals.

3.2 The relationship between shrinkage and number of it-

erations

The issues that most new users of gbm struggle with are the choice of n.trees
and shrinkage. It is important to know that smaller values of shrinkage (al-
most) always give improved predictive performance. That is, setting shrinkage=0.001
will almost certainly result in a model with better out-of-sample predictive per-
formance than setting shrinkage=0.01. However, there are computational
costs, both storage and CPU time, associated with setting shrinkage to be
low. The model with shrinkage=0.001 will likely require ten times as many
iterations as the model with shrinkage=0.01, increasing storage and computa-
tion time by a factor of 10. Figure 3 shows the relationship between predictive
performance, the number of iterations, and the shrinkage parameter. Note that
the increase in the optimal number of iterations between two choices for shrink-
age is roughly equal to the ratio of the shrinkage parameters. It is generally
the case that for small shrinkage parameters, 0.001 for example, there is a fairly
long plateau in which predictive performance is at its best. My rule of thumb
is to set shrinkage as small as possible while still being able to fit the model
in a reasonable amount of time and storage. I usually aim for 3,000 to 10,000
iterations with shrinkage rates between 0.01 and 0.001.

3.3 Estimating the optimal number of iterations

gbm offers three methods for estimating the optimal number of iterations after
the gbm model has been fit, an independent test set (test), out-of-bag estima-
tion (OOB), and v-fold cross validation (cv). The function gbm.perf computes
the iteration estimate.

Like Friedman’s MART software, the independent test set method uses a sin-
gle holdout test set to select the optimal number of iterations. If train.fraction
is set to be less than 1, then only the first train.fraction×nrow(data) will

7

Figure 3: Out-of-sample predictive performance by number of iterations and
shrinkage. Smaller values of the shrinkage parameter offer improved predictive
performance, but with decreasing marginal improvement.

be used to fit the model. Note that if the data are sorted in a systematic way
(such as cases for which y = 1 come first), then the data should be shuffled
before running gbm. Those observations not used in the model fit can be used
to get an unbiased estimate of the optimal number of iterations. The down-
side of this method is that a considerable number of observations are used to
estimate the single regularization parameter (number of iterations) leaving a
reduced dataset for estimating the entire multivariate model structure. Use
gbm.perf(...,method="test") to obtain an estimate of the optimal number
of iterations using the held out test set.

If bag.fraction is set to be greater than 0 (0.5 is recommended), gbm
computes an out-of-bag estimate of the improvement in predictive performance.
It evaluates the reduction in deviance on those observations not used in se-
lecting the next regression tree. The out-of-bag estimator underestimates the
reduction in deviance. As a result, it almost always is too conservative in
its selection for the optimal number of iterations. The motivation behind
this method was to avoid having to set aside a large independent dataset,

8

02000400060008000100000.1900.1950.2000.2050.210IterationsSquared error0.10.050.010.0050.001which reduces the information available for learning the model structure. Use
gbm.perf(...,method="OOB") to obtain the OOB estimate.

Lastly, gbm offers v-fold cross validation for estimating the optimal num-
ber of iterations.
If when fitting the gbm model, cv.folds=5 then gbm will
do 5-fold cross validation. gbm will fit five gbm models in order to compute
the cross validation error estimate and then will fit a sixth and final gbm
model with n.treesiterations using all of the data. The returned model ob-
ject will have a component labeled cv.error. Note that gbm.more will do
additional gbm iterations but will not add to the cv.error component. Use
gbm.perf(...,method="cv") to obtain the cross validation estimate.

Figure 4: Out-of-sample predictive performance of four methods of selecting the
optimal number of iterations. The vertical axis plots performance relative the
best. The boxplots indicate relative performance across thirteen real datasets
from the UCI repository. See demo(OOB-reps).

Figure 4 compares the three methods for estimating the optimal number
of iterations across 13 datasets. The boxplots show the methods performance
relative to the best method on that dataset. For most datasets the method
perform similarly, however, 5-fold cross validation is consistently the best of
them. OOB, using a 33% test set, and using a 20% test set all have datasets for
which the perform considerably worse than the best method. My recommen-
dation is to use 5- or 10-fold cross validation if you can afford the computing
time. Otherwise you may choose among the other options, knowing that OOB
is conservative.

9

 OOB Test 33% Test 20% 5-fold CV 0.2 0.4 0.6 0.8 1.0 Method for selecting the number of iterations Performance over 13 datasets 4 Available distributions

This section gives some of the mathematical detail for each of the distribution
options that gbm offers. The gbm engine written in C++ has access to a C++
class for each of these distributions. Each class contains methods for computing
the associated deviance, initial value, the gradient, and the constants to predict
in each terminal node.

In the equations shown below, for non-zero offset terms, replace f (xi) with

oi + f (xi).

4.1 Gaussian

Deviance

Initial value

Gradient

Terminal node estimates

4.2 AdaBoost

Deviance

Initial value

Gradient

Terminal node estimates

4.3 Bernoulli

Deviance

Initial value

Gradient

Terminal node estimates

(cid:88)

1
(cid:80) wi
f (x) =

wi(yi − f (xi))2

(cid:80) wi(yi − oi)
(cid:80) wi

zi = yi − f (xi)
(cid:80) wi(yi − f (xi))
(cid:80) wi

(cid:88)

wi exp(−(2yi − 1)f (xi))

(cid:80) yiwie−oi
(cid:80)(1 − yi)wieoi

1
(cid:80) wi
1
log
2
zi = −(2yi − 1) exp(−(2yi − 1)f (xi))
(cid:80)(2yi − 1)wi exp(−(2yi − 1)f (xi))
(cid:80) wi exp(−(2yi − 1)f (xi))

(cid:88)

wi(yif (xi) − log(1 + exp(f (xi))))

1
(cid:80) wi

−2

log

(cid:80) wiyi
(cid:80) wi(1 − yi)

zi = yi −
(cid:80) wi(yi − pi)
(cid:80) wipi(1 − pi)
where pi =

1
1 + exp(−f (xi))

1
1 + exp(−f (xi))

Notes:
(cid:136) For non-zero offset terms, the computation of the initial value requires
(cid:80) wi(yi − pi)
(cid:80) wipi(1 − pi)

Newton-Raphson. Initialize f0 = 0 and iterate f0 ← f0 +

where pi =

1
1 + exp(−(oi + f0))

.

10

4.4 Laplace

Deviance

Initial value
Gradient
Terminal node estimates medianw(z)

(cid:80) wi|yi − f (xi)|

1
(cid:80) wi
medianw(y)
zi = sign(yi − f (xi))

Notes:

(cid:136) medianw(y) denotes the weighted median, defined as the solution to the

equation

(cid:80) wiI(yi≤m)
(cid:80) wi

= 1
2

(cid:136) gbm() currently does not implement the weighted median and issues a
warning when the user uses weighted data with distribution="laplace".

4.5 Quantile regression

Contributed by Brian Kriegler (see [6]).
(cid:16)

Deviance

α (cid:80)
(1 − α) (cid:80)
w (y)

1
(cid:80) wi

yi>f (xi) wi(yi − f (xi)) +

(cid:17)
yi≤f (xi) wi(f (xi) − yi)

quantile(α)
zi = αI(yi > f (xi)) − (1 − α)I(yi ≤ f (xi))
quantile(α)

w (z)

Initial value
Gradient
Terminal node estimates

Notes:

w (y) denotes the weighted quantile, defined as the solution to

(cid:136) quantile(α)

the equation

(cid:80) wiI(yi≤q)
(cid:80) wi

= α

(cid:136) gbm() currently does not implement the weighted median and issues a

warning when the user uses weighted data with distribution=list(name="quantile").

4.6 Cox Proportional Hazard

Deviance

Gradient

−2 (cid:80) wi(δi(f (xi) − log(Ri/wi)))

zi = δi −

(cid:88)

δj

j

wjI(ti ≥ tj)ef (xi)
k wkI(tk ≥ tj)ef (xk)

(cid:80)

Initial value
0
Terminal node estimates Newton-Raphson algorithm

1. Initialize the terminal node predictions to 0, ρ = 0

2. Let p(k)

i =

(cid:80)

j I(k(j) = k)I(tj ≥ ti)ef (xi)+ρk
j I(tj ≥ ti)ef (xi)+ρk

(cid:80)

3. Let gk = (cid:80) wiδi

(cid:16)

I(k(i) = k) − p(k)

i

(cid:17)

11

4. Let H be a k × k matrix with diagonal elements
(cid:16)
1 − p(m)
i
p(n)
i

(a) Set diagonal elements Hmm = (cid:80) wiδip(m)
(b) Set off diagonal elements Hmn = − (cid:80) wiδip(m)

i

i

(cid:17)

5. Newton-Raphson update ρ ← ρ − H−1g

6. Return to step 2 until convergence

Notes:
(cid:136) ti is the survival time and δi is the death indicator.
(cid:136) Ri denotes the hazard for the risk set, Ri = (cid:80)N
(cid:136) k(i) indexes the terminal node of observation i

j=1 wjI(tj ≥ ti)ef (xi)

(cid:136) For speed, gbm() does only one step of the Newton-Raphson algorithm
rather than iterating to convergence. No appreciable loss of accuracy
since the next boosting iteration will simply correct for the prior iterations
inadequacy.

(cid:136) gbm() initially sorts the data by survival time. Doing this reduces the
computation of the risk set from O(n2) to O(n) at the cost of a single up
front sort on survival time. After the model is fit, the data are then put
back in their original order.

4.7 Poisson

Deviance

-2 1

(cid:80) wi

(cid:80) wi(yif (xi) − exp(f (xi)))
(cid:19)

Gradient

Initial value

f (x) = log

(cid:18) (cid:80) wiyi
(cid:80) wieoi
zi = yi − exp(f (xi))
(cid:80) wiyi
(cid:80) wi exp(f (xi))
The Poisson class includes special safeguards so that the most extreme pre-

Terminal node estimates

log

dicted values are e−19 and e+19. This behavior is consistent with glm().

4.8 Pairwise

This distribution implements ranking measures following the LambdaMart al-
gorithm [1]. Instances belong to groups; all pairs of items with different labels,
belonging to the same group, are used for training. In Information Retrieval
applications, groups correspond to user queries, and items to (feature vectors
of) documents in the associated match set to be ranked.

For consistency with typical usage, our goal is to maximize one of the utility
functions listed below. Consider a group with instances x1, . . . , xn, ordered such
that f (x1) ≥ f (x2) ≥ . . . f (xn); i.e., the rank of xi is i, where smaller ranks are
preferable. Let P be the set of all ordered pairs such that yi > yj.

12

Concordance: Fraction of concordant (i.e, correctly ordered) pairs. For the special case

of binary labels, this is equivalent to the Area under the ROC Curve.

(cid:40) ∥{(i,j)∈P |f (xi)>f (xj )}∥

∥P ∥

0

P ̸= ∅
otherwise.

MRR: Mean reciprocal rank of the highest-ranked positive instance (it is assumed

yi ∈ {0, 1}):

(cid:26)

1
min{1≤i≤n|yi=1}
0

∃i : 1 ≤ i ≤ n, yi = 1
otherwise.

MAP: Mean average precision, a generalization of MRR to multiple positive in-

stances:

(cid:40) (cid:80)

∥{1≤j≤i|yj =1}∥ / i

1≤i≤n|yi=1

∥{1≤i≤n|yi=1}∥

0

nDCG: Normalized discounted cumulative gain:

∃i : 1 ≤ i ≤ n, yi = 1
otherwise.

(cid:80)

(cid:80)

1≤i≤n log2(i + 1) yi
1≤i≤n log2(i + 1) y′
i

,

where y′

1, . . . , y′

n is a reordering of y1, . . . , yn with y′

1 ≥ y′

2 ≥ . . . ≥ y′
n.

The generalization to multiple (possibly weighted) groups is straightforward.
Sometimes a cut-off rank k is given for MRR and nDCG, in which case we replace
the outer index n by min(n, k).

The initial value for f (xi) is always zero. We derive the gradient of a cost
function whose gradient locally approximates the gradient of the IR measure
for a fixed ranking:

Φ =

(cid:88)

Φij

=

(i,j)∈P
(cid:88)

(i,j)∈P

|∆Zij| log

(cid:16)

1 + e−(f (xi)−f (xj ))(cid:17)

,

where |∆Zij| is the absolute utility difference when swapping the ranks of i and
j, while leaving all other instances the same. Define

λij =

∂Φij
∂f (xi)

= −|∆Zij|

1
1 + ef (xi)−f (xj )

= −|∆Zij| ρij,

13

with

ρij = −

λij
|∆Zij|

=

1
1 + ef (xi)−f (xj )

For the gradient of Φ with respect to f (xi), define

λi =

=

∂Φ
∂f (xi)
(cid:88)

λij −

(cid:88)

λji

j|(i,j)∈P
(cid:88)

= −

j|(j,i)∈P

|∆Zij| ρij

j|(i,j)∈P
(cid:88)

+

j|(j,i)∈P

|∆Zji| ρji.

The second derivative is

γi

def
=

=

∂2Φ
∂f (xi)2
(cid:88)

|∆Zij| ρij (1 − ρij)

j|(i,j)∈P
(cid:88)

+

j|(j,i)∈P

|∆Zji| ρji (1 − ρji).

Now consider again all groups with associated weights. For a given terminal

node, let i range over all contained instances. Then its estimate is

−

(cid:80)
(cid:80)

i viλi
i viγi

,

where vi = w(group(i))/∥{(j, k) ∈ group(i)}∥.

In each iteration, instances are reranked according to the preliminary scores
f (xi) to determine the |∆Zij|. Note that in order to avoid ranking bias, we
break ties by adding a small amount of random noise.

References

[1] C. Burges. From ranknet to lambdarank to lambdamart: An overview.

Microsoft Research Technical Report MSR-TR-2010-82, 2010.

[2] Y. Freund and R. E. Schapire. A decision-theoretic generalization of on-line
learning and an application to boosting. Journal of Computer and System
Sciences, 55(1):119–139, 1997.

[3] J. H. Friedman. Greedy function approximation: A gradient boosting ma-

chine. Annals of Statistics, 29(5):1189–1232, 2001.

14

[4] J. H. Friedman. Stochastic gradient boosting. Computational Statistics and

Data Analysis, 38(4):367–378, 2002.

[5] J. H. Friedman, T. Hastie, , and R. Tibshirani. Additive logistic regression:
a statistical view of boosting. Annals of Statistics, 28(2):337–374, 2000.

[6] B. Kriegler and R. Berk. Small area estimation of the homeless in los ange-
les, an application of cost-sensitive stochastic gradient boosting. Annals of
Applied Statistics, 4(3):1234–1255, 2010.

[7] G. Ridgeway. The state of boosting. Computing Science and Statistics,

31:172–181, 1999.

15


# TrajectoryGeometry

#### Anna Laddach and Michael Shapiro

#### 2025-10-30

# TrajectoryGeometry

## Introduction

The purpose of this package is to discover directionality in the changes in a time or pseudo-time series of gene expression.

A direction in N-dimensional space is a point on the (N-1)-sphere. That is, a direction in 2-dimensional space is a point on the circle (i.e., the circumference of the circle), a direction in 3-dimensional space is a point on the sphere (i.e., the surface of a solid ball), and so on in higher dimensions. A direction in 25000-dimensional gene expression space is a point on the 24999-dimensional sphere in this space.

If we have a trajectory in some space, we can look out from the starting point and follow the direction of that trajectory on the sphere as seen from our vantage point. This will give us a collection of points on the sphere. If that trajectory is moving in some well-defined direction, those points on the sphere should be close together. We’ll say more in a moment as to how to determine whether these points are close.

We illustrate here a path in 3-dimensional space, the projection of its points onto the 2-sphere and the center of a circle which minimizes mean distance to these points and the circle representing this mean distance. We can see that some of the early steps produce outliers on the sphere.

![A path and its projection to the sphere.](data:image/png;base64...)

A path and its projection to the sphere.

This approach is very general. Given gene expression data organized in a time series we can apply these methods to the gene expression, to normalized gene expression or to any chosen dimension of a principal component analysis of the data set.

## The Algorithm

### A Path gives points on a sphere

Suppose we have a matrix \(X\) with \(N\) rows and \(D\) columns. Here we consider each row as a time point and each each column as a feature which could be expression or normalized expression of a given gene or a principal component. We therefore have a path consisting of \(N\) points in \(D\) dimensional space. In our experience, biological trajectories are capable of changing direction, so we may wish to query the data for directionality starting at the \(k\)th time point. Let \(x\_i\) be the $ i$th row of \(X\). We will consider the matrix \(X'\) starting with the \(k\)th row of \(X\). We view the successive points from \(x\_k\) and consider the successive vectors \(y\_1=x\_{k+1} - x\_k\), \(y\_2=x\_{k+2} - x\_k\), …, \(y\_m=x\_{N} - x\_k\). (Thus \(m = N - k - 1\).) Taking \[p\_i = { y\_i \over
|| y\_i ||}\] gives \(m\) points on the unit sphere which represent the directionality of the path \(x\_k, \dots, x\_N\).

### How close are these points on the sphere?

We would like to measure how compactly a set of points $ p\_1,,p\_m$ sit on the sphere. To to this we would like to find a center for these points and a circle (more generally as \(N-2\) dimensional sphere) which measures their collective separation from that center. The measure of their collective distance from their center could be their median, their mean or their maximum distance from this center. The center is chosen to minimize whichever summary statistic we’re using. Distance in this context is spherical distance, i.e., the angular distance between points as viewed from the center of the sphere. That is, we take \(\mu\) to be one of the functions median, mean or max. The center is then \[C = {\mathrm{argmin}}\_x
\mu(d(x,p\_1),d(x,p\_2),\dots,d(x,p\_m))\] and \[R\_\mu = \mu(d(x,p\_1),d(x,p\_2),\dots,d(x,p\_m))\] In this way, we get a map \[X' \mapsto R\_\mu \] and we take \(R\_\mu\) as our measure of the clustering of the points \(p\_i\) and therefore of the directionality of \(X'\).

### Testing for statistical significance

We would like to test whether this clustering is statistically significant. To ask whether the points \(p\_i\) are close is to ask, close compared to what? We do this by producing \(K\) randomized paths \(Y\_1, \dots, Y\_K\) modeled on \(X'\). For each of these we compute \(R\_{\mu,i}\). A p-value for the directionality of $ X’$ comes from the ranking of \(R\_\mu\) among \(R\_{\mu,1}, \dots, R\_{\mu,K}\). If it is less than all but 5% of these, you have detected a p-value of p<0.05.

### Randomization

This package offers several methods for producing a set of randomized paths based on a path \(X\). They are roughly divided into two methods. One produces a random path by taking random steps in the ambient space of \(X\) and one produces random paths by permuting the entries in \(X\).

* Random steps. Here we produce a path starting at the same point as \(X\) and having the same number steps.
* There is an option to require the steps to have the same length as those of \(X\). This is done by including ‘preserveLengths’ in the randomization parameter. If this is omitted all steps will have length 1.

```
library(TrajectoryGeometry)
randomizationParams = c('bySteps','preserveLengths')
Y = generateRandomPaths(path=straight_path,
                        randomizationParams=randomizationParams,
                        N=10)
```

* Negative values in the randomized paths may be reasonable in the case where one is working with PCA data and can expect negative values. However, in the case of non-negative gene expression data, the randomized paths should also be non-negative and this can be accomplished by including the value ‘nonNegative’

```
randomizationParams = c('bySteps','preserveLengths','nonNegative')
Y = generateRandomPaths(path=straight_path,
                        randomizationParams=randomizationParams,
                        N=10)
```

* Permutation. Here we produce the randomized paths by permuting the entries of \(X\). This can be done either by permuting the entries of \(X\) freely or permuting values within each column spearately. The former may be appropriate in the case of PCA data or in the case of normalized gene expression data where the expression levels are fairly uniform between genes. However, in the case where different genes have significantly different expression levels, it seems appropriate to restrict to permutations which preserve columns. These operations are carried out as above using either of the following:

```
randomizationParams = c('byPermutation','permuteAsMatrix')
randomizationParams = c('byPermutation','permuteWithinColumns')
```

## Does a path confined to a direction consistently move in that direction?

The answer here is not necessarily. Consider a path which starts out at the origin and the heads out along the x-axis. Perhaps is gets a little ways out and then takes to wandering back and forth. As long as it never quite gets back to the origin, the methods we have described will show this path as highly directional. Accordingly if you have determined that your path has strong directionality using these methods, it is appropriate to check for progression in that direction. This can be done with the function pathProgression()

```
progress = pathProgression(straight_path,direction=straight_path_center)
progress = pathProgression(crooked_path,from=6,direction=crooked_path_center)
```

## Stability

A related issue which can also be checked using pathProgression() is the instability of behavior in the neighborhood of the starting point of a path. Consider a path which starts at a point \(P\_0\) and after oscillating small distances in the neighborhood of \(P\_0\) proceeds in a highly directional manner towards a point \(P\_k\). We would like to see this as a highly directional path. However, the oscillations around \(P\_0\), no matter how small, can in projection occupy large portions of the sphere. Accordingly testPathForDirectionality() may be bamboozled out of detecting directionality. A prophylaxis against this is the following:

```
direction = oscillation[nrow(straight_path),] - oscillation[1,]
progress = pathProgression(oscillation,direction=direction)
```

This will allow you to detect a portion of the path which does not depart from the neighborhood of its starting point. You can then use the from parameter of testPathForDirectionality() to eliminate these oscillations from consideration. Note that we did not need to normalize direction as that is done within pathProgression().
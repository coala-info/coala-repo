Estimating the Number of Essential Genes using
Occugene

Oliver Will

October 30, 2025

This vignette contains code from a chapter of the forthcoming book, A Oster-
man and S Gerdes. Gene Essentiality: Protocols and Bioinformatics. Humana
Press. This package has similar functionality as the R package negenes written
by Karl Broman.

Biologists have built large random mutagenesis libraries for prokaryotes. For
a description of the biology, see MA Jacobs ( et al).
(2003) Comprehensive
transposon mutant library of Pseudomonas aeruginosa. Proc Natl Acad Sci
USA. 100:14339–14344. The occugene package provides statistical tools to
help build random libraries.

We model the number of insertions per clone as a Multinomial(n, p1, . . . , pk)
random vector. The number of knockouts in the library follows the occupancy
distribution of the multinomial random variable. We compute the expected
number of genes hit if there were no essential genes.

> library("occugene")
> n <- 60
> p <- c(seq(10,1,-1),seq(10,1,-1),18)/124
> p <- p/sum(p)
> eMult(n,p)

[1] 17.74773

> varMult(n,p)

[1] 1.744004

We approximate the moments of the occupancy distribution using Monte

Carlo integration.

> eMult(n,p,iter=100,seed=4)

[1] 17.64

> varMult(n,p,iter=100,seed=4)

1

[1] 2.050909

We load an example hit table and experimental results to analyze. The
format of the hit table is different than what is used in negenes because we
wish to the track the order of insert locations.

> data(sampleAnnotation)
> data(sampleInsertions)
> print(sampleAnnotation)

idNum first last orientation
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0

2
13
23
32
40
44
50
55
59
62
64
75
85
94
102
106
112
117
121
124

11
21
30
38
45
48
53
57
60
62
73
83
92
100
107
110
115
119
122
124

1
2
3
4
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
15
16
17
18
19
20

1
2
3
4
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
15
16
17
18
19
20

> print(sampleInsertions)

position
69
2
36
34
99
33
91
113
120
8
93
35

1
2
3
4
5
6
7
8
9
10
11
12

2

13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58

11
120
52
55
122
69
121
94
90
124
62
61
84
100
58
101
63
64
68
31
111
84
58
122
56
72
49
2
116
31
67
18
113
9
113
112
91
67
49
93
112
98
99
52
17
17

3

59
60

112
92

> a.data <- sampleAnnotation
> experiment <- sampleInsertions

We estimate the number of genes that will be knocked out in the next 10

clones using the Efron and Thisted estimator.

> orf <- cbind(a.data$first,a.data$last)
> clone <- experiment$position
> etDelta(10,orf,clone)

$expected
[1] 0.1190665

$variance
[1] 0.02936508

We use the Will and Jacobs’ bootstrap to estimate the number of knockouts

made in the next 10 clones.

> orf <- cbind(a.data$first,a.data$last)
> clone <- experiment$position
> fFit(orf,clone,FALSE)

Nonlinear regression model

model: noOrfs ~ b0 - b1 * exp(-b2 * x)

data: cumul

b0

b2
12.34393 12.05475 0.06668

b1

residual sum-of-squares: 15.62

Number of iterations to convergence: 6
Achieved convergence tolerance: 7.579e-07

> unbiasDelta0(10,orf,clone,iter=10,seed=4,alpha=0.05,TR=F)

$delta0
[1] 0.2959099

$CI
[1] -0.1730529 0.5010068

We estimate the number of essential genes using the Will and Jacobs’ boot-

strap.

> unbiasB0(orf,clone,iter=10,seed=4,alpha=0.05,TR=F)

4

$b0
[1] 14.42681

$CI
[1] 10.87780 16.83998

Finally, we convert occugene’s data format into the format for negenes.

> newOrf <- occup2Negenes(orf,clone)
> print(newOrf)

n.sites n.sites2 counts counts2
0
0
0
0
0
0
0
0
0
2
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
2
0
0
0
0
0
0
0
0
0
0

10
9
8
7
4
3
4
3
2
1
10
9
8
7
4
3
4
3
2
1

5
3
0
4
0
0
2
2
0
1
7
0
4
5
0
0
6
0
3
1

1
2
3
4
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
15
16
17
18
19
20

We outlined the basic features of the occugene package in this Sweave doc-

ument.

5


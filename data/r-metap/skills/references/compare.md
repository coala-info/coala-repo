Comparison of methods in the metap package

Michael Dewey

December 18, 2025

1

Introduction

1.1 What is this document for?

This document describes some methods for the meta–analysis of p–values
(signiﬁcance values) contained in the package metap and contains comments
on the performance of the various algorithms under a small number of dif-
ferent scenarios with hints on the choice of method.

1.2 Notation

The k studies give rise to p–values, pi, i = 1, . . . , k. These are assumed to
be independent. We shall also need the ordered p–values: p[1] ≤
≤
p[k] and weights wi, i = 1, . . . , k. Logarithms are natural. A function for
combining p–values is denoted g. The size of the test is α. We may also need
k degrees of freedom, νi.

p[2], . . . ,

The methods are referred to by the name of the function in metap. Table 1
shows other descriptions of each method.

2 Theoretical results

There have been various attempts to clarify the problem and to discuss op-
timality of the methods. A detailed account was provided by Lipták (1958).

Birnbaum (1954) considered the property of admissibility. A method is ad-
missible if when it rejects H0 for a set of pi it will also reject H0 for P ∗i where
pi for all i. He considered that Fisher’s and Tippett’s method were
p∗i ≤
admissible. See also Owen (2009).

1

Function name

Description(s)

invchisq
invt
logitp
meanp
meanz
maximump
minimump
sumlog
sump
sumz
truncated
truncated
votep
wilkinsonp

Eponym
Lancaster’s method

Inverse chi square
Inverse t
Logistic

Tippett’s method
Fisher’s method
Edgington’s method Uniform
Normal
Stouﬀer’s method
Truncated Fisher

Chi square (2 df)

rank–truncated

Wilkinson’s method

Table 1: Methods considered in this document

He also points out the problem is poorly speciﬁed. This may account for
the number of methods available and their diﬀering behaviour. The null
hypothesis H0 is well deﬁned, that all pi have a uniform distribution on the
unit interval. There are two classes of alternative hypothesis

• HA: all pi have the same (unknown) non–uniform, non–increasing den-

sity,

• HB: at least one pi has an (unknown) non–uniform, non–increasing

density.

If all the tests being combined come from what are basically replicates then
HA is appropriate whereas if they are of diﬀerent kinds of test or diﬀerent
conditions then HB is appropriate. Note that Birnbaum speciﬁcally consid-
ers the possibility that the tests being combined may be very diﬀerent for
instance some tests of means, some of variances, and so on.

3 The methods

3.1 Comparison scenarios

To provide a standard of comparison we shall use the following two situations.
Some authors have also used the case of exactly two pi.

2

What if all pi = p? Perhaps surprisingly there are substantial diﬀerences
here as we shall see when we look at each method. We shall describe
how the returned value varies with p and k.

Cancellation When the collection of primary studies contains a number of
values signiﬁcant in both directions the methods can give very diﬀerent
results.
If the intention of the synthesis is to examine a directional
hypothesis one would want a method where these cancelled out. The
decision between methods should be made on theoretical grounds of
course. We shall use the following four values as our example.

> cancel <- c(0.001, 0.001, 0.999, 0.999)

3.2 Methods using transformation of the p–values

One class of methods relies on transforming the p–values ﬁrst.

Function name Deﬁnition

Critical value

invchisq

invt

logitp

meanz

sumlog

sumz

νi(pi)

k
i=1 χ2
P
k
i=1 tνi (pi)
P
νi
k
i=1
−2
qP
νi
i=1 log p
k
1−p
P
C

where C = q

kπ2(5k+2)
3(5k+4)

k
i=1

z(pi)
k

¯z
s¯z
where ¯z =
P
and s¯z = sz
√k
2 log pi

k
i=1 −
P
k
i=1 z(pi)
P
√k

νi(α)

χ2
P
z(α)

t5k+4

1(α)

tk

−

χ2k(α)

z(α)

Table 2: Deﬁnitions of methods using transformation of the p values

3.2.1 The method of summation of logs, Fisher’s method

2 and the
See Table 2 for the deﬁnition. This works because
sum of χ2 is itself a χ2 with degrees of freedom equal to the sum of the
degrees of freedom of the individual χ2. Of course the sum of the log of the
pi is also the log of the product of the pi. Fisher’s method (Fisher, 1925) is
provided in sumlog.

2 log pi is a χ2

−

As can be seen in Figure 1 when all the pi = p sumlog returns a value
which decreases with k when p < 0.32, increases with k when p > 0.37,

3

and in between increases with k and then decreases. Some detailed algebra
provided in a post to https://stats.stackexchange.com/questions/243003 by
1 = 0.3679. Where the pi
Christoph Hanck suggests that the breakpoint is e−
are less than this then for a suﬃciently large k (several hundred) the result
will be signiﬁcant and not if above that. Over the range of k we are plotting
this bound is not yet closely approached.

Figure 1: Behaviour of the methods using transformed p values for k values
of p = pi

3.2.2

Inverse χ2 Lancaster’s method

It would of course be possible to generalise Fisher’s method to use transfor-
mation to χ2 with any other number of degrees of freedom rather than 2.
Lancaster (1961) suggests that this is highly correlated with sumlog. Lan-
caster’s method is provided in invchisq. In fact the resemblance to sumlog
becomes less as the number of degrees of freedom increases. Figure 2a shows
for a small number of selected degrees of freedom how it compares to Fisher’s
method.

3.2.3 The method of summation of z values, Stouﬀer’s method

The method of summation of z values is provided in sumz (Stouﬀer et al.,
1949). See Table 2 for the deﬁnition. As can be seen in Figure 1 it returns
a value for our pi = p example which decreases with k when p below 0.5 and
increases above.

k
i=1 wiz(pi)
A weighted version of Stouﬀer’s method is available P
√
i=1 w2

k

i

where wi are

the weights.
In the absence of eﬀect sizes (in which case a method using
eﬀect sizes would be more appropriate anyway) best results are believed to

P

4

kg(p)0.00.20.40.60.81.05101520logitpmeanzsumlog51015200.00.20.40.60.81.0sumzp0.20.30.36790.40.50.6(a) Fisher’s method and Lancaster’s method

(b) Stouﬀer’s method and inverse t

Figure 2: Sum and diﬀerence plots of Fisher v Lancaster and Stouﬀer v
inverse t

be obtained with weights proportional to the square root of the sample sizes
(Zaykin, 2011) following Lipták (1958).

3.2.4 Mean of normals method

There is also a method closely related to Stouﬀer’s using the mean of normals
provided in meanz also deﬁned in Table 2 which has very similar properties
except that when all the pi are equal it either gives 0 or 1 as can be seen in
Figure 1.

> meanz(c(0.3, 0.31))$p

[1] 5.581505e-280

> meanz(c(0.1, 0.2))$p

[1] 6.959644e-07

The method of meanz also has the unusual property that a set of p–values
which are all less than those in another set can still give rise to a larger
overall p. See example above. This is the only method considered here which
has this property so if it is a desirable one then that is the only method to
consider.

5

sumdiff−0.20.00.20.00.51.01.52.0FL4FL160.00.51.01.52.0FL256L4L160.00.51.01.52.0L4L256−0.20.00.2L16L256sumdiff−0.2−0.10.00.10.20.51.01.52.0St4St160.51.01.52.0St256t4t160.51.01.52.0t4t256−0.2−0.10.00.10.2t16t2563.2.5 The inverse t method

A closely related method is the inverse t method. See Table 2 for the def-
inition. This method is provided in invt. As is clear from the deﬁnition
this method tends to Stouﬀer’s method as νi
. Figure 2b shows this for
selected degrees of freedom.

→ ∞

3.2.6 The method of summation of logits

See Table 2 for the deﬁnition. This method is provided in logitp. The
constant C was arrived at by equating skewness and kurtosis with that of
the t–distribution (Loughin, 2004). As can be seen in Figure 1 this method
returns a value for our pi = p example which decreases with k when p below
0.5 and increases above.

3.2.7 Examples for methods using transformations of the p values

Function name

validity
value expressed

cancel

logitp
meanz
sumlog
sumz

as

−

15.4
11.09
15.52
15.87

log10 p

0.5
0.5
0.00055
0.5

Table 3: Examples of methods using transformation of the p values

Using the same example dataset which we have already plotted and our
cancellation dataset we have the values in Table 3. As can be seen all the
methods cancel except for sumlog. The agreement for the validity dataset is
close except for meanz whoch gives a value several orders of magnitude greater
than the other three. Lancaster’s method and inverse t are not shown as they
are both inﬁnite families of possible methods and in any event are similar to
Fisher’s method and Stouﬀer’s method respectively.

3.3 Methods using untransformed p–values

3.3.1 The method of minimum p, maximum p, and Wilkinson’s

method

The methods of minimum p (Tippett, 1931), maximum p and Wilkinson
(Wilkinson, 1951) are deﬁned in Table 4. Wilkinson’s method depends on
which value (the rth) of p[i] is selected. Wilkinson’s method is provided

6

Function name Deﬁnition

Critical value

meanp

minimump
maximump
wilkinsonp

sump

−

k
i=1 pi
¯p = P
k
z = (0.5
p[1]
p[k]
p[r]
(S)k
k
k! − (cid:0)
1(cid:1)
where S =

¯p)√12k

z(α)
1
−
αk

(1

1
k

α)

−

k
s=r (cid:0)

k
s(cid:1)

αs(1

−

α)k

−

s

k
2(cid:1)

(S

2)k
−
k! −

P
. . . α

(S

1)k
k! +
−
(cid:0)
k
i=1 pi

P

Table 4: Deﬁnitions of methods not using transformation of the p values, the
i) becomes
series for sump continues until the term in in the numerator (S
negative

−

Figure 3: Behaviour of the methods using untransformed p values for k values
of p = pi

7

kg(p)0.00.20.40.60.81.05101520maximumpmeanp5101520minimumpsump51015200.00.20.40.60.81.0votepp0.20.30.36790.40.50.6in wilkinsonp and a convenience function minimump with its own print
method is provided for the minimum p method (r = 1). It is also possible
to use the method for the maximum p (that is r = k) and a convenience
function maximump is provided for that purpose.

As can be seen in Figure 3 these methods return a value for our pi = p
example which always increases with k which is true for minimump and which
always decreases with k which is true for maximump

3.3.2 The method of summation of p–values, Edgington’s method

Deﬁned in Table 4 (Edgington, 1972a). This method is provided in sump. As
can be seen in Figure 3 this method returns a value for our pi = p example
which decreases with k when p below 0.5 and increases above.

p)k
Some authors use a simpler version, (
, for instance Rosenthal (1978) in
P
k!
the text although compare his Table 4. This can be very conservative when
p > 1 There seems no particular need to use this method but it is returned
P
by sump as the value of conservativep for use in checking published values.

Note also that there can be numerical problems for extreme values of S and
in that case recourse might be made to meanp which has similar properties.

3.3.3 The mean p method

Deﬁned in Table 4. Although this method is attributed to Edgington (Edg-
ington, 1972b) when the phrase Edgington’s method is used it refers to the
method of summation of p–values described above in Section 3.3.2. As can
be seen in Figure 3 this method returns a value for our pi = p example which
decreases with k when p below 0.5 and increases above.

Not surprisingly this method gives very similar results to Edington’s other
method implemented in sump and since it does not have the numerical prob-
lems of that method it might perhaps be preferred.

3.3.4 Examples for methods using untransformed p–values

Using the same example dataset which we have already plotted and our
cancellation dataset we have the values in Table 5. As can be seen meanp
and sump cancel but the other two do not. Agreement here is not so good
especially for the maximum p method. Wilkinson’s method not shown as it
depends on the value of r.

8

Function name

cancel

validity
value expressed

as

−

log10 p

minimump
maximump
meanp
sump

4.22
2.63
8.62
10.63

0.00399
0.99601
0.5
0.5

Table 5: Examples for methods using the untransformed p values

3.4 Other methods

3.4.1 The method of vote–counting

A simple way of looking at the problem is vote counting. Strictly speak-
ing this is not a method which combines p–values in the same sense as the
other methods.
If most of the studies have produced results in favour of
the alternative hypothesis irrespective of whether any of them is individually
signiﬁcant then that might be regarded as evidence for that alternative. The
numbers for and against may be compared with what would be expected un-
der the null using the binomial distribution. A variation on this would allow
for a neutral zone of studies which are considered neither for nor against. For
instance one might only count studies which have reached some conventional
level of statistical signiﬁcance in the two diﬀerent directions.

This method returns a value for our pi = p example which is 1 for p values
above 0.5 and otherwise invariant with p but decreases with k. This method
does cancel signiﬁcant values in both directions.

Function name validity

cancel

votep

0.000201

0.6875

Table 6: Examples for vote counting

3.4.2 Methods not using all p–values

If there is a hypothesis that the signal will be concentrated in only a few
p–values then alternative methods are available in truncated. This is a
wrapper to two packages available on CRAN: TFisher which provides the
truncated Fisher method (Zaykin et al., 2007; Zhang et al., 2018) and mutoss
which provides the rank–truncated Fisher method (Dudbridge and Koele-
man, 2003). Note that Table 7 only shows results for the validity data–set

9

as, since the methods explicitly only consider results in one direction the
cancellation issue does not arise.

Function name

truncated at p = 0.5

truncated at rank = 5

truncated

15.48

8.06

Table 7: Examples for truncated using the validity data–set expressed as

log10 p

−

These methods are appropriate for the situation where it is known that many
of the p–values are noise and there will only be a few signals.

4 Loughin’s recommendations

In his simulation study Loughin (2004) carried out extensive comparisons.
Note that he did not consider all the methods implemented here. These
omissions are not too important for our purposes. The methods implemented
here as invchisq, invt, meanp and meanz are all very similar to ones which
he did study. The truncation methods appeared about the same time as his
work but in any case are fundamentally diﬀerent. Vote counting is arguably
not a method of the same sort.

As Loghin points out the ﬁrst thing to consider is whether large p–values
should cancel small ones.
If this is not desired then the only methods to
consider are those in sumlog (Fisher), minimump (Tippett) and maximump.

Figure 4: Loughin’s recommendations based on structure

He bases his recommendations on criteria of structure and the arrangement

10

Whatisstructure?sumlog (Fisher)minimump (Tippett)Emphasise small p-valuessump (Edgington)maximumpEmphasise large p-valuessumz (Stouffer)logitpEmphasise p-values equallyof evidence against H0. Figure 4 shows a summary of his recommendations
about the structure of the evidence.

Figure 5: Loughin’s recommendations based on where the strength of the
evidence is located

Figure 5 summarise his recommendations about the arrangement of evidence.

Overall he considered the choice to lie between Stouﬀer’s method, Fisher’s
method and the logistic method implemented in logitp. As has already
been mentioned Fisher’s method cancels whereas the other two do not so if
the weak evidence in a small number of p–values is not to be over–whelmed
by the others then Fisher is the best choice. However where the evidence is
more evenly spread Stouﬀer’s method may be preferred. The logistic method
represents a compromise between them and is perhaps best suited where
the pattern of evidence is not clear in advance. The other methods are not
universally ruled out and may be helpful in the speciﬁc circumstance outlined
in his summaries.

References

A Birnbaum. Combining independent tests of signiﬁcance. Journal of the

American Statistical Association, 49:559–574, 1954.

F Dudbridge and B P C Koeleman. Rank truncated product of p–values,

11

sump (Edgington)maximumpsumz (Stouffer)logitpsump (Edgington)maximumpsumz (Stouffer)logitpsumz (Stouffer)logitpsumlog (Fisher)sumz (Stouffer)logitpminimump (Tippett)sumlog (Fisher)sumz (Stouffer)logitpLocationofevidenceIn the majorityNofstudiesEqually in allNofstudiesSome in allStrengthofevidenceIn the minorityStrengthoftotal evidenceIn one test only< 10any< 10anyModerate or strongAny powerStrong total evidenceModerate total evidenceWeak total evidencewith application to genomewide association scans. Genetic Epidemiology,
25:360–366, 2003.

E S Edgington. An additive method for combining probability values from

independent experiments. Journal of Psychology, 80:351–363, 1972a.

E S Edgington. A normal curve method for combining probability values
from independent experiments. Journal of Psychology, 82:85–89, 1972b.

R A Fisher. Statistical methods for research workers. Oliver and Boyd,

Edinburgh, 1925.

H Lancaster. The combination of probabilities: an application of orthonormal

functions. Australian Journal of Statistics, 3:20–33, 1961.

T Lipták. On the combination of independent tests. A Magyar Tudományos
Akadémia Matematikai Kutató Intézetének Közleményi, 3:171–197, 1958.

T M Loughin. A systematic comparison of methods for combining p–values
from independent tests. Computation Statistics and Data Analysis, 47:
467–485, 2004.

A B Owen. Karl Pearson’s meta–analysis revisited. Annals of Statistics, 37:

3867–3892, 2009.

R Rosenthal. Combining results of independent studies. Psychological Bul-

letin, 85:185–193, 1978.

S A Stouﬀer, E A Suchman, L C DeVinney, S A Star, and R M Jnr Williams.
The American soldier, vol 1: Adjustment during army life. Princeton
University Press, Princeton, 1949.

L H C Tippett. The methods of statistics. Williams and Norgate, London,

1931.

B Wilkinson. A statistical consideration in psychological research. Psycho-

logical Bulletin, 48:156–158, 1951.

D V Zaykin. Optimally weighted z–test is a powerful method for combining
probabilities in meta–analysis. Journal of Evolutionary Biology, 24:1836–
1841, 2011.

D V Zaykin, L A Zhivotovsky, W Czika, S Shao, and R D Wolﬁnger. Combin-
ing p–values in large–scale genomics experiments. Pharmaceutical Statis-
tics, 6:217–236, 2007.

12

H Zhang, T Tong, J Landers, and Z Wu. TFisher tests: optimal and adaptive
thresholding for combining p–values. arXiv, 2018. URL arXiv:1801.
04309.

13


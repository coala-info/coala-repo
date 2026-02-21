Proximity measures in the proxy package for R

David Meyer

December 29, 2025

1 Similarities

Aliases: Jaccard, binary, Reyssac, Roux
Type
Formula: a / (a + b + c)

: binary

Aliases: Kulczynski1
Type
Formula: a / (b + c)

: binary

Aliases: Kulczynski2
Type
Formula: [a / (a + b) + a / (a + c)] / 2

: binary

Aliases: Mountford
Type
Formula: 2a / (ab + ac + 2bc)

: binary

Aliases: Fager, McGowan
Type
: binary
Formula: a / sqrt((a + b)(a + c)) - sqrt(a + c) / 2

Aliases: Russel, Rao
Type
Formula: a / n

: binary

Aliases: simple matching, Sokal/Michener
Type
Formula: (a + d) / n

: binary

Aliases: Hamman
: binary
Type
Formula: ([a + d] - [b + c]) / n

Aliases: Faith

1

: binary
Type
Formula: (a + d/2) / n

Aliases: Tanimoto, Rogers
Type
Formula: (a + d) / (a + 2b + 2c + d)

: binary

Aliases: Dice, Czekanowski, Sorensen
Type
Formula: 2a / (2a + b + c)

: binary

Aliases: Phi
Type
Formula: (ad - bc) / sqrt[(a + b)(c + d)(a + c)(b + d)]

: binary

Aliases: Stiles
Type
: binary
Formula: log(n(|ad-bc| - 0.5n)^2 / [(a + b)(c + d)(a + c)(b + d)])

Aliases: Michael
Type
Formula: 4(ad - bc) / [(a + d)^2 + (b + c)^2]

: binary

Aliases: Mozley, Margalef
Type
Formula: an / (a + b)(a + c)

: binary

Aliases: Yule
Type
Formula: (ad - bc) / (ad + bc)

: binary

Aliases: Yule2
Type
Formula: (sqrt(ad) - sqrt(bc)) / (sqrt(ad) + sqrt(bc))

: binary

Aliases: Ochiai
Type
: binary
Formula: a / sqrt[(a + b)(a + c)]

Aliases: Simpson
Type
Formula: a / min{(a + b), (a + c)}

: binary

Aliases: Braun-Blanquet
Type
: binary
Formula: a / max{(a + b), (a + c)}

2

Aliases: cosine
Type
: metric
Formula: xy / sqrt(xx * yy)

Aliases: angular
Type
Formula: 1 - acos(xy / sqrt(xx * yy)) / pi

: metric

Aliases: eJaccard, extended_Jaccard
Type
Formula: xy / (xx + yy - xy)

: metric

Aliases: eDice, extended_Dice, eSorensen
Type
Formula: 2xy / (xx + yy)

: metric

Aliases: correlation
Type
Formula: xy / sqrt(xx * yy) for centered x,y

: metric

Aliases: Chi-squared
Type
Formula: sum_ij (o_i - e_i)^2 / e_i

: nominal

Aliases: Phi-squared
Type
Formula: [sum_ij (o_i - e_i)^2 / e_i] / n

: nominal

Aliases: Tschuprow
Type
Formula: sqrt{[sum_ij (o_i - e_i)^2 / e_i] / n / sqrt((p - 1)(q - 1))}

: nominal

Aliases: Cramer
Type
Formula: sqrt{[Chi / n)] / min[(p - 1), (q - 1)]}

: nominal

Aliases: Pearson, contingency
Type
Formula: sqrt{Chi / (n + Chi)}

: nominal

Aliases: Gower
Type
Formula: Sum_k (s_ijk * w_k) / Sum_k (d_ijk * w_k)

: NA

3

2 Dissimilarities

Aliases: Euclidean, L2
Type
: metric
Formula: sqrt(sum_i (x_i - y_i)^2))

Aliases: Mahalanobis
Type
Formula: sqrt((x - y) Sigma^(-1) (x - y))

: metric

Aliases: Bhjattacharyya
Type
: metric
Formula: sqrt(sum_i (sqrt(x_i) - sqrt(y_i))^2))

Aliases: Manhattan, City-Block, L1, taxi
Type
Formula: sum_i |x_i - y_i|

: metric

Aliases: supremum, max, maximum, Tschebyscheff, Chebyshev
Type
Formula: max_i |x_i - y_i|

: metric

Aliases: Minkowski, Lp
Type
: metric
Formula: (sum_i (x_i - y_i)^p)^(1/p)

Aliases: Canberra
Type
Formula: sum_i |x_i - y_i| / |x_i + y_i|

: metric

Aliases: Wave, Hedges
Type
: metric
Formula: sum_i (1 - min(x_i, y_i) / max(x_i, y_i))

Aliases: divergence
Type
Formula: sum_i (x_i - y_i)^2 / (x_i + y_i)^2

: metric

Aliases: Kullback, Leibler
Type
Formula: sum_i [x_i * log((x_i / sum_j x_j) / (y_i / sum_j y_j)) / sum_j x_j)]

: metric

Aliases: Bray, Curtis
Type
: metric
Formula: sum_i |x_i - y_i| / sum_i (x_i + y_i)

4

Aliases: Soergel
Type
Formula: sum_i |x_i - y_i| / sum_i max{x_i, y_i}

: metric

Aliases: Levenshtein
Type
: other
Formula: Number of insertions, edits, and deletions between to strings

Aliases: Podani, discordance
Type
Formula: 1 - 2 * (a - b + c - d) / (n * (n - 1))

: metric

Aliases: Chord
Type
Formula: sqrt(2 * (1 - xy / sqrt(xx * yy)))

: metric

Aliases: Geodesic
Type
Formula: arccos(xy / sqrt(xx * yy))

: metric

Aliases: Whittaker
Type
Formula: sum_i |x_i / sum_i x - y_i / sum_i y| / 2

: metric

Aliases: Hellinger
Type
Formula: sqrt(sum_i (sqrt(x_i / sum_i x) - sqrt(y_i / sum_i y)) ^ 2)

: metric

Aliases: fJaccard, fuzzy_Jaccard
Type
Formula: sum_i (min{x_i, y_i} / max{x_i, y_i})

: metric

5


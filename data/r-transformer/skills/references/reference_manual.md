Package ‘transformer’

July 22, 2025

Title Implementation of Transformer Deep Neural Network with Vignettes

Version 0.2.0

Description Transformer is a Deep Neural Network Architecture based i.a. on the Attention mecha-

nism (Vaswani et al. (2017) <doi:10.48550/arXiv.1706.03762>).

License MIT + file LICENSE

Encoding UTF-8

RoxygenNote 7.2.3

Imports attention (>= 0.4.0)

Suggests covr, testthat (>= 3.0.0)

Config/testthat/edition 3

NeedsCompilation no

Author Bastiaan Quast [aut, cre] (ORCID:

<https://orcid.org/0000-0002-2951-3577>)

Maintainer Bastiaan Quast <bquast@gmail.com>

Repository CRAN

Date/Publication 2023-11-10 12:30:02 UTC

Contents

feed_forward .
.
layer_norm .
.
multi_head .
.
.
row_means
.
.
row_vars .
.
.
transformer

.

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

.
.
.
.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
2
3
3
4
4

6

Index

1

2

layer_norm

feed_forward

Feed Forward Layer

Description

Feed Forward Layer

Usage

feed_forward(x, dff, d_model)

Arguments

x

dff

inputs

dimensions of feed-forward model

d_model

dimensions of the model

Value

output of the feed-forward layer

layer_norm

Layer Normalization

Description

Layer Normalization

Usage

layer_norm(x, epsilon = 1e-06)

Arguments

x

epsilon

Value

inputs

scale

outputs of layer normalization

multi_head

3

multi_head

Multi-Headed Attention

Description

Multi-Headed Attention

Usage

multi_head(Q, K, V, d_model, num_heads, mask = NULL)

Arguments

Q
K
V
d_model
num_heads
mask

Value

queries
keys
values
dimensions of the model
number of heads
optional mask

multi-headed attention outputs

row_means

Row Means

Description

Row Means

Usage

row_means(x)

Arguments

x

Value

matrix

vector with the mean of each of row of the input matrix

Examples

row_means(t(matrix(1:5)))

4

transformer

row_vars

Row Variances

Description

Row Variances

Usage

row_vars(x)

Arguments

x

Value

matrix

vector with the variance of each of row of the input matrix

Examples

row_vars(t(matrix(1:5)))

transformer

Transformer

Description

Transformer

Usage

transformer(x, d_model, num_heads, dff, mask = NULL)

Arguments

x

d_model

num_heads

dff

mask

Value

inputs

dimensions of the model

number of heads

dimensions of feed-forward model

optional mask

output of the transformer layer

transformer

Examples

x <- matrix(rnorm(50 * 512), 50, 512)
d_model <- 512
num_heads <- 8
dff <- 2048

output <- transformer(x, d_model, num_heads, dff)

5

Index

feed_forward, 2

layer_norm, 2

multi_head, 3

row_means, 3
row_vars, 4

transformer, 4

6


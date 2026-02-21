# DoRothEA regulons.

Pau Badia i Mompel1\*

1Institute for Computational Biomedicine, Heidelberg University

\*pau.badia@uni-heidelberg.de

#### 4 November 2025

#### Package

dorothea 1.22.0

# Contents

* [1 Introduction](#introduction)
* [2 Activity estimation](#activity-estimation)
* [3 Load](#load)
* [4 Exploration](#exploration)
* [5 CollecTRI](#collectri)

# 1 Introduction

DoRothEA is a gene regulatory network (GRN) containing signed transcription factor
(TF) - target gene interactions. DoRothEA regulons, the collection of TFs and
their transcriptional targets, were curated and collected from different types of
evidence for both human and mouse.

![](data:image/png;base64...)

For each TF-target interaction we assigned a confidence level based on the
number of supporting evidence. The confidence assignment comprises five levels,
ranging from A (highest confidence) to E (lowest confidence). Interactions that
are supported by all four lines of evidence, manually curated by experts in
specific reviews, or supported both in at least two curated resources are
considered to be highly reliable and were assigned an A level. Level B-D are
reserved for curated and/or ChIP-seq interactions with different levels of
additional evidence. Finally, E level is used for interactions that are
uniquely supported by computational predictions. To provide the most confident
regulon for each TF, we aggregated the TF-target interactions with the highest
possible confidence score that resulted in a regulon size equal to or greater
than ten targets. The final confidence level assigned to the TF regulon is the
lowest confidence score of its component targets.

# 2 Activity estimation

DoRothEA regulons can be coupled with any statistical method to infer TF
activities from bulk or single-cell transcriptomics.
In this vignette we just show how to access these regulons and some of their
properties. To infer TF activities, please check out
[decoupleR](https://doi.org/10.1093/bioadv/vbac016), available in
[R](https://saezlab.github.io/decoupleR/) or
[python](https://github.com/saezlab/decoupler-py).

# 3 Load

First we load the necessary packages:

```
library(dorothea)
library(decoupleR)
library(ggplot2)
library(dplyr)
```

Here is how to retrieve all regulons from human:

```
net <- decoupleR::get_dorothea(levels = c('A', 'B', 'C', 'D'))
head(net)
#> # A tibble: 6 × 4
#>   source confidence target   mor
#>   <chr>  <chr>      <chr>  <dbl>
#> 1 MYC    A          TERT    1
#> 2 JUN    D          SMAD3   0.25
#> 3 SMAD3  A          JUN     1
#> 4 JUN    D          SMAD4   0.25
#> 5 SMAD4  A          JUN     1
#> 6 RELA   D          FAS     0.25
```

Here we can observe some of the target genes for the TF ADNP. We can see their
confidence level, in this case D, and their mode of regulation, in this case
positive. To better estimate TF activities, we recommend to select regulons from
the confidence levels A, B and C.

# 4 Exploration

We can observe the total number of genes per TF:

```
n_genes <- net %>%
  group_by(source) %>%
  summarize(n = n())

ggplot(data=n_genes, aes(x=n)) +
  geom_density() +
  theme(text = element_text(size=12)) +
  xlab('Number of target genes') +
  ylab('densities') +
  theme_bw() +
  theme(legend.position = "none")
```

![](data:image/png;base64...)

The majority of TFs have around 20 target genes, but there are some that reach
more than 1000.

Additionally, we can visualize how many edges each confidence level adds:

```
n_edges <- net %>%
  group_by(confidence) %>%
  summarize(n = n())

ggplot(data=n_edges, aes(x=confidence, y=log10(n), color=confidence, fill=confidence)) +
  geom_bar(stat="identity") +
  theme(text = element_text(size=12)) +
  xlab('Confidence') +
  ylab('log10(Number of edges)') +
  theme_bw() +
  theme(legend.position = "none")
```

![](data:image/png;base64...)

Each confidence level contributes around 10,000 TF - target relationships, B
and E being the exceptions.

We can also check how many TFs are repressors, TFs with most of their edges with
negative mode of regulation (`mor`), and how many are activators, TFs with most
of their edges with positive `mor`:

```
prop <- net %>%
  mutate(mor = case_when(mor < 0 ~ -1, mor > 0 ~ 1)) %>%
  group_by(source, mor) %>%
  summarize(n = n()) %>%
  mutate(freq = n / sum(n)) %>%
  filter(mor == 1)
#> `summarise()` has grouped output by 'source'. You can override using the
#> `.groups` argument.

ggplot(data=prop, aes(x=freq)) +
  geom_density() +
  theme(text = element_text(size=12)) +
  xlab('% of positive edges') +
  ylab('densities') +
  theme_bw() +
  theme(legend.position = "none")
```

![](data:image/png;base64...)

Most TFs in DoRothEA are activators, but there are also some of them that
are repressors.

# 5 CollecTRI

Recently, we have released a new literature based GRN with increased coverage and better
performance at identifying perturbed TFs, called [CollecTRI](https://github.com/saezlab/CollecTRI).
We encourage users to use CollecTRI instead of DoRothEA. Vignettes on how to
obtain activities are available at the [decoupleR package](https://saezlab.github.io/decoupleR/).

Here’s how to access it. The argument `split_complexes` keeps complexes or
splits them into subunits, by default we recommend to keep complexes together.

```
net <- decoupleR::get_collectri(split_complexes = FALSE)
#> Warning in OmnipathR::import_tf_mirna_interactions(genesymbols = TRUE, resources = "CollecTRI", : 'OmnipathR::import_tf_mirna_interactions' is deprecated.
#> Use 'tf_mirna' instead.
#> See help("Deprecated")
#> Warning in readLines(con = path, encoding = encoding): incomplete final line
#> found on 'https://omnipathdb.org/resources'
head(net)
#> # A tibble: 6 × 3
#>   source target   mor
#>   <chr>  <chr>  <dbl>
#> 1 MYC    TERT       1
#> 2 SPI1   BGLAP      1
#> 3 SMAD3  JUN        1
#> 4 SMAD4  JUN        1
#> 5 STAT5A IL2        1
#> 6 STAT5B IL2        1
```

We can observe the total number of genes per TF:

```
n_genes <- net %>%
  group_by(source) %>%
  summarize(n = n())

ggplot(data=n_genes, aes(x=n)) +
  geom_density() +
  theme(text = element_text(size=12)) +
  xlab('Number of target genes') +
  ylab('densities') +
  theme_bw() +
  theme(legend.position = "none")
```

![](data:image/png;base64...)

Similarly to DoRothEA, the majority of TFsin CollecTRI have around 20 target genes, but
there are some that reach more than 1000.

We can also check how many TFs are repressors, TFs with most of their edges with
negative mode of regulation (`mor`), and how many are activators, TFs with most
of their edges with positive `mor`:

```
prop <- net %>%
  mutate(mor = case_when(mor < 0 ~ -1, mor > 0 ~ 1)) %>%
  group_by(source, mor) %>%
  summarize(n = n()) %>%
  mutate(freq = n / sum(n)) %>%
  filter(mor == 1)
#> `summarise()` has grouped output by 'source'. You can override using the
#> `.groups` argument.

ggplot(data=prop, aes(x=freq)) +
  geom_density() +
  theme(text = element_text(size=12)) +
  xlab('% of positive edges') +
  ylab('densities') +
  theme_bw() +
  theme(legend.position = "none")
```

![](data:image/png;base64...)

As seen in DoRothEA, Most TFs in CollecTRI are also activators.
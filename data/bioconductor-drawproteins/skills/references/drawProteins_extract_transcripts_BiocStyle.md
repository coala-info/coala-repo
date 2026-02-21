# Using extract\_transcripts in drawProteins

Dr Paul Brennan

#### 2026-02-03

#### Package

drawProteins 1.30.0

# Contents

* [1 Introducing extract\_transcripts() in drawProteins](#introducing-extract_transcripts-in-drawproteins)
* [2 Making a new dataframe with each transcript separated](#making-a-new-dataframe-with-each-transcript-separated)
* [3 Session info](#session-info)

# 1 Introducing extract\_transcripts() in drawProteins

Many proteins are present as alternate transcripts where the same gene is
produces alternative forms of the protein through differential mRNA splicing or
post-translational cleavage.

These are detailed in UniProt. When they are extracted by the UniProt API, it
gives lists of alternative forms followed by lists of features. In order to
plot each protein and the appropriate features, these need to be separated in
our dataframe. This is done using the `extract_transcripts()` function.

This Vignette shows how this works and gives an example.

The workflow using extract\_transcripts() is:

1. to provide one or more Uniprot IDs
2. get a list of features from the Uniprot API
3. run `extract_transcripts()` to generate a new dataframe
4. draw the chains and features as desired

Steps 1 and 2 are illustrated in drawProteins Vignette so only step3 and the
visualisation of step 4 will be shown here.

# 2 Making a new dataframe with each transcript separated

The NFkappaB transcription factor family contains two proteins that are present
in two forms. The dataframe obtained from Uniprot is contained in the
drawProtein package as “five\_rel\_data” and can be loaded using the `data()`
function.

When loaded this has 320 obs of 9 variables and will plot five chains as
shown by checking the `max(five_rel_data$order)` function.

To plot all the transcripts, a new dataframe is produced using the
`extact_transcripts()` function. The new dataframe is called prot\_data and
has 430 obs of 9 variables and will plot seven chains as shown by checking
the `max(prot_data$order)` function.

```
# load up data for five NF-kappaB proteins
data("five_rel_data")
max(five_rel_data$order)
```

```
[1] 5
```

```
# returns 5

# use extract_transcripts() to create a new data frame
prot_data <- extract_transcripts(five_rel_data)
max(prot_data$order)
```

```
[1] 7
```

```
# returns 7
```

Now, let’s check out the chains for the two objects for comparison purposes.

```
p1 <- draw_canvas(five_rel_data)
p1 <- draw_chains(p1, five_rel_data)
p1 <- p1 + ggtitle("Five chains plotted")

p2 <- draw_canvas(prot_data)
p2 <- draw_chains(p2, prot_data)
p2 <- p2 + ggtitle("Seven chains plotted")

p1
```

![](data:image/png;base64...)

```
p2
```

![](data:image/png;base64...)

The appropriate domains and phosphorylation sites can be drawn correctly.

```
p2 <- draw_domains(p2, prot_data)
p2 <- draw_phospho(p2, prot_data, size =8)
p2
```

![](data:image/png;base64...)

Note that the names of the different transcripts are the same so it’s wise to
use the option customize the labels.

```
p2 <- draw_canvas(prot_data)
p2 <- draw_chains(p2, prot_data,
            fill = "lightsteelblue1",
            outline = "grey",
            labels = c("p105",
                        "p105",
                        "p100",
                        "p100",
                        "Rel B",
                        "c-Rel",
                        "p65/Rel A",
                        "p50",
                        "p52"),
            label_size = 5)
p2 <- draw_phospho(p2, prot_data, size = 8, fill = "red")
p2 + theme_bw()
```

![](data:image/png;base64...)

# 3 Session info

Here is the output of `sessionInfo()` on the system on which this document was
compiled:

```
R version 4.5.2 (2025-10-31)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=en_GB              LC_COLLATE=C
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base

other attached packages:
[1] knitr_1.51          ggplot2_4.0.2       httr_1.4.7
[4] drawProteins_1.30.0 BiocStyle_2.38.0

loaded via a namespace (and not attached):
 [1] gtable_0.3.6        jsonlite_2.0.0      dplyr_1.2.0
 [4] compiler_4.5.2      BiocManager_1.30.27 Rcpp_1.1.1
 [7] tinytex_0.58        tidyselect_1.2.1    magick_2.9.0
[10] dichromat_2.0-0.1   jquerylib_0.1.4     scales_1.4.0
[13] yaml_2.3.12         fastmap_1.2.0       R6_2.6.1
[16] labeling_0.4.3      generics_0.1.4      curl_7.0.0
[19] tibble_3.3.1        bookdown_0.46       bslib_0.10.0
[22] pillar_1.11.1       RColorBrewer_1.1-3  rlang_1.1.7
[25] cachem_1.1.0        xfun_0.56           sass_0.4.10
[28] S7_0.2.1            otel_0.2.0          cli_3.6.5
[31] withr_3.0.2         magrittr_2.0.4      digest_0.6.39
[34] grid_4.5.2          lifecycle_1.0.5     vctrs_0.7.1
[37] evaluate_1.0.5      glue_1.8.0          farver_2.1.2
[40] rmarkdown_2.30      tools_4.5.2         pkgconfig_2.0.3
[43] htmltools_0.5.9
```
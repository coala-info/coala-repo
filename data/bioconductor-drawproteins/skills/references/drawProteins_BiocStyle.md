# Using drawProteins

Dr Paul Brennan

#### 2026-02-03

#### Package

drawProteins 1.30.0

# Contents

* [1 Overview of drawProteins](#overview-of-drawproteins)
* [2 Getting the data from Uniprot](#getting-the-data-from-uniprot)
* [3 Turning Uniprot data into a dataframe](#turning-uniprot-data-into-a-dataframe)
* [4 Draw the protein chains and domains](#draw-the-protein-chains-and-domains)
* [5 Checking the other features](#checking-the-other-features)
* [6 Putting it all together](#putting-it-all-together)
  + [6.0.1 Adding titles to the plots](#adding-titles-to-the-plots)
* [7 Drawing schematic for multiple proteins](#drawing-schematic-for-multiple-proteins)
* [8 Customising the draw functions](#customising-the-draw-functions)
* [9 Session info](#session-info)

# 1 Overview of drawProteins

This package has been created to allow the creation of protein schematics based
on the data obtained from the Uniprot Protein Database.

The basic workflow is:
1. to provide one or more Uniprot IDs
2. get a list of feature from the Uniprot API
3. draw the basic chains of these proteins
4. add features as desired

drawProteins uses the package httr to interact with the Uniprot API and extract
a JSON object into R. The JSON object is used to create a data.table.

The graphing package ggplot2 is then used to create the protein schematic.

# 2 Getting the data from Uniprot

Currently, drawProteins interacts with the
[Uniprot database]<http://www.uniprot.org/>. At least one working
Uniprot accession numbers must be provided. More than one can be provided but
they must be separated by a single space. The spaces are replaced to create an
url that can be used to query the Uniprot API

The `get_features()` function uses the Uniprot API to return the features of a
protein - the chain, domain information and other annotated features such as
“repeats” and “motifs”. Post-translational modifications, such as
phosphorylations, are also provided.

The `httr::content()` function is then used to extract the content. From the
`get_features()` function, this will provide lists of lists. The length of the
parent lists corresponds to the number of accession numbers provided.
Interestingly, the order sometimes appears different to that provided. Each of
lists inside the parent list are a list of six - one for each protein - that
contains names of the proteins and the features.

As an example, we will retrieve the details of a protein called Rel A or
NF-kappaB, p65, a well studied transcription factor.

With internet access, this can be retreived from Uniprot with this code:

```
# accession numbers of rel A
    drawProteins::get_features("Q04206") ->
    rel_json
```

```
[1] "Download has worked"
```

# 3 Turning Uniprot data into a dataframe

The next step in the workflow is to convert the data from the Uniprot API into
a dataframe that can be used with ggplot2.

The `feature_to_dataframe()` function will convert the list of lists of six
provided by the `get_features()` function to a dataframe which can then be
used to plot the schematics.

The `feature_to_dataframe()` function will also add an “order” value to allow
plotting. The order goes from the bottom in the manner of a graph.

```
drawProteins::feature_to_dataframe(rel_json) -> rel_data

# show in console
head(rel_data[1:4])
```

```
                 type                         description begin end
featuresTemp    CHAIN            Transcription factor p65     1 551
featuresTemp.1 DOMAIN                                 RHD    19 306
featuresTemp.2 REGION                          Disordered   309 348
featuresTemp.3 REGION Transcriptional activation domain 3   342 389
featuresTemp.4 REGION Transcriptional activation domain 1   415 476
featuresTemp.5 REGION                          Disordered   506 530
```

# 4 Draw the protein chains and domains

The data can be plotted with ggplot2 using the `geom_rect()` and `geom_label`.
The first step is to make canvas with `draw_canvas` which is based on the
longest protein that is being drawin. This can be done using a pipe in the
following way.

```
draw_canvas(rel_data) -> p
p
```

![](data:image/png;base64...)

Then we can plot the protein chain. We use the `draw_chain()` function to which
we have to provide the ggplot object `p` and the data which is
called `rel_data`.

```
p <- draw_chains(p, rel_data)
p
```

![](data:image/png;base64...)

Now, we add the domains which are drawn to scale in terms of their lengths. We
use the `draw_domains()` function to which we have to provide the
ggplot object `p` and the data which is called `rel_data`.
The default is to label the chains. The labels can be removed using the
argument `label_chains = FALSE`.

```
p <- draw_domains(p, rel_data)
p
```

![](data:image/png;base64...)

To show this visualisation better, a white background helps as well as removing
the y-axis and the grid.
Also changing the size of the text using the base\_size argument.
This can be done with this code:

```
# white background and remove y-axis
p <- p + theme_bw(base_size = 20) + # white background
    theme(panel.grid.minor=element_blank(),
        panel.grid.major=element_blank()) +
    theme(axis.ticks = element_blank(),
        axis.text.y = element_blank()) +
    theme(panel.border = element_blank())
p
```

![](data:image/png;base64...)

# 5 Checking the other features

```
draw_regions(p, rel_data) # adds activation domain
```

![](data:image/png;base64...)

```
draw_repeat(p, rel_data) # doesn't add anything in this case
```

![](data:image/png;base64...)

```
draw_motif(p, rel_data) # adds 9aa Transactivation domain & NLS
```

![](data:image/png;base64...)

```
# add phosphorylation sites from Uniprot
draw_phospho(p, rel_data, size = 8)
```

![](data:image/png;base64...)

# 6 Putting it all together

In this way it’s possible to chose the geoms that give the information desired
in the way you like. Some customisation is possible as described below.

For Rel A, my recommendation would be the following workflow.

```
draw_canvas(rel_data) -> p
p <- draw_chains(p, rel_data)
p <- draw_domains(p, rel_data)
p <- draw_regions(p, rel_data)
p <- draw_motif(p, rel_data)
p <- draw_phospho(p, rel_data, size = 8)

p <- p + theme_bw(base_size = 20) + # white backgnd & change text size
    theme(panel.grid.minor=element_blank(),
        panel.grid.major=element_blank()) +
    theme(axis.ticks = element_blank(),
        axis.text.y = element_blank()) +
    theme(panel.border = element_blank())
p
```

![](data:image/png;base64...)

### 6.0.1 Adding titles to the plots

Using ggplot2 then allows the addition of titles:

```
# add titles
rel_subtitle <- paste0("circles = phosphorylation sites\n",
                "RHD = Rel Homology Domain\nsource:Uniprot")

p <- p + labs(title = "Rel A/p65",
                subtitle = rel_subtitle)
p
```

![](data:image/png;base64...)

# 7 Drawing schematic for multiple proteins

With internet access, the script below shows the workflow for five proteins of
the NFkappaB transcription factor family.

```
# accession numbers of five NF-kappaB proteins
prot_data <- drawProteins::get_features("Q04206 Q01201 Q04864 P19838 Q00653")
```

```
[1] "Download has worked"
```

```
prot_data <- drawProteins::feature_to_dataframe(prot_data)

p <- draw_canvas(prot_data)
p <- draw_chains(p, prot_data)
p <- draw_domains(p, prot_data)
p <- draw_repeat(p, prot_data)
p <- draw_motif(p, prot_data)
p <- draw_phospho(p, prot_data, size = 8)

# background and y-axis
p <- p + theme_bw(base_size = 20) + # white backgnd & change text size
    theme(panel.grid.minor=element_blank(),
        panel.grid.major=element_blank()) +
    theme(axis.ticks = element_blank(),
        axis.text.y = element_blank()) +
    theme(panel.border = element_blank())

# add titles
rel_subtitle <- paste0("circles = phosphorylation sites\n",
                "RHD = Rel Homology Domain\nsource:Uniprot")

p <- p + labs(title = "Schematic of human NF-kappaB proteins",
                subtitle = rel_subtitle)

# move legend to top
p <- p + theme(legend.position="top") + labs(fill="")
p
```

![](data:image/png;base64...)

# 8 Customising the draw functions

Currently, it’s possible to customise the chain colour and outline. It’s
possible to remove the labels.

```
data("five_rel_data")
p <- draw_canvas(five_rel_data)
p <- draw_chains(p, five_rel_data,
            label_chains = FALSE,
            fill = "hotpink",
            outline = "midnightblue")
p
```

![](data:image/png;base64...)

It’s also possible to change the size and colour of the phosphorylation symbols.

```
p <- draw_canvas(five_rel_data)
p <- draw_chains(p, five_rel_data,
            fill = "lightsteelblue1",
            outline = "grey",
            label_size = 5)
p <- draw_phospho(p, five_rel_data, size = 10, fill = "red")
p + theme_bw()
```

![](data:image/png;base64...)

It’s also possible to change the labels to a custom list. But remember that the
plots are drawn from the bottom up.

```
p <- draw_canvas(five_rel_data)
p <- draw_chains(p, five_rel_data,
            fill = "lightsteelblue1",
            outline = "grey",
            labels = c("p50/p105",
                        "p50/p105",
                        "p52/p100",
                        "p52/p100",
                        "Rel B",
                        "c-Rel",
                        "p65/Rel A"),
            label_size = 5)
p <- draw_phospho(p, five_rel_data, size = 8, fill = "red")
p + theme_bw()
```

![](data:image/png;base64...)

# 9 Session info

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
# CNViz

#### Rebecca Greenblatt (rebecca.greenblatt@gmail.com)

#### 4-14-21

```
library(CNViz)
#> Loading required package: shiny
```

# Introduction

Copy number data can be difficult to appreciate when presented in a list format or as a tab-delimited file. When projected onto a scatterplot, large scale changes can be appreciated, but smaller, gene-level changes are often missed. CNViz takes copy number data, at the probe, gene and/or segment level, and launches an interactive shiny application to visualize your sample. Loss of heterozygosity (LOH) and variant data (SNVs and short indels) can also be included.

# `launchCNViz`

This function launches an interactive Shiny application with your copy number data. See detailed descriptions and examples for each input below.

## Input Data

### `sample_name`

A character string that identifies your sample “i.e. sample123”

### `meta_data`

Can include any information about your sample you would like. For example, you might include purity of the sample, tumor ploidy, sex of patient, diagnosis, etc. It shoud only be one row. The only value that will be relevant to the visualization is ploidy. If not included, it will be assumed to be 2.

```
data(meta_data)
head(meta_data)
#>   purity ploidy
#> 1   0.55      2
```

### `probe_data`

This should be a dataframe containing probe-level data. Therefore each row should have chromosome, corresponding gene, chromosomal starting location (hg38), chromosomal end location, and log-2 ratio. A weight column is optional, but if included should represent a level of confidence in the log-2 value. This dataframe will likely have hundreds to thousands of rows depending on how many genes you wish to include. Only one of probe\_data, gene\_data or segment\_data is required, but having all will make the visualization more informative. A GRanges object will be accepted as well as long as gene and log2 are meta-data columns.

```
data(probe_data)
head(probe_data)
#>    chr   start     end     gene       log2   weight
#> 1 chr1 2556608 2556788 TNFRSF14  0.1795960 0.657040
#> 2 chr1 2557689 2557869 TNFRSF14  0.2031640 0.692880
#> 3 chr1 2558285 2558525 TNFRSF14  0.1353360 0.761431
#> 4 chr1 2558849 2559029 TNFRSF14 -0.0260057 0.683930
#> 5 chr1 2559780 2560020 TNFRSF14  0.0926252 0.743339
```

### `gene_data`

This is similar to probe\_data, however each row corresponds to a single gene. If your gene data comes with copy number estimate instead of log-2 ratio, you can convert copy number to log-2 with `log(C/2, 2)` where C is the copy number estimate. In the example below, the copy numbers were 4, 4, 4 and 0. You will notice 0 corresponds to a log-2 value of `-Inf`. Do not worry about this, the function will adjust these values so they appear on the plot. If your data does not come with weight values, and you have probe data available, you can use the number of probes targeted to that gene as the weight or the sum of the weights of all probes targeted to that gene (if your probe data has a weight column). This data frame can have an LOH columnm, indicating whether or not this gene is suspected to have loss of heterozyogisity - this column should take on values TRUE or FALSE. A GRanges object will be accepted as well as long as gene and log2 are meta-data columns.
\* If your probe data corresponds to raw/unadjusted values, and your gene data corresponds to values adjusted for tumor purity and/or ploidy, take note of this, and explain this to any users of the application. This is important because the log-2 values on the gene plot and probe plots may not align.

```
data(gene_data)
head(gene_data)
#>    chr    start      end     gene log2   loh weight
#> 1 chr1  2556609  2563330 TNFRSF14    1 FALSE     10
#> 2 chr1 23558900 23559456      ID3    1 FALSE      2
#> 3 chr1 36466058 36479554    CSF3R    1 FALSE     17
#> 4 chr1 38839509 38859647    RRAGC    1 FALSE      7
#> 5 chr1 43337798 43352825      MPL    1 FALSE     12
```

### `segment_data`

Each row will correspond to a segment as shown below. An LOH column can be included in this dataframe as well, indicating whether or not the entire segment is suspected of having loss of heterozygosity.

```
data(segment_data)
head(segment_data)
#>    chr     start       end log2   loh
#> 1 chr1   1050069 122026459    1 FALSE
#> 2 chr1 124932724 246947668    1 FALSE
#> 3 chr4   1942322  49712061    1 FALSE
#> 4 chr4  51743951 188110779    1 FALSE
#> 5 chr5   1076406  46485900    1 FALSE
```

### `variant_data`

Each row will correspond to a singlue nucleotide variant (SNV) or small indel. The gene, and mutation\_id (in any format) must be included. Other columns like depth and starting location (start) are optional. Any additional columns you include will be displayed in the table. If start is included, this will enable CNViz to plot the location of the mutation on the probe plot. This table can include short insertions and deletions as long as they are formatted in the same manner as SNVs - in this case, you may want to include a ref and alt column. A VRanges object will be accepted as well as long as gene is a meta-data columns.

```
data(variant_data)
head(variant_data)
#>     gene        mutation_id depth    start
#> 1   XPO1 chr2:61495391_G/GA   254 61495391
#> 2 FANCD2  chr3:10046563_G/A   417 10046563
#> 3 FANCD2  chr3:10046728_C/T   528 10046728
#> 4 FANCD2  chr3:10046746_C/T   450 10046746
#> 5 FANCD2  chr3:10047822_A/G   259 10047822
```

## Output

```
launchCNViz(sample_name = "sample123", meta_data = meta_data, probe_data = probe_data, gene_data = gene_data, segment_data = segment_data, variant_data = variant_data)
```

This will launch a Shiny application. See <https://rebeccagreenblatt.shinyapps.io/cnviz_example> for a live example using simulated data. \* Note: if any of meta\_data, probe\_data, gene\_data, segment\_data or snv\_data is not included, it will be set to an empty data frame (`data.frame()`). See `?launchCNViz` in the console.
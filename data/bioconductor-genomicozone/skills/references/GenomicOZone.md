# Example: finding E. coli outstanding genomic zones in response to nickel stress

#### Hua Zhong and Joe Song

#### Updated January 26, 2021; Created August 9, 2019

We illustrate the GenomicOZone package with an example. The *Escherichia coli* transcriptome data set (Gault and Rodrigue 2016) contains transcriptome profiles of *E. coli* K-12 under nickel stress, with three samples under exposure to nickel and three normal samples.

To run this example, two other packages `GEOquery` (Davis and Meltzer 2007) for data download and `readxl` for Excel file reading are required and should have been installed, in addition to `GenomicOZone`.

```
require(GenomicOZone)
# require(GEOquery)
require(readxl)
```

The following code chunk reads a data transcriptome set, prepares genome annotation, and creates parameters before outstanding zone analysis. Specifically, an *Escherichia coli* transcriptome data set of series number GSE76167 was downloaded from GEO database (Edgar, Domrachev, and Lash 2002) and saved in the package. We accessed the data and extracted the RPKM values from six samples including three stressed samples and three wild-type samples. The genome annotation is prepared as a `GRanges` (Lawrence et al. 2013) object.

```
# Obtain data matrix from GSE76167 supplementary file
# invisible(getGEOSuppFiles("GSE76167"))
# data <- read_excel(".//GSE76167_GeneFPKM_AllSamples.xlsx")
file <- system.file("extdata", "GSE76167_GeneFPKM_AllSamples.xlsx", package = "GenomicOZone", mustWork = TRUE)
data <- read_excel(file)

# Adjust the input data
data.info <- data[,1:5]
data <- data[,-c(1:5)]
data <- data[,substr(colnames(data), 1, 4) == "FPKM"]
data <- data.matrix(data[,c(1,5,6,3,4,2)])
colnames(data) <- c(paste(rep("WT",3), "_", c(1,2,3), sep=""),
                    paste(rep("Ni",3), "_", c(1,2,3), sep=""))
rownames(data) <- data.info$tracking_id

# Obtain genes
data.genes <- data.info$gene_short_name
data.genes[data.genes == "-"] <- data.info$tracking_id[data.genes == "-"]

# Create colData
colData <- data.frame(Sample_name = colnames(data),
                      Condition = factor(rep(c("WT", "Ni"), each = 3),
                                         levels = c("WT", "Ni")))

# Create design
design <- ~ Condition

# Create rowData.GRanges
pattern <- "(.[^\\:]*)\\:([0-9]+)\\-([0-9]+)"
matched <- regexec(pattern, as.character(data.info$locus))
values <- regmatches(as.character(data.info$locus), matched)
data.gene.coor <-  data.frame(chr = as.character(sapply(values, function(x){x[[2]]})),
                              start = as.numeric(sapply(values, function(x){x[[3]]})),
                              end = as.numeric(sapply(values, function(x){x[[4]]})))
rownames(data.gene.coor) <- as.character(data.info$tracking_id)
rowData.GRanges <- GRanges(seqnames = data.gene.coor$chr,
                           IRanges(start = data.gene.coor$start,
                                   end = data.gene.coor$end),
                           Gene.name = data.genes)
names(rowData.GRanges) <- data.info$tracking_id

chr.size <- 4646332
names(chr.size) <- "NC_007779"
seqlevels(rowData.GRanges) <- names(chr.size)
seqlengths(rowData.GRanges) <- chr.size
```

With the formatted data, parameters, and annotation, we run the outstanding zone analysis as below:

```
# Create an input object also checking for data format, consistency, and completeness
GOZ.ds <- GOZDataSet(data = data,
                     colData = colData,
                     design = design,
                     rowData.GRanges = rowData.GRanges)

# Run the outstanding zone analysis
GOZ.ds <- GenomicOZone(GOZ.ds)
```

The following four auxiliary functions extract gene annotation, zone annotation, outstanding zone annotation, and zone expression matrix, respectively:

```
# Extract gene/zone GRanges object
Gene.GRanges <- extract_genes(GOZ.ds)
head(Gene.GRanges)
#> GRanges object with 6 ranges and 2 metadata columns:
#>          seqnames    ranges strand |   Gene.name        zone
#>             <Rle> <IRanges>  <Rle> | <character>    <factor>
#>   gene0 NC_007779   189-255      * |        thrL NC_007779_1
#>   gene1 NC_007779  336-2799      * |        thrA NC_007779_1
#>   gene2 NC_007779 2800-3733      * |        thrB NC_007779_1
#>   gene3 NC_007779 3733-5020      * |        thrC NC_007779_1
#>   gene4 NC_007779 5233-5530      * |        yaaX NC_007779_1
#>   gene5 NC_007779 5682-6459      * |        yaaA NC_007779_1
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome

Zone.GRanges <- extract_zones(GOZ.ds)
head(Zone.GRanges)
#> GRanges object with 6 ranges and 3 metadata columns:
#>                seqnames      ranges strand |        zone p.value.adj
#>                   <Rle>   <IRanges>  <Rle> |    <factor>   <numeric>
#>   NC_007779_1 NC_007779      1-9926      * | NC_007779_1 9.80875e-03
#>   NC_007779_2 NC_007779  9927-20813      * | NC_007779_2 9.46349e-07
#>   NC_007779_3 NC_007779 20814-42401      * | NC_007779_3 2.77431e-01
#>   NC_007779_4 NC_007779 42402-72227      * | NC_007779_4 1.92004e-01
#>   NC_007779_5 NC_007779 72228-88026      * | NC_007779_5 2.36520e-04
#>   NC_007779_6 NC_007779 88027-99642      * | NC_007779_6 4.36277e-01
#>               effect.size
#>                 <numeric>
#>   NC_007779_1   0.1440329
#>   NC_007779_2   0.3000733
#>   NC_007779_3   0.0142269
#>   NC_007779_4   0.0146438
#>   NC_007779_5   0.1749271
#>   NC_007779_6   0.0137143
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome

# min.effect.size = 0.36 is chosen from the
#     minumum of top 5% effect size values
OZone.GRanges <- extract_outstanding_zones(
                              GOZ.ds,
                              alpha = 0.05,
                              min.effect.size = 0.36)
head(OZone.GRanges)
#> GRanges object with 6 ranges and 3 metadata columns:
#>                 seqnames          ranges strand |         zone p.value.adj
#>                    <Rle>       <IRanges>  <Rle> |     <factor>   <numeric>
#>   NC_007779_13 NC_007779   194902-211875      * | NC_007779_13 2.43544e-08
#>   NC_007779_28 NC_007779   452812-467605      * | NC_007779_28 2.43544e-08
#>   NC_007779_29 NC_007779   467606-478589      * | NC_007779_29 1.93940e-11
#>   NC_007779_32 NC_007779   505826-535808      * | NC_007779_32 5.59306e-18
#>   NC_007779_36 NC_007779   590163-605172      * | NC_007779_36 2.67853e-08
#>   NC_007779_65 NC_007779 1059677-1072591      * | NC_007779_65 3.27949e-15
#>                effect.size
#>                  <numeric>
#>   NC_007779_13    0.369738
#>   NC_007779_28    0.369738
#>   NC_007779_29    0.512169
#>   NC_007779_32    0.400091
#>   NC_007779_36    0.419441
#>   NC_007779_65    0.566764
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome

Zone.exp.mat <- extract_zone_expression(GOZ.ds)
head(Zone.exp.mat)
#>                  WT_1      WT_2      WT_3      Ni_1      Ni_2      Ni_3
#> NC_007779_1 62214.043 83959.120 73790.007 47984.066 55259.507 49647.909
#> NC_007779_2  6247.521 21137.231 24602.949 28791.985 28981.303 33428.900
#> NC_007779_3  7900.263  9331.010  9789.358  2364.148  2515.822  2508.266
#> NC_007779_4  3943.298  4319.107  4270.070  5037.490  6642.837  6111.983
#> NC_007779_5  9095.239  8746.648  9593.191 10926.196 12249.913 14521.159
#> NC_007779_6  2108.727  2016.687  1815.983  2510.306  2378.745  2172.734
```

Three types of plot can be generated from the returned object by `GenomicOZone()`, including genome-wide overview, within-chromosome heatmap, and within-zone expression. The plots are generated using R package `ggplot2` (Wickham 2016) and `ggbio` (Yin, Cook, and Lawrence 2012). The value of `min.effect.size = 0.36` is chosen from the minumum of top 5% effect size values. The effect size for ANOVA is calculated by R package `sjstats` (Lüdecke 2019).

```
# Genome-wide overview
plot_genome(GOZ.ds, plot.file = "E_coli_genome.pdf",
            plot.width = 15, plot.height = 4,
            alpha = 0.05, min.effect.size = 0.36)
#> Warning in (function (mapping = NULL, data = NULL, stat = "identity", position
#> = "identity", : Ignoring unknown parameters: `fill`
#> Scale for x is already present.
#> Adding another scale for x, which will replace the existing scale.
#> Scale for x is already present.
#> Adding another scale for x, which will replace the existing scale.
#> Ignoring unknown labels:
#> • sep : ""
#> NULL
knitr::include_graphics("E_coli_genome.pdf")
```

```
# Within-chromosome heatmap
plot_chromosomes(GOZ.ds, plot.file = "E_coli_chromosome.pdf",
                 plot.width = 20, plot.height = 4,
                 alpha = 0.05, min.effect.size = 0.36)
#> Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
#> ℹ Please use tidy evaluation idioms with `aes()`.
#> ℹ See also `vignette("ggplot2-in-packages")` for more information.
#> ℹ The deprecated feature was likely used in the GenomicOZone package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the GenomicOZone package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> png
#>   2
knitr::include_graphics("E_coli_chromosome.pdf")
```

```
# Within-zone expression
plot_zones(GOZ.ds, plot.file = "E_coli_zone.pdf",
           plot.all.zones = FALSE,
           alpha = 0.05, min.effect.size = 0.36)
#> Warning: The `size` argument of `element_rect()` is deprecated as of ggplot2 3.4.0.
#> ℹ Please use the `linewidth` argument instead.
#> ℹ The deprecated feature was likely used in the GenomicOZone package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> Warning: The `fun.y` argument of `stat_summary()` is deprecated as of ggplot2 3.3.0.
#> ℹ Please use the `fun` argument instead.
#> ℹ The deprecated feature was likely used in the GenomicOZone package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#> png
#>   2
knitr::include_graphics("E_coli_zone.pdf")
```

## References

Davis, Sean, and Paul S Meltzer. 2007. “GEOquery: A Bridge Between the Gene Expression Omnibus (Geo) and Bioconductor.” *Bioinformatics* 23 (14): 1846–7.

Edgar, Ron, Michael Domrachev, and Alex E Lash. 2002. “Gene Expression Omnibus: NCBI Gene Expression and Hybridization Array Data Repository.” *Nucleic Acids Research* 30 (1): 207–10.

Gault, Manon, and Agnès Rodrigue. 2016. “Data Set for Transcriptome Analysis of Escherichia Coli Exposed to Nickel.” *Data in Brief* 9: 314–17.

Lawrence, Michael, Wolfgang Huber, Hervé Pages, Patrick Aboyoun, Marc Carlson, Robert Gentleman, Martin T Morgan, and Vincent J Carey. 2013. “Software for Computing and Annotating Genomic Ranges.” *PLoS Computational Biology* 9 (8): e1003118.

Lüdecke, Daniel. 2019. *Sjstats: Statistical Functions for Regression Models (Version 0.17.5)*. <https://doi.org/10.5281/zenodo.1284472>.

Wickham, Hadley. 2016. *Ggplot2: Elegant Graphics for Data Analysis*. Springer-Verlag New York. <https://ggplot2.tidyverse.org>.

Yin, Tengfei, Dianne Cook, and Michael Lawrence. 2012. “Ggbio: An R Package for Extending the Grammar of Graphics for Genomic Data.” *Genome Biology* 13 (8): R77.
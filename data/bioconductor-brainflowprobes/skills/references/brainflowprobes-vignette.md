Code

* Show All Code
* Hide All Code

# brainflowprobes user guide

Amanda Price1\*

1Lieber Institute for Brain Development, Johns Hopkins Medical Campus

\*amanda.joy.price@gmail.com

#### 28 April 2020

#### Package

brainflowprobes 1.2.0

# 1 Basics

## 1.1 Install *[brainflowprobes](https://bioconductor.org/packages/3.11/brainflowprobes)*

`R` is an open-source statistical environment which can be easily modified to enhance its functionality via packages. *[brainflowprobes](https://bioconductor.org/packages/3.11/brainflowprobes)* is an `R` package available via the [Bioconductor](http://bioconductor/packages/brainflowprobes) repository for packages. `R` can be installed on any operating system from [CRAN](https://cran.r-project.org/) after which you can install *[brainflowprobes](https://bioconductor.org/packages/3.11/brainflowprobes)* by using the following commands in your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
      install.packages("BiocManager")
  }

BiocManager::install("brainflowprobes")

## Check that you have a valid Bioconductor installation
BiocManager::valid()

## If you want to force the installation of the development version, you can
## do so by running. However, we suggest that you wait for Bioconductor to
## run checks and build the latest release.
BiocManager::install("LieberInstitute/brainflowprobes")
```

## 1.2 Required knowledge

*[brainflowprobes](https://bioconductor.org/packages/3.11/brainflowprobes)* is based on many other packages, particularly *[GenomicRanges](https://bioconductor.org/packages/3.11/GenomicRanges)*, *[derfinder](https://bioconductor.org/packages/3.11/derfinder)*, and *[derfinderPlot](https://bioconductor.org/packages/3.11/derfinderPlot)*. A *[brainflowprobes](https://bioconductor.org/packages/3.11/brainflowprobes)* user is not expected to deal with those packages directly, but may find their manuals useful.

If you are asking yourself the question “How do I start using Bioconductor?” you might be interested in [this blog post](http://lcolladotor.github.io/2014/10/16/startbioc/#.VkOKbq6rRuU).

## 1.3 Asking for help

The blog post quoted above mentions some options, but we would like to highlight the [Bioconductor support site](https://support.bioconductor.org/) as the main resource for getting help: remember to use the `brainflowprobes` tag and check [the older posts](https://support.bioconductor.org/t/brainflowprobes/). Other alternatives are available such as creating GitHub issues and tweeting. However, please note that if you want to receive help you should adhere to the [posting guidelines](http://www.bioconductor.org/help/support/posting-guide/). It is particularly critical that you provide a small reproducible example and your session information so package developers can track down the source of the error.

## 1.4 Citing *[brainflowprobes](https://bioconductor.org/packages/3.11/brainflowprobes)*

We hope that *[brainflowprobes](https://bioconductor.org/packages/3.11/brainflowprobes)* will be useful for your research. Please use the following information to cite the package and the overall approach. Thank you!

```
## Citation info
citation("brainflowprobes")
```

```
##
## Price AJ (2020). _Plots and annotation for choosing BrainFlow target
## probe sequence_. doi: 10.18129/B9.bioc.brainflowprobes (URL:
## https://doi.org/10.18129/B9.bioc.brainflowprobes),
## https://github.com/LieberInstitute/brainflowprobes - R package version
## 1.2.0, <URL: http://www.bioconductor.org/packages/brainflowprobes>.
##
## A BibTeX entry for LaTeX users is
##
##   @Manual{,
##     title = {Plots and annotation for choosing BrainFlow target probe sequence},
##     author = {Amanda J Price},
##     year = {2020},
##     url = {http://www.bioconductor.org/packages/brainflowprobes},
##     note = {https://github.com/LieberInstitute/brainflowprobes - R package version 1.2.0},
##     doi = {10.18129/B9.bioc.brainflowprobes},
##   }
```

# 2 Introduction

*[brainflowprobes](https://bioconductor.org/packages/3.11/brainflowprobes)* is an R package that contains four functions to aid in designing probes to target RNA sequences in nuclei isolated from human postmortem brain using flow cytometry. *[brainflowprobes](https://bioconductor.org/packages/3.11/brainflowprobes)* was made to support the method described in the BrainFlow publication, which is based on the Invitrogen PrimeFlow&#174 RNA kit.

## 2.1 Notes before starting

This package is currently only compatible with hg19 sequences. Also, because of the type of data used, the plotting functions `plot_coverage()` and `four_panels()` do not work on Windows machines. To visualize the data, please use `R` installed on either Mac or Linux operating systems. The `region_info()` function can still be used on Windows machines for creating an annotated `.csv` file to get the information required for custom probe synthesis.

# 3 Choosing candidate RNA sequences

Which genes you choose to target will ultimately depend on the purpose of your experiment. BrainFlow can be used to isolate specific cell populations for downstream sequencing, for instance, or to assess the coexpression of up to four transcripts at a time at single-nucleus resolution. For the highest probability of success, however, several parameters should be considered when choosing a sequence to target, no matter the purpose. Target sequences are more likely to be successful if they:

* Are at least 1kb of contiguously expressed sequence (mandatory)
* Are as highly expressed a target as possible (within the cell population of interest)
* Are as highly expressed in nuclear RNA as possible
* Are selectively expressed in the cell population of interest
* Are robust to degradation due to postmortem factors
* Avoid splice junctions if it can be helped (given that we’re profiling nuclear RNA)

More details about probe design and each of these considerations can be found in the BrainFlow manuscript. One strategy for choosing a sequence could be to choose the 3’UTR of a transcript of interest. Another strategy (and how many of the probes already validated in the BrainFlow manuscript were designed) is to identify expressed regions using the *[derfinder](https://bioconductor.org/packages/3.11/derfinder)* package. However you choose which sequences to test, the *[brainflowprobes](https://bioconductor.org/packages/3.11/brainflowprobes)* package will help narrow down the best sequences for which to synthesize target probes.

# 4 Annotating a candidate sequence

Let’s say you want to design a probe to target deep layer pyramidal neurons in the prefrontal cortex. You choose TBR1 because of its role in neuronal identity specification in these cells, and you want to see if the last exon of this gene, a ~2.5 Kb sequence, would make for a good probe target. You find using the UCSC Genome browser (for instance) that the hg19 coordinates for this exon are `chr2:162279880-162282378:+`, where `chr2` is the chromosome, `162279880-162282378` is the start and end of the exon, and `+` means that it is on the plus strand.

Before any of the *[brainflowprobes](https://bioconductor.org/packages/3.11/brainflowprobes)* functions can be used, the package must be loaded and attached:

```
## Load brainflowprobes R package
library("brainflowprobes")
```

The next step is to use the `region_info()` function to annotate the sequence in a `.csv` file that can be used to custom synthesize a target probe:

```
region_info("chr2:162279880-162282378:+", CSV = FALSE, SEQ = TRUE, OUTDIR = ".")
```

```
## snapshotDate(): 2020-03-31
```

```
## loading from cache
```

```
## Completed! If CSV=TRUE, check for region_info.csv in the temporary
## directory (i.e. tempdir()) unless otherwise specified in OUTDIR.
```

```
##   seqnames     start       end width strand name          annotation
## 1     chr2 162279880 162282378  2499      + TBR1 NM_006593 NP_006584
##   description region distance   subregion insideDistance exonnumber nexons
## 1 inside exon inside     7072 inside exon              0          3      3
##              UTR geneL codingL          Geneid
## 1 overlaps 3'UTR  9573    7816 ENSG00000136535
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              Sequence
## 1 GATCTACACCGGCTGTGACATGGACCGCCTGACCCCCTCGCCCAACGACTCGCCGCGCTCGCAGATCGTGCCCGGGGCCCGCTACGCCATGGCCGGCTCTTTCCTGCAGGACCAGTTCGTGAGCAACTACGCCAAGGCCCGCTTCCACCCGGGCGCGGGCGCGGGCCCCGGGCCGGGTACGGACCGCAGCGTGCCGCACACCAACGGGCTGCTGTCGCCGCAGCAGGCCGAGGACCCGGGCGCGCCCTCGCCGCAACGCTGGTTTGTGACGCCGGCCAACAACCGGCTGGACTTCGCGGCCTCGGCCTATGACACGGCCACGGACTTCGCGGGCAACGCGGCCACGCTGCTCTCTTACGCGGCGGCGGGCGTGAAGGCGCTGCCGCTGCAGGCTGCAGGCTGCACTGGCCGCCCGCTCGGCTACTACGCCGACCCGTCGGGCTGGGGCGCCCGCAGTCCCCCGCAGTACTGCGGCACCAAGTCGGGCTCGGTGCTGCCCTGCTGGCCCAACAGCGCCGCGGCCGCCGCGCGCATGGCCGGCGCCAATCCCTACCTGGGCGAGGAGGCCGAGGGCCTGGCCGCCGAGCGCTCGCCGCTGCCGCCCGGCGCCGCCGAGGACGCCAAGCCCAAGGACCTGTCCGATTCCAGCTGGATCGAGACGCCCTCCTCGATCAAGTCCATCGACTCCAGCGACTCGGGGATTTACGAGCAGGCCAAGCGGAGGCGGATCTCGCCGGCCGACACGCCCGTGTCCGAGAGTTCGTCCCCGCTCAAGAGCGAGGTGCTGGCCCAGCGGGACTGCGAGAAGAACTGCGCCAAGGACATTAGCGGCTACTATGGCTTCTACTCGCACAGCTAGGCCGCCCCTGCCCGCCCGGCCCCGCCGCGGCCCGGACCCCCAGCCAGCCCCTCACAGCTCTTCCCCAGCTCCGCCTCCCCACACTCCTCCTTGCGCACCCACTCATTTTATTTGACCCTCGATGGCCGTCTGCAGCGAATAAGTGCAGGTCTCCGAGCGTGATTTTAACCTTTTTTGCACAGCAGTCTCTGCAATTAGCTCACCGACCTTCAACTTTGCTGTAAACCTTTTGGTTTTCCTACTTACTCTTCTTCTGTGGAGTTATCCTCCTACAATTCCCCTCCCCCTCGTCTTTCTCTTACCTCCTACTTCTCTTTCTTGTAATGAAACTCTTCACCTTTAGGAGACCTGGGCAGTCCTGTCAGGCAGCAGCGATTCCGACCCGCCAAGTCTCGGCCTCCACATTAACCATAGGATGTTGACTCTAGAACCTGGACCCACCCAGCGCGTCCTTTCTTATCCCCGAGTGGATGGATGGATGGATGGATGGTAGGGATGTTAATAATTTTAGTGGAACAAAGCCTGTGAAATGATTGTACATAGTGTTAATTTATTGTAACGAATGGCTAGTTTTTATTCTCGTCAAGGCACAAAACCAGTTCATGCTTAACCTTTTTTTCCTTTCCTTTCTTTGCTTTTCTTTCTCTCCTCTCATACTTTCTCTTCTCTCTCTTTTAATTTTCTTGTGAGATAATATTCTAAGAGGCTCTAGAAACATGAAATACTCAGTAGTGATGGGTTTCCCACTTCTCCTCAATCCGTTGCATGAAATAATTACTATGTGCCCTAATGCACACAAATAGCTAAGGAGAATCCACCCAAACACCTTTAAAGGATAGGTGTCTGTTCATAGGCAAGTCGATTAAGTGGCATGATGCCTGCAAAGCAAAGTCAACTGGAGTTGTATGTTCCCCCCACCTTCTAAATAGAATAGCTCGACATCAGCAATATTATTTTGCCTTATTTGTTTTTCCCCAAAGTGCCAAATCCATTACTGGTCTGTGCAGGTGCCAAATATGCTGACAAACTGTTTCTGAATATCTTTCAGTACCCCTTCACCTTTATATGCTGTAAATCTTTGTAATGAATACTCTATTAATGATATAGATGACTGAATTGTTGGTAACTATAGTGTAGTCTAGTGAAGATGAATTGTGTGAGTTGTATATTTTACTGCATTTTAGTTTTGAAAATGACTTCCCCACCACCTAGAAACAGCTGAAATTTGACTTCCTTGGGAGAACACTAGCATTAATGCAAGTAAGACTGATTTTCCCCTAAGTCTTGTTATATTTGATAAGGAGCATTAATCCCCCTGGAAATAGATTAGTAGGATTTCTAATGTTGTGTAGCAAACCTATACTTTTTTGTATTTAAAAATTAATGTGAAATATGCATCATACACAATATTCAATCTAGATTCCAGTCCATGGGGGGATTTTTCCTAATAGGAATTCAGGGTCTAAACGTGTGTATATTTTGGCTCTTCTGTAAATCTAATGTTGTGATTTTTATATTTGTTTCGTTTTGTCTGTGAACTGAATAATTTATACAAGAACACACTCCATTGAGAAACGTTTTGTTTTTTGCTCGTTTGTATCGTCTGTGTATAACAAGTAAAATAAACCTGGTAAAAACGC
```

This function will annotate the specified genomic regions (sequences) by calling the `matchGenes()` function from the *[bumphunter](https://bioconductor.org/packages/3.11/bumphunter)* package. The output is a table where the first six columns include the coordinates (chromosome, start, end, and strand), region width, and the name of the nearest gene. The proceeding columns list further information about the nearest gene and where the region is in relation to that gene. These columns are described in the documentation for `matchGenes()`, reprinted below:

| Column | Description |
| --- | --- |
| annotation | RefSeq ID |
| description | a factor with levels c(“upstream”, “promoter”, “overlaps 5’”, “inside intron”, “inside exon”, “covers exon(s)”, “overlaps exon upstream”, “overlaps exon downstream”, “overlaps two exons”, “overlaps 3’”, “close to 3’”, “downstream”, “covers”) |
| region | a factor with levels c(“upstream”, “promoter”, “overlaps 5’”, “inside”, “overlaps 3’”, “close to 3’”, “downstream”, “covers”) |
| distance | distance before 5’ end of gene |
| subregion | a factor with levels c(“inside intron”, “inside exon”, “covers exon(s)”, “overlaps exon upstream”, “overlaps exon downstream”, “overlaps two exons”) |
| insideDistance | distance past 5’ end of gene |
| exonnumber | which exon |
| nexons | number of exons |
| UTR | a factor with levels c(“inside transcription region”, “5’ UTR”, “overlaps 5’ UTR”, “3’UTR”, “overlaps 3’UTR”, “covers transcription region”) |
| geneL | the gene length |
| codingL | the coding length |
| Entrez | Entrez ID of closest gene |

If `CSV = TRUE`, a file called `region_info.csv` will be printed in your working directory, unless another location and file name are listed in the `OUTDIR` option. It is important that `chr` preceeds the chromosome number, that the sequence is hg19, and that the candidate coordinates are encased in quotation marks (this tells `R` that it should read the coordinates as a character class). The output of this function is what can be sent to Invitrogen to specify the sequences you would like to be targeted.

# 5 Plotting expression coverage across a candidate region

*[brainflowprobes](https://bioconductor.org/packages/3.11/brainflowprobes)* includes two functions that visualize expression information about candidate target regions based on four external datasets. Coverage data for these external datasets are stored online as BigWig tracks that unfortunately cannot be called using `R` on a Windows operating system. For users with Mac or Linux machines, expression of candidate regions in these datasets can be loaded and visualized using `plot_coverage()` and `four_panels()`.

`plot_coverage()` uses the `getRegionCoverage()` function from the *[derfinder](https://bioconductor.org/packages/3.11/derfinder)* package to cut the coverage values for region(s) of interest (specified in the `REGION` option) in a set of nuclear (N) and cytoplasmic (C) RNA-seq samples derived from adult (A) and fetal (F) human cortex. In this dataset, two different RNA-seq libraries based on either polyA-enrichment (P) or rRNA depletion (R) were generated and sequenced for each fraction-age pair, resulting in eight groups of samples. Optimal candidate target probe sequences will be highly and uniformly expressed across the region.

```
plot_coverage("chr2:162279880-162282378:+",
    PDF = "regionCoverage_fractionedData.pdf",
    OUTDIR = ".",
    COVERAGE = NULL, VERBOSE = FALSE
)
```

In this example, this exon is highly expressed in both nuclear and cytoplasmic RNA but is not uniformly expressed. 2.5 Kb (the length of this exon) is longer than the minimum for probe synthesis, so we can limit the coordinates to exclude the lower-expressed sequence:

```
plot_coverage("chr2:162280900-162282378:+",
    PDF = "regionCoverage_fractionedData_shorter.pdf",
    OUTDIR = ".",
    COVERAGE = NULL, VERBOSE = FALSE
)
```

These new coordinates are now evenly expressed across a ~1.5 Kb region.

# 6 Assessing other parameters for a candidate region using four\_panels()

Calculating coverage can take several minutes depending on the number of candidate regions being assessed. The coverage can also be pre-computed outside the context of the plotting functions using `brainflowprobes_cov()`, and then specified in the `COVERAGE` parameter of either `plot_coverage()` or `four_panels()`.

```
tbr1.cov <- brainflowprobes_cov("chr2:162280900-162282378:+", VERBOSE = FALSE)
```

This example takes ~10 minutes to run. The resulting `tbr1.cov` object includes a list for each of the four external datasets of coverage across each region being assayed. In this case, coverage at each of the 1479 bases of the TBR1 exon is reported for each sample of the four datasets.

A snapshot of coverage, degradation and cell type specificity can be visualized using the `four_panels()` function:

```
four_panels("chr2:162280900-162282378:+",
    PDF = "four_panels.pdf",
    OUTDIR = ".",
    JUNCTIONS = FALSE,
    COVERAGE = tbr1.cov, VERBOSE = FALSE
)
```

The upper left panel (**Separation**) shows a boxplot of the mean transformed coverage value across the 1.5 Kb region in the fractionated data used by `plot_coverage` described above. This region is expressed at about the same level in both nuclear (N) and cytoplasmic (C) samples, making this a good candidate so far.

The upper right panel (**Degradation**) plots the mean transformed coverage in cortical tissue samples left on a benchtop at room temperature for 0-60 minutes (x-axis) before RNA extraction and sequencing using either polyA selection (“polyA”) or rRNA depletion (“Ribo”) library preparation kits. Expression coverage of this region does not reduce after an hour at room temperature, meaning that this sequence may be a good candidate for target probe synthesis.

The lower left panel (**Sorted**) shows expression of the region in nuclear RNA that has been sorted based on NeuN antibody labeling and sequenced using two library preparation strategies: polyA selection (“PolyA”) or rRNA depletion (“RiboGone”). NeuN+ (positive) samples are enriched for neurons, while NeuN- (negative) samples are enriched for non-neurons such as the subclasses of glia or epithelial cells. Although these samples were collected using a different protocol, as products of flow cytometric sorting of postmortem brain tissue, they provide insight to the level of detectable expression that may be expected from sorted nuclear RNA. If your target gene is cell type-specific (such as TBR1), it can also be used as a sanity check for the expected neuronal-enriched expression pattern of that gene.

The lower right panel (**Single Cells**) shows the expression of the region in 466 single cells isolated from human cortex or hippocampus and can be used to verify the cell type-specificity of the expression pattern, should you be interested in a cell type-specific target. In the case of the 6th exon of TBR1, it is selectively expressed in quiescent fetal brain cells and a subset of adult neurons, as is expected given its biological role.

After generating these plots, one can conclude that `chr2:162280900-162282378:+` is a strong candidate for a target probe. To design a custom probe, go to <https://www.thermofisher.com/order/custom-oligo/brancheddna>. Enter the name of the probe (e.g., TBR1\_exon6), choose ‘Prime Flow’ as the chemistry, ‘RNA’ as the target, and your desired fluorophore. We recommend shoowing Alexa Fluor 647 as it is the brightest and will offer the greatest chance of success. Choose ‘[Hs] Human’ as the species, and copy the sequence from `region_info.csv` to the target information. In the comment field, mention that this probe is for targeting nuclear RNA from human postmortem brain using BrainFlow application of the Invitrogen PrimeFlow&#174 RNA assay.

Even though it appears to be a good candidate however, it must still be validated experimentally.

# 7 Assessing many candidate sequences at a time

Say rather than one candidate you have a list of differentially expressed regions that are upregulated in your cell population of interest and you want to see which would make the best BrainFlow target probes. In this case, you can input a list of coordinates:

```
candidates <- c(
    "chr2:162279880-162282378:+",
    "chr11:31806351-31811553",
    "chr7:103112236-103113354"
)

region_info(candidates, CSV = FALSE, SEQ = FALSE)
```

```
## snapshotDate(): 2020-03-31
```

```
## loading from cache
```

```
## Completed! If CSV=TRUE, check for region_info.csv in the temporary
## directory (i.e. tempdir()) unless otherwise specified in OUTDIR.
```

```
##   seqnames     start       end width strand         name
## 1     chr2 162279880 162282378  2499      +         TBR1
## 2    chr11  31806351  31811553  5203      *         ELP4
## 3     chr7 103112236 103113354  1119      * LOC101927870
##                                                                annotation
## 1                                                     NM_006593 NP_006584
## 2 NM_001288725 NM_001288726 NM_019040 NP_001275654 NP_001275655 NP_061913
## 3                                                               NR_110141
##     description region distance     subregion insideDistance exonnumber nexons
## 1   inside exon inside     7072   inside exon              0          3      3
## 2   inside exon inside   275049   inside exon              0         25     25
## 3 inside intron inside    26582 inside intron         -25120          2      4
##                           UTR  geneL codingL          Geneid
## 1              overlaps 3'UTR   9573      NA ENSG00000136535
## 2                       3'UTR 280570      NA ENSG00000109911
## 3 inside transcription region  68800      NA ENSG00000234715
```

Each candidate target probe region will be output as a row in the `region_info.csv` table.

When multiple regions are assessed concurrently using `plot_coverage()` and `four_panels()`, each region will be plotted and saved as individual pages in a pdf. It is recommended to not assess more than 50 or so regions as a time because of size and ease of interpretibility. An example would look like this (this example won’t run in this vignette to keep loading time down):

```
plot_coverage(candidates,
    PDF = "regionCoverage_fractionedData_multiple.pdf", OUTDIR = "."
)

four_panels(candidates, PDF = "four_panels_multiple.pdf", OUTDIR = ".")
```

# 8 Spanning splice junctions

Sometimes a gene may be too short to avoid a sequence that spans splice junctions, or you may be interested in creating a target probe that matches a probe that has been designed for another assay (sich as FISH). In this case, the start and end of the entire spliced sequence can be used as input to both `region_info()` and `plot_coverage()`. Because `four_panels()` averages the coverage across each candidate region, you want to exclude intron sequence. In this case, you may input the coordinates of the exons within a transcript of interest and specify that `JUNCTIONS = TRUE`. For instance, when designing a probe for PENK we wanted to target bases 2-1273 of NM\_001135690.2 to match another probe from a different assay. From the UCSC genome browser, one can identify the coordinates of the exons within this transcript:

```
PENK_exons <- c(
    "chr8:57353587-57354496:-",
    "chr8:57358375-57358515:-",
    "chr8:57358985-57359040:-",
    "chr8:57359128-57359292:-"
)

four_panels(PENK_exons, JUNCTIONS = TRUE, PDF = "PENK_panels.pdf")
```

By specifying `JUNCTIONS = TRUE`, `four_panels()` will average the coverage of the four exons rather than plotting each exon on an individual pdf page.

# 9 Final considerations

Depending on the length of the target sequence, you may be able to synthesize a high sensitivity probe that includes 20 rather than 10 target-hybridizing pairs (See BrainFlow methods or the PrimFlow RNA literature for more information).

Also, it is worth noting that there are no hard cutoffs for what will work as a probe in the assay even if all the data looks as it should. All custom target probes designed using these plots will ultimately have to be validated at the bench.

Good luck and happy sorting!

# 10 Reproducibility

The *[brainflowprobes](https://bioconductor.org/packages/3.11/brainflowprobes)* package was made possible thanks to:

* R ([R Core Team, 2020](https://www.R-project.org/))
* *[BiocStyle](https://bioconductor.org/packages/3.11/BiocStyle)* ([Oleś, Morgan, and Huber, 2020](https://github.com/Bioconductor/BiocStyle))
* *[Biostrings](https://bioconductor.org/packages/3.11/Biostrings)* ([Pagès, Aboyoun, Gentleman, and DebRoy, 2020](#bib-Pages_2020))
* *[BSgenome.Hsapiens.UCSC.hg19](https://bioconductor.org/packages/3.11/BSgenome.Hsapiens.UCSC.hg19)* ([Team, 2020](#bib-Team_2020))
* *[bumphunter](https://bioconductor.org/packages/3.11/bumphunter)* ([Jaffe, Murakami, Lee, Leek, et al., 2012](https://doi.org/10.1093/ije/dyr238))
* *[cowplot](https://CRAN.R-project.org/package%3Dcowplot)* ([Wilke, 2019](https://CRAN.R-project.org/package%3Dcowplot))
* *[derfinder](https://bioconductor.org/packages/3.11/derfinder)* ([Collado-Torres, Nellore, Frazee, Wilks, et al., 2017](http://nar.oxfordjournals.org/content/early/2016/09/29/nar.gkw852))
* *[derfinderPlot](https://bioconductor.org/packages/3.11/derfinderPlot)* ([Collado-Torres, Jaffe, and Leek, 2017](http://www.bioconductor.org/packages/derfinderPlot))
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* ([Csárdi, core, Wickham, Chang, et al., 2018](https://CRAN.R-project.org/package%3Dsessioninfo))
* *[GenomicRanges](https://bioconductor.org/packages/3.11/GenomicRanges)* ([Lawrence, Huber, Pagès, Aboyoun, et al., 2013](http://www.ploscompbiol.org/article/info%3Adoi/10.1371/journal.pcbi.1003118))
* *[GenomicState](https://bioconductor.org/packages/3.11/GenomicState)* ([Collado-Torres, 2019](https://github.com/LieberInstitute/GenomicState))
* *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* ([Wickham, 2016](https://ggplot2.tidyverse.org))
* *[knitcitations](https://CRAN.R-project.org/package%3Dknitcitations)* ([Boettiger, 2019](https://CRAN.R-project.org/package%3Dknitcitations))
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* ([Xie, 2014](http://www.crcpress.com/product/isbn/9781466561595))
* *[RColorBrewer](https://CRAN.R-project.org/package%3DRColorBrewer)* ([Neuwirth, 2014](https://CRAN.R-project.org/package%3DRColorBrewer))
* *[rtracklayer](https://bioconductor.org/packages/3.11/rtracklayer)* ([Lawrence, Gentleman, and Carey, 2009](http://bioinformatics.oxfordjournals.org/content/25/14/1841.abstract))
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* ([Allaire, Xie, McPherson, Luraschi, et al., 2020](https://github.com/rstudio/rmarkdown))
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* ([Wickham, 2011](https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf))

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("brainflowprobes-vignette.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("brainflowprobes-vignette.Rmd", tangle = TRUE)
```

```
## Clean up
file.remove("brainflowprobes_ref.bib")
```

```
## [1] TRUE
```

Date the vignette was generated.

```
## [1] "2020-04-28 00:30:01 EDT"
```

Wallclock time spent generating the vignette.

```
## Time difference of 41.613 secs
```

`R` session information.

```
## ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
##  setting  value
##  version  R version 4.0.0 (2020-04-24)
##  os       Ubuntu 18.04.4 LTS
##  system   x86_64, linux-gnu
##  ui       X11
##  language (EN)
##  collate  C
##  ctype    en_US.UTF-8
##  tz       America/New_York
##  date     2020-04-28
##
## ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
##  package                     * version  date       lib source
##  acepack                       1.4.1    2016-10-29 [2] CRAN (R 4.0.0)
##  AnnotationDbi                 1.50.0   2020-04-27 [2] Bioconductor
##  AnnotationFilter              1.12.0   2020-04-27 [2] Bioconductor
##  AnnotationHub                 2.20.0   2020-04-27 [2] Bioconductor
##  askpass                       1.1      2019-01-13 [2] CRAN (R 4.0.0)
##  assertthat                    0.2.1    2019-03-21 [2] CRAN (R 4.0.0)
##  backports                     1.1.6    2020-04-05 [2] CRAN (R 4.0.0)
##  base64enc                     0.1-3    2015-07-28 [2] CRAN (R 4.0.0)
##  bibtex                        0.4.2.2  2020-01-02 [2] CRAN (R 4.0.0)
##  Biobase                       2.48.0   2020-04-27 [2] Bioconductor
##  BiocFileCache                 1.12.0   2020-04-27 [2] Bioconductor
##  BiocGenerics                  0.34.0   2020-04-27 [2] Bioconductor
##  BiocManager                   1.30.10  2019-11-16 [2] CRAN (R 4.0.0)
##  BiocParallel                  1.22.0   2020-04-27 [2] Bioconductor
##  BiocStyle                   * 2.16.0   2020-04-27 [2] Bioconductor
##  BiocVersion                   3.11.1   2020-04-27 [2] Bioconductor
##  biomaRt                       2.44.0   2020-04-27 [2] Bioconductor
##  Biostrings                    2.56.0   2020-04-27 [2] Bioconductor
##  biovizBase                    1.36.0   2020-04-27 [2] Bioconductor
##  bit                           1.1-15.2 2020-02-10 [2] CRAN (R 4.0.0)
##  bit64                         0.9-7    2017-05-08 [2] CRAN (R 4.0.0)
##  bitops                        1.0-6    2013-08-17 [2] CRAN (R 4.0.0)
##  blob                          1.2.1    2020-01-20 [2] CRAN (R 4.0.0)
##  bookdown                      0.18     2020-03-05 [2] CRAN (R 4.0.0)
##  brainflowprobes             * 1.2.0    2020-04-27 [1] Bioconductor
##  BSgenome                      1.56.0   2020-04-27 [2] Bioconductor
##  BSgenome.Hsapiens.UCSC.hg19   1.4.3    2020-04-25 [2] Bioconductor
##  bumphunter                    1.30.0   2020-04-27 [2] Bioconductor
##  checkmate                     2.0.0    2020-02-06 [2] CRAN (R 4.0.0)
##  cli                           2.0.2    2020-02-28 [2] CRAN (R 4.0.0)
##  cluster                       2.1.0    2019-06-19 [2] CRAN (R 4.0.0)
##  codetools                     0.2-16   2018-12-24 [2] CRAN (R 4.0.0)
##  colorspace                    1.4-1    2019-03-18 [2] CRAN (R 4.0.0)
##  cowplot                       1.0.0    2019-07-11 [2] CRAN (R 4.0.0)
##  crayon                        1.3.4    2017-09-16 [2] CRAN (R 4.0.0)
##  curl                          4.3      2019-12-02 [2] CRAN (R 4.0.0)
##  data.table                    1.12.8   2019-12-09 [2] CRAN (R 4.0.0)
##  DBI                           1.1.0    2019-12-15 [2] CRAN (R 4.0.0)
##  dbplyr                        1.4.3    2020-04-19 [2] CRAN (R 4.0.0)
##  DelayedArray                  0.14.0   2020-04-27 [2] Bioconductor
##  derfinder                     1.22.0   2020-04-27 [2] Bioconductor
##  derfinderHelper               1.22.0   2020-04-27 [2] Bioconductor
##  derfinderPlot                 1.22.0   2020-04-27 [2] Bioconductor
##  dichromat                     2.0-0    2013-01-24 [2] CRAN (R 4.0.0)
##  digest                        0.6.25   2020-02-23 [2] CRAN (R 4.0.0)
##  doRNG                         1.8.2    2020-01-27 [2] CRAN (R 4.0.0)
##  dplyr                         0.8.5    2020-03-07 [2] CRAN (R 4.0.0)
##  ellipsis                      0.3.0    2019-09-20 [2] CRAN (R 4.0.0)
##  ensembldb                     2.12.0   2020-04-27 [2] Bioconductor
##  evaluate                      0.14     2019-05-28 [2] CRAN (R 4.0.0)
##  fansi                         0.4.1    2020-01-08 [2] CRAN (R 4.0.0)
##  fastmap                       1.0.1    2019-10-08 [2] CRAN (R 4.0.0)
##  foreach                       1.5.0    2020-03-30 [2] CRAN (R 4.0.0)
##  foreign                       0.8-79   2020-04-26 [2] CRAN (R 4.0.0)
##  Formula                       1.2-3    2018-05-03 [2] CRAN (R 4.0.0)
##  generics                      0.0.2    2018-11-29 [2] CRAN (R 4.0.0)
##  GenomeInfoDb                  1.24.0   2020-04-27 [2] Bioconductor
##  GenomeInfoDbData              1.2.3    2020-04-24 [2] Bioconductor
##  GenomicAlignments             1.24.0   2020-04-27 [2] Bioconductor
##  GenomicFeatures               1.40.0   2020-04-27 [2] Bioconductor
##  GenomicFiles                  1.24.0   2020-04-27 [2] Bioconductor
##  GenomicRanges                 1.40.0   2020-04-27 [2] Bioconductor
##  GenomicState                  0.99.9   2020-04-25 [2] Bioconductor
##  GGally                        1.5.0    2020-03-25 [2] CRAN (R 4.0.0)
##  ggbio                         1.36.0   2020-04-27 [2] Bioconductor
##  ggplot2                       3.3.0    2020-03-05 [2] CRAN (R 4.0.0)
##  glue                          1.4.0    2020-04-03 [2] CRAN (R 4.0.0)
##  graph                         1.66.0   2020-04-27 [2] Bioconductor
##  gridExtra                     2.3      2017-09-09 [2] CRAN (R 4.0.0)
##  gtable                        0.3.0    2019-03-25 [2] CRAN (R 4.0.0)
##  Hmisc                         4.4-0    2020-03-23 [2] CRAN (R 4.0.0)
##  hms                           0.5.3    2020-01-08 [2] CRAN (R 4.0.0)
##  htmlTable                     1.13.3   2019-12-04 [2] CRAN (R 4.0.0)
##  htmltools                     0.4.0    2019-10-04 [2] CRAN (R 4.0.0)
##  htmlwidgets                   1.5.1    2019-10-08 [2] CRAN (R 4.0.0)
##  httpuv                        1.5.2    2019-09-11 [2] CRAN (R 4.0.0)
##  httr                          1.4.1    2019-08-05 [2] CRAN (R 4.0.0)
##  interactiveDisplayBase        1.26.0   2020-04-27 [2] Bioconductor
##  IRanges                       2.22.0   2020-04-27 [2] Bioconductor
##  iterators                     1.0.12   2019-07-26 [2] CRAN (R 4.0.0)
##  jpeg                          0.1-8.1  2019-10-24 [2] CRAN (R 4.0.0)
##  jsonlite                      1.6.1    2020-02-02 [2] CRAN (R 4.0.0)
##  knitcitations               * 1.0.10   2019-09-15 [2] CRAN (R 4.0.0)
##  knitr                         1.28     2020-02-06 [2] CRAN (R 4.0.0)
##  later                         1.0.0    2019-10-04 [2] CRAN (R 4.0.0)
##  lattice                       0.20-41  2020-04-02 [2] CRAN (R 4.0.0)
##  latticeExtra                  0.6-29   2019-12-19 [2] CRAN (R 4.0.0)
##  lazyeval                      0.2.2    2019-03-15 [2] CRAN (R 4.0.0)
##  lifecycle                     0.2.0    2020-03-06 [2] CRAN (R 4.0.0)
##  limma                         3.44.0   2020-04-27 [2] Bioconductor
##  locfit                        1.5-9.4  2020-03-25 [2] CRAN (R 4.0.0)
##  lubridate                     1.7.8    2020-04-06 [2] CRAN (R 4.0.0)
##  magrittr                      1.5      2014-11-22 [2] CRAN (R 4.0.0)
##  Matrix                        1.2-18   2019-11-27 [2] CRAN (R 4.0.0)
##  matrixStats                   0.56.0   2020-03-13 [2] CRAN (R 4.0.0)
##  memoise                       1.1.0    2017-04-21 [2] CRAN (R 4.0.0)
##  mime                          0.9      2020-02-04 [2] CRAN (R 4.0.0)
##  munsell                       0.5.0    2018-06-12 [2] CRAN (R 4.0.0)
##  nnet                          7.3-14   2020-04-26 [2] CRAN (R 4.0.0)
##  openssl                       1.4.1    2019-07-18 [2] CRAN (R 4.0.0)
##  OrganismDbi                   1.30.0   2020-04-27 [2] Bioconductor
##  pillar                        1.4.3    2019-12-20 [2] CRAN (R 4.0.0)
##  pkgconfig                     2.0.3    2019-09-22 [2] CRAN (R 4.0.0)
##  plyr                          1.8.6    2020-03-03 [2] CRAN (R 4.0.0)
##  png                           0.1-7    2013-12-03 [2] CRAN (R 4.0.0)
##  prettyunits                   1.1.1    2020-01-24 [2] CRAN (R 4.0.0)
##  progress                      1.2.2    2019-05-16 [2] CRAN (R 4.0.0)
##  promises                      1.1.0    2019-10-04 [2] CRAN (R 4.0.0)
##  ProtGenerics                  1.20.0   2020-04-27 [2] Bioconductor
##  purrr                         0.3.4    2020-04-17 [2] CRAN (R 4.0.0)
##  qvalue                        2.20.0   2020-04-27 [2] Bioconductor
##  R6                            2.4.1    2019-11-12 [2] CRAN (R 4.0.0)
##  rappdirs                      0.3.1    2016-03-28 [2] CRAN (R 4.0.0)
##  RBGL                          1.64.0   2020-04-27 [2] Bioconductor
##  RColorBrewer                  1.1-2    2014-12-07 [2] CRAN (R 4.0.0)
##  Rcpp                          1.0.4.6  2020-04-09 [2] CRAN (R 4.0.0)
##  RCurl                         1.98-1.2 2020-04-18 [2] CRAN (R 4.0.0)
##  RefManageR                    1.2.12   2019-04-03 [2] CRAN (R 4.0.0)
##  reshape                       0.8.8    2018-10-23 [2] CRAN (R 4.0.0)
##  reshape2                      1.4.4    2020-04-09 [2] CRAN (R 4.0.0)
##  rlang                         0.4.5    2020-03-01 [2] CRAN (R 4.0.0)
##  rmarkdown                     2.1      2020-01-20 [2] CRAN (R 4.0.0)
##  rngtools                      1.5      2020-01-23 [2] CRAN (R 4.0.0)
##  rpart                         4.1-15   2019-04-12 [2] CRAN (R 4.0.0)
##  Rsamtools                     2.4.0    2020-04-27 [2] Bioconductor
##  RSQLite                       2.2.0    2020-01-07 [2] CRAN (R 4.0.0)
##  rstudioapi                    0.11     2020-02-07 [2] CRAN (R 4.0.0)
##  rtracklayer                   1.48.0   2020-04-27 [2] Bioconductor
##  S4Vectors                     0.26.0   2020-04-27 [2] Bioconductor
##  scales                        1.1.0    2019-11-18 [2] CRAN (R 4.0.0)
##  sessioninfo                 * 1.1.1    2018-11-05 [2] CRAN (R 4.0.0)
##  shiny                         1.4.0.2  2020-03-13 [2] CRAN (R 4.0.0)
##  stringi                       1.4.6    2020-02-17 [2] CRAN (R 4.0.0)
##  stringr                       1.4.0    2019-02-10 [2] CRAN (R 4.0.0)
##  SummarizedExperiment          1.18.0   2020-04-27 [2] Bioconductor
##  survival                      3.1-12   2020-04-10 [2] CRAN (R 4.0.0)
##  tibble                        3.0.1    2020-04-20 [2] CRAN (R 4.0.0)
##  tidyselect                    1.0.0    2020-01-27 [2] CRAN (R 4.0.0)
##  VariantAnnotation             1.34.0   2020-04-27 [2] Bioconductor
##  vctrs                         0.2.4    2020-03-10 [2] CRAN (R 4.0.0)
##  withr                         2.2.0    2020-04-20 [2] CRAN (R 4.0.0)
##  xfun                          0.13     2020-04-13 [2] CRAN (R 4.0.0)
##  XML                           3.99-0.3 2020-01-20 [2] CRAN (R 4.0.0)
##  xml2                          1.3.2    2020-04-23 [2] CRAN (R 4.0.0)
##  xtable                        1.8-4    2019-04-21 [2] CRAN (R 4.0.0)
##  XVector                       0.28.0   2020-04-27 [2] Bioconductor
##  yaml                          2.2.1    2020-02-01 [2] CRAN (R 4.0.0)
##  zlibbioc                      1.34.0   2020-04-27 [2] Bioconductor
##
## [1] /tmp/RtmpufXiB5/Rinst222c278b84ca
## [2] /home/biocbuild/bbs-3.11-bioc/R/library
```

# 11 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.11/BiocStyle)* ([Oleś, Morgan, and Huber, 2020](https://github.com/Bioconductor/BiocStyle))
with *[knitr](https://CRAN.R-project.org/package%3Dknitr)* ([Xie, 2014](http://www.crcpress.com/product/isbn/9781466561595)) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* ([Allaire, Xie, McPherson, Luraschi, et al., 2020](https://github.com/rstudio/rmarkdown)) running behind the scenes.

Citations made with *[knitcitations](https://CRAN.R-project.org/package%3Dknitcitations)* ([Boettiger, 2019](https://CRAN.R-project.org/package%3Dknitcitations)).

[1] J. Allaire, Y. Xie, J. McPherson, J. Luraschi, et al. *rmarkdown: Dynamic Documents for R*. R package
version 2.1. 2020. <URL: <https://github.com/rstudio/rmarkdown>>.

[2] C. Boettiger. *knitcitations: Citations for ‘Knitr’ Markdown Files*. R package version 1.0.10. 2019.
<URL: [https://CRAN.R-project.org/package=knitcitations](https://CRAN.R-project.org/package%3Dknitcitations)>.

[3] L. Collado-Torres. *GenomicState: Build and access GenomicState objects for use with derfinder tools
from sources like Gencode*. R package version 0.99.9. 2019. <URL:
<https://github.com/LieberInstitute/GenomicState>>.

[4] L. Collado-Torres, A. E. Jaffe, and J. T. Leek. *derfinderPlot: Plotting functions for derfinder*.
<https://github.com/leekgroup/derfinderPlot> - R package version 1.22.0. 2017. DOI:
10.18129/B9.bioc.derfinderPlot. <URL: <http://www.bioconductor.org/packages/derfinderPlot>>.

[5] L. Collado-Torres, A. Nellore, A. C. Frazee, C. Wilks, et al. “Flexible expressed region analysis for
RNA-seq with derfinder”. In: *Nucl. Acids Res.* (2017). DOI: 10.1093/nar/gkw852. <URL:
<http://nar.oxfordjournals.org/content/early/2016/09/29/nar.gkw852>>.

[6] G. Csárdi, R. core, H. Wickham, W. Chang, et al. *sessioninfo: R Session Information*. R package
version 1.1.1. 2018. <URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)>.

[7] A. E. Jaffe, P. Murakami, H. Lee, J. T. Leek, et al. “Bump hunting to identify differentially
methylated regions in epigenetic epidemiology studies”. In: *International journal of epidemiology* 41.1
(2012), pp. 200-209. DOI: 10.1093/ije/dyr238.

[8] M. Lawrence, R. Gentleman, and V. Carey. “rtracklayer: an R package for interfacing with genome
browsers”. In: *Bioinformatics* 25 (2009), pp. 1841-1842. DOI: 10.1093/bioinformatics/btp328. <URL:
<http://bioinformatics.oxfordjournals.org/content/25/14/1841.abstract>>.

[9] M. Lawrence, W. Huber, H. Pagès, P. Aboyoun, et al. “Software for Computing and Annotating Genomic
Ranges”. In: *PLoS Computational Biology* 9 (8 2013). DOI: 10.1371/journal.pcbi.1003118. <URL:
[http://www.ploscompbiol.org/article/info%3Adoi%2F10.1371%2Fjournal.pcbi.1003118](http://www.ploscompbiol.org/article/info%3Adoi/10.1371/journal.pcbi.1003118)}.>

[10] E. Neuwirth. *RColorBrewer: ColorBrewer Palettes*. R package version 1.1-2. 2014. <URL:
[https://CRAN.R-project.org/package=RColorBrewer](https://CRAN.R-project.org/package%3DRColorBrewer)>.

[11] A. Oleś, M. Morgan, and W. Huber. *BiocStyle: Standard styles for vignettes and other Bioconductor
documents*. R package version 2.16.0. 2020. <URL: <https://github.com/Bioconductor/BiocStyle>>.

[12] H. Pagès, P. Aboyoun, R. Gentleman, and S. DebRoy. *Biostrings: Efficient manipulation of biological
strings*. R package version 2.56.0. 2020.

[13] R Core Team. *R: A Language and Environment for Statistical Computing*. R Foundation for Statistical
Computing. Vienna, Austria, 2020. <URL: <https://www.R-project.org/>>.

[14] T. B. D. Team. *BSgenome.Hsapiens.UCSC.hg19: Full genome sequences for Homo sapiens (UCSC version
hg19, based on GRCh37.p13)*. R package version 1.4.3. 2020.

[15] H. Wickham. *ggplot2: Elegant Graphics for Data Analysis*. Springer-Verlag New York, 2016. ISBN:
978-3-319-24277-4. <URL: <https://ggplot2.tidyverse.org>>.

[16] H. Wickham. “testthat: Get Started with Testing”. In: *The R Journal* 3 (2011), pp. 5-10. <URL:
<https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>>.

[17] C. Wilke. *cowplot: Streamlined Plot Theme and Plot Annotations for ‘ggplot2’*. R package version
1.0.0. 2019. <URL: [https://CRAN.R-project.org/package=cowplot](https://CRAN.R-project.org/package%3Dcowplot)>.

[18] Y. Xie. “knitr: A Comprehensive Tool for Reproducible Research in R”. In: *Implementing Reproducible
Computational Research*. Ed. by V. Stodden, F. Leisch and R. D. Peng. ISBN 978-1466561595. Chapman and
Hall/CRC, 2014. <URL: <http://www.crcpress.com/product/isbn/9781466561595>>.
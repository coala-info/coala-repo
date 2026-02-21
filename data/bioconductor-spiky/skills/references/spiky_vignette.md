# Spiky: Analysing cfMeDIP-seq data with spike-in controls

#### Samantha L Wilson and Lauren M Harmon

#### February 8, 2021

# Introduction

To meet the need for a reference control in cell-free methylated DNA immunoprecipitation-sequencing (cfMeDIP-seq)[1](#ref-shen2018sensitive),[2](#ref-shen2019preparation) experiments, we designed spike-in controls and ligated unique molecular indexes (UMI) to adjust for PCR bias, and immunoprecipitation bias caused by the fragment length, G+C content, and CpG density of the DNA fragments that are immunoprecipitated[3](#ref-wilson2022spikeins). This enables absolute quantification of methylated DNA in picomoles, while retaining epigenomic information that allows for sensitive, tissue-specific detection as well as comparable results between different experiments. We designed DNA fragments with 2x3x3x3=54 combinations of methylation status (methylated and unmethylated), fragment length in basepair (bp) (80 bp, 160 bp, 320 bp), G+C content (35%, 50%, 65%), and fraction of CpGs within a fragment (1 CpG/ 80 bp, 1 CpG/ 40 bp, 1 CpG/ 20 bp). Spiky was developed for analyzing DNA methylation of cell-free DNA obtained from cfMeDIP-seq method using reference ‘spike-in’ controls. This package will:

* Assess methylation specificity in each sample
* Using the spike-in control data, output a Gaussian generalized linear model to predict molar amount on DNA samples
* Predict molar amount (picomoles) for each DNA sequence of interest, adjusting for fragment length G+C content and CpG fraction
* Adjust molar amount and bin the fragments into genomic windows used in analyses

# Installation

Install and load the spiky package from Bioconductor.

```
#To install this package, start R (version "3.6" or later) and enter:
  #if (!requireNamespace("BiocManager", quietly = TRUE))
  #  install.packages("BiocManager")
  #
  #BiocManager::install("spiky")

library(spiky)
```

# Load spike database, or create your own with process\_spikes().

### Input: A Fasta file, GRanges, or dataframe of spike-in sequences, and a vector of booleans (0 or 1) describing whether each spike-in sequence is methylated.

### Output: The output contains a DataFrame with the following columns:

*sequence (DNAStringSet)* methylated (boolean) *CpGs (integer)* fmol (numeric) *molmass (numeric)* GCfrac (numeric) *OECpG (numeric)* conc (numeric) \*frag\_grp (character)

If you are using the same synthetic spike-in sequences as described in the manuscript, you may load the spike-in sequence database using:

```
data(spike)
```

If you are using custom spike-ins, you can create your own spike-in sequence database using the process\_spikes() function, which accepts as input a Fasta file, GRanges, or dataframe, and a vector of booleans (0 or 1) describing whether each spike-in sequence is methylated. The input Fasta file can also be generated from BAM header info as follows:

```
sb <- system.file("extdata", "example.spike.bam", package="spiky",              mustWork=TRUE)
outFasta <- paste(system.file("extdata", package="spiky", mustWork=TRUE),"/spike_contigs.fa",sep="")
show(generate_spike_fasta(sb, spike=spike,fa=outFasta))
#> Wrote /tmp/RtmpsgJsoG/Rbuild33abbe4747cf90/spiky/inst/extdata/spike_contigs.fa
#> DNAStringSet object of length 52:
#>      width seq                                              names
#>  [1]   160 CTTTACTACTGAATGTAAGCTCT...TTTACTATAACCGATTACACAT 160b_2C_35G-2_meth
#>  [2]   160 GTAACATGGTTACCACTGGGACC...ACTAGCCGTGTCCCAACCTCAT 160b_2C_50G-2_meth
#>  [3]   160 GACTCCTCCCTAGGCCCCCATGG...CATGCAGGCCCCCCGCTCCATC 160b_2C_65G-2_meth
#>  [4]   160 GTATAATCATAACAAAGGCCTAA...AGCGACTAAGATCTCAGAATTA 160b_4C_35G-2_mod...
#>  [5]   160 AGCCTTGGACGTGAGTCTCTGTT...ACAATTGTCAGGGCCCTCCAGT 160b_4C_50G-1_meth
#>  ...   ... ...
#> [48]    80 ACAACACCCTCCACCCAATACTT...AAGTCAGTCAAATGCCTGTAAC 80b_2C_50G-1
#> [49]    80 CACCTTGAGACCTCCAGAGGGGG...GTGCGCAGGGGGGAAGGGGGGC 80b_2C_65G-1
#> [50]    80 AAGGCATTACTTATCTAATCAAT...TTTGTACTCGTAGACGAAATTG 80b_4C_35G-1
#> [51]    80 AGTCATCAGCATATTGTCAGTAC...TACTCCTAGTGGGCTGCGTGGT 80b_4C_50G-1
#> [52]    80 TTGGGAGGCTCTGGACTGGGGCA...CGTCCCCCCCCATCCTCTCCGC 80b_4C_65G-1
```

The spike-in database can then be created with this input Fasta.

```
spikes <- system.file("extdata", "spikes.fa", package="spiky", mustWork=TRUE)
spikemeth <- spike$methylated
process_spikes(spikes, spikemeth)
#> DataFrame with 52 rows and 5 columns
#>                               sequence methylated      CpGs    GCfrac     OECpG
#>                         <DNAStringSet>  <numeric> <integer> <numeric> <numeric>
#> 80b_1C_35G-1   TAGGATATAG...AAATTATGCT          0         1      0.35      0.29
#> 80b_1C_35G-2   TGTCTAAATT...AAGAACATAT          1         1      0.35      0.29
#> 80b_2C_35G-1   TCTAATACTC...AATCCATAAG          0         2      0.35      0.57
#> 80b_2C_35G-2   CTCAAATATA...CAATAACACT          1         2      0.35      0.57
#> 80b_4C_35G-1   AAGGCATTAC...GACGAAATTG          0         4      0.35      1.14
#> ...                                ...        ...       ...       ...       ...
#> 320b_4C_65G-2  GCAATTGATG...AAGAAGCTAA          0         4      0.35      0.29
#> 320b_8C_65G-1  CCCATGCATC...TCTTACCAGT          1         8      0.50      0.40
#> 320b_8C_65G-2  GAACTTCCAA...ATGCTATGCA          0         8      0.50      0.40
#> 320b_16C_65G-1 TTCGGCACTT...GCTTAAGAAA          1        16      0.50      0.80
#> 320b_16C_65G-2 TTGGGCCGCC...CTGAGATTGT          0        16      0.50      0.80
```

# Process the input files

Spiky supports input files in either BAM or BEDPE format.

### BAM Input

BAM file in standard format (For full details about the BAM format, see <https://samtools.github.io/hts-specs/SAMv1.pdf>). The BAM must also have an accompanying index file, which can be created using samtools index ${filename.bam}. (<http://www.htslib.org/doc/samtools-index.html>)

# BAM required columns

* BAM file
* Columns:
  + chrom/contig: string
  + position start: numeric
  + position end: numeric
  + read counts: integer
  + fragment length (bp): integer

### Output: The output objects will be used downstream in the analysis, including

* genomic\_coverage - A GRanges object showing the genomic coverage of the BAM reads
* spikes\_coverage - A GRanges object showing the coverage of the spikes.

```
genomic_bam_path <- system.file("extdata", "example_chr21.bam", package="spiky", mustWork=TRUE)
genomic_coverage <- scan_genomic_contigs(genomic_bam_path,spike=spike)
#> Warning in find_spike_contigs(si, spike = spike): Cannot resolve contig name mismatches with spike database names. Your file may not have any spikes, or the spike database might not contain them.
#> Tiling 300bp bins across the genome...Done.
#> Binning genomic coverage...
#> Binning genomic coverage...Done.
#> Done.
spike_bam_path <- system.file("extdata", "example.spike.bam", package="spiky", mustWork=TRUE)
spikes_coverage <- scan_spike_contigs(spike_bam_path,spike=spike)
#> Summarizing spike-in counts...Done.
```

### BEDPE Input

BEDPE file in standard format. For full details about the BEDPE format, see Bedtools documentation (<https://bedtools.readthedocs.io/en/latest/content/general-usage.html#bedpe-format>). In short, for a pair of ranges 1 and 2, we have fields chrom1, start1, end1, chrom2, start2, end2, and (optionally) name, score, strand1, strand2, plus any other user defined fields that may be included (these are not yet supported by Spiky). For example, two valid BEDPE lines are:

chr1 100 200 chr5 5000 5100 bedpe\_example1 30

chr9 900 5000 chr9 3000 3800 bedpe\_example2 99 + -

The BEDPE must also have an accompanying index file, which can be created using Bedtools, as in the example shown below, where ${file} represents the name of a BEDPE file.

bedtools sort -i \({file} > sorted\_\){file} bgzip sorted\_\({file} tabix sorted\_\){file}.gz

### Output: The output objects will be used downstream in the analysis, including

* genomic\_coverage - A GRanges object showing the genomic coverage of the BAM reads
* spikes\_coverage - A GRanges object showing the coverage of the spikes.

```
genomic_bedpe_path <- system.file("extdata", "example_chr21_bedpe.bed.gz", package="spiky", mustWork=TRUE)
genomic_coverage <- scan_genomic_bedpe(genomic_bedpe_path,genome="hg38")
#> Tiling 300bp bins across the genome...Done.
#> Binning genomic coverage...
#> Binning genomic coverage...Done.
#> Done.
spike_bedpe_path <- system.file("extdata", "example_spike_bedpe.bed.gz", package="spiky", mustWork=TRUE)
spikes_coverage <- scan_spike_bedpe(spike_bedpe_path,spike=spike)
#> Warning in .toPairs(res): NAs introduced by coercion
#> Summarizing spike-in counts...Done.
```

# Methylation specificity

For each combination of parameters, we designed two distinct spike-in sequences. One to be methylated and one to be unmethylated. The allows us to assess non-specific binding of the monoclonal antibody on a sample-by-sample basis. To calculate methylation specificity we take the number of methylated reads divided by the total number of reads. It is our recommendation that if methylation specificity is <0.98, then the sample should be flagged or removed from analysis as the cfMeDIP performed inadequately.

This calculation is done by the ‘methylation\_specificity’ function.

### Input: The output of the ‘scan\_spike\_contigs’ or ‘scan\_spike\_bedpe’ functions

* spikes\_coverage as produced previously
* spike database as produced previously

### Output: methylation specificity mean and median

* Mean and median of the percent of methylated sequences for each spike-in after cfMeDIP-seq has been performed

### Example

```
##Calculate methylation specificity
methyl_spec <- methylation_specificity(spikes_coverage,spike=spike)
print(methyl_spec)
#> $mean
#> [1] 0.8856087
#>
#> $median
#> [1] 0.9708432
```

# Fit a Gaussian model to predict the molar amount of DNA sequences

For each batch of samples, the coefficients used in the Gaussian generalized linear model will differ. The ‘model\_glm\_pmol’ will calculate these coefficients and output the model to be used to calculate molar amount (picomoles) on the user’s DNA sequences of interest. We assume that all DNA sequences of interest are methylated after undergoing cfMeDIP-seq. As such, we build the Gaussian generalized linear model on only the methylated spike-in control fragments. A generated Bland-Altman plot will visualize how well the model performs.

### Input: The output of the ‘scan\_spike\_contigs’ or ‘scan\_spike\_bedpe’ functions

* spikes\_coverage as produced previously
* spike database as produced previously

### Output:

* Gaussian generalized linear model with coefficients specific to samples used in input data; .rda file

### Example

```
## Build the Gaussian generalized linear model on the spike-in control data
gaussian_glm <- model_glm_pmol(spikes_coverage,spike=spike)
#> Converting x (a coverage result?) to a data.frame...
summary(gaussian_glm)
#>
#> Call:
#> glm(formula = conc ~ read_count + fraglen + GC + CpG_3, data = x)
#>
#> Coefficients:
#>               Estimate Std. Error t value Pr(>|t|)
#> (Intercept)  3.914e-03  4.919e-04   7.958 8.96e-08 ***
#> read_count  -1.946e-08  9.913e-09  -1.964    0.063 .
#> fraglen     -1.149e-05  1.295e-06  -8.873 1.50e-08 ***
#> GC           3.702e-06  7.407e-06   0.500    0.622
#> CpG_3        1.719e-04  2.894e-04   0.594    0.559
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#>
#> (Dispersion parameter for gaussian family taken to be 1.733019e-07)
#>
#>     Null deviance: 3.3927e-05  on 25  degrees of freedom
#> Residual deviance: 3.6393e-06  on 21  degrees of freedom
#> AIC: -324.54
#>
#> Number of Fisher Scoring iterations: 2
```

# Calculating molar amount on DNA sequences of interest

For the samples in which the Gaussian generalized linear model was built, we will calculate the molar amount (picomoles) for each DNA sequence of interest.

### Input: The output of the ‘scan\_genomic\_contigs’ or ‘scan\_genomic\_bedpe’ functions and the Gaussian generalized linear model

* genomic\_coverage as produced previously
* gaussian\_glm as produced previously

### Output: sample\_pmol\_data

* Data frame
* Columns:
  + chrom: string
  + bin position start: numeric
  + bin position end: numeric
  + read counts: coverage of bin
  + fragment length (bp): integer
  + G+C content [0-1]: numeric
  + CpG number: numeric
  + pmol: numeric

### Example

```
# Predict pmol concentration
# To select a genome other than hg38, use BSgenome::available.packages() to find valid BSgenome name
#library("BSgenome.Hsapiens.UCSC.hg38")
sample_data_pmol <- predict_pmol(gaussian_glm, genomic_coverage,bsgenome="BSgenome.Hsapiens.UCSC.hg38",ret="df")
#> Adjusting for bin-level biases...
#> Attempting to load BSgenome.Hsapiens.UCSC.hg38...
#> OK.
#> Done.
#> Starting pmol prediction...
#> Done.
head(sample_data_pmol,n=1)
#>                         chrom range.start range.end
#> chr21:30201601-30201900 chr21    30201601  30201900
#>                                                                                                                                                                                                                                                                                                                             sequence
#> chr21:30201601-30201900 AGGAAGGGGTTCAGTTTCAGTTTTCTGCATATGGCTAGCCAGTTTTCTCAACACCTTTTATTAAATAGGGAATCATTTCCCCATTGCTTGTTTTTGTCAGGTTTGTCAAAGATGAGATGGTTGTAGACGTGCGGTGTTATTTCTGAGGCCTCTGTTCTGTTCCATTGGTCTATATATCTGTTTTGGTATCAGTATCATGCTGTTTTTGTTACTGTAGCCTTGTAGTATAGTTTGAAGTCAGGTAGTGTGATGCCTCCAGCTTTGTTCTTTTTGTTTAGAATTGTCTTGGCTATACAGGCT
#>                         read_count fraglen        GC    CpG_3    pred_conc
#> chr21:30201601-30201900        1.8     300 0.3933333 1.259921 0.0006848288
```

# Adjusting molar amount to binned genomic windows

For our analyses, we binned the genome into 300 bp non-overlapping windows. We then look overlap between fragments in our data with each of the 300 bp genomic windows. We adjust the molar amount (picomoles) by a multiplier. This multiplier is the proportion of overlap between our fragment and the 300 bp window. This is done for every fragment in our sample.

### Input: output dataframe produced from predict\_pmol

* Example: sample\_pmol\_data as produced in previous step

### Output: sample\_binned\_data

* Data frame
* Columns:
  + chrom: string
  + bin position start: numeric
  + bin position end: numeric
  + read counts: coverage of bin
  + fragment length (bp): integer
  + G+C content [0-1]: numeric
  + CpG number: numeric
  + pmol: numeric
  + adjusted pmol: numeric

### Example

```
sample_binned_data <- bin_pmol(sample_data_pmol)
head(sample_binned_data,n=1)
#>                         chrom range.start range.end
#> chr21:30201601-30201900 chr21    30201601  30201900
#>                                                                                                                                                                                                                                                                                                                             sequence
#> chr21:30201601-30201900 AGGAAGGGGTTCAGTTTCAGTTTTCTGCATATGGCTAGCCAGTTTTCTCAACACCTTTTATTAAATAGGGAATCATTTCCCCATTGCTTGTTTTTGTCAGGTTTGTCAAAGATGAGATGGTTGTAGACGTGCGGTGTTATTTCTGAGGCCTCTGTTCTGTTCCATTGGTCTATATATCTGTTTTGGTATCAGTATCATGCTGTTTTTGTTACTGTAGCCTTGTAGTATAGTTTGAAGTCAGGTAGTGTGATGCCTCCAGCTTTGTTCTTTTTGTTTAGAATTGTCTTGGCTATACAGGCT
#>                         read_count fraglen        GC    CpG_3    pred_conc
#> chr21:30201601-30201900        1.8     300 0.3933333 1.259921 0.0006848288
#>                         adjusted_pred_con
#> chr21:30201601-30201900       0.001232692
```

### Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] BSgenome.Hsapiens.UCSC.hg38_1.4.5 spiky_1.16.0
#>  [3] Rsamtools_2.26.0                  Biostrings_2.78.0
#>  [5] XVector_0.50.0                    GenomicRanges_1.62.0
#>  [7] IRanges_2.44.0                    S4Vectors_0.48.0
#>  [9] Seqinfo_1.0.0                     BiocGenerics_0.56.0
#> [11] generics_0.1.4                    devtools_2.4.6
#> [13] usethis_3.2.1
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1            dplyr_1.1.4
#>  [3] farver_2.1.2                S7_0.2.0
#>  [5] bitops_1.0-9                RCurl_1.98-1.17
#>  [7] fastmap_1.2.0               GenomicAlignments_1.46.0
#>  [9] XML_3.99-0.19               digest_0.6.37
#> [11] lifecycle_1.0.4             ellipsis_0.3.2
#> [13] survival_3.8-3              magrittr_2.0.4
#> [15] compiler_4.5.1              rlang_1.1.6
#> [17] sass_0.4.10                 tools_4.5.1
#> [19] yaml_2.3.10                 rtracklayer_1.70.0
#> [21] knitr_1.50                  S4Arrays_1.10.0
#> [23] curl_7.0.0                  sp_2.2-0
#> [25] pkgbuild_1.4.8              DelayedArray_0.36.0
#> [27] RColorBrewer_1.1-3          pkgload_1.4.1
#> [29] abind_1.4-8                 BiocParallel_1.44.0
#> [31] purrr_1.1.0                 desc_1.4.3
#> [33] grid_4.5.1                  colorspace_2.1-2
#> [35] ggplot2_4.0.0               scales_1.4.0
#> [37] dichromat_2.0-0.1           SummarizedExperiment_1.40.0
#> [39] cli_3.6.5                   mvtnorm_1.3-3
#> [41] rmarkdown_2.30              crayon_1.5.3
#> [43] remotes_2.5.0               rstudioapi_0.17.1
#> [45] MBA_0.1-2                   rjson_0.2.23
#> [47] httr_1.4.7                  sessioninfo_1.2.3
#> [49] cachem_1.1.0                splines_4.5.1
#> [51] parallel_4.5.1              restfulr_0.0.16
#> [53] matrixStats_1.5.0           vctrs_0.6.5
#> [55] Matrix_1.7-4                jsonlite_2.0.0
#> [57] Formula_1.2-5               jquerylib_0.1.4
#> [59] distributions3_0.2.3        BlandAltmanLeh_0.3.1
#> [61] glue_1.8.0                  codetools_0.2-20
#> [63] gtable_0.3.6                GenomeInfoDb_1.46.0
#> [65] bamlss_1.2-5                BiocIO_1.20.0
#> [67] UCSC.utils_1.6.0            tibble_3.3.0
#> [69] pillar_1.11.1               htmltools_0.5.8.1
#> [71] BSgenome_1.78.0             R6_2.6.1
#> [73] rprojroot_2.1.1             evaluate_1.0.5
#> [75] lattice_0.22-7              Biobase_2.70.0
#> [77] cigarillo_1.0.0             memoise_2.0.1
#> [79] bslib_0.9.0                 coda_0.19-4.1
#> [81] SparseArray_1.10.0          nlme_3.1-168
#> [83] mgcv_1.9-3                  xfun_0.53
#> [85] pkgconfig_2.0.3             fs_1.6.6
#> [87] MatrixGenerics_1.22.0
```

# References

1. Shen, S. Y. *et al.* Sensitive tumour detection and classification using plasma cell-free dna methylomes. *Nature* **563**, 579–583 (2018).

2. Shen, S. Y., Burgener, J. M., Bratman, S. V. & De Carvalho, D. D. Preparation of cfMeDIP-seq libraries for methylome profiling of plasma cell-free dna. *Nature protocols* **14**, 2749–2780 (2019).

3. Wilson, S. L. *et al.* Sensitive and reproducible cell-free methylome quantification with synthetic spike-in controls. *Cell Reports Methods* 100294 (2022) doi:[https://doi.org/10.1016/j.crmeth.2022.100294](https://doi.org/https%3A//doi.org/10.1016/j.crmeth.2022.100294).
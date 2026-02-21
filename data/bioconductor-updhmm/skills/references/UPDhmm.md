# UPDhmm User Guide: From Detection to Postprocessing

Marta Sevilla Porras1,2\* and Carlos Ruiz Arenas3\*\*

1Universitat Pompeu Fabra (UPF)
2Centro de Investigación Biomédica en Red (CIBERER)
3Universidad de Navarra (UNAV)

\*marta.sevilla@upf.edu
\*\*cruizarenas@unav.es

#### 2025-10-30

#### Package

UPDhmm 1.6.0

# Background

Uniparental disomy (UPD) is a rare genetic condition where an individual inherits both copies of a chromosome from one parent, as opposed to the typical inheritance of one copy from each parent.
The extent of its contribution as a causative factor in rare genetic diseases remains largely unexplored.

UPDs can lead to disease either by inheriting a carrier pathogenic mutation as homozygous from a carrier parent or by causing errors in genetic imprinting.
Nevertheless, there are currently no standardized methods available for the detection and characterization of these events.

We have developed UPDhmm, an R/Bioconductor package that provides a tool to detect, classify, and locate uniparental disomy events in trio genetic data.

# Method overview

UPDhmm relies on a Hidden Markov Model (HMM) to identify regions with UPD.

In our HMM model, the observations are the genotype combinations of the father, mother, and proband at each genomic variant.
The hidden states represent five inheritance patterns:

* Normal (Mendelian inheritance)
* Maternal isodisomy
* Paternal isodisomy
* Maternal heterodisomy
* Paternal heterodisomy

Emission probabilities were defined based on the expected inheritance patterns, and the Viterbi algorithm was used to infer the most likely sequence of hidden states along the genome.

The final output consists of genomic segments whose inferred state deviates from Mendelian inheritance — i.e., likely UPD regions.

# Set-up the packages

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install("UPDhmm")
BiocManager::install("regioneR")
BiocManager::install("karyoploteR")
```

# Loading libraries

```
library(UPDhmm)
library(dplyr)
```

# Quick start

The input required by the package is a multisample VCF file containing genotypes for a trio (proband, mother, and father).

Requirements:

**Only biallelic variants are supported.**

**Accepted genotype (GT) formats: 0/0, 0/1, 1/0, 1/1 (or their phased equivalents 0|0, 0|1, 1|0, 1|1).**

For details on how to preprocess VCF files and prepare them in the appropriate format, please refer to the “Preprocessing and Input Preparation” vignette included with the package.

# Detecting and postprocessing UPD events

In this tutorial, we will perform a complete analysis using two trio VCF files included with the UPDhmm package.

By following the steps below, you will learn how to:

1. Load and preprocess the VCF files.
2. Detect UPD events using the HMM-based approach.
3. Apply quality filters to the detected events.
4. Collapse and summarize results per individual.
5. Perform postprocessing analyses to identify potential true UPDs by detecting recurrent or artifact-prone genomic regions across samples.

# 1. Load and preprocess the VCFs

```
library(VariantAnnotation)
library(regioneR)
library(karyoploteR)

#Example files
files <- c(
  system.file(package = "UPDhmm", "extdata", "sample1.vcf.gz"),
  system.file(package = "UPDhmm", "extdata", "sample2.vcf.gz")
)

# Define the trio structure
trio_list <- list(
  list(
    proband = "NA19675",
    mother  = "NA19678",
    father  = "NA19679"
  ),
  list(
    proband = "NA19685",
    mother  = "NA19688",
    father  = "NA19689"
  )
)

# Read and preprocess each VCF
vcf_list <- mapply(function(file, trio) {
  vcf <- readVcf(file)
  vcfCheck(vcf,
           proband = trio$proband,
           mother  = trio$mother,
           father  = trio$father)
},
files, trio_list, SIMPLIFY = FALSE)
```

Each processed VCF is now ready for UPD detection.

# 2. Detect UPD events using the HMM-based approach

The principal function of `UPDhmm` package, `calculateEvents()`, is the central
function for identifying Uniparental Disomy (UPD) events. It takes the output
from the previous `vcfCheck()` function and systematically analyzes genomic
data, splitting the VCF into chromosomes and applying the Viterbi algorithm.

`calculateEvents()` function encompasses a serie of subprocesses for
identifying Uniparental disomies (UPDs):

1. Split vcf into chromosomes
2. Apply Viterbi algorithm to every chromosome
3. Transform the inferred hidden states to coordinates `data.frame`
4. Create blocks of contiguous variants with the same state
5. Calculate the statistics (log-likelihood and p-value).

In this example, we run the function in serial mode, but `calculateEvents()` now includes an optional argument, *BPPARAM*, which controls parallel execution settings and is passed to bplapply. By default, it uses BiocParallel::SerialParam() (serial execution). To enable parallelization, provide a BiocParallel backend, for example:

```
events_list <- lapply(vcf_list, calculateEvents)
head(events_list[[1]])
```

```
       ID seqnames     start       end   group n_snps log_likelihood
1 NA19675        3 100374740 197574936 het_mat     47       75.21933
2 NA19675        6  32489853  32490000 iso_mat      6       38.63453
3 NA19675        6  32609207  32609341 iso_mat     11       95.23543
4 NA19675       11  55322539  55587117 iso_mat      7       40.02082
5 NA19675       14 105408955 105945891 het_fat     30       20.84986
6 NA19675       15  22382655  23000272 iso_mat     12       48.33859
       p_value n_mendelian_error ratio_proband ratio_mother ratio_father
1 4.212224e-18                 2     1.0104188    1.0250623    0.9731367
2 5.110683e-10                 5     1.0771736    1.0880590    0.9802379
3 1.690378e-22                 7     1.0007892    1.1000846    0.8351554
4 2.512703e-10                 3     1.1680464    1.0441808    1.1935373
5 4.967274e-06                 2     1.0373541    0.9793402    0.9287609
6 3.586255e-12                 3     0.9448732    1.0861209    0.9461424
```

Note: when running under R CMD check or Bioconductor build systems, the number of workers may be automatically limited (usually less than 2).

## Results description

The `calculateEvents` function returns a `data.frame` containing all

| Column name | Description |
| --- | --- |
| `ID` | Identifier of the proband (child sample) |
| `seqnames` | Chromosome name |
| `start` | Start position of the block (genomic coordinate) |
| `end` | End position of the block |
| `group` | Predicted inheritance state (`iso_mat`, `iso_fat`, `het_mat`, `het_fat`) |
| `n_snps` | Number of informative SNPs within the event |
| `log_likelihood` | Log-likelihood ratio comparing the probability of the observed genotype configuration under the best-fitting UPD model versus the null (biparental inheritance). Higher values indicate stronger evidence supporting a UPD-like pattern. |
| `p_value` | Empirical p-value derived from the likelihood ratio test |
| `n_mendelian_error` | Number of Mendelian inconsistencies detected within the region |
| `ratio_proband` | Ratio between the average sequencing depth inside the event and the depth outside it for the proband. A value close to 1 indicates balanced coverage, while significant deviations may suggest copy-number changes. |
| `ratio_mother` | Same ratio computed for the maternal sample |
| `ratio_father` | Same ratio computed for the paternal sample |

In this example, we run the function in serial mode, but `calculateEvents()` now includes an optional argument BPPARAM that controls parallel execution.

| Argument | Description |
| --- | --- |
| `BPPARAM` | Parallelization settings, passed to **`BiocParallel::bplapply()`**. By default, the function uses `BiocParallel::SerialParam()` (serial execution). To enable parallel computation, a BiocParallel backend can be specified — for example: |

```
library(BiocParallel)
BPPARAM <- MulticoreParam(workers = min(2, parallel::detectCores()))
events_list <- lapply(vcf_list, calculateEvents, BPPARAM = BPPARAM)
```

# 3. Apply quality filters to the detected events

Based on the evaluation conducted in the publication, where the UPDhmm package was presented and validated through simulations of events of different sizes and application to a real cohort, we established a series of filtering criteria to remove small events and exclude those likely caused by gains or losses of genetic material in one of the trio members.

Specifically, the following thresholds are applied:

* n\_mendelian\_error > 2: at least three Mendelian errors are required to support a true UPD signal.
* size > 500,000: events must span at least 500 kb to avoid small spurious segments.
* ratio\_proband, ratio\_father, ratio\_mother between 0.8 and 1.2: ensures balanced read depth across trio members, excluding events likely caused by copy-number variation.

```
filtered_events_list <- lapply(events_list, function(df) {
  if (nrow(df) == 0) return(df)  # skip empty results

  df$size <- df$end - df$start

  dplyr::filter(
    df,
    n_mendelian_error > 2,
    size > 500000,
    ratio_proband >= 0.8 & ratio_proband <= 1.2,
    ratio_father  >= 0.8 & ratio_father  <= 1.2,
    ratio_mother  >= 0.8 & ratio_mother  <= 1.2
  )
})
```

# 4. Collapse and summarize results per individual

The `collapseEvents()`function provides a concise summary of detected UPD events per individual and chromosome.
It merges multiple contiguus or overlapping events that share the same predicted type (e.g., maternal isodisomy or paternal heterodisomy within the same chromosome.

During this process, the function:

* Aggregates the total number of collapsed events.
* Sums up the Mendelian errors across merged regions.
* Calculates the minimum start and maximum end coordinates, defining the overall genomic span of the collapsed event.

```
collapsed_list <- lapply(filtered_events_list, collapseEvents)
collapsed_all <- do.call(rbind.data.frame, c(collapsed_list, make.row.names = FALSE))
head(collapsed_all)
```

```
       ID seqnames   group n_events total_mendelian_error total_size
1 NA19675       15 iso_mat        1                     3     617617
2 NA19675       19 het_mat        1                     3    1207630
3 NA19685       15 iso_mat        1                     6   19741113
4 NA19685        6 het_mat        1                     3    1010072
      collapsed_events min_start  max_end
1 15:22382655-23000272  22382655 23000272
2 19:42315281-43522911  42315281 43522911
3 15:22368862-42109975  22368862 42109975
4  6:32489853-33499925  32489853 33499925
```

The function returns a simplified table summarizing one row per individual, chromosome, and UPD type.

| Column name | Description |
| --- | --- |
| `ID` | Identifier of the proband |
| `seqnames` | Chromosome |
| `group` | Predicted state |
| `n_events` | Number of events collapsed |
| `total_mendelian_error` | Sum of Mendelian errors |
| `total_size` | Total genomic span covered |
| `collapsed_events` | Comma-separated list of merged events |
| `min_start / max_end` | Genomic span of collapsed block |

# 5. Perform postprocessing analyses

In this final step, we perform postprocessing analyses to refine the detected UPD events and highlight potentially true or recurrent regions across samples.
This helps to distinguish genuine biological UPDs from artifact-prone genomic regions (e.g., repetitive or complex loci that may systematically produce false positives).

To explore whether similar events recur across individuals, UPDhmm provides two complementary functions:

* `identifyRecurrentRegions()` — identifies overlapping regions across multiple samples and counts how many individuals
  share each region. It returns a GRanges object with the recurrent segments and the number of supporting samples. The function includes several arguments that control how recurrence is determined:

  *Arguments:*

  + df —
    The input data.frame containing the genomic regions to evaluate.
    This table must include columns describing chromosome (seqnames), genomic coordinates (start, end or min\_start,
    max\_end), and a column with Mendelian error counts (n\_mendelian\_error or total\_mendelian\_error).
    Filtering arguments:
  + ID\_col —
    The name of the column containing sample identifiers.
    It allows the function to determine how many unique individuals support each overlapping genomic region.
  + error\_threshold (default = 100) —
    Maximum number of Mendelian errors allowed for a region to be considered in the recurrence analysis.
    Regions exceeding this threshold are excluded from recurrence counting. These regions, which often span broad genomic
    segments, are not considered in the recurrence calculation since they could overlap with many smaller events and bias
    the results. Instead, they are retained in the output as non-recurrent events, under the assumption that they may
    represent genuine large-scale alterations rather than noise.
  + min\_support (default = 3) —
    Minimum number of unique samples that must overlap a region for it to be classified as recurrent.
    This parameter can be adjusted depending on the cohort size — smaller values detect more shared regions, while higher
    thresholds focus on the most consistently recurrent events.
* `markRecurrentRegions()` —
  This function annotates each event in a results table (from calculateEvents() or collapseEvents()) as recurrent or
  non-recurrent,depending on whether it overlaps any region defined as recurrent.
  The function returns the same data.frame provided as input, but with two additional columns:

  + Recurrent: categorical variable indicating whether the event overlaps a recurrent region (“Yes” or “No”).
  + n\_samples: the number of unique samples supporting that recurrent region (as determined in identifyRecurrentRegions()).

These annotations facilitate the downstream filtering of events, allowing users to retain only non-recurrent regions, which are more likely to represent true UPD candidates rather than technical artifacts or common genomic polymorphisms.
In summary, these two functions can thus be combined to systematically identify and flag recurrent genomic regions, facilitating the filtering of potential technical artifacts or recurrent UPDs.

```
recurrentRegions <- identifyRecurrentRegions(
  df = collapsed_all,
  ID_col = "ID",
  error_threshold = 100,
  min_support = 2
)

head(recurrentRegions)
```

```
GRanges object with 1 range and 1 metadata column:
      seqnames            ranges strand | n_samples
         <Rle>         <IRanges>  <Rle> | <integer>
  [1]       15 22368862-42109975      * |         2
  -------
  seqinfo: 6 sequences from an unspecified genome; no seqlengths
```

```
annotatedEvents <- markRecurrentRegions(
  df = collapsed_all,
  recurrent_regions = recurrentRegions
)

head(annotatedEvents)
```

```
       ID seqnames   group n_events total_mendelian_error total_size
1 NA19675       15 iso_mat        1                     3     617617
2 NA19675       19 het_mat        1                     3    1207630
3 NA19685       15 iso_mat        1                     6   19741113
4 NA19685        6 het_mat        1                     3    1010072
      collapsed_events min_start  max_end Recurrent n_samples
1 15:22382655-23000272  22382655 23000272       Yes         2
2 19:42315281-43522911  42315281 43522911        No         1
3 15:22368862-42109975  22368862 42109975       Yes         2
4  6:32489853-33499925  32489853 33499925        No         1
```

Alternatively, recurrent regions can be provided directly as an external BED file (e.g., `SFARI.bed`),
converted into a `GRanges` object, and used in the same way.

The `SFARI.bed` file was generated from our analysis of the **SFARI cohort**,
where recurrent genomic intervals were identified across trios using `UPDhmm`.
These regions represent loci frequently showing **artifactual or low-confidence UPD signals**
in the SFARI dataset and can be used as a **mask** to improve specificity in other analyses.

```
library(regioneR)
bed <- system.file(package = "UPDhmm", "extdata", "SFARI.bed")
bed_df <- read.table(
    bed,
    header = TRUE
)

bed_gr <- toGRanges(bed_df)

annotatedEvents <- markRecurrentRegions(
  df = collapsed_all,
  recurrent_regions = bed_gr
)

head(annotatedEvents)
```

```
       ID seqnames   group n_events total_mendelian_error total_size
1 NA19675       15 iso_mat        1                     3     617617
2 NA19675       19 het_mat        1                     3    1207630
3 NA19685       15 iso_mat        1                     6   19741113
4 NA19685        6 het_mat        1                     3    1010072
      collapsed_events min_start  max_end Recurrent n_samples
1 15:22382655-23000272  22382655 23000272        No         1
2 19:42315281-43522911  42315281 43522911        No         1
3 15:22368862-42109975  22368862 42109975        No         1
4  6:32489853-33499925  32489853 33499925        No         1
```

Regions annotated as non-recurrent and passing all quality filters (low Mendelian error count and consistent read depth ratios) are the most likely true UPD candidates.
Conversely, highly recurrent or error-prone regions should be interpreted with caution, as they may reflect systematic technical artifacts or structural genomic complexity.

# 6. Visualizing UPD events across the genome

After identifying and postprocessing UPD events, a final and highly informative step is to visualize their genomic distribution.
Visualization helps to quickly assess the size, chromosomal location, and type (maternal or paternal; hetero- or isodisomy) of the detected events.

The `karyoploteR` package provides elegant genome-wide visualization tools that can be integrated directly with the UPDhmm results.
The following custom plotting function, `plotUPDKp()`, enables the visualization of UPD segments detected in a trio across all autosomes.
To visualize events across the genome, you can use the karyoploteR package:

```
library(karyoploteR)
library(regioneR)

# Function to visualize UPD events across the genome
plotUPDKp <- function(updEvents) {
  #--------------------------------------------------------------
  # 1. Detect coordinate columns
  #--------------------------------------------------------------
  if (all(c("start", "end") %in% colnames(updEvents))) {
    start_col <- "start"
    end_col <- "end"
  } else if (all(c("min_start", "max_end") %in% colnames(updEvents))) {
    start_col <- "min_start"
    end_col <- "max_end"
  } else {
    stop("Input must contain either (start, end) or (min_start, max_end) columns.")
  }

  #--------------------------------------------------------------
  # 2. Ensure chromosome naming format (e.g. "chr3")
  #--------------------------------------------------------------
  updEvents$seqnames <- ifelse(grepl("^chr", updEvents$seqnames),
                               updEvents$seqnames,
                               paste0("chr", updEvents$seqnames))

  #--------------------------------------------------------------
  # 3. Helper function to safely create GRanges only if events exist
  #--------------------------------------------------------------
  to_gr_safe <- function(df, grp) {
    subset_df <- subset(df, group == grp)
    if (nrow(subset_df) > 0) {
      toGRanges(subset_df[, c("seqnames", start_col, end_col)])
    } else {
      NULL
    }
  }

  #--------------------------------------------------------------
  # 4. Separate UPD event types
  #--------------------------------------------------------------
  het_fat <- to_gr_safe(updEvents, "het_fat")
  het_mat <- to_gr_safe(updEvents, "het_mat")
  iso_fat <- to_gr_safe(updEvents, "iso_fat")
  iso_mat <- to_gr_safe(updEvents, "iso_mat")

  #--------------------------------------------------------------
  # 5. Create the genome ideogram
  #--------------------------------------------------------------
  kp <- plotKaryotype(genome = "hg19")

  #--------------------------------------------------------------
  # 6. Plot regions by inheritance type (if any exist)
  #--------------------------------------------------------------
  if (!is.null(het_fat)) kpPlotRegions(kp, het_fat, col = "#AAF593")
  if (!is.null(het_mat)) kpPlotRegions(kp, het_mat, col = "#FFB6C1")
  if (!is.null(iso_fat)) kpPlotRegions(kp, iso_fat, col = "#A6E5FC")
  if (!is.null(iso_mat)) kpPlotRegions(kp, iso_mat, col = "#E9B864")

  #--------------------------------------------------------------
  # 7. Add legend
  #--------------------------------------------------------------
  legend("topright",
         legend = c("Het_Fat", "Het_Mat", "Iso_Fat", "Iso_Mat"),
         fill = c("#AAF593", "#FFB6C1", "#A6E5FC", "#E9B864"))
}
# Example: visualize UPD events for the first trio
plotUPDKp(annotatedEvents)
```

![](data:image/png;base64...)

# Summary

In summary, the `UPDhmm` package provides a complete workflow for the detection, characterization, and visualization of uniparental disomy (UPD) events from trio-based sequencing data.
Starting from raw VCF files, users can preprocess, model inheritance patterns through a Hidden Markov Model, and identify genomic regions consistent with UPD.
Postprocessing steps, including the collapsing of events and the identification of recurrent or artifact-prone regions, enable a refined interpretation of results and the prioritization of true UPD candidates.
Finally, genome-wide visualization with karyoploteR offers an intuitive way to inspect and report detected UPDs.

Altogether, `UPDhmm facilitates a standardized and reproducible approach for the study of UPD across large cohorts, integrating statistical detection, quality control, and interpretative visualization into a single coherent framework.

# Session Info

```
sessionInfo()
```

```
R version 4.5.1 Patched (2025-08-23 r88802)
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
[1] stats4    stats     graphics  grDevices utils     datasets  methods
[8] base

other attached packages:
 [1] karyoploteR_1.36.0          regioneR_1.42.0
 [3] VariantAnnotation_1.56.0    Rsamtools_2.26.0
 [5] Biostrings_2.78.0           XVector_0.50.0
 [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
 [9] GenomicRanges_1.62.0        IRanges_2.44.0
[11] S4Vectors_0.48.0            Seqinfo_1.0.0
[13] MatrixGenerics_1.22.0       matrixStats_1.5.0
[15] BiocGenerics_0.56.0         generics_0.1.4
[17] dplyr_1.1.4                 UPDhmm_1.6.0
[19] BiocStyle_2.38.0

loaded via a namespace (and not attached):
 [1] DBI_1.2.3                bitops_1.0-9             gridExtra_2.3
 [4] rlang_1.1.6              magrittr_2.0.4           biovizBase_1.58.0
 [7] compiler_4.5.1           RSQLite_2.4.3            GenomicFeatures_1.62.0
[10] png_0.1-8                vctrs_0.6.5              ProtGenerics_1.42.0
[13] stringr_1.5.2            pkgconfig_2.0.3          crayon_1.5.3
[16] fastmap_1.2.0            magick_2.9.0             backports_1.5.0
[19] rmarkdown_2.30           UCSC.utils_1.6.0         tinytex_0.57
[22] bit_4.6.0                xfun_0.53                cachem_1.1.0
[25] cigarillo_1.0.0          GenomeInfoDb_1.46.0      jsonlite_2.0.0
[28] blob_1.2.4               DelayedArray_0.36.0      BiocParallel_1.44.0
[31] parallel_4.5.1           cluster_2.1.8.1          R6_2.6.1
[34] bslib_0.9.0              stringi_1.8.7            RColorBrewer_1.1-3
[37] bezier_1.1.2             rtracklayer_1.70.0       rpart_4.1.24
[40] jquerylib_0.1.4          Rcpp_1.1.0               bookdown_0.45
[43] knitr_1.50               base64enc_0.1-3          Matrix_1.7-4
[46] nnet_7.3-20              tidyselect_1.2.1         rstudioapi_0.17.1
[49] dichromat_2.0-0.1        abind_1.4-8              yaml_2.3.10
[52] codetools_0.2-20         curl_7.0.0               lattice_0.22-7
[55] tibble_3.3.0             KEGGREST_1.50.0          S7_0.2.0
[58] evaluate_1.0.5           foreign_0.8-90           pillar_1.11.1
[61] BiocManager_1.30.26      checkmate_2.3.3          RCurl_1.98-1.17
[64] ensembldb_2.34.0         ggplot2_4.0.0            scales_1.4.0
[67] glue_1.8.0               lazyeval_0.2.2           Hmisc_5.2-4
[70] tools_4.5.1              BiocIO_1.20.0            data.table_1.17.8
[73] BSgenome_1.78.0          GenomicAlignments_1.46.0 XML_3.99-0.19
[76] grid_4.5.1               AnnotationDbi_1.72.0     colorspace_2.1-2
[79] htmlTable_2.4.3          restfulr_0.0.16          Formula_1.2-5
[82] cli_3.6.5                HMM_1.0.2                S4Arrays_1.10.0
[85] AnnotationFilter_1.34.0  gtable_0.3.6             sass_0.4.10
[88] digest_0.6.37            SparseArray_1.10.0       rjson_0.2.23
[91] htmlwidgets_1.6.4        farver_2.1.2             memoise_2.0.1
[94] htmltools_0.5.8.1        lifecycle_1.0.4          httr_1.4.7
[97] bit64_4.6.0-1            bamsignals_1.42.0
```
# NxtIRFcore: Differential Alternative Splicing and Intron Retention analysis

#### Alex CH Wong

#### 10/26/2021

Abstract

Intron Retention (IR) is a form of alternative splicing whereby the intron is retained (i.e. not spliced) in final messenger RNA. Although many bioinformatics tools are available to quantitate other forms of alternative splicing, dedicated tools to quantify Intron Retention are limited. Quantifying IR requires not only measurement of spliced transcripts (often using mapped splice junction reads), but also measurement of the coverage of the putative retained intron. The latter requires adjustment for the fact that many introns contain repetitive regions as well as other RNA expressing elements. IRFinder corrects for many of these complexities; however its dependencies on Linux and STAR limits its wider usage. Also, IRFinder does not calculate other forms of splicing besides IR. Finally, IRFinder produces text-based output, requiring an established understanding of the data produced in order to interpret its results. NxtIRF overcomes the above limitations. Firstly, NxtIRF incorporates the IRFinder C++ routines, allowing users to run the IRFinder algorithm in the R/Bioconductor environment on multiple platforms. NxtIRF is a full pipeline that quantifies IR (and other alternative splicing) events, organises the data and produces relevant visualisation. Additionally, NxtIRF offers an interactive graphical interface that allows users to explore the data. NxtIRFcore is the command-line version of NxtIRF. Version 1.0.0

# (1) Installation and Quick-Start

This section provides instructions for installation and a quick working example to demonstrate the important functions of NxtIRF. NxtIRFcore is the command line utility for NxtIRF.

For detailed explanations of each step shown here, refer to chapter 2: “Explaining the NxtIRF workflow” in this vignette. For a list of ready-made “recipes” for typical-use NxtIRF in real datasets, refer to chapter 3: “NxtIRF cookbook”

### Installation

To install NxtIRFcore, start R (version “4.1”) and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")

BiocManager::install("NxtIRFcore")
```

(Optional) For **MacOS** users, make sure OpenMP libraries are installed correctly. We recommend users follow this [guide](https://mac.r-project.org/openmp/), but the quickest way to get started is to install `libomp` via brew:

```
brew install libomp
```

### Loading NxtIRF

```
library(NxtIRFcore)
#> Loading required package: NxtIRFdata
```

### Building the NxtIRF reference

A NxtIRF reference requires a genome FASTA file (containing genome nucleotide sequences) and a gene annotation GTF file (preferably from Ensembl or Gencode).

NxtIRF provides an example genome and gene annotation which can be accessed via the NxtIRFdata package installed with NxtIRF:

```
# Provides the path to the example genome:
chrZ_genome()
#> [1] "/home/biocbuild/bbs-3.14-bioc/R/library/NxtIRFdata/extdata/genome.fa"

# Provides the path to the example gene annotation:
chrZ_gtf()
#> [1] "/home/biocbuild/bbs-3.14-bioc/R/library/NxtIRFdata/extdata/transcripts.gtf"
```

Using these two files, we construct a NxtIRF reference as follows:

```
ref_path = file.path(tempdir(), "Reference")
BuildReference(
reference_path = ref_path,
fasta = chrZ_genome(),
gtf = chrZ_gtf()
)
```

### Running IRFinder

NxtIRF provides an example set of 6 BAM files to demonstrate its use via this vignette.

Firstly, retrieve the BAM files from ExperimentHub using the NxtIRF helper function `NxtIRF_example_bams()`. This makes a copy of the BAM files to the temporary directory:

```
bams = NxtIRF_example_bams()
bams
#>   sample                       path
#> 1 02H003 /tmp/RtmpbWxbpL/02H003.bam
#> 2 02H025 /tmp/RtmpbWxbpL/02H025.bam
#> 3 02H026 /tmp/RtmpbWxbpL/02H026.bam
#> 4 02H033 /tmp/RtmpbWxbpL/02H033.bam
#> 5 02H043 /tmp/RtmpbWxbpL/02H043.bam
#> 6 02H046 /tmp/RtmpbWxbpL/02H046.bam
```

Finally, run NxtIRF/IRFinder as follows:

```
irf_path = file.path(tempdir(), "IRFinder_output")
IRFinder(
bamfiles = bams$path,
sample_names = bams$sample,
reference_path = ref_path,
output_path = irf_path
)
```

### Collate individual IRFinder runs to build a NxtIRF Experiment

First, collate the IRFinder output files using the helper function `Find_IRFinder_Output()`

```
expr = Find_IRFinder_Output(irf_path)
```

This creates a 3-column data frame with sample name, IRFinder gzipped text output, and COV files. Compile these output files into a single experiment:

```
nxtirf_path = file.path(tempdir(), "NxtIRF_output")
CollateData(
Experiment = expr,
reference_path = ref_path,
output_path = nxtirf_path
)
```

### Importing the collated data as a NxtSE object:

The `NxtSE` is a data structure that inherits `SummarizedExperiment`

```
se = MakeSE(nxtirf_path)
```

### Set some experimental conditions:

```
colData(se)$condition = rep(c("A", "B"), each = 3)
colData(se)$batch = rep(c("K", "L", "M"), 2)
```

### Perform differential alternative splicing

The code below will contrast condition:B in respect to condition:A

```
# Requires limma to be installed:
require("limma")
res_limma = limma_ASE(
se = se,
test_factor = "condition",
test_nom = "B",
test_denom = "A",
)

# Requires DESeq2 to be installed:
require("DESeq2")
res_deseq = DESeq_ASE(
se = se,
test_factor = "condition",
test_nom = "B",
test_denom = "A",
)

# Requires DoubleExpSeq to be installed:
require("DoubleExpSeq")
res_DES = DoubleExpSeq_ASE(
se = se,
test_factor = "condition",
test_nom = "B",
test_denom = "A",
)
```

### Visualise a Coverage plot of a differential IR event:

Filter by visibly-different events:

```
res_limma.filtered = subset(res_limma, abs(AvgPSI_A - AvgPSI_B) > 0.05)
```

Plot individual samples:

```
p = Plot_Coverage(
se = se,
Event = res_limma.filtered$EventName[1],
tracks = colnames(se)[c(1,2,4,5)],
)
as_egg_ggplot(p)
```

![](data:image/png;base64...)

Display the plotly interactive version of the coverage plot (not shown here)

```
# Running this will display an interactive plot
p$final_plot
```

Plot by condition:

```
p = Plot_Coverage(
se = se,
Event = res_limma.filtered$EventName[1],
tracks = c("A", "B"),
condition = "condition",
stack_tracks = TRUE,
t_test = TRUE,
)
as_egg_ggplot(p)
#> Warning: Removed 270 row(s) containing missing values (geom_path).
```

![](data:image/png;base64...)

# (2) Explaining the NxtIRF Workflow

This section explains the working example provided in the prior “Quick-Start” section, to demonstrate how to use NxtIRF.

## Generating the NxtIRF reference

NxtIRF first needs to generate a set of reference files. The NxtIRF reference is used to quantitate IR and alternative splicing, as well as in downstream visualisation tools.

### Building an example NxtIRF reference using BuildReference()

First, load the NxtIRF package:

```
library(NxtIRFcore)
```

NxtIRF generates a reference from a user-provided genome FASTA and genome annotation GTF file, and is optimised for Ensembl references but can accept other reference GTF files. Alternatively, NxtIRF accepts AnnotationHub resources, using the record names of AnnotationHub records as input.

We will first demonstrate a runnable example using the included example NxtIRF genome. This was created using 7 example genes (SRSF1, SRSF2, SRSF3, TRA2A, TRA2B, TP53 and NSUN5). The SRSF and TRA family of genes all contain poison exons flanked by retained introns. Additionally, NSUN5 contains an annotated IR event in its terminal intron. Sequences from these 7 genes were aligned into one sequence to create an artificial chromosome Z (chrZ). The gene annotations were modified to only contain the 7 genes with the modified genomic coordinates.

```
ref_path = file.path(tempdir(), "Reference")

GetReferenceResource(
reference_path = ref_path,
fasta = chrZ_genome(),
gtf = chrZ_gtf()
)

BuildReference(reference_path = ref_path)

# or equivalently, in a one-step process:

BuildReference(
reference_path = ref_path,
fasta = chrZ_genome(),
gtf = chrZ_gtf()
)
```

The first function, GetReferenceResource(), requires 3 arguments: (1) `fasta` The file (or url) of the genome FASTA file, (2) `gtf` The file (or url) of the gene annotation GTF file, and (3) `reference_path` The directory (ideally an empty directory) to create the NxtIRF reference

`GetReferenceResource()` processes the given source genome / annotation files, downloading them where necesssary, and saves a local copy of the GTF file as well as a compressed version of the FASTA sequence file (as a TwoBitFile which is a binary compressed version of the genome sequence).

The next function, `BuildReference()`, uses the resources to build the NxtIRF reference. NxtIRF builds its own version of alternative splicing annotations by comparing differential combinations of splice junctions between the transcripts of each gene. Events annotated include Skipped Exons (SE), Mutually Exclusive Exons (MXE), Alternative First / Last Exons (AFE / ALE), Alternative 5’ or 3’ Splice Sites (A5SS / A3SS), and Intron Retention (IR). For IR events, every intron is considered as a potential Intron Retention event, assuming most IR events are not annotated.

Additionally, BuildReference assesses the coding sequence changes that arise if each individual IR event occurs, annotating the IR events as NMD-inducing if the inclusion of the intron results in premature termination codons (PTCs, as defined by a stop codon located 55 bases upstream of the last exon junction).

## Quantitate IR and Alternative Splicing in Aligned BAM files

NxtIRF adopts the IRFinder algorithm to measure IR in aligned BAM files. The IRFinder algorithm also provides spliced junction counts that is used by NxtIRF to quantitate alternate splicing events.

### Running IRFinder() on example BAM files

In this vignette, we provide 6 example BAM files. These were generated based on aligned RNA-seq BAMs of 6 samples from the Leucegene AML dataset (GSE67039). Sequences aligned to hg38 were filtered to only include genes aligned to that used to create the chrZ chromosome. These sequences were then re-aligned to the chrZ reference using STAR.

First, we download the example bam files using the following convenience function:

```
bam_path = file.path(tempdir(), "bams")

# Copies NxtIRF example BAM files to `bam_path` subdirectory; returns BAM paths
example_bams(path = bam_path)
```

Often, alignment pipelines process multiple samples. NxtIRF provides convenience functions to recursively locate all the BAM files in a given folder, and tries to ascertain sample names. Often sample names can be gleaned when: \* The BAM files are named by their sample names, e.g. “sample1.bam”, “sample2.bam”. In this case, `level = 0` \* The BAM files have generic names but are contained inside parent directories labeled by their sample names, e.g. “sample1/Unsorted.bam”, “sample2/Unsorted.bam”. In this case, `level = 1`

```
# as BAM file names denote their sample names
bams = Find_Bams(bam_path, level = 0)

# In the case where BAM files are labelled using sample names as parent
# directory names (which oftens happens with the STAR aligner), use level = 1
```

This convenience function retrieves a data frame with the first and second columns as the sample names and paths of all the BAM files found. We use this to run IRFinder on all the BAM files using the following:

```
irf_path = file.path(tempdir(), "IRFinder_output")
IRFinder(
bamfiles = bams$path,
sample_names = bams$sample,
reference_path = ref_path,
output_path = irf_path,
n_threads = 2,
overwrite = FALSE,
run_featureCounts = FALSE
)
```

This runs IRFinder using 2 threads. Multi-threading is performed using OpenMP (where available). If OpenMP is not installed when NxtIRFcore was compiled, BiocParallel will be used instead. Setting `overwrite = FALSE` ensures if IRFinder files were generated by a previous run, these would not be overwritten.

Also (optionally), users can generate gene counts from the same reference using `run_featureCounts = TRUE` (requires the Rsubread package). The featureCounts output is stored in the “main.FC.Rds” file which can be retrieved using below:

```
# Re-run IRFinder without overwrite, and run featureCounts
require(Rsubread)

IRFinder(
bamfiles = bams$path,
sample_names = bams$sample,
reference_path = ref_path,
output_path = irf_path,
n_threads = 2,
overwrite = FALSE,
run_featureCounts = TRUE
)

# Load gene counts
gene_counts <- readRDS(file.path(irf_path, "main.FC.Rds"))

# Access gene counts:
gene_counts$counts
```

## Collating IRFinder output into a single dataset

IRFinder produces output on individual samples. NxtIRF makes it easy to collate the output from multiple samples. As some splicing events may occur in some samples but not others, it is important to unify the data and organise it into a single data structure. NxtIRF uses a specialized class (called the NxtSE object) to contain multiple arrays of data. This is used to contain Included and Excluded event counts as well as associated quality control data (including intronic “coverage” which is the fraction of the intron covered by RNA-seq reads in IR events).

### Reviewing the IRFinder output:

Having run IRFinder on all individual BAM files of an experiment, we can collate this data using the CollateData() function. Again, we use a convenience function to generate a list of IRFinder output files:

```
expr <- Find_IRFinder_Output(irf_path)
```

`expr` is a 3-column data frame. The first two columns contain the sample names and IRFinder output file path (as a “.txt.gz” - gzipped text file). This contains all of the original output from vanilla IRFinder, as well as sample QC readouts). Feel free to unzip a file to see what output is generated.

The third column contains “COV” file paths. COV files are generated by NxtIRF and contains RNA-seq read coverage data in a novel compressed format. COV files compress data much better than BigWig files, and also contains RNA-seq coverage data from individual strands. Currently, only NxtIRF is able to read COV files but we anticipate other packages can use COV files via NxtIRF (in future NxtIRF releases)! We will demonstrate how to use COV files in a later section.

## Using CollateData to parse IRFinder output from multiple files.

Now that we have an organised list of IRFinder output files, we parse this into `CollateData()`

```
nxtirf_path = file.path(tempdir(), "NxtIRF_output")

CollateData(
Experiment = expr,
reference_path = ref_path,
output_path = nxtirf_path,
IRMode = "SpliceOverMax",
n_threads = 1
)
```

CollateData extracts IR quantitation and junction counts and organises these counts into unified arrays of data. CollateData also compiles QC parameters for all samples, including read depth and strandedness (directionality).

`IRMode` is a parameter that specifies how IRFinder calculates percentage intron retention (PIR). Previously, IRFinder estimates spliced (or exonic) abundance by including junction reads that involve either flanking exon `SpliceMax = max(SpliceLeft, SpliceRight)`. This is done to correct for the possibility of alternate exons flanking the intron being assessed. NxtIRF extends this estimate by accounting for the possibility that BOTH flanking exons may be alternate exons, thereby accounting for splice events that overlap the intron but does not involve the junctions of either flanking exons. We call this parameter `SpliceOverMax`, which includes `SpliceMax` with the addition of distant splice events.

## Building a NxtSE object from collated data

Now that `CollateData()` has created the unified data in the directory, we can retrieve the data as a NxtSE object:

```
se = MakeSE(nxtirf_path, RemoveOverlapping = TRUE)
```

Two things of note:

1. By default, MakeSE constructs the NxtSE object using all the samples in the collated data. It is possible (and particularly useful in large data sets) to read only a subset of samples. In this case, construct a data.frame object with the first column containing the desired sample names and parse this into the `colData` parameter as shown:

```
subset_samples = colnames(se)[1:4]
df = data.frame(sample = subset_samples)
se_small = MakeSE(nxtirf_path, colData = df, RemoveOverlapping = TRUE)
```

2. In complex transcriptomes including those of human and mouse, alternative splicing implies that introns are often overlapping. Thus, algorithms run the risk of over-calling intron retention where overlapping introns are assessed. NxtIRF removes overlapping introns by considering only introns belonging to the major splice isoforms. It estimates a list of introns of major isoforms by assessing the compatible splice junctions of each isoform, and removes overlapping introns belonging to minor isoforms. To disable this functionality, set `RemoveOverlapping = FALSE`.

## Filtering for Expressed Splicing Events

Often, the gene annotations contain isoforms for all discovered splicing events. Most annotated transcripts are not expressed, and their inclusion in differential analysis complicates results including adjusting for multiple testing. It is prudent to filter these out using various approaches, akin to removing genes with low gene counts in differential gene analysis. We suggest using the default filters which generally excludes splicing events whereby the total included / excluded event counts less than 20 RNA-seq reads. There are other quality-control filters included but these are out of the scope of this vignette (please see the documentation for details).

To filter the NxtSE object using default filters:

```
expressed_events <- apply_filters(se, get_default_filters())

se.filtered = se[expressed_events,]
```

In the above code, `get_default_filters()` retrieves the default filters suggested by NxtIRF. `apply_filters` returns a vector containing which events are included if the filters are applied to the NxtSE object. Finally, we obtain a NxtSE object by subsetting the original NxtSE using the vector of `expressed_events`.

To view a description of what these filters actually do, simply display them:

```
get_default_filters()
#> [[1]]
#> NxtFilter Class: Data    Type: Depth
#> EventTypes: IR MXE SE A3SS A5SS AFE ALE RI
#> Filter must be passed in at least 80.0 percent of all samples
#> Minimum Event Depth: 20
#> Event Depth refers to number of aligned splice reads plus effective depth of their introns
#>
#> [[2]]
#> NxtFilter Class: Data    Type: Coverage
#> EventTypes: IR RI
#> Filter must be passed in at least 80.0 percent of all samples
#> Minimum Coverage Percentage: 90.0
#> In retained introns, coverage refers to the proportion of the measured intron that is covered by at least 1 alignment
#> Event Depth below 5 are ignored
#> Event Depth refers to number of aligned splice reads plus effective depth of their introns
#>
#> [[3]]
#> NxtFilter Class: Data    Type: Coverage
#> EventTypes: MXE SE AFE ALE A5SS A3SS
#> Filter must be passed in at least 80.0 percent of all samples
#> Minimum Coverage Percentage: 60.0
#> In splice events, coverage refers to the proportion of junction reads that belong to either the included or excluded isoforms of the given event
#> Event Depth below 20 are ignored
#> Event Depth refers to number of aligned splice reads plus effective depth of their introns
#>
#> [[4]]
#> NxtFilter Class: Data    Type: Consistency
#> EventTypes: MXE SE RI
#> Filter must be passed in at least 80.0 percent of all samples
#> Sub-event minimum proportion: 0.2 of total isoform splice count
#> In retained introns, sub-events refer to 5'- and 3'-exon-intron spanning alignments
#> In mutually exclusive exons and skipped exons, sub-events refer to the upstream and downstream splice alignments
#> Event Depth below 20 are ignored
#> Event Depth refers to number of aligned splice reads plus effective depth of their introns
```

To construct custom filters, create a NxtFilter object as shown:

```
f1 = NxtFilter(filterClass = "Data", filterType = "Depth", minimum = 20)
f1
#> NxtFilter Class: Data    Type: Depth
#> EventTypes: IR MXE SE A3SS A5SS AFE ALE RI
#> Filter must be passed in at least 100.0 percent of all samples
#> Minimum Event Depth: 20
#> Event Depth refers to number of aligned splice reads plus effective depth of their introns
```

For more information about the filters available, refer to the manual for details:

```
?NxtFilter
```

## Performing analysis of Differential Alternative Splicing Events

Before performing differential analysis, we must annotate our samples. Currently there are no annotations:

```
colData(se.filtered)
#> DataFrame with 6 rows and 0 columns
```

To populate the NxtSE object with annotations, we can modify colData just as we would for a SummarizedExperiment object.

```
colData(se.filtered)$condition = rep(c("A", "B"), each = 3)
colData(se.filtered)$batch = rep(c("K", "L", "M"), 2)

# To display what colData is:
as.data.frame(colData(se.filtered))
#>        condition batch
#> 02H003         A     K
#> 02H025         A     L
#> 02H026         A     M
#> 02H033         B     K
#> 02H043         B     L
#> 02H046         B     M
```

We can use either limma to perform differential alternative splicing analysis

```
require("limma")

# Compare by condition-B vs condition-A

res_limma_condition <- limma_ASE(
se = se.filtered,
test_factor = "condition",
test_nom = "B",
test_denom = "A",
)
#> Oct 26 18:08:46 Performing limma contrast for included / excluded counts separately
#> Oct 26 18:08:46 Performing limma contrast for included / excluded counts together

# Compare by condition-B vs condition-A, batch-corrected by "batch"

res_limma_treatment_batchcorrected <- limma_ASE(
se = se.filtered,
test_factor = "condition",
test_nom = "B",
test_denom = "A",
batch1 = "batch"
)
#> Oct 26 18:08:47 Performing limma contrast for included / excluded counts separately
#> Oct 26 18:08:47 Performing limma contrast for included / excluded counts together
```

NB: we can also use DESeq2 or DoubleExpSeq to perform the same analysis using `DESeq_ASE()` or `DoubleExpSeq_ASE()`. The differences are as follows:

* Limma: models counts as log-normal distributed
* DESeq2: models counts as negative binomial distributed
* DoubleExpSeq: models alternative splicing ratios as beta-binomial distributed

## Visualisation of Differential ASE Analysis

The following guide demonstrates how to plot standard figures including scatter plots of average percent-spliced-in (PSI) values, volcano plots of differentially expressed IR / AS events, and heatmaps of PSI values.

### Scatter plot of differential Alternate Splicing Events

These functions return a data frame with the differential analysis results. These include average percent-spliced-in values for both conditions, which can be used directly to produce a scatter plot comparing the two conditions:

```
library(ggplot2)

ggplot(res_limma_condition, aes(x = 100 * AvgPSI_B, y = 100 * AvgPSI_A)) +
geom_point() + xlim(0, 100) + ylim(0, 100) +
labs(title = "PSI values across conditions",
x = "PSI of condition B", y = "PSI of condition A")
```

![](data:image/png;base64...)

Note the columns in the results are defined by the names of the conditions “A” and “B”.

To filter for specific splicing events (e.g. IR only), simply filter the results data.frame by EventType:

```
ggplot(subset(res_limma_condition, EventType == "IR"),
aes(x = 100 * AvgPSI_B, y = 100 * AvgPSI_A)) +
geom_point() + xlim(0, 100) + ylim(0, 100) +
labs(title = "PIR values across conditions (IR Only)",
x = "PIR of condition B", y = "PIR of condition A")
```

![](data:image/png;base64...)

### Volcano plot of differential Alternate Splicing Events

`limma_ASE` and `DESeq_ASE` contain direct output from limma or DESeq2. The P.Value and pvalue of limma and DESeq2 output denote nominal P values, whereas multiple-correction is performed via the adj.P.Val and padj columns of limma and DESeq2, respectively. To plot these:

```
ggplot(res_limma_condition,
aes(x = logFC, y = -log10(adj.P.Val))) +
geom_point() +
labs(title = "Differential analysis - B vs A",
x = "Log2-fold change", y = "BH-adjusted P values (-log10)")
```

![](data:image/png;base64...)

### Heatmap of differential events

NxtIRF provides convenience functions to retrieve the splicing ratios via the NxtSE object. To produce a heatmap, first we create a matrix of splicing ratios of the top 10 differential events:

```
mat = make_matrix(
se.filtered,
event_list = res_limma_condition$EventName[1:10],
method = "PSI"
)
```

`make_matrix()` has the option of supplying values as logit-transformed. This is useful to contrast where the majority of values are near the 0- or 1- boundary.

Also, when the dataset contains low-abundance splicing depths, samples with splicing depths below a certain threshold can be excluded (replaced with NA). Simply set `depth_threshold` to a level below which sample-events will be converted to NA. Also, events can be excluded from display if a certain fraction of samples have low coverage (i.e. return NA values). This filter can be set using `na.percent.max`. This is useful as events with high number of NA values can return errors in heatmap functions that also perform clustering

With the matrix of values, one can produce a heatmap as shown:

```
library(pheatmap)

pheatmap(mat, annotation_col = as.data.frame(colData(se.filtered)))
```

![](data:image/png;base64...)

## NxtIRF Coverage Plots

NxtIRF is able to produce RNA-seq coverage plots of analysed samples. Coverage data is compiled simultaneous to the IR and junction quantitation performed by the IRFinder C++ routine. This data is saved in “COV” files, which is a BGZF compressed and indexed file. COV files show compression and performance gains over BigWig files.

Additionally, NxtIRF performs coverage plots of multiple samples combined based on user-defined experimental conditions. This is a powerful tool to illustrate group-specific differential splicing or IR. NxtIRF does this by normalising the coverage depths of each sample based on transcript depth at the splice junction / intron of interest. By doing so, the coverage depths of constitutively expressed flanking exons are normalised to unity. As a result, the intron depths reflect the fraction of transcripts with retained introns and can be compared across samples.

We will first demonstrate by plotting the RNA-seq coverage of a single gene by a single sample. `Plot_Coverage()` performs the calculations and generates a compound object containing both static and interactive plots. We can coerce this to a static plot using `as_egg_ggplot()`

```
res = Plot_Coverage(
se = se.filtered,
Gene = "TP53",
tracks = colnames(se.filtered)[1]
)

as_egg_ggplot(res)
```

![](data:image/png;base64...)

The interactive plot (not run here) can be displayed by directly calling the `final_plot` element of the object returned by `Plot_Coverage`

```
# Running this will display an interactive plot
res$final_plot
```

There are many transcripts in TP53! This is because by default, NxtIRF displays all annotated transcripts. For clarity, one can either collapse the transcripts at a per-gene level, by setting condense\_tracks = TRUE:

```
res = Plot_Coverage(
se = se.filtered,
Gene = "TP53",
tracks = colnames(se.filtered)[1],
condense_tracks = TRUE
)
as_egg_ggplot(res)
```

![](data:image/png;base64...)

Alternatively, for fine control, one can supply a vector containing the transcript names to be displayed:

```
res = Plot_Coverage(
se = se.filtered,
Gene = "TP53",
tracks = colnames(se.filtered)[1],
selected_transcripts = c("TP53-201", "TP53-204")
)
as_egg_ggplot(res)
```

![](data:image/png;base64...)

In the heatmap in the previous section, we can see some retained introns in NSUN5 that are more highly expressed in “02H003” and “02H025”. To demonstrate this, we first introduce a new condition that groups these two samples:

```
colData(se.filtered)$NSUN5_IR = c(rep("High", 2), rep("Low", 4))
```

Performing differential analysis will confirm this to be the case:

```
require("limma")

res_limma_NSUN5 <- limma_ASE(
se = se.filtered,
test_factor = "NSUN5_IR",
test_nom = "High",
test_denom = "Low",
)
#> Oct 26 18:08:53 Performing limma contrast for included / excluded counts separately
#> Oct 26 18:08:54 Performing limma contrast for included / excluded counts together

head(res_limma_NSUN5$EventName)
#> [1] "NSUN5/ENST00000252594_Intron8/clean"
#> [2] "NSUN5/ENST00000252594_Intron3/clean"
#> [3] "TP53/ENST00000269305_Intron1/clean"
#> [4] "NSUN5/ENST00000252594_Intron2/clean"
#> [5] "RI:SRSF1-201-exon4;SRSF1-207-intron3"
#> [6] "RI:SRSF1-205-exon3;SRSF1-204-intron3"
```

We can now visualise the top hit, NSUN5 intron 8. To visualise the IR event across conditions, we specify the type of condition to contrast. The names of the tracks will be the names of the nominator (test) and denominator (control) conditions

```
res = Plot_Coverage(
se = se.filtered,
Event = res_limma_NSUN5$EventName[1],
condition = "NSUN5_IR",
tracks = c("High", "Low"),
)
as_egg_ggplot(res)
```

![](data:image/png;base64...)

Note the lines represent mean coverages of all samples in the labelled experimental conditions. These are achieved by normalising their individual coverages by their transcript abundance, which is calculated by summing the abundances of spliced and intron-retaining transcripts. Thus, the normalised coverage at the specified splice junction is approximately 1.0.

The grey shading represent 95% confidence intervals. It is possible that the shaded areas are larger as we traverse away from the splice junction. This may be because of differences in 3’-sequencing bias between different samples of the same condition.

Although NSUN5 intron 8 is the most differentially retained in the analysis, the difference isn’t very apparent. This is because the difference between the absolute values is very small. In contrast, intron 2 looks more prominently different in the heatmap, so we can explore this as well.

We can further compare the coverage by plotting the two conditions on the same track. This done by setting `stack_tracks = TRUE`. Further, we can add a track that tests the per-nucleotide statistical difference between the normalised coverage between the two conditions. To do this, set `t_test = TRUE`:

```
res = Plot_Coverage(
se = se.filtered,
Event = "NSUN5/ENST00000252594_Intron2/clean",
condition = "NSUN5_IR",
tracks = c("High", "Low"),
stack_tracks = TRUE,
t_test = TRUE
)
as_egg_ggplot(res)
#> Warning: Removed 270 row(s) containing missing values (geom_path).
```

![](data:image/png;base64...)

On the first track, the different coloured traces represent the two conditions. The second track plots the -log10 transformed p values, using Students T-test to test the difference between the coverages between the conditions, at per-nucleotide resolution.

Note that the t-test track does not replace formal statistical analysis using the `limma_ASE` or `DESeq_ASE` functions. Instead, they provide a useful adjunct to assess the adequacy of the normalisation of the group coverages.

There are more complex customisation options with NxtIRF’s Plot\_Coverage tool which will be explored in subsequent tutorials (TODO).

# (3) NxtIRF cookbook

```
library(NxtIRFcore)
```

## Reference Generation

First, define the path to the directory in which the reference should be stored. This directory will be made by NxtIRF, but its parent directory must exist, otherwise an error will be returned.

```
ref_path = "./Reference"
```

### Create a NxtIRF reference from user-defined FASTA and GTF files locally:

Note that setting `genome_path = "hg38"` will prompt NxtIRF to use the default files for nonPolyA and Mappability exclusion references in the generation of its reference. Valid options for `genome_path` are “hg38”, “hg19”, “mm10” and “mm9”.

```
BuildReference(
reference_path = ref_path,
fasta = "genome.fa", gtf = "transcripts.gtf",
genome_type = "hg38"
)
```

### Create a NxtIRF reference using web resources from Ensembl’s FTP:

The following will first download the genome and gene annotation files from the online resource and store a local copy of it in a file cache, facilitated by BiocFileCache. Then, it uses the downloaded resource to create the NxtIRF reference.

```
FTP = "ftp://ftp.ensembl.org/pub/release-94/"

BuildReference(
reference_path = ref_path,
fasta = paste0(FTP, "fasta/homo_sapiens/dna/",
"Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz"),
gtf = paste0(FTP, "gtf/homo_sapiens/",
"Homo_sapiens.GRCh38.94.chr.gtf.gz"),
genome_type = "hg38"
)
```

### Create a NxtIRF reference using AnnotationHub resources:

AnnotationHub contains Ensembl references for many genomes. To browse what is available:

```
require(AnnotationHub)
#> Loading required package: AnnotationHub
#> Loading required package: BiocFileCache
#> Loading required package: dbplyr
#>
#> Attaching package: 'AnnotationHub'
#> The following object is masked from 'package:Biobase':
#>
#>     cache

ah = AnnotationHub()
#> snapshotDate(): 2021-10-20
query(ah, "Ensembl")
#> AnnotationHub with 26390 records
#> # snapshotDate(): 2021-10-20
#> # $dataprovider: Ensembl, FANTOM5,DLRP,IUPHAR,HPRD,STRING,SWISSPROT,TREMBL,E...
#> # $species: Homo sapiens, Mus musculus, Danio rerio, Rattus norvegicus, Pan ...
#> # $rdataclass: TwoBitFile, GRanges, EnsDb, SQLiteFile, data.frame, OrgDb, list
#> # additional mcols(): taxonomyid, genome, description,
#> #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
#> #   rdatapath, sourceurl, sourcetype
#> # retrieve records with, e.g., 'object[["AH5046"]]'
#>
#>             title
#>   AH5046  | Ensembl Genes
#>   AH5160  | Ensembl Genes
#>   AH5311  | Ensembl Genes
#>   AH5434  | Ensembl Genes
#>   AH5435  | Ensembl EST Genes
#>   ...       ...
#>   AH97834 | LRBaseDb for Taeniopygia guttata (Zebra finch, v002)
#>   AH97835 | LRBaseDb for Takifugu rubripes (Fugu, v002)
#>   AH97836 | LRBaseDb for Ursus maritimus (Polar bear, v002)
#>   AH97837 | LRBaseDb for Vulpes vulpes (Red fox, v002)
#>   AH97838 | LRBaseDb for Xenopus tropicalis (Tropical clawed frog, v002)
```

For a more specific query:

```
query(ah, c("Homo Sapiens", "release-94"))
#> AnnotationHub with 9 records
#> # snapshotDate(): 2021-10-20
#> # $dataprovider: Ensembl
#> # $species: Homo sapiens
#> # $rdataclass: TwoBitFile, GRanges
#> # additional mcols(): taxonomyid, genome, description,
#> #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
#> #   rdatapath, sourceurl, sourcetype
#> # retrieve records with, e.g., 'object[["AH64628"]]'
#>
#>             title
#>   AH64628 | Homo_sapiens.GRCh38.94.abinitio.gtf
#>   AH64629 | Homo_sapiens.GRCh38.94.chr.gtf
#>   AH64630 | Homo_sapiens.GRCh38.94.chr_patch_hapl_scaff.gtf
#>   AH64631 | Homo_sapiens.GRCh38.94.gtf
#>   AH65744 | Homo_sapiens.GRCh38.cdna.all.2bit
#>   AH65745 | Homo_sapiens.GRCh38.dna.primary_assembly.2bit
#>   AH65746 | Homo_sapiens.GRCh38.dna_rm.primary_assembly.2bit
#>   AH65747 | Homo_sapiens.GRCh38.dna_sm.primary_assembly.2bit
#>   AH65748 | Homo_sapiens.GRCh38.ncrna.2bit
```

We wish to fetch “AH65745” and “AH64631” which contains the desired FASTA and GTF files, respectively. To build a reference using these resources:

```
BuildReference(
reference_path = ref_path,
fasta = "AH65745",
gtf = "AH64631",
genome_type = "hg38"
)
```

`BuildReference` will recognise the inputs of `fasta` and `gtf` as AnnotationHub resources as they begin with “AH”.

### Create a NxtIRF reference from species other than human or mouse:

For human and mouse genomes, we highly recommend specifying `genome_type` as the default mappability file is used to exclude intronic regions with repeat sequences from intron retention analysis. For other species, one could generate a NxtIRF reference without this reference:

```
BuildReference(
reference_path = ref_path,
fasta = "genome.fa", gtf = "transcripts.gtf",
genome_type = ""
)
```

Alternatively, if `STAR` is available on the computer or server where R/RStudio is being run, we can use the one-line function `BuildReference_Full`. This function will: \* Prepare the resources from the given FASTA and GTF files \* Generate a STAR genome \* Use the STAR genome and the FASTA file to *de-novo* calculate and define low mappability regions \* Build the NxtIRF reference using the genome resources and mappability file

```
BuildReference_Full(
reference_path = ref_path,
fasta = "genome.fa", gtf = "transcripts.gtf",
genome_type = "",
use_STAR_mappability = TRUE,
n_threads = 4
)
```

`n_threads` specify how many threads should be used to build the STAR reference and to calculate the low mappability regions

Finally, if `STAR` is not available, `Rsubread` is available on Bioconductor to perform mappability calculations. The example code in the manual is displayed here for convenience, to demonstrate how this would be done:

```
# (1a) Creates genome resource files

ref_path = file.path(tempdir(), "Reference")

GetReferenceResource(
reference_path = ref_path,
fasta = chrZ_genome(),
gtf = chrZ_gtf()
)

# (1b) Systematically generate reads based on the NxtIRF example genome:

Mappability_GenReads(
reference_path = ref_path
)

# (2) Align the generated reads using Rsubread:

# (2a) Build the Rsubread genome index:

setwd(ref_path)
Rsubread::buildindex(basename = "./reference_index",
reference = chrZ_genome())

# (2b) Align the synthetic reads using Rsubread::subjunc()

Rsubread::subjunc(
index = "./reference_index",
readfile1 = file.path(ref_path, "Mappability", "Reads.fa"),
output_file = file.path(ref_path, "Mappability", "AlignedReads.bam"),
useAnnotation = TRUE,
annot.ext = chrZ_gtf(),
isGTF = TRUE
)

# (3) Analyse the aligned reads in the BAM file for low-mappability regions:

Mappability_CalculateExclusions(
reference_path = ref_path,
aligned_bam = file.path(ref_path, "Mappability", "AlignedReads.bam")
)

# (4) Build the NxtIRF reference using the calculated Mappability Exclusions

BuildReference(ref_path)
```

## Align Raw FASTQ files

### Checking if STAR is installed

To use `STAR` to align FASTQ files, one must be using a system with `STAR` installed. This software is not available in Windows. To check if `STAR` is available:

```
STAR_version()
#> Oct 26 18:09:10 STAR is not installed
```

### Building a STAR reference

```
ref_path = "./Reference"

# Ensure genome resources are prepared from genome FASTA and GTF file:

if(!file.exists(file.path(ref_path, "resources"))) {
GetReferenceResource(
reference_path = ref_path,
fasta = "genome.fa",
gtf = "transcripts.gtf"
)
}

# Generate a STAR genome reference:
STAR_BuildRef(
reference_path = ref_path,
n_threads = 8
)
```

### Aligning a single sample using STAR

```
STAR_align_fastq(
STAR_ref_path = file.path(ref_path, "STAR"),
BAM_output_path = "./bams/sample1",
fastq_1 = "sample1_1.fastq", fastq_2 = "sample1_2.fastq",
n_threads = 8
)
```

### Aligning multiple samples using STAR

```
Experiment = data.frame(
sample = c("sample_A", "sample_B"),
forward = file.path("raw_data", c("sample_A", "sample_B"),
c("sample_A_1.fastq", "sample_B_1.fastq")),
reverse = file.path("raw_data", c("sample_A", "sample_B"),
c("sample_A_2.fastq", "sample_B_2.fastq"))
)

STAR_align_experiment(
Experiment = Experiment,
STAR_ref_path = file.path("Reference_FTP", "STAR"),
BAM_output_path = "./bams",
n_threads = 8,
two_pass = FALSE
)
```

To use two-pass mapping, set `two_pass = TRUE`. We recommend disabling this feature, as one-pass mapping is adequate in typical-use cases.

## Running IRFinder on BAM files

To conveniently find all BAM files recursively in a given path:

```
bams = Find_Bams("./bams", level = 1)
```

This convenience function returns the putative sample names, either from BAM file names themselves (`level = 0`), or from the names of their parent directories (`level = 1`).

To use IRFinder using 4 OpenMP threads:

```
# assume NxtIRF reference has been generated in `ref_path`

IRFinder(
bamfiles = bams$path,
sample_names = bams$sample,
reference_path = ref_path,
output_path = "./IRFinder_output",
n_threads = 4,
Use_OpenMP = TRUE
)
```

## Creating COV files from BAM files without running IRFinder

Sometimes one may wish to create a COV file from a BAM file without running the IRFinder algorithm. One reason might be because a NxtIRF/IRFinder reference is not available.

To convert a list of BAM files, run `BAM2COV()`. This is a function structurally similar to `IRFinder()` but without the need to give the path to the NxtIRF reference:

```
BAM2COV(
bamfiles = bams$path,
sample_names = bams$sample,
output_path = "./IRFinder_output",
n_threads = 4,
Use_OpenMP = TRUE
)
```

## Collating IRFinder data into a single experiment:

Assuming the NxtIRF reference is in `ref_path`, after running IRFinder as shown in the previous section, use the convenience function `Find_IRFinder_Output()` to tabulate a list of samples and their corresponding IRFinder outputs:

```
expr = Find_IRFinder_Output("./IRFinder_output")
```

This data.frame can be directly used to run `CollateData`:

```
CollateData(
Experiment = expr,
reference_path = ref_path,
output_path = "./NxtIRF_output"
)
```

Then, the collated data can be imported as a `NxtSE` object, which is an object that inherits `SummarizedExperiment` and has specialized containers to hold additional data required by NxtIRF.

```
se = MakeSE("./NxtIRF_output")
```

## Downstream analysis using NxtIRFcore

Please refer to chapters 1 and 2 for worked examples using the NxtIRF example dataset.

# SessionInfo

```
sessionInfo()
#> R version 4.1.1 (2021-08-10)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 20.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.14-bioc/R/lib/libRblas.so
#> LAPACK: /home/biocbuild/bbs-3.14-bioc/R/lib/libRlapack.so
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] AnnotationHub_3.2.0         BiocFileCache_2.2.0
#>  [3] dbplyr_2.1.1                pheatmap_1.0.12
#>  [5] ggplot2_3.3.5               DoubleExpSeq_1.1
#>  [7] DESeq2_1.34.0               SummarizedExperiment_1.24.0
#>  [9] Biobase_2.54.0              MatrixGenerics_1.6.0
#> [11] matrixStats_0.61.0          GenomicRanges_1.46.0
#> [13] GenomeInfoDb_1.30.0         IRanges_2.28.0
#> [15] S4Vectors_0.32.0            BiocGenerics_0.40.0
#> [17] limma_3.50.0                NxtIRFcore_1.0.0
#> [19] NxtIRFdata_0.99.6
#>
#> loaded via a namespace (and not attached):
#>   [1] colorspace_2.0-2              rjson_0.2.20
#>   [3] ellipsis_0.3.2                XVector_0.34.0
#>   [5] farver_2.1.0                  bit64_4.0.5
#>   [7] interactiveDisplayBase_1.32.0 AnnotationDbi_1.56.0
#>   [9] fansi_0.5.0                   splines_4.1.1
#>  [11] R.methodsS3_1.8.1             sparseMatrixStats_1.6.0
#>  [13] cachem_1.0.6                  geneplotter_1.72.0
#>  [15] knitr_1.36                    jsonlite_1.7.2
#>  [17] Rsamtools_2.10.0              annotate_1.72.0
#>  [19] png_0.1-7                     R.oo_1.24.0
#>  [21] shiny_1.7.1                   HDF5Array_1.22.0
#>  [23] BiocManager_1.30.16           compiler_4.1.1
#>  [25] httr_1.4.2                    assertthat_0.2.1
#>  [27] Matrix_1.3-4                  fastmap_1.1.0
#>  [29] lazyeval_0.2.2                later_1.3.0
#>  [31] htmltools_0.5.2               tools_4.1.1
#>  [33] gtable_0.3.0                  glue_1.4.2
#>  [35] GenomeInfoDbData_1.2.7        dplyr_1.0.7
#>  [37] rappdirs_0.3.3                Rcpp_1.0.7
#>  [39] jquerylib_0.1.4               vctrs_0.3.8
#>  [41] Biostrings_2.62.0             rhdf5filters_1.6.0
#>  [43] rtracklayer_1.54.0            crosstalk_1.1.1
#>  [45] DelayedMatrixStats_1.16.0     xfun_0.27
#>  [47] stringr_1.4.0                 mime_0.12
#>  [49] lifecycle_1.0.1               restfulr_0.0.13
#>  [51] XML_3.99-0.8                  zlibbioc_1.40.0
#>  [53] scales_1.1.1                  BSgenome_1.62.0
#>  [55] promises_1.2.0.1              parallel_4.1.1
#>  [57] rhdf5_2.38.0                  RColorBrewer_1.1-2
#>  [59] yaml_2.2.1                    curl_4.3.2
#>  [61] gridExtra_2.3                 memoise_2.0.0
#>  [63] sass_0.4.0                    stringi_1.7.5
#>  [65] RSQLite_2.2.8                 highr_0.9
#>  [67] BiocVersion_3.14.0            genefilter_1.76.0
#>  [69] BiocIO_1.4.0                  filelock_1.0.2
#>  [71] BiocParallel_1.28.0           rlang_0.4.12
#>  [73] pkgconfig_2.0.3               bitops_1.0-7
#>  [75] evaluate_0.14                 lattice_0.20-45
#>  [77] purrr_0.3.4                   Rhdf5lib_1.16.0
#>  [79] labeling_0.4.2                GenomicAlignments_1.30.0
#>  [81] htmlwidgets_1.5.4             bit_4.0.4
#>  [83] tidyselect_1.1.1              magrittr_2.0.1
#>  [85] R6_2.5.1                      generics_0.1.1
#>  [87] DelayedArray_0.20.0           DBI_1.1.1
#>  [89] withr_2.4.2                   pillar_1.6.4
#>  [91] survival_3.2-13               KEGGREST_1.34.0
#>  [93] RCurl_1.98-1.5                tibble_3.1.5
#>  [95] crayon_1.4.1                  utf8_1.2.2
#>  [97] plotly_4.10.0                 rmarkdown_2.11
#>  [99] locfit_1.5-9.4                grid_4.1.1
#> [101] data.table_1.14.2             blob_1.2.2
#> [103] digest_0.6.28                 xtable_1.8-4
#> [105] numDeriv_2016.8-1.1           tidyr_1.1.4
#> [107] httpuv_1.6.3                  R.utils_2.11.0
#> [109] munsell_0.5.0                 fst_0.9.4
#> [111] viridisLite_0.4.0             bslib_0.3.1
#> [113] egg_0.4.5
```
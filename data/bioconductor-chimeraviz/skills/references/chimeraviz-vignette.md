# chimeraviz

Stian Lågstad

#### 2025-10-29

# Contents

* [1 Introduction](#introduction)
* [2 Basic features](#basic-features)
* [3 Plotting](#plotting)
  + [3.1 Overview plot](#overview-plot)
    - [3.1.1 Building the overview plot](#building-the-overview-plot)
  + [3.2 Fusion reads plot](#fusion-reads-plot)
    - [3.2.1 Building the Fusion Reads Plot](#building-the-fusion-reads-plot)
  + [3.3 Fusion plot](#fusion-plot)
    - [3.3.1 Building the fusion plot](#building-the-fusion-plot)
    - [3.3.2 Plotting the example fusion event](#plotting-the-example-fusion-event)
  + [3.4 Fusion transcripts plot](#fusion-transcripts-plot)
  + [3.5 Fusion transcript plot](#fusion-transcript-plot)
  + [3.6 Fusion transcript plot with protein domain annotations](#fusion-transcript-plot-with-protein-domain-annotations)
  + [3.7 Fusion transcript graph plot](#fusion-transcript-graph-plot)
* [4 Reporting and filtering](#reporting-and-filtering)
  + [4.1 Working with Fusion objects](#working-with-fusion-objects)
  + [4.2 The fusion report](#the-fusion-report)
* [5 More information / where to get help](#more-information-where-to-get-help)
* [6 Session Information](#session-information)

# 1 Introduction

This is the vignette of *chimeraviz*, an R package that automates the creation of chimeric RNA visualizations. This vignette will take you through the functionality of *chimeraviz*.

# 2 Basic features

*chimeraviz* allows you to import data from nine different fusion-finders: deFuse, EricScript, InFusion, JAFFA, FusionCatcher, FusionMap, PRADA, SOAPFuse, and STAR-FUSION. Getting started is easy:

```
# Load chimeraviz
library(chimeraviz)

# Get reference to results file from deFuse
defuse833ke <- system.file(
"extdata",
"defuse_833ke_results.filtered.tsv",
package="chimeraviz")

# Load the results file into a list of fusion objects
fusions <- import_defuse(defuse833ke, "hg19")
```

Import functions for the other supported fusion-finders are similarly named (for example `importEriscript` or `importInfusion`).

A list of Fusion objects, objects that represent each fusion transcript, is now available in the list `fusions`.

```
length(fusions)
```

```
## [1] 17
```

As you can see, this list has 17 fusion objects. It is straightforward to find a specific fusion event and print information about it, or about each of the partner genes.

```
# Find a specific fusion event
fusion <- get_fusion_by_id(fusions, 5267)

# Show information about this fusion event
fusion
```

```
## [1] "Fusion object"
## [1] "id: 5267"
## [1] "Fusion tool: defuse"
## [1] "Genome version: hg19"
## [1] "Gene names: RCC1-HENMT1"
## [1] "Chromosomes: chr1-chr1"
## [1] "Strands: +,-"
## [1] "In-frame?: FALSE"
```

```
# Show information about the upstream fusion partner
upstream_partner_gene(fusion)
```

```
## [1] "PartnerGene object"
## [1] "Name: RCC1"
## [1] "ensemblId: ENSG00000180198"
## [1] "Chromosome: chr1"
## [1] "Strand: +"
## [1] "Breakpoint: 28834672"
```

```
# Show information about the downstream fusion partner
downstream_partner_gene(fusion)
```

```
## [1] "PartnerGene object"
## [1] "Name: HENMT1"
## [1] "ensemblId: ENSG00000162639"
## [1] "Chromosome: chr1"
## [1] "Strand: -"
## [1] "Breakpoint: 109202584"
```

# 3 Plotting

## 3.1 Overview plot

The overview plot is a nice way to get an overview over the nominated fusions in a sample. It will produce a circular plot like this one:

![](data:image/png;base64...)

In this plot, you can see the following:

* All chromosomes with cytoband information
* Fusion events as links between locations in chromosomes (with gene names, if there is enough space in the plot)
* Red links indicate intrachromosomal fusions, while blue links indicate interchromosomal fusions
* The widths of each link varies according to how many reads support the fusion event. See the `plot_circle()` documentation for more detail on how this is computed

### 3.1.1 Building the overview plot

All we need for the overview plot is a list of fusion events. Let’s import the SOAPfuse example data included with *chimeraviz*:

```
# Load SOAPfuse data
if(!exists("soapfuse833ke"))
  soapfuse833ke <- system.file(
    "extdata",
    "soapfuse_833ke_final.Fusion.specific.for.genes",
    package = "chimeraviz")
fusions <- import_soapfuse(soapfuse833ke, "hg38", 10)
```

With these fusion events in the `fusions` variable, we’re ready to plot:

```
plot_circle(fusions)
```

![](data:image/png;base64...)

## 3.2 Fusion reads plot

The fusion reads plot is a way to visualize the reads supporting a fusion event mapped to the putative fusion sequence. Many fusion finders report a putative fusion sequence, and by mapping reads to this sequence visualize how well the fusion event is supported. The function `plot_fusion_reads()` will, given enough data, produce a plot like this one:

```
## Warning in call_new_fun_in_cigarillo("sequenceLayer", "project_sequences", : sequenceLayer() is formally deprecated in GenomicAlignments >= 1.45.5 and
##   replaced with the project_sequences() function from the new cigarillo package
```

![](data:image/png;base64...)

As seen in the plot, this fusion event is supported by 6 paired end reads.

### 3.2.1 Building the Fusion Reads Plot

We have to complete a few steps in order to create the fusion reads plot. We have to:

1. Align reads to the fusion sequence
2. Import the alignment data into a fusion object
3. Create the plot

#### 3.2.1.1 1. Aligning reads to the fusion sequence

##### 3.2.1.1.1 Load example fusion event

First we load an example fusion event:

```
# Load deFuse data
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
    "extdata",
    "defuse_833ke_results.filtered.tsv",
    package = "chimeraviz")
fusions <- import_defuse(defuse833ke, "hg19", 1)
# Choose example fusion event
fusion <- get_fusion_by_id(fusions, 5267)
```

##### 3.2.1.1.2 Extracting fusion reads

Some fusion finders report which reads that gave evidence of the fusion event. By utilizing this information, we can avoid mapping *all* reads against the fusion sequence (that can take a while). deFuse is such a fusion finder. With the script `get_fusion_fastq.pl` that deFuse provides, we can extract the interesting reads. For the example fusion event, we have extracted the interesting reads into the files `reads_supporting_defuse_fusion_5267.1.fq` and `reads_supporting_defuse_fusion_5267.2.fq`. These are included in `chimeraviz` and can be referenced like this:

```
fastq1 <- system.file(
  "extdata",
  "reads_supporting_defuse_fusion_5267.1.fq",
  package = "chimeraviz")
fastq2 <- system.file(
  "extdata",
  "reads_supporting_defuse_fusion_5267.2.fq",
  package = "chimeraviz")
```

##### 3.2.1.1.3 Extract the fusion junction sequence

You can create a file containing the fusion junction sequence like this:

```
referenceFilename <- "reference.fa"
write_fusion_reference(fusion = fusion, filename = referenceFilename)
```

This will create a fasta file with the sequence.

##### 3.2.1.1.4 Map fusion reads to the fusion junction sequence

The goal in this step is to align the reads you have against the fusion junction sequence. There are many ways to do this. `cimeraviz` offers wrapper functions for both Bowtie and Rsubread:

* Bowtie is an ultrafast and memory-efficient tool for aligning sequencing reads to reference sequences (read more [here](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)). Note that both Bowtie 1 and 2 can be used.
* Rsubread is an R package that performs (among other things) read alignment (read more [here](https://bioconductor.org/packages/release/bioc/html/Rsubread.html)).

First we have to create an index for our reference sequence, the fusion junction sequence. Then we will align the reads against the reference. The steps are similar for both Bowtie and Rsubread:

###### 3.2.1.1.4.1 Bowtie

```
# First load the bowtie functions
source(system.file(
  "scripts",
  "bowtie.R",
  package="chimeraviz"))
# Then create index
bowtie_index(
  bowtie_build_location = "/path/to/bowtie-build",
  reference_fasta = reference_filename)
# And align
bowtie_align(
  bowtie_location = "/path/to/bowtie",
  reference_name = reference_filename,
  fastq1 = fastq1,
  fastq2 = fastq2,
  output_bam_filename = "fusion_alignment")
```

The code above first loads the bowtie wrapper functions. This is necessary because the wrapper functions are not part of the `chimeraviz` package, but are added as external scripts. We then create an index for the reference sequence, and align the fusion reads to the reference. The result of this will be the files `fusion_alignment.bam`, `fusion_alignment.bam.bai`, and some additional files that Bowtie creates for indexing.

Note that you can use the parameter `p` with `bowtie_align` to tell bowtie how many threads to use. The more you have available, the faster the alignment will complete.

###### 3.2.1.1.4.2 Rsubread

```
# First load the rsubread functions
source(system.file(
  "scripts",
  "rsubread.R",
  package="chimeraviz"))
# Then create index
rsubread_index(reference_fasta = reference_filename)
# And align
rsubread_align(
  reference_name = reference_filename,
  fastq1 = fastq1,
  fastq2 = fastq2,
  output_bam_filename = "fusion_alignment")
```

The code above first loads the rsubread wrapper functions. This is necessary because the wrapper functions are not part of the `chimeraviz` package, but are added as external scripts. We then create an index for the reference sequence, and align the fusion reads to the reference. The result of this will be the files `fusion_alignment.bam`, `fusion_alignment.bam.bai`, and some additional files that Rsubread creates for indexing and aligning.

###### 3.2.1.1.4.3 A note on alignment performance

If you plan to align the original fastq files against the fusion junction sequence, note that the alignment might take a while. The original fastq files used to generate all chimeraviz example data were 7.3 GB each. Helping in this regard is the fact that many fusion finders report which reads supports each fusion event. deFuse does this with the script `get_fusion_fastq.pl` (introduced in version 0.7 of deFuse). Other fusion finders may only output which read ids supported each fusion event. In that case, chimeraviz will help the user extract specific read ids from the original fastq files using the function `fetch_reads_from_fastq()`. The fastq files produced by `get_fusion_fastq.pl` and `fetch_reads_from_fastq()` are much smaller, resulting in the alignment step only taking a few seconds.

##### 3.2.1.1.5 Example .bam file for this example

We have included an example .bam file with `chimeraviz` that contains the reads supporting fusion event 5267 aligned to the fusion junction sequence. We will continue this example with that .bam file:

```
if(!exists("bamfile5267"))
  bamfile5267 <- system.file(
    "extdata",
    "5267readsAligned.bam",
    package="chimeraviz")
```

#### 3.2.1.2 2. Import the alignment data into our fusion object

Now that we have a .bam file with the fusion reads aligned to the fusion sequence, we can import it to our fusion object:

```
# Add bamfile of fusion reads to the fusion oject
fusion <- add_fusion_reads_alignment(fusion, bamfile5267)
```

#### 3.2.1.3 3. Create the plot

With all that done, we are ready to plot:

```
plot_fusion_reads(fusion)
```

```
## Warning in call_new_fun_in_cigarillo("sequenceLayer", "project_sequences", : sequenceLayer() is formally deprecated in GenomicAlignments >= 1.45.5 and
##   replaced with the project_sequences() function from the new cigarillo package
```

![](data:image/png;base64...)

## 3.3 Fusion plot

The fusion plot is the main product of `chimeraviz`, created with the `plot_fusion` function. It will create a plot like this one:

```
## Warning in call_new_fun_in_cigarillo("sequenceLayer", "project_sequences", : sequenceLayer() is formally deprecated in GenomicAlignments >= 1.45.5 and
##   replaced with the project_sequences() function from the new cigarillo package
## Warning in call_new_fun_in_cigarillo("sequenceLayer", "project_sequences", : sequenceLayer() is formally deprecated in GenomicAlignments >= 1.45.5 and
##   replaced with the project_sequences() function from the new cigarillo package
```

![](data:image/png;base64...)

Or, alternatively:

```
## Warning in call_new_fun_in_cigarillo("sequenceLayer", "project_sequences", : sequenceLayer() is formally deprecated in GenomicAlignments >= 1.45.5 and
##   replaced with the project_sequences() function from the new cigarillo package
## Warning in call_new_fun_in_cigarillo("sequenceLayer", "project_sequences", : sequenceLayer() is formally deprecated in GenomicAlignments >= 1.45.5 and
##   replaced with the project_sequences() function from the new cigarillo package
```

![](data:image/png;base64...)

This plot holds a lot of information. You can see:

* Chromosome ideograms with a red line indicating the location of the two partner genes
* Transcript information showing exons in each partner gene
* The breakpoint between the partner genes, indicated with a red link
* Above the red link you can see the number of sequencing reads that support the fusion event
* Coverage information indicating the RNA expression level
* Genome coordinates (mega basepairs from the p-telomere)

The fusion you can see above is the `RCC1-HENMT1` fusion described by Andreas M. Hoff et al. in the paper [Identification of Novel Fusion Genes in Testicular Germ Cell Tumors (Cancer Research, 2016)](http://cancerres.aacrjournals.org/content/76/1/108.full).

Note that the plot reverses genes as necessary, so that the fused genes are plotted in the “correct” (5’-to-3’) relative orientation.

### 3.3.1 Building the fusion plot

To build the fusion plot, we need the following:

1. Information about a fusion event
2. A way to get transcript information
3. Coverage information from a .bam file (or a .bedGraph file)

We will go through these steps in turn.

#### 3.3.1.1 1. Load fusion data and find a fusion event

For this example we will load data from a deFuse run. deFuse, described in the paper [deFuse: An Algorithm for Gene Fusion Discovery in Tumor RNA-Seq Data (McPherson et al., PloS Comput. Biol, 2011)](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1001138), is a Perl program that nominates gene fusions from RNA-seq data. `chimeraviz` includes example data from a deFuse run, so let’s load it using the `import_defuse()` function:

```
# First find the example data
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
    "extdata",
    "defuse_833ke_results.filtered.tsv",
    package = "chimeraviz")
# Then load the fusion events
fusions <- import_defuse(defuse833ke, "hg19", 1)
```

We should now have a list of fusion events in the `fusions` variable.

Let us try to find the `RCC1-HENMT1` fusion. First, we will search our list of fusion events for fusions involving the gene `RCC1` using the function `get_fusion_by_gene_name()`:

```
# See if we can find any fusions involving RCC1
get_fusion_by_gene_name(fusions, "RCC1")
```

```
## [[1]]
## [1] "Fusion object"
## [1] "id: 5267"
## [1] "Fusion tool: defuse"
## [1] "Genome version: hg19"
## [1] "Gene names: RCC1-HENMT1"
## [1] "Chromosomes: chr1-chr1"
## [1] "Strands: +,-"
## [1] "In-frame?: FALSE"
```

As you can see, we found one fusion event involving this gene. Let us use the `get_fusion_by_id()` function to retrieve the fusion event:

```
# Extract the specific fusion
fusion <- get_fusion_by_id(fusions, 5267)
```

We now have the fusion event we want to plot in the variable `fusion`.

#### 3.3.1.2 2. Create an ensembldb object

To get transcript information we will use functions from the `ensembldb` package. We will use an `EnsDb` object to retrieve transcript information for each of the partner genes in our fusion event. Let us load an example `EnsDb` object:

```
# First find our example EnsDb file
if(!exists("edbSqliteFile"))
  edbSqliteFile <- system.file(
    "extdata",
    "Homo_sapiens.GRCh37.74.sqlite",
    package="chimeraviz")
# Then load it
edb <- ensembldb::EnsDb(edbSqliteFile)
```

This example object, loaded from the file `Homo_sapiens.GRCh37.74.sqlite` that is distributed with `chimeraviz`, only holds transcript data for our specific example fusion transcript. If you want to, you can create a full `EnsDb` by downloading Ensembl data and creating an `EnsDb` object like this:

```
# Create EnsDb from a downloaded .gtf file
edbSqliteFile <- ensDbFromGtf(gtf = "Homo_sapiens.GRCh37.74.gtf")
# The function above create a .sqlite file, like the one that is included with
# chimeraviz. The path to the file is stored in the edbSqliteFile variable. To
# load the database, do this:
edb <- ensembldb::EnsDb(edbSqliteFile)
```

If you choose to do this, note that it might take some time. You only have to do it once, though. The .sqlite file that `ensDbFromGtf` creates can be used in later sessions, like this:

```
# Create an edb object directly from the .sqlite file
edb <- ensembldb::EnsDb("Homo_sapiens.GRCh37.74.sqlite")
```

#### 3.3.1.3 3. Coverage information from a .bam file

We need a .bam file (or a .bedGraph file) if we want to include coverage information in the fusion plot. `chimeraviz` includes an example .bam file that contains only the reads in the region of `RCC1` and `HENMT1`. We only need a variable pointing to it:

```
if(!exists("fusion5267and11759reads"))
  fusion5267and11759reads <- system.file(
    "extdata",
    "fusion5267and11759reads.bam",
    package = "chimeraviz")
```

### 3.3.2 Plotting the example fusion event

With the fusion event, transcript database and bamfile ready, we can create the plot with the function `plot_fusion()`:

```
plot_fusion(
 fusion = fusion,
 bamfile = fusion5267and11759reads,
 edb = edb,
 non_ucsc = TRUE)
```

```
## Warning in call_new_fun_in_cigarillo("sequenceLayer", "project_sequences", : sequenceLayer() is formally deprecated in GenomicAlignments >= 1.45.5 and
##   replaced with the project_sequences() function from the new cigarillo package
## Warning in call_new_fun_in_cigarillo("sequenceLayer", "project_sequences", : sequenceLayer() is formally deprecated in GenomicAlignments >= 1.45.5 and
##   replaced with the project_sequences() function from the new cigarillo package
```

![](data:image/png;base64...)

To collapse all transcripts into one, use the `reduce_transcripts` parameter:

```
plot_fusion(
 fusion = fusion,
 bamfile = fusion5267and11759reads,
 edb = edb,
 non_ucsc = TRUE,
 reduce_transcripts = TRUE)
```

```
## Warning in call_new_fun_in_cigarillo("sequenceLayer", "project_sequences", : sequenceLayer() is formally deprecated in GenomicAlignments >= 1.45.5 and
##   replaced with the project_sequences() function from the new cigarillo package
## Warning in call_new_fun_in_cigarillo("sequenceLayer", "project_sequences", : sequenceLayer() is formally deprecated in GenomicAlignments >= 1.45.5 and
##   replaced with the project_sequences() function from the new cigarillo package
```

![](data:image/png;base64...)

Note the `non_ucsc` parameter we have set to `TRUE`. If the chromosome names in your .bam file are called “1” instead of “chr1”, then you need to set `non_ucsc = TRUE` when using `plot_fusion()`.

If you have read counts in a .bedGraph file (from bedtools genomecov for example), you can use the `bedGraph` parameter instead of the `bamfile` parameter and point to a .bedGraph file.

## 3.4 Fusion transcripts plot

If you are only interested in the transcripts of each partner gene in a fusion event, then it is not necessary to show all the information that is in the fusion plot. The transcripts plot is designed to give a simple view on the transcripts that might be included in the fusion transcript. It can be created like this:

```
# Load deFuse data
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
    "extdata",
    "defuse_833ke_results.filtered.tsv",
    package = "chimeraviz")
fusions <- import_defuse(defuse833ke, "hg19", 1)
# Choose a fusion object
fusion <- get_fusion_by_id(fusions, 5267)
# Load edb
if(!exists("edbSqliteFile"))
  edbSqliteFile <- system.file(
    "extdata",
    "Homo_sapiens.GRCh37.74.sqlite",
    package="chimeraviz")
edb <- ensembldb::EnsDb(edbSqliteFile)
# Plot!
plot_transcripts(
  fusion = fusion,
  edb = edb)
```

![](data:image/png;base64...)

The transcripts of the upstream gene is shown on top, and the transcripts of the downstream gene is shown on the bottom of the figure. As before, the exons that might be part of the fusion transcript are in darker colors. The interesting exons are also highlighted with grey boxes. Below each transcript, the gene name and the Ensembl transcript id is shown. This transcripts plot can also be shown with coverage data, if you are interested in seeing expression levels:

```
# Choose a fusion object
fusion <- get_fusion_by_id(fusions, 5267)
# Load edb
if(!exists("edbSqliteFile"))
  edbSqliteFile <- system.file(
    "extdata",
    "Homo_sapiens.GRCh37.74.sqlite",
    package="chimeraviz")
edb <- ensembldb::EnsDb(edbSqliteFile)
# Get reference to the .BAM file
if(!exists("fusion5267and11759reads"))
  fusion5267and11759reads <- system.file(
    "extdata",
    "fusion5267and11759reads.bam",
    package="chimeraviz")
# Plot!
plot_transcripts(
  fusion = fusion,
  edb = edb,
  bamfile = fusion5267and11759reads,
  non_ucsc = TRUE)
```

```
## Warning in call_new_fun_in_cigarillo("sequenceLayer", "project_sequences", : sequenceLayer() is formally deprecated in GenomicAlignments >= 1.45.5 and
##   replaced with the project_sequences() function from the new cigarillo package
## Warning in call_new_fun_in_cigarillo("sequenceLayer", "project_sequences", : sequenceLayer() is formally deprecated in GenomicAlignments >= 1.45.5 and
##   replaced with the project_sequences() function from the new cigarillo package
```

![](data:image/png;base64...)

Similar to the fusion plot, it is also possible to reduce the transcripts for both genes into a single transcript track. Note the use of the parameter ylim to set a fixed limit for both y-axes in the plot:

```
# Load deFuse data
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
  "extdata",
  "defuse_833ke_results.filtered.tsv",
  package="chimeraviz")
fusions <- import_defuse(defuse833ke, "hg19", 1)
# Choose a fusion object
fusion <- get_fusion_by_id(fusions, 5267)
# Load edb
if(!exists("edbSqliteFile"))
  edbSqliteFile <- system.file(
    "extdata",
    "Homo_sapiens.GRCh37.74.sqlite",
    package="chimeraviz")
edb <- ensembldb::EnsDb(edbSqliteFile)
# Get reference to the .BAM file
if(!exists("fusion5267and11759reads"))
  fusion5267and11759reads <- system.file(
    "extdata",
    "fusion5267and11759reads.bam",
    package="chimeraviz")
# Plot!
plot_transcripts(
  fusion = fusion,
  edb = edb,
  bamfile = fusion5267and11759reads,
  non_ucsc = TRUE,
  reduce_transcripts = TRUE,
  ylim = c(0,1000))
```

```
## Warning in call_new_fun_in_cigarillo("sequenceLayer", "project_sequences", : sequenceLayer() is formally deprecated in GenomicAlignments >= 1.45.5 and
##   replaced with the project_sequences() function from the new cigarillo package
## Warning in call_new_fun_in_cigarillo("sequenceLayer", "project_sequences", : sequenceLayer() is formally deprecated in GenomicAlignments >= 1.45.5 and
##   replaced with the project_sequences() function from the new cigarillo package
```

![](data:image/png;base64...)

It is also possible to use a .bedGraph file instead of a .bam file in this plot.

## 3.5 Fusion transcript plot

The fusion transcript plot shows the reduced version of all exons that could be part of a fusion transcript. This is a way to view all the possible parts of a fusion transcript merged into one.

```
# Load deFuse data
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
    "extdata",
    "defuse_833ke_results.filtered.tsv",
    package="chimeraviz")
fusions <- import_defuse(defuse833ke, "hg19", 1)
# Choose a fusion object
fusion <- get_fusion_by_id(fusions, 5267)
# Load edb
if(!exists("edbSqliteFile"))
  edbSqliteFile <- system.file(
    "extdata",
    "Homo_sapiens.GRCh37.74.sqlite",
    package="chimeraviz")
edb <- ensembldb::EnsDb(edbSqliteFile)
# Plot!
plot_fusion_transcript(
  fusion,
  edb)
```

![](data:image/png;base64...)

As with previous visualizations, coverage data can be added (either with a .bam file or a .bedGraph file).

```
# Load deFuse data
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
    "extdata",
    "defuse_833ke_results.filtered.tsv",
    package="chimeraviz")
fusions <- import_defuse(defuse833ke, "hg19", 1)
# Choose a fusion object
fusion <- get_fusion_by_id(fusions, 5267)
# Load edb
if(!exists("edbSqliteFile"))
  edbSqliteFile <- system.file(
    "extdata",
    "Homo_sapiens.GRCh37.74.sqlite",
    package="chimeraviz")
edb <- ensembldb::EnsDb(edbSqliteFile)
# Get reference to the .BAM file
if(!exists("fusion5267and11759reads"))
  fusion5267and11759reads <- system.file(
    "extdata",
    "fusion5267and11759reads.bam",
    package="chimeraviz")
# Plot!
plot_fusion_transcript(
  fusion,
  edb,
  fusion5267and11759reads)
```

![](data:image/png;base64...)

The fusion transcript plot merges the available transcripts of both genes, remove the parts that are not possible parts of the fusion transcript, and joins the included parts into a new transcript. With the coverage data included, it is easy to see the expression levels of the parts that might be included in a fusion transcript.

## 3.6 Fusion transcript plot with protein domain annotations

The fusion transcript plot with protein domain annotations shows a specific fusion transcript along with protein domain annotation data. If a bamfile is specified, the fusion transcript will be plotted with coverage information as well.

```
# Load deFuse data
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
    "extdata",
    "defuse_833ke_results.filtered.tsv",
    package="chimeraviz")
fusions <- import_defuse(defuse833ke, "hg19", 1)
# Choose a fusion object
fusion <- get_fusion_by_id(fusions, 5267)
# Select transcripts
gene_upstream_transcript <- "ENST00000434290"
gene_downstream_transcript <- "ENST00000370031"
# Load edb
if(!exists("edbSqliteFile"))
  edbSqliteFile <- system.file(
    "extdata",
    "Homo_sapiens.GRCh37.74.sqlite",
    package="chimeraviz")
edb <- ensembldb::EnsDb(edbSqliteFile)
# bamfile with reads in the regions of this fusion event
if(!exists("fusion5267and11759reads"))
  fusion5267and11759reads <- system.file(
    "extdata",
    "fusion5267and11759reads.bam",
    package="chimeraviz")
# bedfile with protein domains for the transcripts in this example
if(!exists("bedfile"))
  bedfile <- system.file(
    "extdata",
    "protein_domains_5267.bed",
    package="chimeraviz")
# Plot!
plot_fusion_transcript_with_protein_domain(
      fusion = fusion,
      edb = edb,
      bamfile = fusion5267and11759reads,
      bedfile = bedfile,
      gene_upstream_transcript = gene_upstream_transcript,
      gene_downstream_transcript = gene_downstream_transcript,
      plot_downstream_protein_domains_if_fusion_is_out_of_frame = TRUE)
```

![](data:image/png;base64...)

Note the optional parameter `plot_downstream_protein_domains_if_fusion_is_out_of_frame`. This let the user see protein domains encoded by the downstream gene even though the reading frame is not kept across the fusion junction.

This plot requires a bed file that contains the transcript level coordinates of protein domains. The bed file must be in this format:

| Transcript\_id | Pfam\_id | Start | End | Domain\_name\_abbreviation | Domain\_name\_full |
| --- | --- | --- | --- | --- | --- |
| ENST00000434290 | PF00415 | 529 | 678 | RCC1 | Regulator of chromosome condensation (RCC1) repeat |
| ENST00000434290 | PF00415 | 379 | 522 | RCC1 | Regulator of chromosome condensation (RCC1) repeat |
| ENST00000434290 | PF00415 | 928 | 1056 | RCC1 | Regulator of chromosome condensation (RCC1) repeat |
| ENST00000370031 | PF13489 | 289 | 753 | Methyltransf\_23 | Methyltransferase domain |

## 3.7 Fusion transcript graph plot

All that is known about a fusion event is that a fusion-finder has scored a possible link between two genes. If there are four transcript variants of the upstream gene partner and four transcript variants of the downstream gene partner, then there are in total sixteen different splice variants of the finally processed fusion transcript. And that is only if we count the known, annotated variants of each gene. How can we make sense of all this? Plotting the transcript together as in previous plots helps, but there is a better way to visualize the putative fusion transcript: As a graph. By representing transcripts as a graph, with exons as nodes and splice junctions as edges, it is much easier to get a view on the putative fusion transcript.

```
# Load deFuse data
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
    "extdata",
    "defuse_833ke_results.filtered.tsv",
    package="chimeraviz")
fusions <- import_defuse(defuse833ke, "hg19", 1)
# Choose a fusion object
fusion <- get_fusion_by_id(fusions, 5267)
# Plot!
plot_fusion_transcripts_graph(
  fusion,
  edb)
```

![](data:image/png;base64...)

As in previous plots, exons from the upstream gene are shown in blue, and exons from the downstream gene are shown in green. This graph plot is a compact view of all possible fusion transcripts based on the known exon boundary transcripts. It is easy to see that there are four possible versions of the first exon in the upstream gene. In the downstream gene, all transcripts first use the same six exons, but they differ in the end. In total, sixteen different transcript variants for the fusion transcript are shown in the graph.

# 4 Reporting and filtering

## 4.1 Working with Fusion objects

There are nine different functions that let you import fusion data, one for each fusion finder:

1. `import_defuse()`
2. `import_ericscript()`
3. `import_fusioncatcher()`
4. `import_fusionmap()`
5. `import_infusion()`
6. `import_jaffa()`
7. `import_prada()`
8. `import_soapfuse()`
9. `import_starfusion()`

Let us continue working with the deFuse example data included with *chimeraviz*:

```
# Get reference to results file from deFuse
if(!exists("defuse833ke"))
  defuse833ke <- system.file(
    "extdata",
    "defuse_833ke_results.filtered.tsv",
    package="chimeraviz")

# Load the results file into a list of fusion objects
fusions <- import_defuse(defuse833ke, "hg19")
```

There are three helpful functions that allow you to manage your list of fusion objects:

```
# Get a specific fusion object by id
get_fusion_by_id(fusions, 5267)
```

```
## [1] "Fusion object"
## [1] "id: 5267"
## [1] "Fusion tool: defuse"
## [1] "Genome version: hg19"
## [1] "Gene names: RCC1-HENMT1"
## [1] "Chromosomes: chr1-chr1"
## [1] "Strands: +,-"
## [1] "In-frame?: FALSE"
```

```
# Get all fusions with a matching gene name
length(get_fusion_by_gene_name(fusions, "RCC1"))
```

```
## [1] 1
```

```
# Get all fusions on a specific chromosome
length(get_fusion_by_chromosome(fusions, "chr1"))
```

```
## [1] 1
```

## 4.2 The fusion report

Creating a fusion report based on a list of fusion events is a nice way to get an overview on the fusions in a sample. The function `create_fusion_report(fusions, "output.html")` will create an HTML page with an overview plot and a table of searchable, sortable fusion data. The function can be used like this:

```
# Load SOAPfuse data
if(!exists("soapfuse833ke"))
  soapfuse833ke <- system.file(
    "extdata",
    "soapfuse_833ke_final.Fusion.specific.for.genes",
    package = "chimeraviz")
fusions <- import_soapfuse(soapfuse833ke, "hg38", 10)
# Create report!
create_fusion_report(fusions, "output.html")
```

The result will be a file, `output.html`, that will look somewhat like this:

![](data:image/png;base64...)

# 5 More information / where to get help

The first place to look for help is in this vignette or in the reference manual for `chimeraviz`. If the documentation and examples there are insufficient, a good place to ask for help is on the [Bioconductor support site](https://support.bioconductor.org/). The [Biostars site](https://www.biostars.org/) may also be of help.

Any bug reports or feature ideas for `chimeraviz` are very welcome! Please report them as issues on [Github](https://github.com/stianlagstad/chimeraviz/issues).

# 6 Session Information

All code in this vignette was executed in the following environment:

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] chimeraviz_1.36.0       data.table_1.17.8       ensembldb_2.34.0
##  [4] AnnotationFilter_1.34.0 GenomicFeatures_1.62.0  AnnotationDbi_1.72.0
##  [7] Biobase_2.70.0          Gviz_1.54.0             GenomicRanges_1.62.0
## [10] Biostrings_2.78.0       Seqinfo_1.0.0           XVector_0.50.0
## [13] IRanges_2.44.0          S4Vectors_0.48.0        BiocGenerics_0.56.0
## [16] generics_0.1.4          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
##   [3] jsonlite_2.0.0              magrittr_2.0.4
##   [5] magick_2.9.0                farver_2.1.2
##   [7] rmarkdown_2.30              BiocIO_1.20.0
##   [9] vctrs_0.6.5                 memoise_2.0.1
##  [11] Rsamtools_2.26.0            RCurl_1.98-1.17
##  [13] base64enc_0.1-3             tinytex_0.57
##  [15] htmltools_0.5.8.1           S4Arrays_1.10.0
##  [17] progress_1.2.3              curl_7.0.0
##  [19] SparseArray_1.10.0          Formula_1.2-5
##  [21] sass_0.4.10                 bslib_0.9.0
##  [23] htmlwidgets_1.6.4           plyr_1.8.9
##  [25] httr2_1.2.1                 cachem_1.1.0
##  [27] GenomicAlignments_1.46.0    lifecycle_1.0.4
##  [29] pkgconfig_2.0.3             Matrix_1.7-4
##  [31] R6_2.6.1                    fastmap_1.2.0
##  [33] MatrixGenerics_1.22.0       digest_0.6.37
##  [35] colorspace_2.1-2            crosstalk_1.2.2
##  [37] Hmisc_5.2-4                 RSQLite_2.4.3
##  [39] org.Hs.eg.db_3.22.0         filelock_1.0.3
##  [41] org.Mm.eg.db_3.22.0         httr_1.4.7
##  [43] abind_1.4-8                 compiler_4.5.1
##  [45] bit64_4.6.0-1               htmlTable_2.4.3
##  [47] S7_0.2.0                    backports_1.5.0
##  [49] BiocParallel_1.44.0         DBI_1.2.3
##  [51] biomaRt_2.66.0              rappdirs_0.3.3
##  [53] DelayedArray_0.36.0         rjson_0.2.23
##  [55] gtools_3.9.5                tools_4.5.1
##  [57] foreign_0.8-90              nnet_7.3-20
##  [59] glue_1.8.0                  restfulr_0.0.16
##  [61] checkmate_2.3.3             cluster_2.1.8.1
##  [63] gtable_0.3.6                BSgenome_1.78.0
##  [65] hms_1.1.4                   pillar_1.11.1
##  [67] stringr_1.5.2               RCircos_1.2.2
##  [69] dplyr_1.1.4                 BiocFileCache_3.0.0
##  [71] lattice_0.22-7              rtracklayer_1.70.0
##  [73] bit_4.6.0                   deldir_2.0-4
##  [75] biovizBase_1.58.0           tidyselect_1.2.1
##  [77] knitr_1.50                  gridExtra_2.3
##  [79] bookdown_0.45               ProtGenerics_1.42.0
##  [81] SummarizedExperiment_1.40.0 xfun_0.53
##  [83] matrixStats_1.5.0           DT_0.34.0
##  [85] stringi_1.8.7               UCSC.utils_1.6.0
##  [87] lazyeval_0.2.2              yaml_2.3.10
##  [89] evaluate_1.0.5              codetools_0.2-20
##  [91] cigarillo_1.0.0             interp_1.1-6
##  [93] tibble_3.3.0                Rgraphviz_2.54.0
##  [95] graph_1.88.0                BiocManager_1.30.26
##  [97] cli_3.6.5                   rpart_4.1.24
##  [99] jquerylib_0.1.4             dichromat_2.0-0.1
## [101] Rcpp_1.1.0                  GenomeInfoDb_1.46.0
## [103] dbplyr_2.5.1                png_0.1-8
## [105] XML_3.99-0.19               parallel_4.5.1
## [107] ggplot2_4.0.0               blob_1.2.4
## [109] prettyunits_1.2.0           latticeExtra_0.6-31
## [111] jpeg_0.1-11                 bitops_1.0-9
## [113] VariantAnnotation_1.56.0    scales_1.4.0
## [115] crayon_1.5.3                rlang_1.1.6
## [117] KEGGREST_1.50.0
```
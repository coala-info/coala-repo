# App Tutorial

Michal Swirski & Hakon Tjeldnes

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
  + [1.1 Ribo-seq overview](#ribo-seq-overview)
* [2 Browser](#browser)
  + [2.1 Browser window](#browser-window)
  + [2.2 Selection panel (browser)](#selection-panel-browser)
    - [2.2.1 Experiment](#exp)
    - [2.2.2 Gene](#gene)
    - [2.2.3 Library](#lib)
    - [2.2.4 Display type](#linetype)
  + [2.3 Selection panel (Settings)](#settings)
  + [2.4](#section)
* [3 Mega Browser](#mbrowser)
  + [3.1 Selection panel (Browser)](#selection-panel-browser-1)
  + [3.2 Selection panel (Settings)](#selection-panel-settings)
  + [3.3 Statistics tab](#statistics-tab)
  + [3.4 Result table](#result-table)
  + [3.5 Requirements](#requirements)
* [4 Analysis](#analysis)
  + [4.1 Motif metaplot](#heatmap)
    - [4.1.1 Selection panel (heatmap)](#selection-panel-heatmap)
    - [4.1.2 Selection panel (settings)](#selection-panel-settings-1)
  + [4.2 Codon dwell time](#codon-dwell-time)
    - [4.2.1 Display panel (codon)](#display-panel-codon)
    - [4.2.2 Codon Table](#codon-table)
  + [4.3 Differential gene expression](#diffexp)
    - [4.3.1 Selection panel (Differential expression)](#selection-panel-differential-expression)
    - [4.3.2 Selection panel (settings)](#selection-panel-settings-2)
  + [4.4 Frame bias (Read length QC)](#frame-bias-read-length-qc)
    - [4.4.1 Display panel (Read length QC)](#display-panel-read-length-qc)
    - [4.4.2 Plot panel](#plot-panel)
  + [4.5 Fastq report (QC)](#fastq-report-qc)
    - [4.5.1 Display panel](#display-panel)
    - [4.5.2 Plot panel](#plot-panel-1)
* [5 Metadata](#metadata)
  + [5.1 Samples](#samples)
  + [5.2 Studies](#studies)
  + [5.3 SRA search](#sra-search)
    - [5.3.1 Study accession number](#study-accession-number)
    - [5.3.2 Output](#output)
  + [5.4 Predicted translons](#translon)
    - [5.4.1 Settings:](#settings-1)
  + [5.5 Sample clustering by organism](#UMAP)
* [6 Additional information](#additional-information)
  + [6.1 Structure of experiments](#structure-of-experiments)
  + [6.2 API for URL access and sharing](#api-for-url-access-and-sharing)
    - [6.2.1 Primary url:](#primary-url)
    - [6.2.2 Page selection API:](#page-selection-api)
    - [6.2.3 Parameter API:](#API)
  + [6.3 About](#about)

# 1 Introduction

Welcome to `RiboCrypt`

`RiboCrypt` is an R package and web server for interactive visualization
and analysis in genomics. `RiboCrypt` works with most NGS-based methods,
but much emphasis is put on Ribo-seq data visualization. RiboCrypt uses
ORFik experiment objects, so to ensure compatibility use
[ORFik](https://doi.org/10.1186/s12859-021-04254-w)
and
[massiveNGSpipe](https://github.com/rc-biotech/massiveNGSpipe)
for processing own (unpublished) data. If you encounter any issues,
please, contact us using the info in the footnote.

The following is web server walk through listing all utilities and
options therein.

## 1.1 Ribo-seq overview

For more general material about ribosome profiling, we suggest reading
[this
review](https://cshperspectives.cshlp.org/content/11/5/a032698.full.pdf%2Bhtml). For more technical explanation of data processing steps and
specific analyses, it’s best to see
[ORFik](https://bioconductor.org/packages/release/bioc/html/ORFik.html)
Overview vignette, especially chapter 6
[“RiboSeq
footprints automatic shift detection and shifting”](https://bioconductor.org/packages/release/bioc/vignettes/ORFik/inst/doc/ORFikOverview.html#riboseq-footprints-automatic-shift-detection-and-shifting).

# 2 Browser

The browser is the basic coverage display page. It contains a selection
panel on the left side and a display window (browser) on the right. It
displays coverage of sequencing data in either transcript coordinates
(default, collapsed introns to width 0), collapsed introns to user defined size
or genomic coordinates. The following
(Fig. 1), SRD5A1 gene,
[has
recently been shown to be decoded in three frames](https://doi.org/10.21203/rs.3.rs-5390104/v1).

![](data:image/png;base64...)

Figure 1. SRD5A1 gene displayed using default options. Using
[API](#API), this browser view can be re-generated using this
[link](https://ribocrypt.org/?&dff=all_merged-Homo_sapiens_modalities&gene=SRD5A1-ENSG00000145545&tx=ENST00000274192&library=RFP&frames_type=area&kmer=9&log_scale=FALSE&extendLeaders=0&extendTrailers=0&viewMode=FALSE&other_tx=FALSE&add_uorfs=FALSE&genomic_region=&customSequence=&phyloP=FALSE&summary_track=FALSE&go=TRUE).

## 2.1 Browser window

When you press the “plot” button on the selection panel, the selected
data will be displayed according to specified options, explained later
in the tutorial.

The browser window consists of the specific parts:

1. Single or multiple density tracks are displayed on top. By default
   Ribo-seq is rendered in 3 colors, where

* red is 0 frame, the start frame of reference transcript.
* green is +1 frame
* blue is +2 frame

2. Sequence track (top middle), displayes DNA sequence when zoomed in
   (< 100nt)
3. Annotation track (middle), the annotation track displays the
   transcript annotation, together with black line-dotted bars that are displayed on
   top of the data track. CDS and other annotations are color-coded
   according to relative reading frame. Introns are thin gray lines and
   UTRs are gray and medium sized.
4. Frame track (bottom), the 3 frames displayed with given color bars:

* white (start codon, ATG)
* black (stop codons, TAA | TAG | TGA)
* brown (custom motifs, e.g. NTG all start codon alternatives)

  When zoomed in, the amino acid sequence is displayed within each
  frame.

5. Additional displays, for example protein structure viewer, which
   appears after clicking on isoform ID on annotation track.

In the example above (Fig. 1), notice green coverage preceding CDS (in
Blue). It corresponds to overlapping open reading frame, so it is clear
that there are two regions that undergo translation simultaneously in
this locus.

## 2.2 Selection panel (browser)

The display panel shows the primary settings, (study, gene, sample,
etc):

### 2.2.1 Experiment

* Select an organism: Either select “ALL” to keep all experiments, or
  subset to a specific organism to display only that subset of
  experiments in experiment select tab.
* Select an experiment: The experiments contain study names combined
  with organism (some studies are multi species, so sometimes one
  study have multiple experiments). Select which one you want. There
  also exist merged experiments (all samples merged for the organism,
  etc). RNA-seq experiments have an addition "\_RNA" as suffix. Modalities
  means all library types (e.g. Ribo-seq, RNA-seq in one experiment)

### 2.2.2 Gene

* Select a gene: A gene can be selected using:
  + Gene id (ENSEMBL)
  + Gene symbol (HGNC, etc)
* Select a transcript: A transcript isoform of the given gene above,
  default is Ensembl canonical isoform, other isoforms can be
  selected.

### 2.2.3 Library

Usually each experiment have multiple libraries. In the case of merged
experiments, different modalities (RFP, RNA, disome, TI, see Fig. 2) can
be selected in this field. Select which one to display, if you select
multiple libraries they will be stacked in the browser as multiple
tracks.

Library are by default named:

* Library type (RFP, RNA etc),
* Condition (WT, KO (wild type, knock out ) etc)
* Stage/timepoint (5h, 1d (5 hours, 1 day) etc)
* fraction (chx, cytosolic, ATF4 (ribosomal inhibitor, cell fraction,
  gene) etc)
* replicate (technical/biological replicate number (r1, r2, r3))

The resuting name could for example be:

* RFP\_WT\_5h\_chx\_cytosolic\_r1

It’s normal to see that if condition is KO (knockout), the fraction
column contains a gene name (the name of the gene that was knocked out).
Currently the best way to find SRR run number for respective sample is
to go to metadata tab and search for the study. The reverse is also true,
if you want to select the library from only known SRR, you can either insert
URL with library=SRR… or find the library name from the

* Unique Alignments checkbox: Specifies to use unique Alignments (SAM NH flag = 1),
  or all alignments (both track files must be pre-computed),
  see below on STAR alignment details for more info.

### 2.2.4 Display type

* Select reading frames display type:
  + lines (single line per frame, most clear for middle distance (>
    100 nt))
  + columns (single bars per position, most clear for single
    nucleotide resolution)
  + stacks (Area under curve, stacked, most clear for large regions
    (> 1000 nt))
  + area (Area under curve, with semitransparent overlapping frames,
    most clear for large regions (> 1000 nt))
  + heatmap (good for displaying large number of libraries, see
    metabrowser for display of thousands of libraries)
  + animate (single row with animation changing between libraries)
* K-mer length: sliding window of selected length applying averaging
  coverage per frame. K-mer = 1 means unaltered data. When looking at
  a large region (> 100nt), pure coverage can usually be hard to
  inspect due to intrinsic Ribo-seq spikyness. Using K-mer length > 1
  (9, the default, is a good starting point), you can easily look at
  patterns over larger regions.

Notice, how in figure 2 reducing K-mer length to 1, changing display
type to columns and adding TI-seq (Translation Initiation profiling,
samples treated with translation initiation inhibitors - either
lactimidomycin or harringtonin) enables detection of translation in all
three reading frames. In fact, experienced user can notice drop of
signal in red frame after stop codon of the corresponding ORF (hidden
behind most abundant, green), further corroborating overlapping
translation. If this process seems somewhat imprecise and not fully
defined - it is by design - annotating such elusive phenomena is
notoriously difficult to tackle algorithmically, and doing so
successfully requires deep intuition in how the signal and noise behave,
so manual investigation into many instances like this. Thus, RiboCrypt
can be treated as a hypothesis building tool, rather a database of fixed
answers.
[Try](https://ribocrypt.org/?&dff=all_merged-Homo_sapiens_modalities&gene=SRD5A1-ENSG00000145545&tx=ENST00000274192&library=RFP,TI&frames_type=columns&kmer=1&log_scale=FALSE&extendLeaders=0&extendTrailers=0&viewMode=FALSE&other_tx=FALSE&add_uorfs=FALSE&genomic_region=&customSequence=&phyloP=FALSE&summary_track=FALSE&go=TRUE)
modifying yourself, for example switching on RNA-seq track, or altering
smoothing window width.

![](data:image/png;base64...)

Figure 2. Comparison of display types and smoothing window widths.

## 2.3 Selection panel (Settings)

Settings tab contains additional parameters:

* 5’ extension (extend viewed window upstream)
* 3’ extension (extend viewed window downstream)
* Custom sequences highlight (Motif search, given in brown color,
  support IUPAC, examples: CTG or NTG)
* Genomic region (Browse genomic window instead of gene, syntax:
  chromosome:start-stop:strand, human/mouse/zebrafish: 1:10000-20000:+
  , yeast: I:10000-20000:+. Both 1 and chr1 works, conversion will be
  done automatically)
* Zoom interval (start with a zoom and highlight on a subsection):
  Either specified in tx/view coordinates, i.e. 20:50 will give zoom
  on region (20-10):(50+10) = 10:60, and a highlight color (light yellow)
  at coordinates 20:50. You can also specify in genomic coordinates as above
  for genomic region (remember the genomic coordinates must then be within
  the gene / region you are displaying).
* Genomic View (Activate/deactivate genomic view, displaying full
  introns, see Figure 3)
* Full annotation (display all transcript isoforms annotation or just
  the selected isoform)
* Collapsed introns (Collapse introns of the annotation which are not overlapping any exons
  the in shown annotation.
  Subset to size defined in collapsed intron width box, setting to 0 should produce the
  same plot in genomic coordinates as turning genomic coordinates off.)
* uORF annotation (display candidate uORFs in the annotation track) this is not the
  predicted set, but all possible uORFs by seqnece. For predicted set, check
  the predicted translons checkbox.
* Predicted translons - display [predicted translons](#translons) in
  the annotation track. Try turning it on for the
  [example](https://ribocrypt.org/?&dff=all_merged-Homo_sapiens_modalities&gene=SRD5A1-ENSG00000145545&tx=ENST00000274192&library=RFP&frames_type=area&kmer=9&log_scale=FALSE&extendLeaders=0&extendTrailers=0&viewMode=FALSE&other_tx=FALSE&add_uorfs=FALSE&genomic_region=&customSequence=&phyloP=FALSE&summary_track=FALSE&go=TRUE)
  in Figures 1 and 2 - notice that the red (second) translon was
  missed
* Log scale (Log scale the coverage, reduces effect of extreme peaks)
* Protein structures (If you click the annotation name of a transcript
  in the plot panel it will display the alpha-fold protein colored by
  the ribo-seq data displayed in the plot panel)
* PhyloP (PhyloP conservation track will be added on the bottom)
* Mappability (mappability track of 28-mers, showing strong / weak mappability regions.)
* Split color frame (Split riboseq signal into colors by frame)
  i.e. red, green and blue. If this is on, then Ribo-seq and
  Ti-seq will be displayed with colors split by frame.
* Frames subset (If split color frame is TRUE,
  you can display only wanted color)
* Summary top track (Add an additional plot track on top, summarizing
  all selected libraries)
* Select Summary display type (same as frames display type above, but
  for the summary track)
* Export format (Choose plot export format from plotly controls. The
  default is svg vector graphics that allows for high customizability)
* Plot (red button, render selected gene/region as plotly html,
  with specified settings)

Uniquely, RiboCrypt allows for toggling between transcriptomic and
genomic views, while displaying coding exons in colors according to the
correct reading frame. Moreover, extensions allow for exploration of
large chunks of the genome, even tens of thousands of bases.
[Try](https://ribocrypt.org/?&dff=all_merged-Saccharomyces_cerevisiae_modalities&gene=EFM5-YGR001C&tx=YGR001C_mRNA&library=RFP&frames_type=area&kmer=5&log_scale=FALSE&extendLeaders=15000&extendTrailers=15000&viewMode=FALSE&other_tx=FALSE&add_uorfs=FALSE&genomic_region=&customSequence=&phyloP=FALSE&summary_track=FALSE&go=TRUE)
finding all genes in this browser window, and then turn full annotation
on to see what you missed! (loading may be a bit slow, but displaying
over region 30 thousands bases long here isn’t practical)

![](data:image/png;base64...)

Figure 3. Comparison between transcriptomic and genomic view on yeast
[EFM5](https://ribocrypt.org/?&dff=all_merged-Saccharomyces_cerevisiae_modalities&gene=EFM5-YGR001C&tx=YGR001C_mRNA&library=RFP&frames_type=area&kmer=5&log_scale=FALSE&extendLeaders=1&extendTrailers=150&viewMode=FALSE&other_tx=FALSE&add_uorfs=FALSE&genomic_region=&customSequence=&phyloP=FALSE&summary_track=FALSE&go=TRUE)
and
[ABP140](https://ribocrypt.org/?&dff=all_merged-Saccharomyces_cerevisiae_modalities&gene=ABP140-YOR239W&tx=YOR239W_mRNA&library=RFP&frames_type=area&kmer=5&log_scale=FALSE&extendLeaders=1&extendTrailers=150&viewMode=FALSE&other_tx=FALSE&add_uorfs=FALSE&genomic_region=&customSequence=&phyloP=FALSE&summary_track=FALSE&go=TRUE)
genes.

## 2.4

# 3 Mega Browser

Display all samples for a specific organism over selected gene (Fig. 5).
This tab does not use bigwig files to load (as that would be very slow).
It uses precomputed fst files of coverage over all libraries. Note: Not
all isoforms are computed, by default the longest isoform is computed.

![](data:image/png;base64...)

Figure 5. Heatmap of thousands of libraries coverage over ATF4
transcript. Clustered using k-means = 2, with summary track displayed on
top.

## 3.1 Selection panel (Browser)

Organism, experiment and gene explained above

* Meta motif: Amino acid motifs from all genes over all libraries (+/- 300 nucleotides shown)
* Order on: the metadata column to order plot by. The first factor defined will
  be the one that decided what to cluster / group by.
* Enrichment test on: What factor to do enrichment analysis on: For clusters (factor 1),
  it will do test on the first factor defined in “Order on”. For all the others it will create
  numeric bins of the ordering.
* K-means clusters: How many k-means clusters to use, if > 1, Group
  will be sorted within the clusters, but K-means have priority.

## 3.2 Selection panel (Settings)

* Normalization (all scores are tpm normalized and log scaled)
  + transcriptNormalized (each sample counts sum to 1) (default)
  + Max normalized (each position count divided by maximum)
  + zscore (zscore normalization, (count \* mean / sd) variance
    scaled normalization)
  + tpm (raw tpm of counts, is very sensitive to extreme peaks)
* Color theme: Which color theme to use
* Color scale multiplier: how much to amplify the color signal (if all
  is single color, try to reduce or increase this depending on which
  color is the majority)
* Sort by other gene: Sort heatmap on expression of another gene
  (increasing). A line plot will be shown left that display the
  expression of that other gene per row. Also the enrichment analysis
  is done on bins of the other genes expression instead of metadata
  term.
* Sort on interval ratio: If 2 numbers of format x:y, will give ordering
  over all libraries by strength of the region. For format x:y;a:b, it will
  create a ratio ordering of strength of x:y / a:b. Useful to compare
  to regions.
* Summary top track (same as in browser, the aggregate of all rows,
  useful to see the frame information, which is not represented in the
  heatmap)
* Split by frame: (Not active yet!): When completed will display the
  heatmap with frame information, so rgb colors from white to dark red
  etc.
* Summary display type: Same as in browser
* Selected region to view: By default uses entire transcript. Can subset to
  only view cds or leader+cds etc.
* Select a transcript: Which transcript isoforms not all isoforms have
  computed fsts. By default the longest isoforms have been computed
  for all genes.
* Minimum counts: The minimum raw counts over the total area per library to display,
  useful to filter out low coverage libraries to remove noice from enrichment test etc.
* K-mer length: Smoothens out the signal by applying a mean sliding
  window, default 1 (off)

## 3.3 Statistics tab

This tab gives the statistics of over representation analysis per
cluster of the metabrowser plot. Using chi squared test, it gives the
residuals per term from metadata (like tissue, cell-line etc). If a
value is bigger than +/- 3, it means it is quite certain this is over
represented. This is shown as a red line.

If no clustering was applied, this tab gives the number of items per
metadata term (40 brain samples, 30 kidney samples etc).

## 3.4 Result table

This tab gives the metadata with run ids, bioproject and cluster / numeric bin id,
for each sample that passes the count filter.

## 3.5 Requirements

This mode is very intensive on CPU, so it requires certain pre-computed
results for the back end. That is namely: - Premade collection
experiments (an ORFik experiment of all experiments per organism) -
Premade collection count table and library sizes (for normalizations
purpose) - Premade fst serialized coverage calculation per gene (for
instant loading of coverage over thousands of libraries)

Note that on the live app, the human collection (4000 Ribo-seq samples)
takes around 30 seconds to plot for a ~ 2K nucleotides gene, ~99% of
the time is spent on rendering the plot, not actual computation. Future
investigation into optimization will be done.

# 4 Analysis

Here we collect the analysis possibilities, which are usually operating
on meta-gene or multi locus scale.

## 4.1 Motif metaplot

This tab displays a heatmap of coverage per readlength at a specific
region (like start site of coding sequences) over all genes selected.

![](data:image/png;base64...)

Figure 4. Metagene per-readlength heatmap of before (upper panel) and
after (bottom panel) P-shifting. Notice emerging periodicity.

### 4.1.1 Selection panel (heatmap)

Study and gene select works same as for browser specified above. In
addition to have the option to specify all genes (default).

* Select libraries. Currently Only 1 library can be selected in
  heatmap mode.
* Anchor region (Select one of):
  + Start codon
  + Stop codon
  + User defined motif
* Anchor on motif: A DNA nucleotide motif to anchor on, will subsample to
  a set of 30k regions for the gene set (if total regions > 30k).
* 5’ extension (extend viewed window upstream from point, default 30)
* 3’ extension (extend viewed window downstreamfrom point, default 30)
* Normalization Normalization mode for data display, select one of:
  + transcriptNormalized (each gene counts sum to 1)
  + zscore (zscore normalization, will give better overview if 1
    readlength is extreme)
  + sum (raw sum of counts, is very sensitive to extreme peaks)
  + log10sum (log10 sum of counts, is less sensitive to extreme
    peaks)
* Min Readlength The minimum readlength to display
* Max readlength The maximum readlength to display

### 4.1.2 Selection panel (settings)

Here additional options are shown:

* Summary top track - summarized coverage from all readlengths
* p-shifted - display either P-sites (default), or non shifted reads 5’ ends.

Metagene analysis with anchor points module can be used, for example, to
investigate how well P-site positioning was performed and biases over motifs (Fig. 4).
If you want to do custom motif analysis over all libraries per organism, we support
this in the Mega Browser tab.

## 4.2 Codon dwell time

This tab displays a heatmap of codons dwell times over all genes
selected, for both A and P sites. When pressing “Differential” you swap
to a between library differential codon dwell time comparison (minimum 2
libraries selected is required for this method!)

### 4.2.1 Display panel (codon)

Study and gene select works same as for browser specified above. In
addition to have the option to specify all genes (default).

* Select libraries (multiple allowed)

#### 4.2.1.1 Filters

* Codon filter value (Minimum reads in ORF to be included)
* Ratio threshold: The ratio of differential codon usage to define as significant.
  If it is 2, it means the ratio must either be >= 2 (upregulated in sample 1 vs 2)
  or <= 1/2 (downregulated in sample 1 vs 2).
* Codon score, all scores are normalized for both codon and count per
  gene level (except for sum):
  + percentage (percentage use relative to max codon, transcript
    normalized percentages)
  + dispersion(NB) (negative binomial dispersion values)
  + alpha(DMN) (Dirichlet-multinomial distribution alpha parameter)
  + sum (raw sum, (a very biased estimator, since some codons are
    used much more than others!))
* Differential: Do differential test (TRUE), or show codon dwell times per library (FALSE)
* Exclude start / stop: As the dwell time of these are often highly biased, exclude the start and stop codon
  per gene from the analysis.

#### 4.2.1.2 Codon plot

Display is the score per codon (amino acid), in addition there are 2
custom “amino acids”, \* as in \* : TGA, means TGA is a stop codon (last
codon in CDS). Similar is #, as in # : ATG which means ATG as start
codon (first codon in CDS). For P-sites start codons should be enriched,
while for A-sites there should be a richer variability, often with a
small enrichment for stop-codons. We will implement a richer model
eventually using the more correct negative binomial relationships
between E, P and A sites, i.g. the motif PPP (triplet-proline in E,P,A
site) is much stronger than a single P in the A site etc. alone etc.

### 4.2.2 Codon Table

The table of result data with all scores per library and ribosome site.

## 4.3 Differential gene expression

Given an experiment with a least 1 design column with two values, like
wild-type (WT) vs knock out (of a specific gene), you can run
differential expression of genes. The output is an interactive plot,
where you can also search for you target genes, making it more useable
than normal expression plots, which often are very hard to read.

### 4.3.1 Selection panel (Differential expression)

Organism and experiment explained above - Differential method: FPKM
ratio is a pure FPKM ratio calculation without factor normalization
(like batch effects), fast and crude check. DESeq2 argument gives a
robust version, but only works for experiments with valid experimental
design (i.e. design matrix must be full ranked, see deseq2 tutorial for
details!) - Select two conditions (which 2 factors to group by)

### 4.3.2 Selection panel (settings)

* draw unregulated (show dots for unregulated genes, makes it much
  slower!)
* Full annotation (all transcript isoforms, default is primary isoform
  only!)
* P-value (sliding bar for p-value cutoff, default 0.05)
* export format for plot (explained above)

## 4.4 Frame bias (Read length QC)

This tab displays a QC of pshifted coverage per readlength (like start
site of coding sequences) over all genes selected. Useful to
see the strength of periodicity per read length.

### 4.4.1 Display panel (Read length QC)

The display panel shows what can be specified to display, the possible
select boxes are same as for heatmap above:

### 4.4.2 Plot panel

From the options specified in the display panel, when you press “plot”
the data will be displayed. It contains the specific parts:

Top plot: Read length relative usage

1. Y-axis: Score
2. Color: Per frame (red, green, blue)
3. Facet box: the read length

Bottom plot: Fourier transform (3 nucleotide periodicity quality, clean
peak means good periodicity)

## 4.5 Fastq report (QC)

This tab displays the fastq QC output from fastp, as a html page.

### 4.5.1 Display panel

The display panel shows what can be specified to display, you can select
from organism, study and library.

### 4.5.2 Plot panel

Displays the html page.

# 5 Metadata

Metadata tab displays information about studies and custom predictions.
RiboCrypt is integrated with
[Ribo-seq Data
Portal](https://rdp.ucc.ie/home), refer to
[this
paper](https://doi.org/10.1093/nar/gkae1020) for details on metadata curation and standardization.

## 5.1 Samples

Full table of supported samples with with linking to
SRR run ids, Bioproject ids and all metadata terms.

## 5.2 Studies

Full table of supported studies with information about sample counts

## 5.3 SRA search

Search SRA for full information of supported study

### 5.3.1 Study accession number

Here you input a study accession number in the form of either:

* SRP
* GEO (GSE)
* PRJNA (PRJ….)
* PRJID (Only numbers)

### 5.3.2 Output

On top the abstract of the study is displayed, and on bottom a table of
all metadata found from the study is displayed.

## 5.4 Predicted translons

Full list of predicted translons on all\_merged tracks per species.
Each translons has a link that directs you to the browser tab
and displays the transcript zoomed in on the translons with
a light yellow highlighting of the region.

### 5.4.1 Settings:

Translon annotation scheme:

* Prediction algorithm: ORFik::detect\_ribo\_orfs
* translon\_types <- c(“uORF”, “uoORF”,“doORF”,“dORF”)
* start\_codons <- “ATG|TTG|CTG”
* additional arguments: add sequence and amino acid sequence per
  translon
* All other arguments default.

## 5.5 Sample clustering by organism

UMAP analysis from count tables of all samples of all genes in the organism:

Plot types:

* UMAP: The default plot is a dotplot of UMAP component 1 and 2 giving clustering
  of samples from gene counts. The user can inspect metadata terms related to clusters, shown
  as colors on the dots (e.g. tissue, cell-type, author, study,…)
  It usually shows a clear correlation within cell lines and of course the study,
  also there should be correlation with who the author is, even between
  different studies from the same author.
  This can be used to detect outliers or believed false metadata, e.g. a
  HEK293 sample marked as HeLa but clearly clustering with HEK293.
* UMAP centroids: If you rather want to find distances between the centroids of each cluster
  this heatmap shows the distances colored.

# 6 Additional information

## 6.1 Structure of experiments

All files are packed into ORFik experiments for easy access through the
ORFik backend package:

Per experiment processing (set of samples of a study per organism):

* Annotation (gtf + TxDb for random access)
* Fasta genome (.fasta, + index for random access)
* Sequencing libraries (all duplicated reads are collapsed)
  + random access (only for collapsed read lengths): bigwig
  + Full genome coverage (only for collapsed read lengths): covRLE
  + Full genome coverage (split by read lengths): covRLElist
* count Tables (Summarized experiments, serialized and compressed as .qs)
* Library size list (Integer vector, .rds)

Collection processing (the set of samples per organism):

* Collection experiment (set of all samples per organism)
* Collection merged experiment (the organism collection merged into single file)
* Precomputed gene coverages per organism: fst (used for metabrowser)
* Translon predictions per organism
* UMAP clustering per organism

Modalities processing (The set of library types per experiment / collection)
- If we have RNA-seq, Disome-seq etc from the same experiment / organism, we create a "\_modalities"
experiment which is the experiment / collection with all library types.

We therefor have an experiment per study + organism pair, and
## massiveNGSpipe

For our webpage the processing pipeline used is
[massiveNGSpipe](https://github.com/rc-biotech/massiveNGSpipe)
which wraps multiple tools:

1. Fastq files are download with massiveNGSpipe download
2. Adapter is detected with either fastqc (sequence detection) and
   falls back to fastp auto detection. Barcodes are detected with a
   custom made sliding window function in massiveNGSpipe
   using quality and base content of fastq files.
3. Reads are then trimmed with fastp (using the wrapper in ORFik)

* Adapter removal specified
* minimum read size (20nt)

4. Read are collapsed (get the set of unique reads and put duplication
   count in read header)
5. Reads are aligned with the STAR aligner (using the wrapper in
   ORFik), that supports contamination removal. Settings:

* genomic coordinates (to allow both genomic and transcriptomic
  coordinates)
* local alignment (to remove unknown flank effects)
* minimum read size (20nt)
* Max mismatches 3 (Not sofclip nucleotides!)
* Max multimappers (10), a note here on definition of unique alignments:
  since –outFilterMultimapScoreRange 1 (default of STAR)
  a multimapper is any read with SAM flag ‘AS’ (Alignment score)
  as maximum - 1, i.e. all reads with 1 less mismatches will be included
  as “multimapper” etc. Another interesting case is that a read can be defined as
  primary alignment, even though it has more mismatches: Read A (28nt) has 2 mismatches,
  and read B (28nt) has 0 mismatches, but a novel junction. STAR gives novel junctions
  a score of -3, and mismatch a score of -1, so 28 - (2\*-1) > 28 - 3. A final thing
  to mention is that since default index seed for STAR is 14, a 27nt read with a
  mismatch on position 14, will never map to it’s correct site
  (as the 14nt seed must be a perfect match for STARs lookup table)
  All other settings are default.

6. When all samples of study are aligned, an ORFik experiment is
   created that connects each sample to metadata (condition, inhibitor,
   fraction, replicate etc)
7. Bam files are then converted to ORFik ofst format
8. These ofst files are then pshifted
9. Faster formats are then created (bigwig, fst and covRLE) for faster
   visualization

## 6.2 API for URL access and sharing

RiboCrypt uses the shiny router API system for creating runnable links
and backspacing etc. The API specification is the following:

### 6.2.1 Primary url:

<https://ribocrypt.org/> (This leads to browser page)

### 6.2.2 Page selection API:

Page selection is done with “#” followed by the page short name, the
list is the following:

* broser page (/ or /#browser)
* MegaBrowser (/#MegaBrowser)
* Motif metaplot (/#Motif%20metaplot)
* Codon dwell time (/#Codon%20dwell%20time)
* Differential expression (/#Differential%20expression)
* Frame bias (/Frame%20bias)
* fastq QC report (/#FastQ%20report)
* Samples information (/#Samples)
* Studies information (/#Studies)
* SRA search (/SRA%20search)
* Predicted Translons (/#Predicted Translons)
* Studies supported (/#UMAP)
* This tutorial (/#tutorial)

Example: <https://ribocrypt.org/#tutorial> sends you to this tutorial
page

### 6.2.3 Parameter API:

Settings can be specified by using the standard web parameter API:

* “?”, Starts the parameter specification
* “&”, to combine terms:

Example:
<https://RiboCrypt.org/?dff=all_merged-Homo_sapiens&gene=ATF4-ENSG00000128272#browser>
will lead you to browser and insert gene ATF4 (all other settings being
default).

A more complicated call would be:
<https://RiboCrypt.org/?dff=all_merged-Homo_sapiens&gene=ATF4-ENSG00000128272&tx=ENST00000404241&frames_type=area&kmer=9&go=TRUE&extendLeaders=100&extendTrailers=100&viewMode=TRUE&other_tx=TRUE#browser>

#### 6.2.3.1 browser:

* dff=all\_merged-Homo\_sapiens (The Experiment to select: for webpage
  it is “study id”\_“Organism”)
* gene=ATF4-ENSG00000128272 (For webpage it is: “Gene symbol”-“Ensembl
  gene id”)
* tx=ENST00000404241(isoform)
* frames\_type=area (plot type)
* kmer=9 (window smoothing)
* go=TRUE (plot on entry, you do not need to click plot for it to
  happen)
* extendLeaders=100 (extend 100 nt upstream of 5’ UTR / Leader)
* extendTrailers=100 (extend 100 nt downstream of 3’ UTR / Trailer)
* viewMode=FALSE (If TRUE, Genomic coordinates, i.e. with introns)
* other\_tx=TRUE (Full annotation, show transcript graph for all
  genes/isoforms in area)
* add\_translon=FALSE (TRUE makes predicted translons be displayed)
* zoom\_region: format tx coord: 20:50, format genomic coord: 1:2000-3000:p;1:4000:5000:p
  (p is converted to +, as url does not support +)
* #browser (open browser window)

## 6.3 About

Where to send your queries:

* Request new data: send an email to Michal
* RiboCrypt web page questions: send an email to Michal
* Details on backend processing: send an email to Håkon
* Bugs (Please report in respective github page)
* Bugs in (front-end) RiboCrypt: <https://github.com/m-swirski/RiboCrypt>
* Bugs in (back-end processing) ORFik: <https://github.com/Roleren/ORFik>
* Bugs in (back-end pipeline) massiveNGSpipe: <https://github.com/rc-biotech/massiveNGSpipe>

If you would like to contribute, improve or add features to our work, you have 2 options:

* Fork one of our github repositories, add code, make pull request
* Contact us to be included on the official discord server (not public)
  for more close contact collaboration.

This app is created as a collaboration with:

* University of Warsaw, Poland
* University of Oslo & University of Bergen, Norway

Main authors and contact:

* Michal Swirski (Warsaw), email:
  michal.swirski@uw.edu.pl
* Håkon Tjeldnes (Oslo & Bergen), email:
  hauken\_heyken@hotmail.com
# MethReg: estimating regulatory potential of DNA methylation in gene transcription

Tiago Chedraoui Silva1\* and Lily Wang1\*\*

1University of Miami Miller School of Medicine

\*txs902 at miami.edu
\*\*lily.wangg at gmail.com

#### 30 October 2025

#### Package

MethReg 1.20.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 MethReg workflow](#methreg-workflow)
* [4 Analysis illustration](#analysis-illustration)
  + [4.1 Input data](#input-data)
    - [4.1.1 Input DNA methylation dataset](#input-dna-methylation-dataset)
    - [4.1.2 Input gene expression dataset](#input-gene-expression-dataset)
    - [4.1.3 Creating triplet dataset](#creating-triplet-dataset)
  + [4.2 Evaluating the regulatory potential of CpGs (or DMRs)](#evaluating-the-regulatory-potential-of-cpgs-or-dmrs)
    - [4.2.1 Analysis using model with methylation by TF interaction](#analysis-using-model-with-methylation-by-tf-interaction)
    - [4.2.2 Stratified analysis by high and low DNA methylation levels](#stratified-analysis-by-high-and-low-dna-methylation-levels)
    - [4.2.3 Visualization of data](#visualization-of-data)
  + [4.3 Results interpretation](#results-interpretation)
* [5 Controlling effects from confounding variables](#controlling-effects-from-confounding-variables)
* [6 Calculating enrichment scores](#calculating-enrichment-scores)
  + [6.1 Using dorothea and viper](#using-dorothea-and-viper)
  + [6.2 Using dorothea and GSVA](#using-dorothea-and-gsva)
* [7 Session information](#session-information)
* [Bibliography](#bibliography)

# 1 Introduction

Transcription factors (TFs) are proteins that facilitate the transcription of
DNA into RNA. A number of recent studies have observed that the binding of TFs
onto DNA can be affected by DNA methylation, and in turn, DNA methylation can
also be added or removed by proteins associated with transcription
factors (Bonder et al. [2017](#ref-bonder2017disease); Banovich et al. [2014](#ref-banovich2014methylation); Zhu, Wang, and Qian [2016](#ref-zhu2016transcription)).

To provide functional annotations for differentially methylated regions (DMRs)
and differentially methylated CpG sites (DMS), `MethReg` performs integrative
analyses using matched DNA methylation and gene expression along with
Transcription Factor Binding Sites (TFBS) data. MethReg evaluates, prioritizes
and annotates DNA methylation regions (or sites) with high regulatory potential
that works synergistically with TFs to regulate target gene expressions,
without any additional ChIP-seq data.

The results from `MethReg` can be used to generate testable hypothesis on the
synergistic collaboration of DNA methylation changes and TFs in gene regulation.
`MethReg` can be used either to evaluate regulatory potentials of candidate
regions or to search for methylation coupled TF regulatory processes in the entire genome.

# 2 Installation

`MethReg` is a Bioconductor package and can be installed through `BiocManager::install()`.

```
if (!"BiocManager" %in% rownames(installed.packages()))
     install.packages("BiocManager")
BiocManager::install("MethReg", dependencies = TRUE)
```

After the package is installed, it can be loaded into R workspace by

```
library(MethReg)
```

# 3 MethReg workflow

The figure below illustrates the workflow for MethReg.
Given matched array DNA methylation data and RNA-seq gene expression data,
MethReg additionally incorporates TF binding information from ReMap2020 (Chèneby et al. [2019](#ref-remap2020))
or the JASPAR2020 (**???**; **???**) database,
and optionally additional TF-target gene interaction databases,
to perform both promoter and distal (enhancer) analysis.

In the unsupervised mode, MethReg analyzes all CpGs on the Illumina arrays.
In the supervised mode, MethReg analyzes and prioritizes differentially methylated CpGs identified in EWAS.

There are three main steps: (1) create a dataset with triplets of CpGs, TFs that bind near the CpGs,
and putative target genes, (2) for each triplet (CpG, TF, target gene), apply integrative
statistical models to DNA methylation, target gene expression, and TF expression values,
and (3) visualize and interpret results from statistical models to estimate individual
and joint impacts of DNA methylation and TF on target gene expression, as well as
annotate the roles of TF and CpG methylation in each triplet.

The results from
the statistical models will also allow us to identify a list of CpGs that work
synergistically with TFs to influence target gene expression.

![Figure 2 Workflow of MethReg. Data - MethReg required inputs are: (1) array-based DNA methylation data (HM450/EPIC) with beta-values, (2) RNA-seq data with normalized counts, (3) estimated TF activities from the RNA-seq data using GSVA or VIPER  software. Creating triplets – there are multiple ways to create a CpG-TF-target gene triplet: (1) CpGs can be mapped to human TFs by using TF motifs from databases such as JASPAR or ReMap and scanning the CpGs region to identify if there is a binding site (2) CpG can be mapped to target genes using a distance-based approach, CpGs will be linked to a gene if it is on promoter region (+-1K bp away from the TSS), for a distal CpG it can be linked to either all genes within a fixed width (i.e. 500k bp), or a fixed number of genes upstream and downstream of the CpG location (3) TF-target genes can be retrieved from external databases (i.e. Cistrome Cancer; Dorothea). Using two different pairs (i.e. CpG-TF, TF-target gene), triplets can then be created. Analysis – each triplet will be evaluated using a robust linear model in which TF activity is estimated from GSVA/Viper software and DNAm.group is a binary variable used to model if the sample CpG belongs to the top 25% methylation levels or the lowest 25% methylation levels. Results – MethReg will output the prioritized triplets and classify both the TF role on the gene expression (repressor or activator) and the DNAm effect on the TF activity (Enhancing or attenuating).](data:image/png;base64...)

Figure 1: Figure 2 Workflow of MethReg
Data - MethReg required inputs are: (1) array-based DNA methylation data (HM450/EPIC) with beta-values, (2) RNA-seq data with normalized counts, (3) estimated TF activities from the RNA-seq data using GSVA or VIPER software. Creating triplets – there are multiple ways to create a CpG-TF-target gene triplet: (1) CpGs can be mapped to human TFs by using TF motifs from databases such as JASPAR or ReMap and scanning the CpGs region to identify if there is a binding site (2) CpG can be mapped to target genes using a distance-based approach, CpGs will be linked to a gene if it is on promoter region (+-1K bp away from the TSS), for a distal CpG it can be linked to either all genes within a fixed width (i.e. 500k bp), or a fixed number of genes upstream and downstream of the CpG location (3) TF-target genes can be retrieved from external databases (i.e. Cistrome Cancer; Dorothea). Using two different pairs (i.e. CpG-TF, TF-target gene), triplets can then be created. Analysis – each triplet will be evaluated using a robust linear model in which TF activity is estimated from GSVA/Viper software and DNAm.group is a binary variable used to model if the sample CpG belongs to the top 25% methylation levels or the lowest 25% methylation levels. Results – MethReg will output the prioritized triplets and classify both the TF role on the gene expression (repressor or activator) and the DNAm effect on the TF activity (Enhancing or attenuating).

# 4 Analysis illustration

## 4.1 Input data

For illustration, we will use chromosome 21 data from 38 TCGA-COAD (colon cancer) samples.

### 4.1.1 Input DNA methylation dataset

The DNA methylation dataset is a matrix or SummarizedExperiment object with
methylation beta or M-values
(The samples are in the columns and methylation regions or probes are in the rows).
If there are potential confounding factors (e.g. batch effect, age, sex) in the dataset,
this matrix would contain residuals from fitting linear regression
instead (see details **Section 5** “Controlling effects from confounding variables” below).

#### 4.1.1.1 Analysis for individual CpGs data

We will analyze all CpGs on chromosome 21 in this vignette.

However, oftentimes, the methylation data can also be, for example,
**differentially methylated sites** (DMS) or **differentially methylated regions** (DMRs)
obtained in an epigenome-wide association study (EWAS) study.

```
data("dna.met.chr21")
```

```
dna.met.chr21[1:5,1:5]
#>            TCGA-3L-AA1B-01A TCGA-4N-A93T-01A TCGA-4T-AA8H-01A TCGA-5M-AAT4-01A TCGA-5M-AAT5-01A
#> cg00002080        0.6454046        0.5933725       0.54955509       0.81987982       0.79171160
#> cg00004533        0.9655396        0.9640490       0.96690671       0.95510446       0.96061252
#> cg00009944        0.5437705        0.2803064       0.42918909       0.60734630       0.47555585
#> cg00025591        0.4021317        0.7953653       0.41816364       0.33241304       0.67251468
#> cg00026030        0.1114705        0.1012902       0.06834467       0.08594876       0.06715677
```

We will first create a SummarizedExperiment object with the function
`make_dnam_se`. This function will use the Sesame R/Bioconductor package
to map the array probes into genomic regions. You cen set human genome version
(hg38 or hg19) and the array type (“450k” or “EPIC”)

```
dna.met.chr21.se <- make_dnam_se(
  dnam = dna.met.chr21,
  genome = "hg38",
  arrayType = "450k",
  betaToM = FALSE, # transform beta to m-values
  verbose = FALSE # hide informative messages
)
#> see ?sesameData and browseVignettes('sesameData') for documentation
#> loading from cache
#> require("GenomicRanges")
```

```
dna.met.chr21.se
#> class: RangedSummarizedExperiment
#> dim: 2918 38
#> metadata(2): genome arrayType
#> assays(1): ''
#> rownames(2918): chr21:10450634-10450635 chr21:10520974-10520975 ...
#>   chr21:46670216-46670217 chr21:46670596-46670597
#> rowData names(53): address_A address_B ... MASK_general probeID
#> colnames(38): TCGA-3L-AA1B-01A TCGA-4N-A93T-01A ... TCGA-A6-5656-01B TCGA-A6-5657-01A
#> colData names(1): samples
SummarizedExperiment::rowRanges(dna.met.chr21.se)[1:4,1:4]
#> GRanges object with 4 ranges and 4 metadata columns:
#>                           seqnames            ranges strand | address_A address_B     channel
#>                              <Rle>         <IRanges>  <Rle> | <integer> <integer> <character>
#>   chr21:10450634-10450635    chr21 10450634-10450635      * |  74716393      <NA>        Both
#>   chr21:10520974-10520975    chr21 10520974-10520975      * |  29756401  20622400         Red
#>   chr21:10521044-10521045    chr21 10521044-10521045      * |  15617483      <NA>        Both
#>   chr21:10521122-10521123    chr21 10521122-10521123      * |  33810384  37781360         Grn
#>                            designType
#>                           <character>
#>   chr21:10450634-10450635          II
#>   chr21:10520974-10520975           I
#>   chr21:10521044-10521045          II
#>   chr21:10521122-10521123           I
#>   -------
#>   seqinfo: 26 sequences from an unspecified genome; no seqlengths
```

#### 4.1.1.2 Analysis of DMRs

Differentially Methylated Regions (DMRs) associated with phenotypes such
as tumor stage can be obtained from R packages such as
`coMethDMR`, `comb-p`, `DMRcate` and many others.
The methylation levels in multiple CpGs within the DMRs need to be
summarized (e.g. using medians), then the analysis for
DMR will proceed in the same way
as those for CpGs.

### 4.1.2 Input gene expression dataset

The gene expression dataset is a matrix with log2 transformed and
normalized gene expression values.
If there are potential confounding factors (e.g. batch effect, age, sex) in the dataset,
this matrix can also contain residuals from linear regression instead
(see **Section 6** “Controlling effects from confounding variables” below).

The samples are in the columns and the genes are in the rows.

```
data("gene.exp.chr21.log2")
gene.exp.chr21.log2[1:5,1:5]
#>                 TCGA-3L-AA1B-01A TCGA-4N-A93T-01A TCGA-4T-AA8H-01A TCGA-5M-AAT4-01A
#> ENSG00000141956         14.64438         14.65342         14.09232         14.60680
#> ENSG00000141959         19.33519         20.03720         19.76128         19.57854
#> ENSG00000142149         17.27832         16.02392         18.16079         15.84463
#> ENSG00000142156         20.38689         18.83080         18.02720         18.91380
#> ENSG00000142166         17.89172         18.06625         18.47187         17.40467
#>                 TCGA-5M-AAT5-01A
#> ENSG00000141956         14.58640
#> ENSG00000141959         18.27442
#> ENSG00000142149         14.79654
#> ENSG00000142156         18.71926
#> ENSG00000142166         16.71412
```

We will also create a SummarizedExperiment object for the gene expression data.
This object will contain the genomic information for each gene.

```
gene.exp.chr21.se <- make_exp_se(
  exp = gene.exp.chr21.log2,
  genome = "hg38",
  verbose = FALSE
)
gene.exp.chr21.se
#> class: RangedSummarizedExperiment
#> dim: 752 38
#> metadata(1): genome
#> assays(1): ''
#> rownames(752): ENSG00000141956 ENSG00000141959 ... ENSG00000281420 ENSG00000281903
#> rowData names(2): ensembl_gene_id external_gene_name
#> colnames(38): TCGA-3L-AA1B-01A TCGA-4N-A93T-01A ... TCGA-A6-5656-01B TCGA-A6-5657-01A
#> colData names(1): samples
SummarizedExperiment::rowRanges(gene.exp.chr21.se)[1:5,]
#> GRanges object with 5 ranges and 2 metadata columns:
#>                   seqnames            ranges strand | ensembl_gene_id external_gene_name
#>                      <Rle>         <IRanges>  <Rle> |     <character>        <character>
#>   ENSG00000141956    chr21 41798225-41879482      - | ENSG00000141956             PRDM15
#>   ENSG00000141959    chr21 44300051-44327376      + | ENSG00000141959               PFKL
#>   ENSG00000142149    chr21 31873020-32044633      + | ENSG00000142149               HUNK
#>   ENSG00000142156    chr21 45981769-46005050      + | ENSG00000142156             COL6A1
#>   ENSG00000142166    chr21 33324429-33359864      + | ENSG00000142166             IFNAR1
#>   -------
#>   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

### 4.1.3 Creating triplet dataset

#### 4.1.3.1 Creating triplet dataset using distance based approaches and JASPAR2022

In this section, **regions** refer to the regions where CpGs are located.

##### 4.1.3.1.1 Linking a region to a target gene

To evaluate the DNA methylation effect on the expression of a gene,
first we need to define which are the possible affected genes.
For this we initially define if the DNA methylation occurred withing a promoter regions,
defined as 2 kbp upstream and 2 kbp downstream of the transcription start site (TSS),
or in a non-promoter region, also known as distal regions, that could behave like enhancer of the gene expression.

Enhancers can increase the transcription of genes and are found in different locations
(upstream or downstream of genes, within introns).
Their functional complexity lies in the possibility genes located more distantly than
the neighboring genes and being able to regulate multiple genes (Pennacchio et al. [2013](#ref-pennacchio2013enhancers)).
Also, enhancer–promoter looping could happen at two sequences within approximately 1 Mb of each other (Pennacchio et al. [2013](#ref-pennacchio2013enhancers)).
Williamson, Hill, and Bickmore ([2011](#ref-williamson2011enhancers)) also highlighted not only that a proportion of enhancers
are situated hundreds to thousands of kilobases from their target genes,
often in large gene-poor regions, but also the promiscuous activity when placed within gene-rich domains.

These promoters and enhancers interactions could be further identified using Chromosome conformation capture techniques such as 3C, 4C, Hi-C.
However, in the lack of this information one could use the position information in the genome to link an enhancer to a candidate target gene.
Such problem is also identified in the GWAS studies, for example,
Brodie, Azaria, and Ofran ([2016](#ref-brodie2016far)) found that affected genes are often up to \(2 Mbps\) away from the
associated SNP and highlighted that some studies suggested to use a cutoff of \(500 Kbps\)
since enhancers and repressors may be as distant as \(500 Kbps\) from their genes.
The issue of this method is that with a big window in gene-rich regions would map
to several genes, and a small window might not map the gene-poor region, making the decision on the window size very difficult.
Another method was presented by Yao et al. ([2015](#ref-yao2015inferring)) which provided
a linkage method based on a fixed quantity of genes upstream and downstream of the enhancers.

MethReg offer two methods for enhancer linking 1) a window-based method similar to the ones in the GWAS studies,
2) a fixed number of genes upstream and downstream of the DNA methylation loci similar to the one suggested by Yao et al. ([2015](#ref-yao2015inferring)),
and one method for promoter linking, which maps to the gene of the promoter region.

The function `create_triplet_distance_based` provides those three different methods to
link a region to a target gene:

1. Mapping the region to the closest gene (`target.method = "genes.promoter.overlap"`)
2. Mapping the region to a specific number of genes upstream down/upstream
   of the region (`target.method = "nearby.genes"`) (Silva et al. [2019](#ref-silva2019elmer)).
3. Mapping the region to all the genes within a window
   (default size = 500 kbp around the region, i.e. +- 250 kbp from start or end
   of the region) (`target.method = "window"`) (Reese et al. [2019](#ref-reese2019epigenome)).

![Different target linking strategies](data:image/png;base64...)

Figure 2: Different target linking strategies

For the analysis of probes in gene promoter region, we recommend setting
`method = "genes.promoter.overlap"`, or
`method = "closest.gene"`.
For the analysis of probes in distal regions, we recommend setting either
`method = "window"` or `method = "nearby.genes"`.
Note that the distal analysis will be more time and resource consuming.

To link regions to TF using JASPAR2022, MethReg uses `motifmatchr` (Schep [2020](#ref-motifmatchr)) to scan
these regions for occurrences of motifs in the database. JASPAR2020 is an
open-access database of curated, non-redundant transcription
factor (TF)-binding profiles (Baranasic [2022](#ref-JASPAR2022); Castro-Mondragon et al. [2021](#ref-fornes2022jaspar)), which contains
more the 500 human TF motifs.

The motif search width of the scanned region is one important parameter.
Although TF recognizes short specific DNA sequence motifs (\(6–12 bp\)) (Leporcq et al. [2020](#ref-leporcq2020tfmotifview)),
the output of a ChIP-seq experiment can include peaks longer than \(1000 bp\) (Boeva [2016](#ref-boeva2016analysis)), but
most of the motifs are found \(\pm\) \(50-75 bp\) from the TF peak center (Heinz et al. [2010](#ref-heinz2010simple)).
Also, recently, it has been shown by Grossman et al. ([2018](#ref-grossman2018positional)) that TFs have different positional
bindings around nucleosome-depleted regions of DNA, which could range from \(\pm200bp\) around
the center of the DNaseI-hypersensitive (DHS) sites defined by the Roadmap Epigenomics project and
Wang et al. ([2019](#ref-wang2019identification)) showed that the methylation levels at UM (unmethylated motifs) and MM (methylated Motifs) were also altered within that range.
Since a single CpG is only 1bp, to predict if the methylation at the loci would affect the TF binding site,
we suggest using a motif search window no bigger than \(400bp\).

The argument `motif.search.window.size` will be used to extend the region when scanning
for the motifs, for example, a `motif.search.window.size` of `50` will add `25` bp
upstream and `25` bp downstream of the original region.

As an example, the following scripts link CpGs with the probes in gene
promoter region (method 1. above)

```
triplet.promoter <- create_triplet_distance_based(
  region = dna.met.chr21.se,
  target.method = "genes.promoter.overlap",
  genome = "hg38",
  target.promoter.upstream.dist.tss = 2000,
  target.promoter.downstream.dist.tss = 2000,
  motif.search.window.size = 400,
  motif.search.p.cutoff  = 1e-08,
  cores = 1
)
```

Alternatively, we can also link each probe with genes within
\(500 kb\) window (method 2).

```
# Map probes to genes within 500kb window
triplet.distal.window <- create_triplet_distance_based(
  region = dna.met.chr21.se,
    genome = "hg38",
    target.method = "window",
    target.window.size = 500 * 10^3,
    target.rm.promoter.regions.from.distal.linking = TRUE,
    motif.search.window.size = 500,
    motif.search.p.cutoff  = 1e-08,
    cores = 1
)
```

For method 3, to map probes to 5 nearest upstream and downstream genes:

```
# Map probes to 5 genes upstream and 5 downstream
triplet.distal.nearby.genes <- create_triplet_distance_based(
  region = dna.met.chr21.se,
    genome = "hg38",
    target.method = "nearby.genes",
    target.num.flanking.genes = 5,
    target.window.size = 500 * 10^3,
    target.rm.promoter.regions.from.distal.linking = TRUE,
    motif.search.window.size = 400,
    motif.search.p.cutoff  = 1e-08,
    cores = 1
)
```

#### 4.1.3.2 Creating triplet dataset using distance based approaches and REMAP2020

Instead of using JASPAR2020 motifs, we will be using REMAP2018 catalogue of
TF peaks which can be access either using the package `ReMapEnrich`
or a most updated version (RemMap2022) is available online at <https://remap.univ-amu.fr/download_page>

```
if (!"BiocManager" %in% rownames(installed.packages()))
     install.packages("BiocManager")
BiocManager::install("remap-cisreg/ReMapEnrich", dependencies = TRUE)
```

To download REMAP2018 catalogue (~1Gb) the following functions are used:

```
library(ReMapEnrich)
remapCatalog2018hg38 <- downloadRemapCatalog("/tmp/", assembly = "hg38")
remapCatalog <- bedToGranges(remapCatalog2018hg38)
```

The function `create_triplet_distance_based` will accept any Granges with TF
information in the same format as the `remapCatalog` one.

```
#-------------------------------------------------------------------------------
# Triplets promoter using remap
#-------------------------------------------------------------------------------
triplet.promoter.remap <- create_triplet_distance_based(
  region = dna.met.chr21.se,
  genome = "hg19",
  target.method =  "genes.promoter.overlap",
  TF.peaks.gr = remapCatalog,
  motif.search.window.size = 400,
  max.distance.region.target = 10^6,
)
```

#### 4.1.3.3 Creating triplet dataset using regulon-based approaches

The human regulons from the dorothea database will be used as an example:

```
if (!"BiocManager" %in% rownames(installed.packages()))
     install.packages("BiocManager")
BiocManager::install("dorothea", dependencies = TRUE)
```

```
regulons.dorothea <- dorothea::dorothea_hs
regulons.dorothea %>% head
#> # A tibble: 6 × 4
#>   tf    confidence target   mor
#>   <chr> <chr>      <chr>  <dbl>
#> 1 ADNP  D          ATF7IP     1
#> 2 ADNP  D          DYRK1A     1
#> 3 ADNP  D          TLK1       1
#> 4 ADNP  D          ZMYM4      1
#> 5 ADNP  D          ABCC1      1
#> 6 ADNP  D          ABCC6      1
```

Using the regulons, you can calculate enrichment scores for each TF across
all samples using dorothea and viper.

```
rnaseq.tf.es <- get_tf_ES(
  exp = gene.exp.chr21.se %>% SummarizedExperiment::assay(),
  regulons = regulons.dorothea
)
#> Warning in run_viper.matrix(input = exp, regulons = regulons, options = list(method = "scale", :
#> This function is deprecated, please check the package decoupleR to infer activities.
```

Finally, triplets can be identified using TF-target from regulon databases with the function `create_triplet_regulon_based`.

```
  triplet.regulon <- create_triplet_regulon_based(
    region = dna.met.chr21.se,
    genome = "hg38",
    motif.search.window.size = 400,
    tf.target = regulons.dorothea,
    max.distance.region.target = 10^6 # 1Mbp
  )
```

```
triplet.regulon %>% head
#> # A tibble: 6 × 7
#>   regionID                target_symbol target     TF_symbol TF    confidence distance_region_targ…¹
#>   <chr>                   <chr>         <chr>      <chr>     <chr> <chr>                       <dbl>
#> 1 chr21:28290328-28290328 CCT8          ENSG00000… ALX3      ENSG… E                          783468
#> 2 chr21:28885020-28885021 CCT8          ENSG00000… ALX3      ENSG… E                          188775
#> 3 chr21:28885068-28885069 CCT8          ENSG00000… ALX3      ENSG… E                          188727
#> 4 chr21:28889202-28889203 CCT8          ENSG00000… ALX3      ENSG… E                          184593
#> 5 chr21:28995965-28995966 CCT8          ENSG00000… ALX3      ENSG… E                           77830
#> 6 chr21:29001707-29001708 CCT8          ENSG00000… ALX3      ENSG… E                           72088
#> # ℹ abbreviated name: ¹​distance_region_target_tss
```

#### 4.1.3.4 Example of triplet data frame

The triplet is a data frame with the following columns:

* `target`: gene identifier (obtained from row names of the gene expression matrix),
* `regionID`: region/CpG identifier (obtained from row names of the DNA methylation matrix)
* `TF`: gene identifier (obtained from the row names of the gene expression matrix)

```
str(triplet.promoter)
#> tibble [32,543 × 7] (S3: tbl_df/tbl/data.frame)
#>  $ regionID                  : chr [1:32543] "chr21:10520974-10520975" "chr21:10520974-10520975" "chr21:10520974-10520975" "chr21:10520974-10520975" ...
#>  $ probeID                   : chr [1:32543] "cg18453969" "cg18453969" "cg18453969" "cg18453969" ...
#>  $ target_symbol             : chr [1:32543] "TPTE" "TPTE" "TPTE" "TPTE" ...
#>  $ target                    : chr [1:32543] "ENSG00000274391" "ENSG00000274391" "ENSG00000274391" "ENSG00000274391" ...
#>  $ TF_symbol                 : chr [1:32543] "BHLHE22" "PITX1" "GSC" "GSC2" ...
#>  $ TF                        : chr [1:32543] "ENSG00000180828" "ENSG00000069011" "ENSG00000133937" "ENSG00000063515" ...
#>  $ distance_region_target_tss: num [1:32543] -577 -577 -577 -577 -577 -577 -577 -577 -577 -577 ...
triplet.promoter$distance_region_target_tss %>% range
#> [1] -1999  1989
triplet.promoter %>% head
#> # A tibble: 6 × 7
#>   regionID                probeID    target_symbol target     TF_symbol TF    distance_region_targ…¹
#>   <chr>                   <chr>      <chr>         <chr>      <chr>     <chr>                  <dbl>
#> 1 chr21:10520974-10520975 cg18453969 TPTE          ENSG00000… BHLHE22   ENSG…                   -577
#> 2 chr21:10520974-10520975 cg18453969 TPTE          ENSG00000… PITX1     ENSG…                   -577
#> 3 chr21:10520974-10520975 cg18453969 TPTE          ENSG00000… GSC       ENSG…                   -577
#> 4 chr21:10520974-10520975 cg18453969 TPTE          ENSG00000… GSC2      ENSG…                   -577
#> 5 chr21:10520974-10520975 cg18453969 TPTE          ENSG00000… HIC2      ENSG…                   -577
#> 6 chr21:10520974-10520975 cg18453969 TPTE          ENSG00000… MEIS1     ENSG…                   -577
#> # ℹ abbreviated name: ¹​distance_region_target_tss
```

Note that there may be multiple rows for a CpG region, when multiple
target gene and/or TFs are found close to it.

## 4.2 Evaluating the regulatory potential of CpGs (or DMRs)

Because TF binding to DNA can be influenced by (or influences)
DNA methylation levels nearby (Yin et al. [2017](#ref-yin2017impact)),
target gene expression levels are often resulted from the synergistic effects
of both TF and DNA methylation. In other words, TF activities in gene
regulation is often affected by DNA methylation.

Our goal then is to highlight DNA methylation regions (or CpGs) where
these synergistic DNAm and TF collaborations occur.
We will perform analyses using the 3 datasets described above in Section 3:

* An input DNA methylation matrix
* An input Gene expression matrix
* The created triplet data frame

### 4.2.1 Analysis using model with methylation by TF interaction

The function `interaction_model` assess the regulatory impact of
DNA methylation on TF regulation of target genes via the following approach:

**considering DNAm values as a binary variable** - we define a binary variable
`DNAm Group` for DNA methylation values (high = 1, low = 0).
That is, samples with the highest DNAm levels (top 25 percent) has high = 1,
samples with lowest DNAm levels (bottom 25 pecent) has high = 0.

Note that in this implementation, only samples with DNAm values in
the first and last quartiles are considered.

\[log\_2(RNA target) \sim log\_2(TF) + \text{DNAm Group} + log\_2(TF) \* \text{DNAm Group}\]

```
results.interaction.model <- interaction_model(
    triplet = triplet.promoter,
    dnam = dna.met.chr21.se,
    exp = gene.exp.chr21.se,
    dnam.group.threshold = 0.1,
    sig.threshold = 0.05,
    fdr = T,
    stage.wise.analysis = FALSE,
    filter.correlated.tf.exp.dnam = F,
    filter.triplet.by.sig.term = T
)
#> Warning: Returning more (or less) than 1 row per `summarise()` group was deprecated in dplyr 1.1.0.
#> ℹ Please use `reframe()` instead.
#> ℹ When switching from `summarise()` to `reframe()`, remember that `reframe()` always returns an
#>   ungrouped data frame and adjust accordingly.
#> ℹ The deprecated feature was likely used in the MethReg package.
#>   Please report the issue at <https://github.com/TransBioInfoLab/MethReg/issues/>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was generated.
```

The output of `interaction_model` function will be a data frame with the following variables:

* `<variable>_pvalue`: p-value for a tested variable (methylation or TF), given the other variables included in the model.
* `<variable>_estimate`: estimated effect for a variable. If estimate > 0, increasing values
  of the variable corresponds to increased outcome values (target gene expression).
  If estimate < 0, increasing values of the variable correspond to decreased target gene expression levels.

The following columns are provided for the results of fitting **quartile model** to triplet data:

* direct effect of methylation:
  + `RLM_DNAmGroup_pvalue`: p-value for binary DNA methylation variable
  + `RLM_DNAmGroup_estimate`: estimated DNA methylation effect
* direct effect of TF:
  + `RLM_TF_pvalue` : p-value for TF expression
  + `RLM_TF_estimate`: estimated TF effect
* synergistic effects of methylation and TF:
  + `RLM_DNAmGroup:TF_pvalue`: : p-value for DNA methylation by TF interaction
  + `RLM_DNAmGroup:TF_estimate`: estimated DNA methylation by TF interaction effect

**Selecting the significant triplet!**

`RLM_DNAmGroup:TF_pvalue`: raw p-value obtained from fitting robust linear model, without any multiple comparison correction

If `stage.wise.analysis = TRUE` is selected, MethReg implements the stage-wise procedure for testing interactions by first aggregating all CpG-TF-target gene triplets associated with the same CpG as a group. Then it performs two steps:

1. In the screening step, MethReg tests the null hypothesis that any of the individual triplets mapped to a CpG has a significant DNAm × TF effect.
2. In the confirmation step, MethReg tests each triplet associated with the CpG selected in the screening step while controlling FWER as described in Van den Berge et al. (2017, PMID: 28784146)

`RLM_DNAmGroup:TF_region_stage_wise_adj_pvalue`: p-value obtained in step (1) described above

`RLM_DNAmGroup:TF_triplet_stage_wise_adj_pvalue`: this is multiple comparison corrected p-value for each triplet obtained in step (2) above, and should be used to select triplets

For a easier visualization of the results please refer to the `export_results_to_table` function.

```
# Results for quartile model
results.interaction.model %>% dplyr::select(
  c(1,4,5,grep("RLM",colnames(results.interaction.model)))
  ) %>% head
#>                  regionID          target TF_symbol RLM_DNAmGroup_pvalue RLM_DNAmGroup_fdr
#> 1 chr21:17611485-17611486 ENSG00000280594     BACH1          0.008769449        0.01753890
#> 2 chr21:41879303-41879304 ENSG00000141956      ETS2          0.044083747        0.08816749
#> 3 chr21:46286242-46286243 ENSG00000182362      ETS2          0.008407302        0.01681460
#>   RLM_TF_pvalue RLM_TF_fdr RLM_DNAmGroup:TF_pvalue RLM_DNAmGroup:TF_fdr RLM_DNAmGroup_estimate
#> 1    0.02659345 0.05318690             0.008160234           0.01632047             -16.782510
#> 2    0.01651490 0.03302981             0.059441204           0.11888241               9.235738
#> 3    0.02598837 0.05197675             0.012364430           0.02472886             -16.085545
#>   RLM_TF_estimate RLM_DNAmGroup:TF_estimate
#> 1       0.4514233                 0.9459172
#> 2       0.3990901                -0.3929210
#> 3      -0.3510502                 0.6729856
```

### 4.2.2 Stratified analysis by high and low DNA methylation levels

For triplets with significant \(log\_2(TF) × DNAm\) interaction effect identified
above, we can further assess how gene regulation by TF changes when DNAm
is high or low. To this end, the function
`stratified_model` fits two separate models (see below) to only
samples with the highest DNAm levels (top 25 percent), and then to
only samples with lowest DNAm levels (bottom 25 percent), separately.

\[\text{Stratified Model: } log\_2(RNA target) \sim log\_2(TF)\]

```
results.stratified.model <- stratified_model(
    triplet = results.interaction.model,
    dnam = dna.met.chr21.se,
    exp = gene.exp.chr21.se,
    dnam.group.threshold = 0.25
)
```

```
results.stratified.model %>% head
#>                  regionID    probeID target_symbol          target TF_symbol              TF
#> 1 chr21:17611485-17611486 cg04464940      BTG3-AS1 ENSG00000280594     BACH1 ENSG00000156273
#> 2 chr21:41879303-41879304 cg17014849        PRDM15 ENSG00000141956      ETS2 ENSG00000157557
#> 3 chr21:46286242-46286243 cg21945459          YBEY ENSG00000182362      ETS2 ENSG00000157557
#>   distance_region_target_tss           target_region met.IQR RLM_DNAmGroup_pvalue RLM_DNAmGroup_fdr
#> 1                       -257 chr21:17611744-17633199       0          0.008769449        0.01753890
#> 2                        177 chr21:41798225-41879482       0          0.044083747        0.08816749
#> 3                        -98 chr21:46286342-46297751       0          0.008407302        0.01681460
#>   RLM_TF_pvalue RLM_TF_fdr RLM_DNAmGroup:TF_pvalue RLM_DNAmGroup:TF_fdr RLM_DNAmGroup_estimate
#> 1    0.02659345 0.05318690             0.008160234           0.01632047             -16.782510
#> 2    0.01651490 0.03302981             0.059441204           0.11888241               9.235738
#> 3    0.02598837 0.05197675             0.012364430           0.02472886             -16.085545
#>   RLM_TF_estimate RLM_DNAmGroup:TF_estimate      Model.quantile
#> 1       0.4514233                 0.9459172 Robust Linear Model
#> 2       0.3990901                -0.3929210 Robust Linear Model
#> 3      -0.3510502                 0.6729856 Robust Linear Model
#>   Target_gene_DNAm_high_vs_Target_gene_DNAm_low_wilcoxon_pvalue
#> 1                                                    0.03038282
#> 2                                                    0.03038282
#> 3                                                    0.03038282
#>   TF_DNAm_high_vs_TF_DNAm_low_wilcoxon_pvalue
#> 1                                  0.03038282
#> 2                                  0.47048642
#> 3                                  0.31232142
#>   % of target genes not expressed in DNAm_low and DNAm_high DNAm_low_RLM_target_vs_TF_pvalue
#> 1                                                       0 %                        0.1650152
#> 2                                                       0 %                        0.5185605
#> 3                                                       0 %                        0.7965329
#>   DNAm_low_RLM_target_vs_TF_estimate DNAm_high_RLM_target_vs_TF_pvalue
#> 1                          0.4487346                        0.03507941
#> 2                          0.1102264                        0.52581775
#> 3                          0.3231508                        0.09615865
#>   DNAm_high_RLM_target_vs_TF_estimate DNAm.effect TF.role
#> 1                           0.6058538        <NA>      NA
#> 2                           0.3056055          ns      NA
#> 3                           1.1994286        <NA>      NA
```

### 4.2.3 Visualization of data

The functions `plot_interaction_model`
will create figures to visualize the data,
in a way that corresponds to the linear model we considered above.
It requires the output from the function `interaction_model` (a dataframe),
the DNA methylation matrix and the gene expression matrix as input.

```
plots <- plot_interaction_model(
    triplet.results = results.interaction.model[1,],
    dnam = dna.met.chr21.se,
    exp = gene.exp.chr21.se,
    dnam.group.threshold = 0.25
)
```

```
plots
#> $`chr21:17611485-17611486_TF_ENSG00000156273_target_ENSG00000280594`
```

![An example output from MethReg.](data:image/png;base64...)

Figure 3: An example output from MethReg

The first row of the figures shows pairwise associations between DNA methylation,
TF, and target gene expression levels.

The second row of the figures shows how much TF activity on target gene expression
levels vary varies by DNA methylation levels.
When TF by methylation interaction is significant (Section 4.1),
we expect the association between TF and target gene expression
to vary depending on whether DNA methylation is low or high.

In this example, when DNA methylation is low, target gene expression is relatively
independent of the amount of TF available. On the other hand, when the DNA methylation
level is high, more abundant TF corresponds to increased gene expression (an activator TF).
One possibility is that DNA methylation might enhance TF binding in this case.
***This is an example where DNA methylation and TF work synergistically to affect target gene expression***.

While the main goal of MethReg is to prioritize methylation CpGs, also
note that without stratifying by DNA methylation, the overall TF-target
effects (p = 0.971) are not as significant as the association in stratified
analysis in high methylation samples (p = 0.0096).
***This demonstrates that by additionally modeling DNA methylation,***
***we can also nominate TF – target associations that might have been missed otherwise***.

Note that because of the small sample size (only 38 samples) included in this example for illustration, the P-value for high methylation samples (p = 0.096)
is only marginally significant.
In real data analysis, we
expect MethReg to work well with at least 100 matched samples measured

## 4.3 Results interpretation

Shown below are some expected results from fitting Models 1 & 2 described in
**Section 4.1** above, depending on TF binding preferences. Please note that
there can be more possible scenarios than those listed here, therefore,
careful evaluation of the statistical models and visualization of data as
described in **Section 4** are needed to gain a good understanding of the
multi-omics data.

![Scenarios modeled by MethReg. A and B: DNA methylation decreases TF activity. In A TF is a repressor of the target gene, while in B TF is an activator. C and D: DNA methylation increases TF activity. In C TF is a repressor of the target gene, while in D TF is an activator. E and F: DNA methylation inverts the TF role. In E when DNA methylation levels are low the TF works as a repressor, when DNA methylation levels are high the TF acts as an activator. In F when the DNA methylation levels are low the TF works as an activator, when methylation levels are high the TF acts a repressor.](data:image/png;base64...)

Figure 4: Scenarios modeled by MethReg
A and B: DNA methylation decreases TF activity. In A TF is a repressor of the target gene, while in B TF is an activator. C and D: DNA methylation increases TF activity. In C TF is a repressor of the target gene, while in D TF is an activator. E and F: DNA methylation inverts the TF role. In E when DNA methylation levels are low the TF works as a repressor, when DNA methylation levels are high the TF acts as an activator. In F when the DNA methylation levels are low the TF works as an activator, when methylation levels are high the TF acts a repressor.

# 5 Controlling effects from confounding variables

Both gene expressions and DNA methylation levels can be affected by age, sex,
shifting in cell types, batch effects and other confounding (or covariate) variables.
In this section, we illustrate analysis workflow that reduces confounding effects,
by first extracting the residual data with the function `get_residuals`,
before fitting the models discussed above in Section 4.

The `get_residuals` function will use gene expression (or DNA methylation data)
and phenotype data as input. To remove confounding effects in gene expression data,
we use the `get_residuals` function which extract residuals after fitting the
following model for gene expression data:
\[log\_2(RNA target) \sim covariate\_{1} + covariate\_{2} + ... + covariate\_{N}\]
or the following model for methylation data:

\[methylation.Mvalues \sim covariate\_{1} + covariate\_{2} + ... + covariate\_{N}\]

```
data("gene.exp.chr21.log2")
data("clinical")
metadata <- clinical[,c("sample_type","gender")]

gene.exp.chr21.residuals <- get_residuals(gene.exp.chr21, metadata) %>% as.matrix()
```

```
gene.exp.chr21.residuals[1:5,1:5]
```

```
data("dna.met.chr21")
dna.met.chr21 <- make_se_from_dnam_probes(
  dnam = dna.met.chr21,
  genome = "hg38",
  arrayType = "450k",
  betaToM = TRUE
)
dna.met.chr21.residuals <- get_residuals(dna.met.chr21, metadata) %>% as.matrix()
```

```
dna.met.chr21.residuals[1:5,1:5]
```

The models described in **Section 4.1** can then be applied to these residuals
data using the `interaction_model` function:

```
results <- interaction_model(
    triplet = triplet,
    dnam = dna.met.chr21.residuals,
    exp = gene.exp.chr21.residuals
)
```

# 6 Calculating enrichment scores

## 6.1 Using dorothea and viper

This example shows how to use dorothea regulons and viper to calculate
enrichment scores for each TF across all samples.

```
regulons.dorothea <- dorothea::dorothea_hs
regulons.dorothea %>% head
#> # A tibble: 6 × 4
#>   tf    confidence target   mor
#>   <chr> <chr>      <chr>  <dbl>
#> 1 ADNP  D          ATF7IP     1
#> 2 ADNP  D          DYRK1A     1
#> 3 ADNP  D          TLK1       1
#> 4 ADNP  D          ZMYM4      1
#> 5 ADNP  D          ABCC1      1
#> 6 ADNP  D          ABCC6      1
```

```
rnaseq.tf.es <- get_tf_ES(
  exp = gene.exp.chr21.se %>% SummarizedExperiment::assay(),
  regulons = regulons.dorothea
)
#> Warning in run_viper.matrix(input = exp, regulons = regulons, options = list(method = "scale", :
#> This function is deprecated, please check the package decoupleR to infer activities.
```

```
rnaseq.tf.es[1:4,1:4]
#>                 TCGA-3L-AA1B-01A TCGA-4N-A93T-01A TCGA-4T-AA8H-01A TCGA-5M-AAT4-01A
#> ENSG00000101126        0.5107344       -2.1708007       -1.4257370      -2.29950338
#> ENSG00000101544       -1.0332572       -0.2855890        0.8007206       0.14008977
#> ENSG00000139154       -0.9773648        0.2275618        0.9888562      -2.01317607
#> ENSG00000160224        0.2112202       -0.9044230        0.1509887      -0.01717518
```

## 6.2 Using dorothea and GSVA

```
regulons.dorothea <- dorothea::dorothea_hs
regulons.dorothea$tf <- MethReg:::map_symbol_to_ensg(
  gene.symbol = regulons.dorothea$tf,
  genome = "hg38"
)
regulons.dorothea$target <- MethReg:::map_symbol_to_ensg(
  gene.symbol = regulons.dorothea$target,
  genome = "hg38"
)
split_tibble <- function(tibble, col = 'col') tibble %>% split(., .[, col])
regulons.dorothea.list <- regulons.dorothea %>% na.omit() %>%
  split_tibble('tf') %>%
  lapply(function(x){x[[3]]})
```

```
library(GSVA)
rnaseq.tf.es.gsva <- gsva(
  expr = gene.exp.chr21.se %>% SummarizedExperiment::assay(),
  gset.idx.list = regulons.dorothea.list,
  method = "gsva",
  kcdf = "Gaussian",
  abs.ranking = TRUE,
  min.sz = 5,
  max.sz = Inf,
  parallel.sz = 1L,
  mx.diff = TRUE,
  ssgsea.norm = TRUE,
  verbose = TRUE
)
```

# 7 Session information

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
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
#>  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
#> [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#>  [1] BSgenome.Hsapiens.UCSC.hg38_1.4.5 BSgenome_1.78.0
#>  [3] rtracklayer_1.70.0                BiocIO_1.20.0
#>  [5] Biostrings_2.78.0                 XVector_0.50.0
#>  [7] GenomeInfoDb_1.46.0               GenomicRanges_1.62.0
#>  [9] Seqinfo_1.0.0                     IRanges_2.44.0
#> [11] S4Vectors_0.48.0                  MethReg_1.20.0
#> [13] sesameData_1.27.1                 ExperimentHub_3.0.0
#> [15] AnnotationHub_4.0.0               BiocFileCache_3.0.0
#> [17] dbplyr_2.5.1                      BiocGenerics_0.56.0
#> [19] generics_0.1.4                    dplyr_1.1.4
#> [21] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] splines_4.5.1               bitops_1.0-9                filelock_1.0.3
#>   [4] tibble_3.3.0                preprocessCore_1.72.0       XML_3.99-0.19
#>   [7] DirichletMultinomial_1.52.0 lifecycle_1.0.4             httr2_1.2.1
#>  [10] pwalign_1.6.0               rstatix_0.7.3               doParallel_1.0.17
#>  [13] lattice_0.22-7              MASS_7.3-65                 backports_1.5.0
#>  [16] magrittr_2.0.4              openxlsx_4.2.8              plotly_4.11.0
#>  [19] sass_0.4.10                 rmarkdown_2.30              jquerylib_0.1.4
#>  [22] yaml_2.3.10                 zip_2.3.3                   cowplot_1.2.0
#>  [25] DBI_1.2.3                   RColorBrewer_1.1-3          abind_1.4-8
#>  [28] sfsmisc_1.1-22              purrr_1.1.0                 mixtools_2.0.0.1
#>  [31] RCurl_1.98-1.17             rappdirs_0.3.3              seqLogo_1.76.0
#>  [34] parallelly_1.45.1           codetools_0.2-20            DelayedArray_0.36.0
#>  [37] tidyselect_1.2.1            UCSC.utils_1.6.0            farver_2.1.2
#>  [40] matrixStats_1.5.0           GenomicAlignments_1.46.0    jsonlite_2.0.0
#>  [43] wheatmap_0.2.0              e1071_1.7-16                Formula_1.2-5
#>  [46] survival_3.8-3              motifmatchr_1.32.0          iterators_1.0.14
#>  [49] foreach_1.5.2               segmented_2.1-4             tools_4.5.1
#>  [52] progress_1.2.3              dorothea_1.21.0             TFMPvalue_0.0.9
#>  [55] Rcpp_1.1.0                  glue_1.8.0                  gridExtra_2.3
#>  [58] SparseArray_1.10.0          mgcv_1.9-3                  xfun_0.53
#>  [61] decoupleR_2.16.0            MatrixGenerics_1.22.0       withr_3.0.2
#>  [64] BiocManager_1.30.26         fastmap_1.2.0               caTools_1.18.3
#>  [67] digest_0.6.37               R6_2.6.1                    colorspace_2.1-2
#>  [70] gtools_3.9.5                dichromat_2.0-0.1           RSQLite_2.4.3
#>  [73] cigarillo_1.0.0             utf8_1.2.6                  tidyr_1.3.1
#>  [76] data.table_1.17.8           class_7.3-23                prettyunits_1.2.0
#>  [79] httr_1.4.7                  htmlwidgets_1.6.4           S4Arrays_1.10.0
#>  [82] TFBSTools_1.48.0            pkgconfig_2.0.3             gtable_0.3.6
#>  [85] blob_1.2.4                  S7_0.2.0                    htmltools_0.5.8.1
#>  [88] carData_3.0-5               bookdown_0.45               scales_1.4.0
#>  [91] Biobase_2.70.0              png_0.1-8                   knitr_1.50
#>  [94] tzdb_0.5.0                  reshape2_1.4.4              rjson_0.2.23
#>  [97] nlme_3.1-168                curl_7.0.0                  proxy_0.4-27
#> [100] cachem_1.1.0                stringr_1.5.2               BiocVersion_3.22.0
#> [103] KernSmooth_2.23-26          parallel_4.5.1              viper_1.44.0
#> [106] AnnotationDbi_1.72.0        restfulr_0.0.16             pillar_1.11.1
#> [109] grid_4.5.1                  vctrs_0.6.5                 pscl_1.5.9
#> [112] ggpubr_0.6.2                car_3.1-3                   JASPAR2024_0.99.7
#> [115] evaluate_1.0.5              readr_2.1.5                 tinytex_0.57
#> [118] magick_2.9.0                cli_3.6.5                   compiler_4.5.1
#> [121] Rsamtools_2.26.0            rlang_1.1.6                 crayon_1.5.3
#> [124] ggsignif_0.6.4              labeling_0.4.3              bcellViper_1.45.0
#> [127] plyr_1.8.9                  stringi_1.8.7               viridisLite_0.4.2
#> [130] BiocParallel_1.44.0         lazyeval_0.2.2              Matrix_1.7-4
#> [133] hms_1.1.4                   sesame_1.28.0               bit64_4.6.0-1
#> [136] ggplot2_4.0.0               KEGGREST_1.50.0             SummarizedExperiment_1.40.0
#> [139] kernlab_0.9-33              broom_1.0.10                memoise_2.0.1
#> [142] bslib_0.9.0                 bit_4.6.0
```

# Bibliography

Banovich, Nicholas E, Xun Lan, Graham McVicker, Bryce Van de Geijn, Jacob F Degner, John D Blischak, Julien Roux, Jonathan K Pritchard, and Yoav Gilad. 2014. “Methylation Qtls Are Associated with Coordinated Changes in Transcription Factor Binding, Histone Modifications, and Gene Expression Levels.” *PLoS Genetics* 10 (9).

Baranasic, Damir. 2022. *JASPAR2022: Data Package for Jaspar Database (Version 2022)*. <http://jaspar.genereg.net/>.

Boeva, Valentina. 2016. “Analysis of Genomic Sequence Motifs for Deciphering Transcription Factor Binding and Transcriptional Regulation in Eukaryotic Cells.” *Frontiers in Genetics* 7: 24.

Bonder, Marc Jan, René Luijk, Daria V Zhernakova, Matthijs Moed, Patrick Deelen, Martijn Vermaat, Maarten Van Iterson, et al. 2017. “Disease Variants Alter Transcription Factor Levels and Methylation of Their Binding Sites.” *Nature Genetics* 49 (1): 131.

Brodie, Aharon, Johnathan Roy Azaria, and Yanay Ofran. 2016. “How Far from the Snp May the Causative Genes Be?” *Nucleic Acids Research* 44 (13): 6046–54.

Castro-Mondragon, Jaime A, Rafael Riudavets-Puig, Ieva Rauluseviciute, Roza Berhanu Lemma, Laura Turchi, Romain Blanc-Mathieu, Jeremy Lucas, et al. 2021. “JASPAR 2022: the 9th release of the open-access database of transcription factor binding profiles.” *Nucleic Acids Research* 50 (D1): D165–D173. <https://doi.org/10.1093/nar/gkab1113>.

Chèneby, Jeanne, Zacharie Ménétrier, Martin Mestdagh, Thomas Rosnet, Allyssa Douida, Wassim Rhalloussi, Aurélie Bergon, Fabrice Lopez, and Benoit Ballester. 2019. “ReMap 2020: a database of regulatory regions from an integrative analysis of Human and Arabidopsis DNA-binding sequencing experiments.” *Nucleic Acids Research* 48 (D1): D180–D188. <https://doi.org/10.1093/nar/gkz945>.

Grossman, Sharon R, Jesse Engreitz, John P Ray, Tung H Nguyen, Nir Hacohen, and Eric S Lander. 2018. “Positional Specificity of Different Transcription Factor Classes Within Enhancers.” *Proceedings of the National Academy of Sciences* 115 (30): E7222–E7230.

Heinz, Sven, Christopher Benner, Nathanael Spann, Eric Bertolino, Yin C Lin, Peter Laslo, Jason X Cheng, Cornelis Murre, Harinder Singh, and Christopher K Glass. 2010. “Simple Combinations of Lineage-Determining Transcription Factors Prime Cis-Regulatory Elements Required for Macrophage and B Cell Identities.” *Molecular Cell* 38 (4): 576–89.

Leporcq, Clémentine, Yannick Spill, Delphine Balaramane, Christophe Toussaint, Michaël Weber, and Anaı̈s Flore Bardet. 2020. “TFmotifView: A Webserver for the Visualization of Transcription Factor Motifs in Genomic Regions.” *Nucleic Acids Research* 48 (W1): W208–W217.

Pennacchio, Len A, Wendy Bickmore, Ann Dean, Marcelo A Nobrega, and Gill Bejerano. 2013. “Enhancers: Five Essential Questions.” *Nature Reviews Genetics* 14 (4): 288–95.

Reese, Sarah E, Cheng-Jian Xu, T Herman, Mi Kyeong Lee, Sinjini Sikdar, Carlos Ruiz-Arenas, Simon K Merid, et al. 2019. “Epigenome-Wide Meta-Analysis of Dna Methylation and Childhood Asthma.” *Journal of Allergy and Clinical Immunology* 143 (6): 2062–74.

Schep, Alicia. 2020. *Motifmatchr: Fast Motif Matching in R*.

Silva, Tiago C, Simon G Coetzee, Nicole Gull, Lijing Yao, Dennis J Hazelett, Houtan Noushmehr, De-Chen Lin, and Benjamin P Berman. 2019. “ELMER V. 2: An R/Bioconductor Package to Reconstruct Gene Regulatory Networks from Dna Methylation and Transcriptome Profiles.” *Bioinformatics* 35 (11): 1974–7.

Wang, Mengchi, Kai Zhang, Vu Ngo, Chengyu Liu, Shicai Fan, John W Whitaker, Yue Chen, et al. 2019. “Identification of Dna Motifs That Regulate Dna Methylation.” *Nucleic Acids Research* 47 (13): 6753–68.

Williamson, Iain, Robert E Hill, and Wendy A Bickmore. 2011. “Enhancers: From Developmental Genetics to the Genetics of Common Human Disease.” *Developmental Cell* 21 (1): 17–19.

Yao, Lijing, Hui Shen, Peter W Laird, Peggy J Farnham, and Benjamin P Berman. 2015. “Inferring Regulatory Element Landscapes and Transcription Factor Networks from Cancer Methylomes.” *Genome Biology* 16 (1): 1–21.

Yin, Yimeng, Ekaterina Morgunova, Arttu Jolma, Eevi Kaasinen, Biswajyoti Sahu, Syed Khund-Sayeed, Pratyush K Das, et al. 2017. “Impact of Cytosine Methylation on Dna Binding Specificities of Human Transcription Factors.” *Science* 356 (6337).

Zhu, Heng, Guohua Wang, and Jiang Qian. 2016. “Transcription Factors as Readers and Effectors of Dna Methylation.” *Nature Reviews Genetics* 17 (9): 551–65.
# `chipenrich`: Gene Set Enrichment For ChIP-seq Peak Data

Ryan P. Welch, Chee Lee, Raymond G. Cavalcante, Chris Lee, Kai Wang, Laura J. Scott, Maureen A. Sartor

#### 2025-10-29

# Contents

* [1 Introduction](#introduction)
* [2 Concepts and Usage](#concepts-and-usage)
  + [2.1 Peaks](#peaks)
  + [2.2 Genomes](#genomes)
  + [2.3 Locus Definitions](#locus-definitions)
    - [2.3.1 Built-in locus definitions](#built-in-locus-definitions)
    - [2.3.2 Custom locus definitions](#custom-locus-definitions)
    - [2.3.3 Selecting a locus definition](#selecting-a-locus-definition)
  + [2.4 Gene Sets](#gene-sets)
    - [2.4.1 Built-in gene sets](#built-in-gene-sets)
    - [2.4.2 Custom gene sets](#custom-gene-sets)
  + [2.5 Mappability](#mappability)
    - [2.5.1 Built-in mappability](#built-in-mappability)
    - [2.5.2 Custom mappability](#custom-mappability)
  + [2.6 Testing for enrichment](#testing-for-enrichment)
    - [2.6.1 `broadenrich()`](#broadenrich)
    - [2.6.2 `chipenrich()`](#chipenrich)
    - [2.6.3 `polyenrich()`](#polyenrich)
    - [2.6.4 `hybridenrich()`](#hybridenrich)
    - [2.6.5 `proxReg()`](#proxreg)
  + [2.7 QC Plots](#qc-plots)
    - [2.7.1 Peak distance to TSS distribution](#peak-distance-to-tss-distribution)
    - [2.7.2 Presence of peak versus locus length](#presence-of-peak-versus-locus-length)
    - [2.7.3 Number of peaks versus locus length](#number-of-peaks-versus-locus-length)
    - [2.7.4 Gene coverage versus locus length](#gene-coverage-versus-locus-length)
  + [2.8 Output](#output)
    - [2.8.1 Assigned peaks](#assigned-peaks)
    - [2.8.2 Peaks-per-gene](#peaks-per-gene)
    - [2.8.3 Gene set enrichment results](#gene-set-enrichment-results)
  + [2.9 Assessing Type I Error with Randomizations](#assessing-type-i-error-with-randomizations)
* [3 References](#references)
* **Appendix**

# 1 Introduction

Gene set enrichment (GSE) testing enables the interpretation of lists of genes (e.g. from RNA-seq), or lists of genomic regions (e.g. from ChIP-seq), in terms of pathways and other biologically meaningful sets of genes. The `chipenrich` package is designed for GSE testing of large sets of genomic regions with different properties. The primary innovation of `chipenrich` is its accounting for biases that are known to affect the Type I error of such testing, and other properties of the data. It offers many options for gene set databases, and several other methods/options: tests for wide versus narrow genomic regions, a thousand versus > a million genomic regions, regions in promoters vs enhancers vs gene bodies, or accounting for the strength/score of each genomic region.

The `chipenrich` package includes different enrichment methods for different use cases:

* `broadenrich()` is designed for use with broad peaks that may intersect multiple gene loci, and cumulatively cover greater than 5% of the genome. For example, most ChIP-seq experiments for histone modifications.
* `chipenrich()` is designed for use with 1,000s or 10,000s of narrow genomic regions which results in a relatively small percent of genes being assigned a genomic region. For example, many ChIP-seq experiments for transcription factors.
* `polyenrich()` is also designed for narrow peaks, but for experiments with > ~50,000 genomic regions, or in cases where the number of binding sites per gene is thought to be important. If unsure whether to use chipenrich or polyenrich, then we recommend hybridenrich.
* `hybridenrich()` is used when one is unsure of which method, between ChIP-Enrich or Poly-Enrich, is the optimal method. It is slightly more conservative than either test for an individual gene set, but is usually more powerful overall.

We recommend using polyenrich(method=‘polyenrich-weighted’, multiAssign=TRUE, .) with any enhancer locus definition. See example below for more details.

# 2 Concepts and Usage

```
library(chipenrich)
```

```
##
```

```
##
```

```
##
```

```
##
```

```
##
```

Due to several required dependencies, installation may take some time if the dependencies are not already installed.

## 2.1 Peaks

A ChIP-seq peak is a genomic region that represents a transcription factor binding event or the presence of a histone complex with a particular histone modification. Typically peaks are called with a peak caller (such as [MACS2](https://github.com/taoliu/MACS) or [PePr](https://github.com/shawnzhangyx/PePr/)) and represent relative enrichment of reads in a sample where the antibody is present versus input. Typically, peaks are output by a peak caller in [`BED`-like](https://genome.ucsc.edu/FAQ/FAQformat.html) format.

User input for `chipenrich()`, `broadenrich()`, or `polyenrich()` may be peaks called from a ChIP-seq or ATAC-seq experiment or other large sets of genomic regions (e.g. from a family of repetitive elements or hydroxymethylation experiments) but we shall continue to refer to the input genomic regions as ‘peaks’ for simplicity. Peaks can be input as either a file path or a `data.frame`.

If a file path, the following formats are fully supported via their file extensions: `.bed`, `.broadPeak`, `.narrowPeak`, `.gff3`, `.gff2`, `.gff`, and `.bedGraph` or `.bdg`. BED3 through BED6 files are supported under the `.bed` extension ([BED specification](https://genome.ucsc.edu/FAQ/FAQformat.html)). Files without these extensions are supported under the conditions that the first 3 columns correspond to `chr`, `start`, and `end` and that there is either no header column, or it is commented out. Files may be compressed with `gzip`, and so might end in `.narrowPeak.gz`, for example. For files with extension support, the `rtracklayer::import()` function is used to read peaks, so adherence to the mentioned file formats is necessary.

If peaks are already in the R environment as a `data.frame`, the `GenomicRanges::makeGRangesFromDataFrame()` function is used to convert to a `GRanges` object. For the acceptable column names needed for correct interpretation, see `?GenomicRanges::makeGRangesFromDataFrame`.

For the purpose of the vignette, we’ll load some ChIP-seq peaks from the `chipenrich.data` companion package:

```
data(peaks_E2F4, package = 'chipenrich.data')
data(peaks_H3K4me3_GM12878, package = 'chipenrich.data')

head(peaks_E2F4)
```

```
##   chrom     start       end
## 1  chr1 156186314 156186469
## 2  chr1  10490456  10490550
## 3  chr1  46713352  46713436
## 4  chr1 226496843 226496924
## 5  chr1 200589825 200589928
## 6  chr1  47779789  47779907
```

```
head(peaks_H3K4me3_GM12878)
```

```
##   chrom    start      end
## 1 chr22 16846080 16871326
## 2 chr22 17305402 17306803
## 3 chr22 17517008 17517744
## 4 chr22 17518172 17518768
## 5 chr22 17518987 17520014
## 6 chr22 17520113 17520375
```

## 2.2 Genomes

Genomes for fly, human, mouse, rat, and zebrafish are supported. Particular supported genome builds are given by:

```
supported_genomes()
```

```
##  [1] "danRer10" "dm3"      "dm6"      "hg19"     "hg38"     "mm10"
##  [7] "mm9"      "rn4"      "rn5"      "rn6"
```

## 2.3 Locus Definitions

A gene locus definition is a way of defining the gene regulatory regions, and enables us to associate peaks with genes. The terms ‘gene regulatory region’ and ‘gene locus’ are used interchangeably in the vignette. An example is the ‘5kb’ gene locus definition, which assigns the 5000 bp immediately up- and down- stream of transcription start sites (TSS) to the respective gene. A locus definition can also express from where one expects a transcription factor or histone modification to regulate genes. For example, a locus definition defined as 1kb upstream and downstream of a TSS (the 1kb definition) would capture TFs binding in proximal-promoter regions.

### 2.3.1 Built-in locus definitions

A number of locus definitions representing different regulatory paradigms are included in the package:

* `nearest_tss`: The locus is the region spanning the midpoints between the TSSs of adjacent genes. Thus, each genomic region is assigned to the gene with the nearest TSS.
* `nearest_gene`: The locus is the region spanning the midpoints between the boundaries of each gene, where a gene is defined as the region between the furthest upstream TSS and furthest downstream TES for that gene. If gene loci overlap, the midpoint of the overlap is used as a border. If a gene locus is nested in another, the larger locus is split in two.
* `exon`: Each gene has multiple loci corresponding to its exons. Overlaps between different genes are allowed.
* `intron`: Each gene has multiple loci corresponding to its introns. Overlaps between different genes are allowed.
* `1kb`: The locus is the region within 1kb of any of the TSSs belonging to a gene. If TSSs from two adjacent genes are within 2 kb of each other, we use the midpoint between the two TSSs as the boundary for the locus for each gene.
* `1kb_outside_upstream`: The locus is the region more than 1kb upstream from a TSS to the midpoint between the adjacent TSS.
* `1kb_outside`: The locus is the region more than 1kb upstream or downstream from a TSS to the midpoint between the adjacent TSS.
* `5kb`: The locus is the region within 5kb of any of the TSSs belonging to a gene. If TSSs from two adjacent genes are within 10 kb of each other, we use the midpoint between the two TSSs as the boundary for the locus for each gene.
* `5kb_outside_upstream`: The locus is the region more than 5kb upstream from a TSS to the midpoint between the adjacent TSS.
* `5kb_outside`: The locus is the region more than 5kb upstream or downstream from a TSS to the midpoint between the adjacent TSS.
* `10kb`: The locus is the region within 10kb of any of the TSSs belonging to a gene. If TSSs from two adjacent genes are within 20 kb of each other, we use the midpoint between the two TSSs as the boundary for the locus for each gene.
* `10kb_outside_upstream`: The locus is the region more than 10kb upstream from a TSS to the midpoint between the adjacent TSS.
* `10kb_outside`: The locus is the region more than 10kb upstream or downstream from a TSS to the midpoint between the adjacent TSS.

The complete listing of genome build and locus definition pairs can be listed with `supported_locusdefs()`:

```
# Take head because it's long
head(supported_locusdefs())
```

```
##     genome              locusdef
## 1 danRer10                  10kb
## 2 danRer10          10kb_outside
## 3 danRer10 10kb_outside_upstream
## 4 danRer10                   1kb
## 5 danRer10           1kb_outside
## 6 danRer10  1kb_outside_upstream
```

### 2.3.2 Custom locus definitions

Users can create custom locus definitions for any of the `supported_genomes()`, and pass the file path as the value of the `locusdef` parameter in `broadenrich()`, `chipenrich()`, or `polyenrich()`. Custom locus definitions should be defined in a tab-delimited text file with column names `chr`, `start`, `end`, and `gene_id`. For example:

```
chr start   end geneid
chr1    839460  839610  148398
chr1    840040  840190  148398
chr1    840040  840190  57801
chr1    840800  840950  148398
chr1    841160  841310  148398
```

### 2.3.3 Selecting a locus definition

For a transcription factor ChIP-seq experiment, selecting a particular locus definition for use in enrichment testing implies how the TF is assumed to regulate genes. For example, selecting the `1kb` locus definition will imply that the biological processes found enriched are a result of TF regulation near the promoter. In contrast, selecting the `5kb_outside` locus definition will imply that the biological processes found enriched are a result of TF regulation distal from the promoter.

Selecting a locus definition can also help reduce the noise in the enrichment tests. For example, if a TF is known to primarily regulate genes by binding around the promoter, then selecting the `1kb` locus definition can help to reduce the noise from TSS-distal peaks in the enrichment testing.

The [`plot_dist_to_tss()` QC plot](#peak-distance-to-tss-distribution) displays where peak midpoints fall relative to TSSs genome-wide, and can help inform the choice of locus definition. For example, if many peaks fall far from the TSS, the `nearest_tss` locus definition may be a good choice because it will capture *all* peaks, whereas the `1kb` locus definition may not capture many of the peaks and adversely affect the enrichment testing.

## 2.4 Gene Sets

Gene sets are sets of genes that represent a particular biological function.

### 2.4.1 Built-in gene sets

Gene sets for fly, human, mouse, rat, and zebrafish are built in to `chipenrich`. Some organisms have gene sets that others do not, so check with:

```
# Take head because it's long
head(supported_genesets())
```

```
##     geneset organism
## 1      GOBP      dme
## 6      GOCC      dme
## 11     GOMF      dme
## 46 reactome      dme
## 2      GOBP      dre
## 7      GOCC      dre
```

Descriptions of our built-in gene sets:

* `GOBP`: Gene Ontology-Biological Processes, Bioconductor ver. 3.4.2. (<http://www.geneontology.org/>)
* `GOCC`: Gene Ontology-Cell Component, Bioconductor ver. 3.4.2. (geneontology.org)
* `GOMF`: Gene Ontology-Molecular Function, Bioconductor ver 3.4.2. (geneontology.org)
* `biocarta_pathway`: BioCarta Pathway, Ver 6.0. (cgap.nci.nih.gov/Pathways/BioCarta\_Pathways)
* `ctd`: Comparative Toxicogenomics Database, Last updated June 06, 2017. Groups of genes that interact with specific chemicals to help understand enviromental exposures that affect human health. (ctdbase.org)
* `cytoband`: Cytobands (NCBI). Groups of genes that reside in the same area of a chromosome.
* `drug_bank`: Sets of gene that are targeted by a specific drug. Ver 5.0.7. (www.drugbank.ca)
* `hallmark`: Hallmark gene sets (MSigDB). Ver 6.0. Specific biological states or processes that display coherent expression. (software.broadinstitute.org/gsea/msigdb/collections.jsp)
* `immunologic`: Immunologic signatures (MSigDB). Ver 6.0. Gene sets that represent cell states within the immune system. (software.broadinstitute.org/gsea/msigdb/collections.jsp)
* `kegg_pathway`: Kyoto Encyclopedia of Genes and Genomes. Ver 3.2.3. (genome.jp/kegg)
* `mesh`: Gene Annotation with MeSH, the National Library of Medicine’s controlled vocabulary for biology and medicine. Useful for testing hypotheses related to diseases, processes, other genes, confounders such as populations and experimental techniques, etc. based on knowledge from the literature that may not yet be formally described in any other gene sets. Last updated ~2013. (gene2mesh.ncibi.org)
* `metabolite`: Metabolite concepts, defined from Edinburgh Human Metabolic Network database (Ma, et al., 2007) Contains gene sets coding for metabolic enzymes that catalyze reactions involving the respective metabolite.
* `microrna`: microRNA targets (MSigDB). Ver 6.0. Gene sets containing genes with putative target sites of human mature miRNA. (software.broadinstitute.org/gsea/msigdb/collections.jsp)
* `oncogenic`: Oncogenic signatures (MSigDB). Ver 6.0. Gene sets that represent signatures of pathways often disregulated in cancer. (software.broadinstitute.org/gsea/msigdb/collections.jsp)
* `panther_pathway`: PANTHER Pathway. Ver 3.5. Contains primarily signaling pathways with subfamilies. (pantherdb.org/pathway)
* `pfam`: Pfam Ver 31.0 (March 2017). A large collection of protein families. (pfam.xfam.org)
* `protein_interaction_biogrid`: Protein Interaction from Biological General Repository for Interaction Datasets. Ver 3.4.151. (thebiogrid.org)
* `reactome`: Reactome Pathway Database. Ver 61. (reactome.org)
* `transcription_factors`: Transcription Factors (MSigDB). Ver 6.0. Gene sets that share upstream cis-regulatory motifs which can function as potential transcription factor binding sites. (software.broadinstitute.org/gsea/msigdb/collections.jsp)

### 2.4.2 Custom gene sets

Users can perform GSE on custom gene sets for any supported organism by passing the file path as the value of `genesets` parameter in `broadenrich()`, `chipenrich()`, `polyenrich()`, or `hybridenrich()`. Custom gene set definitions should be defined in a tab-delimited text file with a header. The first column should be the geneset ID or name, and the second column should be the Entrez IDs belonging to the geneset. For example:

```
gs_id   gene_id
GO:0006631  30
GO:0006631  31
GO:0006631  32
GO:0006631  33
GO:0006631  34
GO:0006631  35
GO:0006631  36
GO:0006631  37
GO:0006631  51
GO:0006631  131
GO:0006631  183
GO:0006631  207
GO:0006631  208
GO:0006631  215
GO:0006631  225
```

If a gene set from another database is in the form of a list with an array of genes (e.g. EGSEA PMID: 29333246), you can convert it into the neccessary form by the following and input the path directly to the `genesets` parameter. Note: Converting from R to text back to R is quite redundant and we are planning to be able to bypass this step.

```
library(EGSEAdata)
egsea.data("mouse")
temp = Mm.H #Or some other gene sets
geneset = do.call(rbind,lapply(1:length(temp), function(index) {data.frame(gs_id = rep(names(temp)[index], length(temp[[index]])),gene_id = unlist(strsplit(temp[[index]],split = " ")),stringsAsFactors = F)}))
write.table(geneset, "./custom_geneset.txt", quote=F, sep="\t",row.names = F, col.names = T)
```

## 2.5 Mappability

We define base pair mappability as the average read mappability of all possible reads of size K that encompass a specific base pair location, \(b\). Mappability files from UCSC Genome Browser mappability track were used to calculate base pair mappability. The mappability track provides values for theoretical read mappability, or the number of places in the genome that could be mapped by a read that begins with the base pair location \(b\). For example, a value of 1 indicates a Kmer read beginning at \(b\) is mappable to one area in the genome. A value of 0.5 indicates a Kmer read beginning at \(b\) is mappable to two areas in the genome. For our purposes, we are only interested in uniquely mappable reads; therefore, all reads with mappability less than 1 were set to 0 to indicate non-unique mappability. Then, base pair mappability is calculated as:

\[
\begin{equation}
M\_{i} = (\frac{1}{2K-1}) \sum\_{j=i-K+1}^{i+(K-1)} M\_{j}
\end{equation}
\]

where \(M\_{i}\) is the mappability of base pair \(i\), and \(M\_{j}\) is mappability (from UCSC’s mappability track) of read \(j\) where j is the start position of the K length read.

### 2.5.1 Built-in mappability

Base pair mappability for reads of lengths 24, 36, 40, 50, 75, and 100 base pairs for `hg19` and for reads of lengths 36, 40, 50, 75, and 100 base pairs `mm9` a included. See the complete list with:

```
# Take head because it's long
head(supported_read_lengths())
```

```
##   genome locusdef read_length
## 1   hg19     10kb         100
## 2   hg19     10kb          24
## 3   hg19     10kb          36
## 4   hg19     10kb          40
## 5   hg19     10kb          50
## 6   hg19     10kb          75
```

### 2.5.2 Custom mappability

Users can use custom mappability with any built-in locus definition (if, for example, the read length needed is not present), or with a custom locus definition. Custom mappability should be defined in a tab-delimited text file with columns named `gene_id` and `mappa`. Gene IDs should be Entrez Gene IDs, and mappability should be in [0,1]. A check is performed to verify that the gene IDs in the locus definition and mappability overlap by at least 95%. An example custom mappability file looks like:

```
mappa   gene_id
0.8 8487
0.1 84
0.6 91
1   1000
```

## 2.6 Testing for enrichment

As stated in the introduction, the `chipenrich` package includes three classes of methods for doing GSE testing. For each method, we describe the intended use case, the model used for enrichment, and an example using the method.

### 2.6.1 `broadenrich()`

Broad-Enrich is designed for use with broad peaks that may intersect multiple gene loci, and/or cumulatively cover greater than 5% of the genome. For example, ChIP-seq experiments for histone modifications or large sets of copy number alterations.

The Broad-Enrich method uses the cumulative peak coverage of genes in its logistic regression model for enrichment: `GO ~ ratio + s(log10_length)`. Here, `GO` is a binary vector indicating whether a gene is in the gene set being tested, `ratio` is a numeric vector indicating the ratio of the gene covered by peaks, and `s(log10_length)` is a binomial cubic smoothing spline which adjusts for the relationship between gene coverage and locus length.

```
gs_path = system.file('extdata','vignette_genesets.txt', package='chipenrich')
results = broadenrich(peaks = peaks_H3K4me3_GM12878, genome = 'hg19', genesets = gs_path, locusdef = "nearest_tss", qc_plots = FALSE, out_name = NULL, n_cores=1)
results.be = results$results
print(results.be[1:5,1:5])
```

```
##    Geneset.Type Geneset.ID Description      P.value          FDR
## 1 user-supplied GO:0002521  GO:0002521 9.600908e-06 8.000756e-05
## 2 user-supplied GO:0031400  GO:0031400 7.564088e-05 4.727555e-04
## 3 user-supplied GO:0022411  GO:0022411 1.775843e-04 8.879214e-04
## 4 user-supplied GO:0071845  GO:0071845 6.040129e-04 1.888373e-03
## 5 user-supplied GO:0022604  GO:0022604 3.868645e-03 9.671612e-03
```

### 2.6.2 `chipenrich()`

ChIP-Enrich is designed for use with 1,000s or 10,000s of narrow genomic regions which results in a relatively small percent of genes being assigned a genomic region. For example, many ChIP-seq experiments for transcription factors.

The ChIP-Enrich method uses the presence of a peak in its logistic regression model for enrichment: `peak ~ GO + s(log10_length)`. Here, `GO` is a binary vector indicating whether a gene is in the gene set being tested, `peak` is a binary vector indicating the presence of a peak in a gene, and `s(log10_length)` is a binomial cubic smoothing spline which adjusts for the relationship between the presence of a peak and locus length.

```
# Without mappability
gs_path = system.file('extdata','vignette_genesets.txt', package='chipenrich')
results = chipenrich(peaks = peaks_E2F4, genome = 'hg19', genesets = gs_path,locusdef = "nearest_tss", qc_plots = FALSE, out_name = NULL, n_cores = 1)
results.ce = results$results
print(results.ce[1:5,1:5])
```

```
##    Geneset.Type Geneset.ID Description      P.value          FDR
## 1 user-supplied GO:0034660  GO:0034660 5.435777e-05 0.0004529814
## 2 user-supplied GO:0007346  GO:0007346 8.592104e-05 0.0005370065
## 3 user-supplied GO:0031400  GO:0031400 1.164884e-03 0.0058244176
## 4 user-supplied GO:0009314  GO:0009314 2.166075e-02 0.0676898435
## 5 user-supplied GO:0051129  GO:0051129 1.196240e-01 0.2718727018
```

```
# With mappability
gs_path = system.file('extdata','vignette_genesets.txt', package='chipenrich')
results = chipenrich(peaks = peaks_E2F4, genome = 'hg19', genesets = gs_path, locusdef = "nearest_tss", mappability=24, qc_plots = FALSE,out_name = NULL,n_cores=1)
results.cem = results$results
print(results.cem[1:5,1:5])
```

```
##    Geneset.Type Geneset.ID Description      P.value          FDR
## 1 user-supplied GO:0034660  GO:0034660 4.552997e-05 0.0003794164
## 2 user-supplied GO:0007346  GO:0007346 7.076743e-05 0.0004422965
## 3 user-supplied GO:0031400  GO:0031400 1.045192e-03 0.0052259579
## 4 user-supplied GO:0009314  GO:0009314 2.358027e-02 0.0736883370
## 5 user-supplied GO:0043623  GO:0043623 1.125058e-01 0.2412736564
```

### 2.6.3 `polyenrich()`

Poly-Enrich is also designed for narrow peaks, for experiments with 100,000s of peaks, or in cases where the number of binding sites per gene affects its regulation. If unsure whether to use chipenrich or polyenrich, then we recommend hybridenrich.

The Poly-Enrich method uses the number of peaks in genes in its negative binomial regression model for enrichment: `num_peaks ~ GO + s(log10_length)`. Here, `GO` is a binary vector indicating whether a gene is in the gene set being tested, `num_peaks` is a numeric vector indicating the number of peaks in each gene, and `s(log10_length)` is a negative binomial cubic smoothing spline which adjusts for the relationship between the number of peaks in a gene and locus length.

```
gs_path = system.file('extdata','vignette_genesets.txt', package='chipenrich')
results = polyenrich(peaks = peaks_E2F4, genome = 'hg19', genesets = gs_path, method = 'polyenrich', locusdef = "nearest_tss", qc_plots = FALSE, out_name = NULL, n_cores = 1)
results.pe = results$results
print(results.pe[1:5,1:5])
```

```
##    Geneset.Type Geneset.ID Description      P.value          FDR
## 1 user-supplied GO:0007346  GO:0007346 0.0001062920 0.0008857671
## 2 user-supplied GO:0031400  GO:0031400 0.0006436043 0.0032180217
## 3 user-supplied GO:0009314  GO:0009314 0.0018988370 0.0079118209
## 4 user-supplied GO:0051129  GO:0051129 0.1471393500 0.4309134129
## 5 user-supplied GO:0043623  GO:0043623 0.2068384382 0.4309134129
```

Poly-Enrich can also be used for linking human distal enhancer regions to their target genes, which are not necessarily the adjacent genes. We optimized human distal enhancer to target gene locus definitions (locusdef=“enhancer” or locusdef=“enhancer\_plus5kb”). locusdef=“enhancer” uses only distal regions >5kb from a TSS, while locusdef=“enhancer\_plus5kb” combines distal enhancers (>5kb from a TSS) with promoters (<=5kb from a TSS) to capture all genomic regions. Poly-Enrich is strongly recommended when using either the ‘enhancer’ or ‘enhancer\_plus5kb’ gene locus definition, because only polyenrich is able to properly split the weight of genomic regions that are assigned to multiple genes (multiAssign=TRUE). The performance of Poly-Enrich using the enhancer locusdefs can be found in our recent study (details in reference 5). Like chipenrich, polyenrich is designed for narrow peaks, but for experiments with > ~50,000 genomic regions, or in cases where the number of binding sites per gene is thought to be important.

Poly-Enrich also allows weighting of individual genomic regions based on a score, which can be useful for differential methylation enrichment analysis and ChIP-seq. Currently the options are: `signalValue` and `logsignalValue`. `signalValue` weighs each genomic region or peak based on the Signal Value given in the narrowPeak format or a user-supplied column (column name should be `signalValue`), while `logsignalValue` takes the log of these values. To use weighted Poly-Enrich, use method = `polyenrich_weighted`. When using the `enhancer` or `enhancer_plus5kb` locus definition, we recommend selecting the `polyenrich_weighted` method, which in this case will automatically set multiAssign as `TRUE`.

```
gs_path = system.file('extdata','vignette_genesets.txt', package='chipenrich')
results = polyenrich(peaks = peaks_E2F4, genome = 'hg19', genesets = gs_path, method="polyenrich_weighted", locusdef = "enhancer_plus5kb", qc_plots = FALSE, out_name = NULL, n_cores = 1)
results.pe = results$results
print(results.pe[1:5,1:5])
```

```
##    Geneset.Type Geneset.ID Description      P.value          FDR
## 1 user-supplied GO:0007346  GO:0007346 2.092665e-05 0.0001743888
## 2 user-supplied GO:0031400  GO:0031400 6.961091e-04 0.0034805456
## 3 user-supplied GO:0009314  GO:0009314 1.254251e-03 0.0052260469
## 4 user-supplied GO:0034660  GO:0034660 1.003133e-01 0.2786481244
## 5 user-supplied GO:0051129  GO:0051129 1.413485e-01 0.3533713630
```

### 2.6.4 `hybridenrich()`

The hybrid method is used when one is unsure of which method, between ChIP-Enrich or Poly-Enrich, is the optimal method, and the most statistically powerful results are desired for each gene set. The runtime for this method, however, is ~2X that of the others.

The hybrid p-value is given as `2*min(chipenrich_pvalue, polyenrich_pvalue)`. This test will retain the same Type 1 level and will be a consistent test if one of chipenrich or polyenrich is consistent. This can be extended to any number of tests, but currently we only allow a hybrid test for chipenrich and polyenrich. For more information about chipenrich or polyenrich, see their respective sections.

```
gs_path = system.file('extdata','vignette_genesets.txt', package='chipenrich')
results = hybridenrich(peaks = peaks_E2F4, genome = 'hg19', genesets = gs_path, locusdef = "nearest_tss", qc_plots = F, out_name = NULL, n_cores = 1)
results.hybrid = results$results
print(results.hybrid[1:5,1:5])
```

```
##   Geneset.ID  Geneset.Type Description          FDR     Effect
## 1 GO:0001558 user-supplied  GO:0001558 3.910701e-01 -0.1554272
## 2 GO:0002521 user-supplied  GO:0002521 2.869857e-01 -0.1787083
## 3 GO:0003013 user-supplied  GO:0003013 5.871998e-07 -0.6905978
## 4 GO:0006631 user-supplied  GO:0006631 3.910701e-01 -0.1429443
## 5 GO:0007346 user-supplied  GO:0007346 5.370065e-04  0.4998322
```

### 2.6.5 `proxReg()`

The proximity to regulatory regions (proxReg) test is a complementary test to any gene set enrichment test on a set of genomic regions, not just exclusive to the methods in this package. It tests if the genomic regions tend to be closer to (or farther from) gene transcription start sites or enhancer regions in each gene set tested. Currently, testing proximity to enhancer regions is only compatible with the hg19 genome. The purpose of ProxReg is to provide additional information for interpreting gene set enrichment test results, as a gene set enrichment test alone does not give information about whether the genomic regions occur near promoter or enhancer regions.

ProxReg first calculates the distance between the midpoints of peaks and the nearest transcription start site or the nearest enhancer region midpoint for each genomic region. Each genomic region is then assigned to the gene with the nearest transcription start site. The distances are then classified according to whether the gene is in the gene set or not, and a signed Wilcoxon rank-sum test is used to calculate if the regions are closer or farther in the gene set than average.

```
gs_path = system.file('extdata','vignette_genesets.txt', package='chipenrich')
results.prox = proxReg(peaks_E2F4, reglocation = 'tss', genome = 'hg19', genesets=gs_path, out_name=NULL)
results.prox = results.prox$results
print(results.prox[1:5,1:7])
```

```
##    Geneset.Type Geneset.ID Description      P.value         FDR    Effect
## 1 user-supplied GO:0048568  GO:0048568 0.0000669118 0.001060050 -3.987008
## 2 user-supplied GO:0008015  GO:0008015 0.0000933957 0.001060050 -3.907138
## 3 user-supplied GO:0003013  GO:0003013 0.0001272060 0.001060050 -3.831806
## 4 user-supplied GO:0048545  GO:0048545 0.0016805216 0.006001863 -3.141557
## 5 user-supplied GO:0007517  GO:0007517 0.0022661465 0.007081708 -3.052935
##    Status
## 1 farther
## 2 farther
## 3 farther
## 4 farther
## 5 farther
```

## 2.7 QC Plots

Each enrich function outputs QC plots if `qc_plots = TRUE`. There are also stand-alone functions to make the QC plots without the need for GSE testing. The QC plots can be used to help determine which locus definition to use, or which enrichment method is more appropriate.

### 2.7.1 Peak distance to TSS distribution

This plot gives a distribution of the distance of the peak midpoints to the TSSs. It can help in [selecting a locus definition](#selecting-a-locus-definition). For example, if genes are primarily within 5kb of TSSs, then the `5kb` locus definition may be a good choice. In contrast, if most genes fall far from TSSs, the `nearest_tss` locus definition may be a good choice.

```
# Output in chipenrich and polyenrich
plot_dist_to_tss(peaks = peaks_E2F4, genome = 'hg19')
```

![E2F4 peak distances to TSS](data:image/png;base64...)

Figure 1: E2F4 peak distances to TSS

### 2.7.2 Presence of peak versus locus length

This plot visualizes the relationship between the presence of at least one peak in a gene locus and the locus length (on the log10 scale). For clarity of visualization, each point represents 25 gene loci binned after sorting by locus length. The expected fit under the assumptions of Fisher’s Exact Test (horizontal line), and a binomial-based test (gray curve) are displayed to indicate how the dataset being enriched conforms to the assumption of each. The empirical spline used in the `chipenrich` method is in orange.

```
# Output in chipenrich
plot_chipenrich_spline(peaks = peaks_E2F4, locusdef = 'nearest_tss', genome = 'hg19')
```

![E2F4 chipenrich spline without mappability](data:image/png;base64...)

Figure 2: E2F4 chipenrich spline without mappability

### 2.7.3 Number of peaks versus locus length

This plot visualizes the relationship between the number of peaks assigned to a gene and the locus length (on the log10 scale). For clarity of visualization, each point represents 25 gene loci binned after sorting by locus length. The empirical spline used in the `polyenrich` method is in orange.

If many gene loci have multiple peaks assigned to them, `polyenrich` is likely an appropriate method. If there are a low number of peaks per gene, then `chipenrich()` may be the appropriate method.

```
# Output in polyenrich
plot_polyenrich_spline(peaks = peaks_E2F4, locusdef = 'nearest_tss', genome = 'hg19')
```

![E2F4 polyenrich spline without mappability](data:image/png;base64...)

Figure 3: E2F4 polyenrich spline without mappability

### 2.7.4 Gene coverage versus locus length

This plot visualizes the relationship between proportion of the gene locus covered by peaks and the locus length (on the log10 scale). For clarity of visualization, each point represents 25 gene loci binned after sorting by locus length.

```
# Output in broadenrich
plot_gene_coverage(peaks = peaks_H3K4me3_GM12878, locusdef = 'nearest_tss',  genome = 'hg19')
```

![H3K4me3 gene coverage](data:image/png;base64...)

Figure 4: H3K4me3 gene coverage

## 2.8 Output

The output of `broadenrich()`, `chipenrich()`, and `polyenrich()` is a list with components corresponding to each section below. If `out_name` is not `NULL`, then a file for each component will be written to the `out_path` with prefixes of `out_name`.

### 2.8.1 Assigned peaks

Peak assignments are stored in `$peaks`. This is a peak-level summary. Each line corresponds to a peak intersecting a particular gene locus defined in the selected locus definition. In the case of `broadenrich()` peaks may be assigned to multiple gene loci. Doing `table()` on the `peak_id` column will indicate how many genes are assigned to each peak.

```
head(results$peaks)
```

```
##   peak_id  chr peak_start peak_end gene_id gene_symbol gene_locus_start
## 1  peak:1 chr1     816846   816937  284593      FAM41C           787681
## 2  peak:2 chr1     859131   859258  148398      SAMD11           836357
## 3  peak:3 chr1     877208   877306  148398      SAMD11           836357
## 4  peak:4 chr1     895928   896050  339451      KLHL17           895324
## 5  peak:5 chr1     968519   968706  375790        AGRN           952176
## 6  peak:6 chr1     968678   968804  375790        AGRN           952176
##   gene_locus_end nearest_tss dist_to_tss nearest_tss_gene_id nearest_tss_symbol
## 1         836356      812182       -4708              284593             FAM41C
## 2         879482      860530       -1335              148398             SAMD11
## 3         879482      876524         732              148398             SAMD11
## 4         899806      895967          21              339451             KLHL17
## 5         982595      955503       13108              375790               AGRN
## 6         982595      955503       13237              375790               AGRN
##   nearest_tss_gene_strand
## 1                       -
## 2                       +
## 3                       +
## 4                       +
## 5                       +
## 6                       +
```

### 2.8.2 Peaks-per-gene

Peak information aggregated over gene loci is stored in `$peaks_per_gene`. This is a gene-level summary. Each line corresponds to aggregated peak information over the `gene_id` such as the number of peaks assigned to the gene locus or the ratio of the gene locus covered in the case of `broadenrich()`.

```
head(results$peaks_per_gene)
```

```
##       gene_id  length log10_length num_peaks peak
## 15687  144245 2469903     6.392680        21    1
## 19908  643955 2785792     6.444949        18    1
## 15550  139886 2421902     6.384157        14    1
## 18040  340441 2378457     6.376295        13    1
## 19970  645367 1508636     6.178585        13    1
## 13906   84920 2558900     6.408053        12    1
```

### 2.8.3 Gene set enrichment results

GSE results are stored in `$results`. For convenience, gene set descriptions are provided in addition to the gene set ID (which is the same as the ID from the originating database). The `Status` column takes values of `enriched` if the `Effect` is > 0 and `depleted` if < 0, with `enriched` results being of primary importance. Finally, the `Geneset.Peak.Genes` column gives a list of gene IDs that had signal contributing to the test for enrichment. This list can be used to cross reference information from `$peaks` or `$peaks_per_gene` if desired.

```
head(results$results)
```

```
##   Geneset.ID  Geneset.Type Description          FDR      Effect Odds.Ratio
## 1 GO:0001558 user-supplied  GO:0001558 3.910701e-01 -0.15542715  0.8560494
## 2 GO:0002521 user-supplied  GO:0002521 2.869857e-01 -0.17870830  0.8363498
## 3 GO:0003013 user-supplied  GO:0003013 5.871998e-07 -0.69059775  0.5012763
## 4 GO:0006631 user-supplied  GO:0006631 3.910701e-01 -0.14294430  0.8668023
## 5 GO:0007346 user-supplied  GO:0007346 5.370065e-04  0.49983219  1.6484446
## 6 GO:0007517 user-supplied  GO:0007517 5.301420e-01 -0.09772304  0.9069000
##   N.Geneset.Genes N.Geneset.Peak.Genes Geneset.Avg.Gene.Length
## 1             275                  140                172092.6
## 2             295                  147                146430.3
## 3             298                  118                151568.7
## 4             282                  137                115786.5
## 5             296                  186                117903.1
## 6             294                  159                192436.3
##                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             Geneset.Peak.Genes
## 1                                                                                                                                                                                                                                                                             6595, 79960, 55602, 3490, 10718, 51232, 1026, 1029, 1031, 6195, 51176, 53335, 81621, 323, 817, 3621, 7481, 8877, 9166, 9792, 221937, 185, 596, 1630, 2023, 2137, 2395, 2810, 3084, 3624, 4009, 4089, 4897, 5468, 5607, 5931, 6494, 6597, 6695, 6794, 7143, 8408, 8692, 8835, 9344, 9353, 9564, 10276, 11007, 22850, 23411, 54512, 54825, 54879, 57142, 64061, 81501, 118611, 131566, 102, 153, 659, 694, 984, 1027, 1032, 1154, 1490, 1491, 1594, 1601, 2033, 2147, 2247, 2273, 2305, 2487, 3984, 4487, 5048, 5167, 5393, 5538, 5795, 5925, 6259, 6422, 6423, 6868, 7040, 7042, 7046, 7251, 7473, 8425, 8482, 8725, 8840, 9423, 9538, 9826, 10201, 10399, 10459, 10488, 10507, 10668, 11054, 11082, 11108, 11344, 23394, 23404, 26153, 27000, 27346, 29882, 29946, 51079, 51193, 51293, 51330, 51379, 51447, 53834, 55035, 56994, 57446, 57611, 64321, 65981, 81565, 84162, 85004, 91584, 112398, 150465, 340152, 343472, 728642
## 2                                                                                                                                                                                                                                                                           677, 5293, 9308, 641, 3398, 6670, 55636, 1029, 1054, 2625, 3725, 3726, 5578, 5897, 9734, 51176, 53335, 441478, 355, 639, 1432, 1499, 1794, 2778, 3707, 4067, 6469, 6659, 6722, 6929, 7048, 8767, 9846, 10766, 64919, 596, 652, 814, 861, 863, 1316, 1958, 2101, 3566, 3575, 3593, 3600, 3624, 3659, 3662, 3665, 3676, 3976, 4254, 4602, 4609, 4627, 5153, 5336, 5468, 6776, 7037, 7163, 7422, 8320, 8600, 8792, 9290, 9611, 10272, 10320, 10892, 22806, 23598, 27434, 64421, 79840, 81501, 84807, 133522, 100, 101, 301, 472, 912, 939, 942, 959, 1050, 1147, 1236, 1588, 2302, 3087, 3135, 3428, 3440, 3658, 3815, 4066, 4436, 4860, 5138, 5316, 5590, 5591, 5663, 5664, 5734, 5914, 6146, 6422, 6689, 6693, 6777, 6850, 6868, 7001, 7040, 7189, 7294, 7471, 7518, 7855, 8324, 8326, 8546, 8943, 9092, 9093, 9370, 9607, 9655, 9759, 10014, 10202, 10370, 10537, 27086, 28962, 29760, 63976, 80762, 84524, 149233, 159296, 171392
## 3                                                                                                                                                                                                                                                                                                                                                                                                                                                                              284, 476, 3398, 23493, 55636, 777, 947, 6714, 6772, 133, 240, 817, 1268, 2296, 2729, 4092, 5606, 6262, 6671, 8913, 23576, 143282, 156, 185, 1727, 1907, 1909, 2034, 2035, 2643, 2730, 3212, 3383, 3757, 4090, 5125, 5468, 5604, 6717, 7422, 8195, 9353, 10242, 10539, 26509, 27345, 154796, 70, 100, 128, 135, 136, 140, 147, 148, 151, 153, 659, 857, 875, 1482, 1490, 1636, 1814, 1816, 1889, 2006, 2053, 2548, 3162, 3356, 3363, 3753, 3768, 3784, 3827, 4205, 4635, 4852, 4880, 4882, 5025, 5028, 5037, 5138, 5290, 5443, 5465, 5608, 5664, 5742, 5743, 5795, 5797, 5973, 6051, 6331, 6532, 6648, 6846, 7042, 7068, 7168, 8509, 8654, 8870, 9370, 9474, 9607, 9759, 10159, 10659, 10800, 51752, 57085, 57493, 91807, 121643
## 4                                                                                                                                                                                                                                                                                             3638, 5828, 51099, 9444, 9451, 31, 240, 1268, 2181, 2194, 3667, 7306, 9415, 51141, 51144, 55437, 60481, 81617, 219743, 246, 1907, 2180, 2693, 3033, 3988, 3995, 4594, 4644, 5096, 5321, 5468, 5564, 6307, 6622, 6776, 6794, 6916, 7132, 9023, 9261, 9524, 10891, 10998, 11000, 11343, 23411, 23600, 51084, 51422, 51719, 54363, 55268, 57678, 64174, 81616, 123099, 142827, 197322, 285440, 34, 241, 301, 341, 672, 857, 1376, 1632, 1738, 1892, 2205, 2475, 2639, 2687, 2690, 3032, 3248, 3992, 4056, 4258, 4282, 5095, 5191, 5264, 5465, 5562, 5565, 5571, 5740, 5742, 5743, 5825, 6051, 6309, 6777, 6850, 7291, 7915, 8560, 8605, 8660, 9370, 10062, 10449, 10455, 10728, 10999, 11001, 11332, 23175, 23659, 26027, 26063, 27349, 50640, 51094, 51179, 51495, 54995, 57140, 58526, 59344, 64834, 65985, 79071, 79602, 79993, 80142, 83401, 84188, 84869, 84909, 92335, 122970, 126129, 137964, 348158, 401494
## 5 3398, 5569, 5586, 9184, 55159, 415116, 1026, 1029, 3265, 5578, 5727, 150094, 323, 996, 1111, 2296, 3146, 4091, 6659, 7314, 8451, 8621, 8626, 8877, 9099, 10296, 10950, 23026, 29117, 55023, 57026, 79791, 351, 595, 596, 598, 652, 655, 675, 699, 835, 994, 995, 1104, 1869, 1977, 1978, 3275, 4085, 4609, 5300, 5311, 5347, 5682, 5689, 5690, 5698, 5709, 5713, 6233, 6597, 6776, 6790, 7153, 7161, 7324, 8091, 8318, 8379, 8558, 8881, 9735, 9787, 10783, 23137, 23326, 23411, 23476, 23513, 26271, 26574, 27085, 54623, 55743, 56475, 63967, 64326, 80895, 81620, 90381, 118611, 332, 472, 701, 890, 891, 900, 983, 990, 991, 1017, 1027, 1063, 1263, 1540, 1613, 1761, 1814, 1877, 2273, 2290, 3364, 3553, 3643, 4193, 4751, 5037, 5048, 5119, 5424, 5684, 5686, 5702, 5704, 5707, 5708, 5711, 5714, 5715, 5717, 5718, 5728, 5883, 5925, 6777, 7013, 7040, 7175, 7272, 7311, 7321, 7480, 8697, 8883, 9088, 9183, 9491, 9585, 9587, 9700, 10201, 10213, 10361, 10393, 10459, 10537, 11065, 11130, 22974, 23087, 25906, 26013, 29882, 29945, 51143, 51203, 51379, 51433, 51499, 51512, 51529, 54443, 54962, 54998, 55022, 55055, 55367, 55726, 64682, 79027, 79577, 140609, 143471, 286053, 340152, 340533
## 6                                                                                                                                                                              4154, 463, 1756, 4208, 6662, 7026, 23493, 2254, 4851, 7402, 9734, 10277, 23236, 51176, 150094, 650, 1960, 2296, 2317, 3146, 4061, 4092, 6469, 6497, 6498, 6899, 6938, 7049, 9099, 54583, 57496, 221937, 375790, 43, 351, 596, 652, 668, 1489, 2010, 2263, 3084, 3110, 3756, 3976, 4618, 4627, 4654, 4763, 5457, 5463, 6256, 6334, 6495, 6525, 6717, 7273, 7472, 9149, 9242, 9421, 9750, 23024, 23411, 26281, 55692, 55796, 120892, 126272, 221496, 58, 70, 153, 387, 445, 694, 783, 857, 891, 983, 1063, 1103, 1271, 1282, 1293, 1301, 1310, 1482, 1508, 1634, 1855, 2033, 2066, 2247, 2273, 2280, 2548, 2627, 2660, 2817, 4038, 4205, 4209, 4487, 4635, 4637, 4638, 4703, 4804, 5307, 5530, 6272, 6300, 6442, 6443, 6444, 6939, 7040, 7168, 7291, 7471, 7480, 8038, 8407, 8531, 9093, 9241, 9456, 9759, 9794, 10014, 10472, 10869, 10939, 22801, 22808, 23414, 23592, 26263, 27086, 50804, 53834, 55898, 56704, 57462, 60485, 60529, 64321, 84159, 84466, 84976, 91653, 140578, 146862, 163126, 221662, 283078, 284358, 347273
##      P.value.x Status.x    P.value.y Status.y P.value.Hybrid   FDR.Hybrid
## 1 2.275696e-01 depleted 2.062403e-01 depleted   4.124805e-01 0.6445007871
## 2 1.492326e-01 depleted 3.728343e-01 enriched   2.984651e-01 0.5739714273
## 3 4.697598e-08 depleted 1.437417e-06 depleted   9.395197e-08 0.0000011744
## 4 2.566339e-01 depleted 1.660788e-01 depleted   3.321575e-01 0.5931384576
## 5 8.592104e-05 enriched 1.062920e-04 enriched   1.718421e-04 0.0010740130
## 6 4.360419e-01 depleted 4.163423e-01 depleted   8.326846e-01 0.9462325323
##   Status.Hybrid
## 1      depleted
## 2  Inconsistent
## 3      depleted
## 4      depleted
## 5      enriched
## 6      depleted
```

## 2.9 Assessing Type I Error with Randomizations

Randomization of locus definitions allows for the assessment of Type I Error under the null hypothesis of no true gene set enrichment. A well-calibrated Type I Error means that the false positive rate is controlled, and the p-values reported for actual data can be trusted. In both Welch & Lee, et al. and Cavalcante, et al., we demonstrated that both `chipenrich()` and `broadenrich()` have well-calibrated Type I Error over dozens of publicly available ENCODE ChIP-seq datasets. Unpublished data suggests the same is true for `polyenrich()`.

Within `chipenrich()`, `broadenrich()`, and `polyenrich()`, the `randomization` parameters can be used to assess the Type I Error for the data being analyzed.

The randomization codes, and their effects are:

* `NULL`: No randomizations, the default.
* `complete`: Shuffle the `gene_id` and `symbol` columns of the `locusdef` together, without regard for the chromosome location, or locus length. The null hypothesis is that there is no true gene set enrichment.
* `bylength`: Shuffle the `gene_id` and `symbol` columns of the `locusdef` together, within bins of 100 genes sorted by locus length. The null hypothesis is that there is no true gene set enrichment, but with preserved locus length relationship.
* `bylocation`: Shuffle the `gene_id` and `symbol` columns of the `locusdef` together, within bins of 50 genes sorted by genomic location. The null hypothesis is that there is no true gene set enrichment, but with preserved genomic location.

The return value of `chipenrich()`, `broadenrich()`, or `polyenrich()` with a selected randomization is the same list object described above. To assess the Type I error, the `alpha` level for the particular data set can be calculated by dividing the total number of gene sets with p-value < `alpha` by the total number of tests tested. Users may want to perform multiple randomizations for a set of peaks and take the median of the `alpha` values.

```
# Assessing if alpha = 0.05
gs_path = system.file('extdata','vignette_genesets.txt', package='chipenrich')
results = chipenrich(peaks = peaks_E2F4, genome = 'hg19', genesets = gs_path,
    locusdef = "nearest_tss", qc_plots = FALSE, randomization = 'complete',
    out_name = NULL, n_cores = 1)
alpha = sum(results$results$P.value < 0.05) / nrow(results$results)
# NOTE: This is for
print(alpha)
```

```
## [1] 0.04
```

# 3 References

# Appendix

1. R.P. Welch^, C. Lee^, R.A. Smith, P. Imbriano, S. Patil, T. Weymouth, L.J. Scott, M.A. Sartor. “ChIP-Enrich: gene set enrichment testing for ChIP-seq data.” Nucl. Acids Res. (2014) 42(13):e105. [doi:10.1093/nar/gku463](https://academic.oup.com/nar/article-lookup/doi/10.1093/nar/gku463)
2. R.G. Cavalcante, C. Lee, R.P. Welch, S. Patil, T. Weymouth, L.J. Scott, and M.A. Sartor. “Broad-Enrich: functional interpretation of large sets of broad genomic regions.” Bioinformatics (2014) 30(17):i393-i400 [doi:10.1093/bioinformatics/btu444](https://academic.oup.com/bioinformatics/article-lookup/doi/10.1093/bioinformatics/btu444)
3. C.T. Lee , R.G. Cavalcante, C. Lee, T. Qin, S. Patil, S. Wang, Z. Tsai, A.P. Boyle, M.A. Sartor. “Poly-Enrich: Count-based Methods for Gene Set Enrichment Testing with Genomic Regions.” NAR genomics and bioinformatics 2.1 (2020): lqaa006. [doi.org/10.1093/nargab/lqaa006](https://academic.oup.com/nargab/article/2/1/lqaa006/5728474)
4. C.T. Lee, K. Wang, T. Qin, M.A. Sartor. “Testing proximity of genomic regions to transcription start sites and enhancers complements gene set enrichment testing.” Frontiers in genetics 11 (2020): 199. [doi.org/10.3389/fgene.2020.00199](https://www.frontiersin.org/articles/10.3389/fgene.2020.00199/full)
5. T. Qin, C.T. Lee, R.G. Cavalcante, P. Orchard, H. Yao, H. Zhang, S. Wang, S. Patil, A.P. Boyle, M.A. Sartor, “Comprehensive enhancer-target gene assignments improve gene set level interpretation of genome-wide regulatory data.” (2020) bioRxiv. [doi.org/10.1101/2020.10.22.351049](https://www.biorxiv.org/content/10.1101/2020.10.22.351049v1)
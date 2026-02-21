# Prime Editing

Aditya M Bhagwat

#### 2025-10-30

# Contents

* [1 Background](#background)
* [2 Multicrispr](#multicrispr)
  + [2.1 Install](#install)
  + [2.2 Define targets](#define-targets)
  + [2.3 Find prime editing spacers and nicking spacers](#find-prime-editing-spacers-and-nicking-spacers)
  + [2.4 Return spacer GRanges](#return-spacer-granges)
* [References](#references)
* **Appendix**

# 1 Background

**Crispr/Cas9** is a prokaryotic immune system turned into a genome engineering tool, with a Cas9/gRNA complex at the heart of its functioning. The **gRNA** (guide RNA) contains a 20 nucleotide (proto)**spacer** which guides the complex to a genomic locus with identical sequence, but only when followed by an *NGG* **PAM** (protospacer adjacent motif (see Figure 1A). The **Cas9** enzyme performs some effector action at that locus: *wildtype Cas9* cuts both strands after spacer nucleotide 17, *Cas9Nickase* cuts only a single strand (two variants exist, cutting respectively each of the strands), while catalytically dead *dCas9*, fused to some effector domain (KRAB, VPR, APEX) performs some alternative action (e.g. KRAB represses, VPR activates, APEX biotinylates).

**Prime Editing** (Anzalone et al., 2019) extends this further, by coupling Cas9 to a Reverse Transcriptase (RT). As shown in Figure 1, the guide RNA is extended with a 3’ extension that contains primer binding site (binding a complementary DNA region that acts as a primer for reverse transcription) and reverse transcription template (the template used for reverse transcription). The spacer still acts as targeting agent, guiding the Cas9/RT complex to targeted genomic locus.

![gRNAs for Crispr/Cas9 (A) and Prime Editing](data:image/png;base64...)

Figure 1: gRNAs for Crispr/Cas9 (A) and Prime Editing

**Guide RNA design** involves finding good guide RNAs to hit the targets of interest. Plasmids with guide RNA scaffolds, ready for cloning desired spacers into, can be readily ordered from AddGene. The actual task, therefore, boils down to finding good spacers for the targets of interest. For prime editing, it additionally involves finding appropriate primer binding site and reverse transcription template to edit the target site of interest. In general, a good spacer needs to fulfill two requirements:

1. **Minimal off-target** (mis)matches, so that only intended targets are hit.

   * Crispr gRNAs can hit exact (with identical and alternate NGG pam), as well as (up-to 3) mismatch offtargets.
   * Prime Editing is much more specific, hitting only exact offtargets.
2. **Maximal on-target** efficiency. Over the years, several sequence-to-efficiency prediction models have been developed, of which the Doench 2016 score has currently become the community standard. The score is not perfect, and examples can be found where the prediction and the actual outcome differ. Yet, to-date it is the best heuristic to predict on-target efficiency, worth making use of.

# 2 Multicrispr

Multicrispr was developed to make guide RNA design easier. As shown below, it contains functions to **define** and **transform** targets, **find spacers**, compute/add **offtarget counts** and **efficiency scores** (Doench 2016), and finally return all of this as a **GRanges** object.

![](data:image/png;base64...)

## 2.1 Install

Installing **multicrispr** is simple:

```
# From BioC
install.packages("BiocManager")
BiocManager::install(version='devel')
BiocManager::install("multicrispr")

# From gitlab:
#url <- 'https://gitlab.gwdg.de/loosolab/software/multicrispr.git'
#remotes::install_git(url, repos = BiocManager::repositories())
```

Doench et al. (2016) ’s python package **azimuth** for on-target efficiency prediction using their method can be easily installed and activated using reticulate:

```
# Install once
  # reticulate::conda_create('azienv', 'python=2.7')
  # reticulate::conda_install('azienv', 'azimuth', pip = TRUE)
  # reticulate::conda_install('azienv', 'scikit-learn==0.17.1', pip = TRUE)
# Then activate
  reticulate::use_condaenv('azienv')
```

Bowtie-indexed genomes for quick offtarget analysis can be installed using `index_genome`. For the two genomes used in the examples, mm10 and hg38, the functions downloads pre-build indexes from our data server, allowing a quick exploration (set `download=FALSE` to build index anew):

```
index_genome(BSgenome.Mmusculus.UCSC.mm10::BSgenome.Mmusculus.UCSC.mm10)
index_genome(BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38  )
```

## 2.2 Define targets

**bed\_to\_granges** converts a (0-based) BED coordinate file into a (1-based) GRanges.

```
# char_to_granges: Anzalone et al. (2019) prime editing targets
require(multicrispr)
bsgenome <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38
targets <- char_to_granges(c(PRNP = 'chr20:4699600:+'), bsgenome)
plot_intervals(targets)
```

![](data:image/png;base64...)

## 2.3 Find prime editing spacers and nicking spacers

**find\_primespacers** finds prime editing spacers, 3’ extensions and nicking spacers. For both, on- and off-target analysis is performed.
Desired edits are always to be specified with respect to the defauylt (+) strand.

```
spacers <- find_primespacers(targets, bsgenome=bsgenome, edits = "T")
```

![](data:image/png;base64...)

## 2.4 Return spacer GRanges

```
  str(gr2dt(spacers), vec.len=2)
## Classes 'data.table' and 'data.frame':   4 obs. of  21 variables:
##  $ seqnames        : Factor w/ 711 levels "chr1","chr2",..: 20 20 20 20
##  $ start           : int  4699568 4699569 4699575 4699578
##  $ end             : int  4699587 4699588 4699594 4699597
##  $ width           : int  20 20 20 20
##  $ strand          : Factor w/ 3 levels "+","-","*": 1 1 1 1
##  $ targetname      : chr  "PRNP" "PRNP" ...
##  $ targetstart     : int  4699600 4699600 4699600 4699600
##  $ targetend       : int  4699600 4699600 4699600 4699600
##  $ crisprname      : chr  "PRNP_1" "PRNP_2" ...
##  $ crisprspacer    : chr  "AGCAGCTGGGGCAGTGGTGG" "GCAGCTGGGGCAGTGGTGGG" ...
##  $ crisprpam       : chr  "GGG" "GGG" ...
##  $ crisprprimer    : chr  "GCTGGGGCAGTGG" "CTGGGGCAGTGGT" ...
##  $ crisprtranscript: chr  "TGGGGGGCCTTGGCGT" "GGGGGGCCTTGGCGTC" ...
##  $ crisprextension : chr  "ACGCCAAGGCCCCCCACCACTGCCCCAGC" "GACGCCAAGGCCCCCCACCACTGCCCCAG" ...
##  $ crisprextrange  : chr  "chr20:4699572-4699600:-" "chr20:4699573-4699601:-" ...
##  $ Doench2014      : num  0.00995 0.04497 ...
##  $ nickrange       : chr  "chr20:4699632-4699651:-;chr20:4699633-4699652:-;chr20:4699664-4699683:-" "chr20:4699632-4699651:-;chr20:4699633-4699652:-;chr20:4699664-4699683:-" ...
##  $ nickspacer      : chr  "TCACTGCCGAAATGTATGAT;GTCACTGCCGAAATGTATGA;GCATGTTTTCACGATAGTAA" "TCACTGCCGAAATGTATGAT;GTCACTGCCGAAATGTATGA;GCATGTTTTCACGATAGTAA" ...
##  $ nickpam         : chr  "GGG;TGG;CGG" "GGG;TGG;CGG" ...
##  $ nickDoench2014  : chr  "0.141166924987143;0.318967004337458;0.51579612064087" "0.141166924987143;0.318967004337458;0.51579612064087" ...
##  $ names           : chr  "PRNP_1" "PRNP_2" ...
##  - attr(*, ".internal.selfref")=<externalptr>
```

# References

# Appendix

Anzalone, A.V., Randolph, P.B., Davis, J.R. et al. Search-and-replace genome editing without double-strand breaks or donor DNA. Nature 576, 149–157 (2019). <https://doi.org/10.1038/s41586-019-1711-4>

Doench et al. (2016). Optimized sgRNA design to maximize activity and minimize off-target effects of CRISPR-Cas9. Nature Biotechnology, 34(7), doi:10.1038/nbt.3437
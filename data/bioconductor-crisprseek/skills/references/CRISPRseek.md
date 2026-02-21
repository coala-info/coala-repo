# CRISPRseek: design of guide RNA and off-target analysis

Lihua Julie Zhu1, Kai Hu1 and Michael Brodsky1

1UMass Chan Medical School, Worcester, USA

#### 29 October 2025

#### Abstract

The *[CRISPRseek](https://bioconductor.org/packages/3.22/CRISPRseek)* (Zhu et al. [2014](#ref-zhu2014)) package provides a range of funtions for identifying and analyzing guide RNAs (gRNAs) in CRISPR-based experiments. It generates detailed reports that include information on potential off-targets, restriction enzyme recognition sites, potential gRNA pairings for double nickases, and more.

#### Package

CRISPRseek 1.50.0

# 1 Introduction

CRISPR-Cas nucleases and their derivatives, such as *nickases* and *gene expression regulators*, have become the most popular tools for genome modification and gene expression regulation in both model organisms and human cells (Mali et al. [2013](#ref-mali2013); Hsu et al. [2013](#ref-hsu2013)). The CRISPR-Cas system uses a guide RNA (gRNA) to direct the Cas nuclease to target DNA sequence that is adjacent to a Protospace Adjacent Motif (PAM). The Cas enzyme then creates a double-strand break at the target site, initiating the gene modification. Following the cut, various editing outcomes, such as short insertions and deletions (INDELs) as well as point mutations, can occur through different DNA damage repair mechanisms (Chen et al. [2019](#ref-chen2019)). In the most widely used CRISPR system from *Streptococcus pyogenes*, the gRNA consists of 20 nucleotides, with the preferred PAM being “NGG” (or “NAG” with reduced activity).

A key limitation of CRISPR systems is their potential to cleave DNA sequences that do no perfectly match the gRNA target, known as “off-target effects”. Therefore, designing gRNAs with low off-target activity is crucial for the effective application of CRISPR systems (Zhu [2015](#ref-zhu2015)). Several strategies can help minimize off-target effects:

* Evaluate gRNA candidates for potential off-target matches in the genome.
* Analyze flanking sequences of off-target sites to determine if they lie within critical regions, such as exons.
* Leverage specific target sequence arrangements, such as using paired nickases, which create double-strand breaks only when the two sites are properly spaced and oriented.
* Use restriction enzyme recognition sites overlapping the target sites to monitor cleavage events.

We developed the *[CRISPRseek](https://bioconductor.org/packages/3.22/CRISPRseek)* package to assist with all the above steps. Key features include:

* **gRNA identification**:
  + Identify candidate gRNAs within an input sequence using experimentally relevant constraints.
  + **Double nickase pairs**: Automatically identify gRNA pairs suitable for double nickases.
  + **Restriction site overlap**: Detect if gRNAs overlap with restriction enzyme recognition sites.
* **Off-target analysis**:
  + **Off-target search**: Search the genome for off-targets with a user-defined maximum number of mismatches and/or bulges.
  + **Off-target scoring**: Calculate and rank off-target scores based on mismatches, bulges, and a penalty weight matrix using different algorithms.
  + **Off-target annotation**: Annotate off-targets with flanking sequences, such as whether they are within exons.
  + **Off-target filtering**: Filter off-targets according to user-defined criteria.

The *[CRISPRseek](https://bioconductor.org/packages/3.22/CRISPRseek)* package generates several reports. Key output includes:

* **Summary.xlsx**: Summarizes detected gRNAs, ranked by total topN off-target score, and includes restriction enzyme cut sites and potential gRNA pairings.
* **OfftargetAnalysis.xlsx**: Contains detailed off-target information, such as off-target sequences, associated scores, alignments, among others.
* **REcutDetails.xlsx**: Lists detailed information about restriction enzyme cut sites for each gRNA.
* **pairedgRNAs.xlsx**: Provides potential gRNA pairs suitable for use with double nickases.

The *[CRISPRseek](https://bioconductor.org/packages/3.22/CRISPRseek)* package is highly flexible, allowing users to customize gRNA and PAM sequence requirements for different CRISPR systems across various bacterial species. It can also be easily extended to incorporate improved weight matrices or scoring methods for off-target analysis as new experimental and computational results emerge.

# 2 Core functions

Key functions implemented in the *[CRISPRseek](https://bioconductor.org/packages/3.22/CRISPRseek)*, along with their roles, input parameters, and outputs, are illustrated in the diagram below. For convenience, we highly recommend using the one-stop wrapper function, `offtargetAnalysis()`, which streamlines the entire gRNA identification and off-target analysis workflow.

![Analytical workflow and core functions in CRISPRseek](data:image/png;base64...)

Figure 1: Analytical workflow and core functions in CRISPRseek

# 3 Example use scenarios

In this section, we will demonstrate different gRNA design scenarios using the `offtargetAnalysis()` function. Some of its core parameters are described below. Type `?offtargetAnalysis` for detailed description of all supported parameters.

* “inputFilePath”:
  + Path to an input sequence file or a `DNAStringSet` object containing sequences to be searched for potential gRNAs.
* “findgRNAs”:
  + Defaults to TRUE. Specifies whether to find gRNAs from the sequences in `inputFilePath`. Set to FALSE if the input file already contains user-selected gRNAs plus PAM.
* “findgRNAsWithREcutOnly”:
  + Defaults to TRUE. Specifies whether to search for gRNAs that overlap with restriction enzyme recognition sites only.
* “REpatternFile”:
  + Path to a file containing restriction enzyme cut patterns.
* “findPairedgRNAOnly”:
  + Defaults to FALSE. Specifies whether to search only for paired gRNAs in such an orientation that the first one is on the minus strand (reverse gRNA) and the second one is on plus strand (forward gRNA).
* “annotatePaired”:
  + Defaults to TRUE. Specifies whether to output paired gRNA information.
* “PAM”:
  + Defaults to “NGG”. Defines the protospacer adjacent motif sequence.
* “BSgenomeName”:
  + A `BSgenome` object containing the target genome sequence, used for off-target search.
* “genomeSeqFile”:
  + Alternative to `BSgenomeName`. Specifies the path to a custom target genome file in FASTA format, used for off-target search. It is applicable when `BSgenomeName` is NOT set. When `genomeSeqFile` is set, the `annotateExon`, `txdb`, and `orgAnn` parameters will be ignored.
* “chromToSearch”:
  + Defaults to “all”, meaning all chromosomes in the target genome are searched for off-targets. Set to a specific chromosome (e.g., “chrX”) to restrict the search to that chromsome only.
* “max.mismatch”:
  + Defaults to 3. Maximum number of mismatches allowed in off-target search. Warning: search will be considerably slower if set to a value greater than 3.
* “findOffTargetsWithBulge”:
  + Defaults to FALSE. Specifies whether to search for off-targets with bulges.
* “DNA\_bulge”:
  + Defaults to 2. Maximum number of DNA bulges allowed in off-target search.
* “RNA\_bulge”:
  + Defaults to 2. Maximum number of RNA bulges allowed in off-target search.
* “annotateExon”:
  + Defaults to TRUE. Specifies whether to annotate if off-targets are within exons. If set to TRUE, provide “txdb” and “orgAnn” for annotation.
* “txdb”:
  + A `TxDb` object containing organism-specific annotation data, required for `annotateExon`.
* "orgAnn:
  + An `OrgDb` object containing organism-specific annotation mapping information, required for `annotateExon`.
* “outputDir”:
  + Defaults to the current working directotry. Specifies the path to the directory where the analysis results will be saved.
* “baseEditing”:
  + Defaults to FALSE. Specifies whether to design gRNAs for base editing.
* “primeEditing”:
  + Defaults to FALSE. Specifies whether to design gRNAs for prime editing.
* “predIndelFreq”:
  + Defaults to FALSE. Specifies whether to output the predicted INDELs and their frequencies.

To annotate the resulting off-targets to nearby exons, the following parameters are required: “annotateExon”, “BSgenomeName”, “txdb”, and “orgAnn”.

* To find the BSgenome for other species, use the `available.genomes()` function in the *[BSgenome](https://bioconductor.org/packages/3.22/BSgenome)* package. Common examples include *[BSgenome.Hsapiens.UCSC.hg19](https://bioconductor.org/packages/3.22/BSgenome.Hsapiens.UCSC.hg19)* (hg19), *[BSgenome.Hsapiens.UCSC.hg38](https://bioconductor.org/packages/3.22/BSgenome.Hsapiens.UCSC.hg38)* (hg38), *[BSgenome.Mmusculus.UCSC.mm10](https://bioconductor.org/packages/3.22/BSgenome.Mmusculus.UCSC.mm10)* (mm10), *[BSgenome.Celegans.UCSC.ce6](https://bioconductor.org/packages/3.22/BSgenome.Celegans.UCSC.ce6)* (ce6).
* To find a list of existing `TxDb` objects, search for annotation packages starting with “TxDb” at [Bioconductor](http://www.bioconductor.org/packages/release/BiocViews.html). Examples include *[TxDb.Hsapiens.UCSC.hg19.knownGene](https://bioconductor.org/packages/3.22/TxDb.Hsapiens.UCSC.hg19.knownGene)* (for hg19) and *[TxDb.Mmusculus.UCSC.mm10.knownGene](https://bioconductor.org/packages/3.22/TxDb.Mmusculus.UCSC.mm10.knownGene)* (for mm10). To build custom `TxDb`, refer to the *[GenomicFeatures](https://bioconductor.org/packages/3.22/GenomicFeatures)* and *[txdbmaker](https://bioconductor.org/packages/3.22/txdbmaker)* packages.
* To find a list of existing `OrgDb` packages, search for “OrgDb” at [Bioconductor](http://www.bioconductor.org/packages/release/BiocViews.html). Examples include *[org.Hs.eg.db](https://bioconductor.org/packages/3.22/org.Hs.eg.db)* (for human) and *[org.Mm.eg.db](https://bioconductor.org/packages/3.22/org.Mm.eg.db)* (for mouse).

The `offTargetAnalysis()` function offers two input options:

* Input raw sequence

By default, the parameter `findgRNAs = TRUE` directs the function to accept a sequence file (via `inputFilePath`), search for potential gRNAs, and then perform off-target analysis.

* Input user-designed gRNAs

Alternatively, if you already have a list of user-designed gRNAs, you can provide them via `inputFilePath` as well, set `findgRNAs = FALSE`, and the function will perform off-target analysis without searching for gRNAs.

The following examples use a raw sequence as input and, therefore, set `findgRNAs = TRUE`.

## 3.1 Using default settings

By default, the `offTargetAnalysis()` function will identify all potential gRNAs in the given input sequence, perform off-target analysis, and annotate for all identified off-targets. This generates the most comprehensive reports, but comes with the trade-off of the slowest running time. Additionally, we need to load the necessary annotation packages first:

```
library(CRISPRseek)
library(BSgenome.Hsapiens.UCSC.hg38)
library(TxDb.Hsapiens.UCSC.hg38.knownGene)
library(org.Hs.eg.db)
```

Note that we set `chromToSearch = "chrX"` to restrict the off-target search to the “chrX” to speed up the analysis.

```
inputFilePath <- system.file('extdata', 'inputseq.fa', package = 'CRISPRseek')
outputDir <- getwd()
res <- offTargetAnalysis(inputFilePath = inputFilePath,
                         BSgenomeName = Hsapiens,
                         chromToSearch= "chrX",

                         # Annotation packages required for annotation.
                         txdb = TxDb.Hsapiens.UCSC.hg38.knownGene,
                         orgAnn = org.Hs.egSYMBOL,

                         outputDir = outputDir,
                         overwrite = TRUE)
head(res$summary[, c("names", "gRNAsPlusPAM", "gRNAefficacy")])
```

```
##                  names            gRNAsPlusPAM gRNAefficacy
## 1 Hsap_GATA1_ex2_gR17f CCAGTTTGTGGATCCTGCTCNGG   0.10654794
## 2 Hsap_GATA1_ex2_gR20r GGTGTGGAGGACACCAGAGCNGG   0.14209108
## 3 Hsap_GATA1_ex2_gR39f GTGTCCTCCACACCAGAATCNGG   0.06962952
## 4 Hsap_GATA1_ex2_gR40f TGTCCTCCACACCAGAATCANGG   0.26188176
## 5  Hsap_GATA1_ex2_gR7r CCAGAGCAGGATCCACAAACNGG   0.10171983
```

```
head(res$offtarget[, c("name", "OffTargetSequence", "alignment", "score", "gRNAefficacy")])
```

```
##                     name       OffTargetSequence            alignment score
## 81  Hsap_GATA1_ex2_gR40f TGTCCTTGACACAAGAATCATGT ......TG....A.......   0.7
## 171 Hsap_GATA1_ex2_gR20r GGTCTGGAGGACAGCACAGCCTG ...C.........G..C...   0.2
## 191 Hsap_GATA1_ex2_gR20r TGTGTGTAGGACTCCAGAGCAAG T.....T.....T.......   0.8
## 16  Hsap_GATA1_ex2_gR20r GGTGTGGAGGAGATGAGAGCATG ...........G.TG.....   0.0
## 23   Hsap_GATA1_ex2_gR7r CCAGAGCAGGATCCACAAACTGG .................... 100.0
## 9   Hsap_GATA1_ex2_gR40f TGTCCTCCACACCAGAATCAGGG .................... 100.0
##     gRNAefficacy
## 81     0.2068879
## 171    0.2487753
## 191    0.1297587
## 16     0.1521223
## 23     0.1017198
## 9      0.2618818
```

## 3.2 Skipping off-target annotation

To skip the annotation step, simply set `annotateExon = FALSE`:

```
res <- offTargetAnalysis(inputFilePath = inputFilePath,
                         BSgenomeName = Hsapiens,
                         annotateExon = FALSE,
                         chromToSearch = "chrX",
                         outputDir = outputDir,
                         overwrite = TRUE)
```

## 3.3 Skipping off-target analysis

For a quicker gRNA search, you can call the function with `chromToSearch = ""`, which disables the search of identified gRNAs against the reference genome. This will significantly reduce the running time.

```
res <- offTargetAnalysis(inputFilePath = inputFilePath,
                         BSgenomeName = Hsapiens, # optional
                         chromToSearch = "",
                         outputDir = outputDir,
                         overwrite = TRUE)
res
```

```
## DNAStringSet object of length 5:
##     width seq                                               names
## [1]    23 CCAGTTTGTGGATCCTGCTCTGG                           Hsap_GATA1_ex2_gR17f
## [2]    23 GTGTCCTCCACACCAGAATCAGG                           Hsap_GATA1_ex2_gR39f
## [3]    23 TGTCCTCCACACCAGAATCAGGG                           Hsap_GATA1_ex2_gR40f
## [4]    23 GGTGTGGAGGACACCAGAGCAGG                           Hsap_GATA1_ex2_gR20r
## [5]    23 CCAGAGCAGGATCCACAAACTGG                           Hsap_GATA1_ex2_gR7r
```

Note that setting `chromToSearch = ""` also disables the calculation of gRNA efficacy, which measures how effectively a gRNA facilitates cleavage at the target site. To enable the calculation of gRNA efficacy at the on-target site, specify the chromosome where the on-targets are located (e.g., `chromToSearch = "chrX"`) and set `max.mismatch = 0` to ensure no off-target analysis is performed.

```
res <- offTargetAnalysis(inputFilePath = inputFilePath,
                         BSgenomeName = Hsapiens,
                         annotateExon = FALSE,
                         chromToSearch = "chrX",
                         max.mismatch = 0,
                         outputDir = outputDir,
                         overwrite = TRUE)
head(res$summary[, c("names", "gRNAsPlusPAM", "gRNAefficacy")])
```

```
##                  names            gRNAsPlusPAM gRNAefficacy
## 1 Hsap_GATA1_ex2_gR17f CCAGTTTGTGGATCCTGCTCNGG   0.10654794
## 2 Hsap_GATA1_ex2_gR20r GGTGTGGAGGACACCAGAGCNGG   0.14209108
## 3 Hsap_GATA1_ex2_gR39f GTGTCCTCCACACCAGAATCNGG   0.06962952
## 4 Hsap_GATA1_ex2_gR40f TGTCCTCCACACCAGAATCANGG   0.26188176
## 5  Hsap_GATA1_ex2_gR7r CCAGAGCAGGATCCACAAACNGG   0.10171983
```

Four rule sets are currently supported for calculating gRNA efficacy (`rule.set = c("Root_RuleSet1_2014", "Root_RuleSet2_2016", "CRISPRscan", "DeepCpf1")`) (Doench et al. [2014](#ref-doench2014), [2016](#ref-doench2016); Moreno-Mateos et al. [2015](#ref-moreno2015); Kim et al. [2018](#ref-kim2018)). By default, “Root\_RuleSet\_2014” is be used. To use “Root\_RuleSet2\_2016”, first install python 2.7 via Anaconda (As RuleSet2 is implemented with python 2.7), then install the following Python packages: scikit-learn 0.16.1, pickle, pandas, numpy, and scipy. Afterward, in an R session, run the following commands:

```
Sys.setenv(PATH = paste("/anaconda2/bin", Sys.getenv("PATH"), sep = ":"))
system("python --version") # Should output Python 2.7.15.
```

If `rule.set = "CRISPRscan"`, must also specify the corresponding parameters for `baseBefroegRNA`, `baseAfterPAM`, and `featureWeightMatrixFile` to ensure correct efficacy calculation:

```
m <- system.file("extdata", "Morenos-Mateo.csv", package = "CRISPRseek")
res <- offTargetAnalysis(inputFilePath = inputFilePath,
                         BSgenomeName = Hsapiens,
                         annotateExon = FALSE,
                         chromToSearch = "chrX",
                         max.mismatch = 0,
                         rule.set = "CRISPRscan",
                         baseBeforegRNA = 6,
                         baseAfterPAM = 6,
                         featureWeightMatrixFile = m,
                         outputDir = outputDir,
                         overwrite = TRUE)
```

## 3.4 Searching for off-targets in custom genomes

If you would like to search for off-targets in custom reference genomes (rather than using a `BSgenome`), you can specify the path to the custom reference sequence file via the `genomeSeqFile` argument. Please note that, when a custom reference is used, arguments `annotateExon`, `BSgenomeName`, `txdb`, and `fetchSequence` will be ignored.

```
inputFilePath2 <- system.file("extdata", "inputseqWithoutBSgenome.fa", package = "CRISPRseek")
genomeSeqFile <- system.file("extdata", "genomeSeq.fasta", package = "CRISPRseek")

res <- offTargetAnalysis(inputFilePath = inputFilePath2,
                         genomeSeqFile = genomeSeqFile,
                         outputDir = outputDir,
                         overwrite = TRUE)
head(res$summary)
```

## 3.5 Searching for off-targets with bulges

The *[CRISPRseek](https://bioconductor.org/packages/3.22/CRISPRseek)* supports searching for off-targets with bulges (both RNA bulges and DNA bulges) by integrating the Cas-OFFinder (Bae, Park, and Kim [2014](#ref-bae2014)) tool. To enable this, you can call the master function `offTargetAnalysis()` with the argument `findOffTargetsWithBulge = TRUE`.

There are three parameters specific to bulge searches, with the following default values:

* `method.findOffTargetsWithBulge = "CasOFFinder_v3.0.0b3"`
* `DNA_bulge = 2`
* `RNA_bulge = 2`

Note that, currently, `method.findOffTargetsWithBulge` only supports “CasOFFinder\_v3.0.0b3”, which generates results that may differ from those produced by “CasOFFinder\_v2”, For more details, refer to this [link](https://github.com/snugel/cas-offinder). To use “CasOFFinder” on Linux or Windows, you may need to install “pocl-opencl-icd” if it is not already installed.

```
if (interactive()) {
  res <- offTargetAnalysis(inputFilePath = inputFilePath,
                         findOffTargetsWithBulge = TRUE,
                         BSgenomeName = Hsapiens,
                         chromToSearch = "chrX",
                         annotateExon = FALSE,
                         outputDir = outputDir,
                         overwrite = TRUE)
  head(res$offtarget[, c("name", "gRNAPlusPAM_bulge", "OffTargetSequence_bulge", "n.RNABulge", "n.DNABulge", "alignment")])
}
```

The columns relevant to the bulge search are described below. If no bulge is detected, both the “gRNAPlusPAM\_bulge” and “OffTargetSequence\_bulge” columns for that row will both be empty, while the “n.RNABulge” and “n.DNABulge” values will both be 0.

* “gRNAPlusPAM\_bulge”
  + A hyphen (“-”) indicates where a DNA bulge occurs.
* “OffTargetSequence\_bulge”
  + A hyphen (“-”) indicates where an RNA bulge occurs.
* “n.RNABulge”
  + The counts of RNA bulges.
* “n.DNABulge”
  + The counts of DNA bulges.
* “alignment”
  + A dot (“.”) represents base match, a caret (“^”) indicates the position of a DNA bulge, and a hyphen (“-”) indicates the position of an RNA bulge.

Alternatively, you can use the wrapper function `getOfftargetWithBulge()` to directly output the Cas-OFFinder results. The function accepts input in the form of either a `DNAStringSet` object from `findgRNA()`, or a `list` object from `offTargetAnalysis()`.

Note that `getOfftargetWithBulge()` currently supports two versions of Cas-OFFinder: “2.4.1” and “3.0.0b3”, specified through the `cas_offinder_version` argument, with the default set to “2.4.1”. Type `?getOfftargetWithBulges` for more examples.

```
if (interactive()) {
  gRNA_PAM <- findgRNAs(inputFilePath = system.file("extdata",
                                                    "inputseq.fa",
                                                    package = "CRISPRseek"),
                        pairOutputFile = "testpairedgRNAs.xls",
                        findPairedgRNAOnly = TRUE)
  res <- getOfftargetWithBulge(gRNA_PAM,
                               BSgenomeName = Hsapiens,
                               chromToSearch = "chrX")
  head(res)
}
```

## 3.6 Scoring off-targets using different methods

The `scoring.method` argument in `offTargetAnalysis()` determines how off-target scores are calculated. By default, `scoring.method = "Hsu-Zhuang"`, which models the effect of mismatch position on cutting frequency. To account for both mismatch position and type, you can switch to using the CFD score (Doench et al. [2016](#ref-doench2016)). To enable this, set `scoring.method = "CFDscore"` and `PAM.pattern = "NNG$|NGN$"`.

```
res <- offTargetAnalysis(inputFilePath = inputFilePath,
                         BSgenomeName = Hsapiens,
                         chromToSearch = "chrX",
                         annotateExon = FALSE,
                         scoring.method = "CFDscore",
                         PAM.pattern = "NNG$|NGN$",
                         outputDir = outputDir,
                         overwrite = TRUE)
head(res$offtarget[, c("name", "gRNAPlusPAM", "score", "alignment")])
```

```
##                    name             gRNAPlusPAM    score            alignment
## 23  Hsap_GATA1_ex2_gR7r CCAGAGCAGGATCCACAAACNGG 1.000000 ....................
## 22  Hsap_GATA1_ex2_gR7r CCAGAGCAGGATCCACAAACNGG 0.032997 ....T.......T....T..
## 9  Hsap_GATA1_ex2_gR40f TGTCCTCCACACCAGAATCANGG 1.000000 ....................
## 14 Hsap_GATA1_ex2_gR40f TGTCCTCCACACCAGAATCANGG 0.022774 G...A...T...........
## 10 Hsap_GATA1_ex2_gR40f TGTCCTCCACACCAGAATCANGG 0.022096 ....T......AT.......
## 13 Hsap_GATA1_ex2_gR40f TGTCCTCCACACCAGAATCANGG 0.021065 .......A..........G.
```

## 3.7 Only reporting desired gRNAs

You can filter the output to include only the desired gRNAs, such as paired gRNAs or those with specific restriction enzyme recognition sites, by adjusting the following parameters.

* `findPairedgRNAOnly = FALSE`:
  + If set to TRUE, only gRNAs in paired configurations will be reported.
  + To qualify as a pair, the gap between the forward gRNA and the reverse gRNA must fall between `min.gap` (defaults to 0) and `max.gap` (defaults to 20), inclusive. And the reverse gRNA must be positioned before the forward gRNA.
  + The identified gRNAs will be annotated with restriction enzyme recognition site for users to review later.
* `findgRNAsWithREcutOnly = FALSE`:
  + If set to TRUE, only gRNAs that overlap with a restriction enzyme recognition site will be reported.
  + Use the `REpatternFile` parameter to specify the file containing the restriction enzyme recognition patterns.
  + The identified gRNAs will be annotated with pairing information for users to review later.

Both parameters can be set to TRUE simultaneously to report only paired gRNAs, where at least one gRNA in the pair overlaps with a restriction enzyme recognition site.

```
res <- offTargetAnalysis(inputFilePath = inputFilePath,
                         BSgenomeName = Hsapiens,
                         annotateExon = FALSE,
                         chromToSearch = "chrX",
                         findPairedgRNAOnly = TRUE,
                         findgRNAsWithREcutOnly = TRUE,
                         outputDir = outputDir,
                         overwrite = TRUE)
head(res$summary[, c("names", "gRNAsPlusPAM", "gRNAefficacy", "PairedgRNAName", "REname")])
```

```
##                  names            gRNAsPlusPAM gRNAefficacy
## 1 Hsap_GATA1_ex2_gR39f GTGTCCTCCACACCAGAATCNGG   0.06962952
## 2 Hsap_GATA1_ex2_gR40f TGTCCTCCACACCAGAATCANGG   0.26188176
## 3  Hsap_GATA1_ex2_gR7r CCAGAGCAGGATCCACAAACNGG   0.10171983
##                               PairedgRNAName            REname
## 1                        Hsap_GATA1_ex2_gR7r BslI  HinfI  TfiI
## 2                        Hsap_GATA1_ex2_gR7r BslI  HinfI  TfiI
## 3 Hsap_GATA1_ex2_gR39f  Hsap_GATA1_ex2_gR40f       BslI  PflMI
```

## 3.8 Finding gRNAs in long input sequences

Searching for gRNAs in long input sequences (> 200 kb) may be slow. To improve performance, set `annotatePaired = FALSE`, and enable multicore processing by setting `enable.multicore = TRUE` and adjusting `n.cores.max`. Additionally, we recommend splitting very long sequences into smaller chunks and analyzing each sub-sequence separately. Special thanks to Alex Williams for sharing [this use case](https://support.bioconductor.org/p/72994/). Finally, please ensure that repeat-masked sequences are used as input.

## 3.9 Finding gRNAs preferentially targeting one allele

To identify gRNAs that preferentially target one allele, the function `compare2Sequences()`, which takes two input files, can be used. In the following example, file “rs362331C.fa” and “rs362331T.fa” represent two input files that contain sequences differing by a single nucleotide polymorphism (SNP). The results are saved in the file “scoresFor2InputSequences.xlsx”. The output file lists all possible gRNA sequences for each of the two input files and provides a cleavage score for each of the two input sequences. To preferentially target one allele, select gRNA sequences that have the lowest score for the other allele. Selected gRNAs can then by examined for off-targets using `offTargetAnalysis()` function with `findgRNAs = FALSE` as described above.

```
inputFile1Path <- system.file("extdata", "rs362331C.fa", package="CRISPRseek")
inputFile2Path <- system.file("extdata", "rs362331T.fa", package="CRISPRseek")

res <- compare2Sequences(inputFile1Path,
                         inputFile2Path,
                         outputDir = outputDir,
                         overwrite = TRUE)
```

```
## search for gRNAs for input file1...
```

```
## search for gRNAs for input file2...
```

```
## [1] "Scoring ..."
```

```
## finish off-target search in sequence 2
```

```
## finish off-target search in sequence 1
## finish feature vector building
## finish score calculation
## [1] "Done!"
```

```
head(res[, c("name", "gRNAPlusPAM", "scoreForSeq1", "scoreForSeq2", "gRNAefficacy", "scoreDiff")])
```

```
##               name             gRNAPlusPAM scoreForSeq1 scoreForSeq2
## 10 rs362331C_gR22r TGAAGTGCACACAGTGGATGNGG          100         17.2
## 11 rs362331C_gR21r GAAGTGCACACAGTGGATGANGG          100         26.8
## 12 rs362331C_gR15r CACACAGTGGATGAGGGAGCNGG          100         61.1
## 7   rs362331C_gR9r GTGGATGAGGGAGCAGGCGTNGG          100         98.6
## 2  rs362331T_gR38f CTACTGTGTGCACTTCATCCNGG          100          100
## 6  rs362331T_gR10r AGTAGATGAGGGAGCAGGCGNGG          100          100
##                   gRNAefficacy scoreDiff
## 10          0.0978516718170484      82.8
## 11           0.129816665166513      73.2
## 12          0.0169291602963948      38.9
## 7  extended sequence too short       1.4
## 2  extended sequence too short       0.0
## 6            0.161377523263354       0.0
```

## 3.10 Configuring for base editors

Cytosine base editors (CBEs) and adenine base editors (ABEs) can introduce specific DNA C-to-T or A-to-G alterations, respectively (Gaudelli et al. [2017](#ref-gaudelli2017); Komor et al. [2016](#ref-komor2016)). The `offTargetAnalsys()` can design gRNAs optimized for base editing by setting `baseEditing = TRUE`. In this case, the following parameters must also be specified (defaults are for the CBE system developed in the Liu Lab): `targetBase = "C"`, `editingWindow = 4:8`, `editingWindow.offtarget = 4:8`.

```
res <- offTargetAnalysis(inputFilePath = inputFilePath,
                         chromToSearch = "",
                         baseEditing = TRUE,
                         targetBase = "C",
                         editingWindow = 4:8,
                         editingWindow.offtargets = 4:8,
                         outputDir = outputDir,
                         overwrite = TRUE)
res
```

```
## DNAStringSet object of length 1:
##     width seq                                               names
## [1]    23 CCAGAGCAGGATCCACAAACTGG                           Hsap_GATA1_ex2_gR7r
```

## 3.11 Configuring for prime editors

In addition to CBE, the Liu Lab also developed the prime editor (PE) (Anzalone et al. [2019](#ref-anzalone2019)), which is more versatile and flexible with high efficacy and without the need to make a DSB or providing donor template. It can be used to make all possible 12 single base changes, 1-44 bp insertions, or 1-80 bp deletions. This editing system can be programmed to correct about 89 percent of human pathogenic variants.

To design gRNAs and pegRNAs for PE, set `primeEditing = TRUE` together with the following parameters:

* “targeted.seq.length.change”
* “bp.after.target.end”
* “PBS.length”
* “RT.template.length”
* “RT.template.pattern”
* “target.start”
* “target.end”
* “correct.seq”
* “findPairedgRNAOnly” (must set to TRUE),
* “paired.orientation” (must set to “PAMin”)
* “min.gap” (for paired gRNAs)
* “max.gap” (for paired gRNAs)

Type `?offTargetAnalysis` for detailed description of each of these parameters.

```
inputFilePath <- DNAStringSet("CCAGTTTGTGGATCCTGCTCTGGTGTCCTCCACACCAGAATCAGGGATCGAAAACTCATCAGTCGATGCGAGTCATCTAAATTCCGATCAATTTCACACTTTAAACG")
res <- offTargetAnalysis(inputFilePath,
                         chromToSearch = "",
                         gRNAoutputName = "testPEgRNAs", # Required when inputFilePath is a DNAStringSet object.
                         primeEditing = TRUE,
                         targeted.seq.length.change = 0,
                         bp.after.target.end = 15,
                         PBS.length = 15,
                         RT.template.length = 8:30,
                         RT.template.pattern = "D$",
                         target.start = 20,
                         target.end = 20,
                         corrected.seq = "T",
                         findPairedgRNAOnly = TRUE,
                         paired.orientation = "PAMin",
                         outputDir = outputDir,
                         overwrite = TRUE)
res
```

```
## DNAStringSet object of length 4:
##     width seq                                               names
## [1]    23 CCAGTTTGTGGATCCTGCTCTGG                           NA_gR17f
## [2]    23 GAGTTTTCGATCCCTGATTCTGG                           NA_gR41r
## [3]    23 TTCGATCCCTGATTCTGGTGTGG                           NA_gR36r
## [4]    23 GATCCCTGATTCTGGTGTGGAGG                           NA_gR33r
```

# 4 Have questions?

For questions related to usage, please search/post your queries on the [Bioconductor Support Site](https://support.bioconductor.org/new/post/). If you wish to report a bug or request a new feature, kindly raise an issue on the [CRISPRseek](https://github.com/LihuaJulieZhu/CRISPRseek/issues/new) GitHub repository.

# 5 Selected Q & A

## 5.1 Can CRISPRseek detect off-targets with bulges?

Yes, starting from version 1.44.1, *[CRISPRseek](https://bioconductor.org/packages/3.22/CRISPRseek)* supports the detection of off-targets with bulges by integrating Cas-OFFinder (Bae, Park, and Kim [2014](#ref-bae2014)). To learn more, type `?getOfftargetWithBulge` and `?offTargetAnalysis` for detailed documentation.

# 6 How to cite CRISPRseek

If you use *[CRISPRseek](https://bioconductor.org/packages/3.22/CRISPRseek)* in your work, please cite it as follows:

```
citation(package = "CRISPRseek")
```

```
## Please cite the paper below for the CRISPRseek package.
##
##   Zhu LJ, Holmes BR, Aronin N, Brodsky MH (2014) CRISPRseek: A
##   Bioconductor Package to Identify Target-Specific Guide RNAs for
##   CRISPR-Cas9 Genome-Editing Systems. PLoS ONE 9(9): e108424.
##   doi:10.1371/journal.pone.0108424
##
##   Lihua Julie Zhu (2015). Overview of guide RNA design tools for
##   CRISPR-Cas9 genome editing technology. Front. Biol., 10(4): 289-296
##
## To see these entries in BibTeX format, use 'print(<citation>,
## bibtex=TRUE)', 'toBibtex(.)', or set
## 'options(citation.bibtex.max=999)'.
```

# 7 Session info

Here is the output of `sessionInfo()` on the system on which this document was compiled running pandoc 2.7.3:

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] org.Hs.eg.db_3.22.0
##  [2] TxDb.Hsapiens.UCSC.hg38.knownGene_3.22.0
##  [3] BSgenome.Hsapiens.UCSC.hg38_1.4.5
##  [4] BSgenome_1.78.0
##  [5] rtracklayer_1.70.0
##  [6] BiocIO_1.20.0
##  [7] GenomeInfoDb_1.46.0
##  [8] CRISPRseek_1.50.0
##  [9] GenomicFeatures_1.62.0
## [10] AnnotationDbi_1.72.0
## [11] Biobase_2.70.0
## [12] GenomicRanges_1.62.0
## [13] Biostrings_2.78.0
## [14] Seqinfo_1.0.0
## [15] XVector_0.50.0
## [16] IRanges_2.44.0
## [17] S4Vectors_0.48.0
## [18] BiocGenerics_0.56.0
## [19] generics_0.1.4
## [20] BiocFileCache_3.0.0
## [21] dbplyr_2.5.1
## [22] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3                   bitops_1.0-9
##  [3] httr2_1.2.1                 rlang_1.1.6
##  [5] magrittr_2.0.4              ade4_1.7-23
##  [7] rio_1.2.4                   matrixStats_1.5.0
##  [9] compiler_4.5.1              RSQLite_2.4.3
## [11] png_0.1-8                   vctrs_0.6.5
## [13] stringr_1.5.2               pkgconfig_2.0.3
## [15] crayon_1.5.3                fastmap_1.2.0
## [17] Rsamtools_2.26.0            rmarkdown_2.30
## [19] UCSC.utils_1.6.0            purrr_1.1.0
## [21] bit_4.6.0                   xfun_0.53
## [23] cachem_1.1.0                cigarillo_1.0.0
## [25] seqinr_4.2-36               jsonlite_2.0.0
## [27] blob_1.2.4                  rhdf5filters_1.22.0
## [29] keras_2.16.0                DelayedArray_0.36.0
## [31] Rhdf5lib_1.32.0             BiocParallel_1.44.0
## [33] parallel_4.5.1              tensorflow_2.20.0
## [35] R6_2.6.1                    bslib_0.9.0
## [37] stringi_1.8.7               reticulate_1.44.0
## [39] jquerylib_0.1.4             Rcpp_1.1.0
## [41] bookdown_0.45               SummarizedExperiment_1.40.0
## [43] knitr_1.50                  base64enc_0.1-3
## [45] Matrix_1.7-4                tidyselect_1.2.1
## [47] abind_1.4-8                 yaml_2.3.10
## [49] codetools_0.2-20            curl_7.0.0
## [51] lattice_0.22-7              tibble_3.3.0
## [53] withr_3.0.2                 KEGGREST_1.50.0
## [55] evaluate_1.0.5              zip_2.3.3
## [57] pillar_1.11.1               BiocManager_1.30.26
## [59] filelock_1.0.3              MatrixGenerics_1.22.0
## [61] whisker_0.4.1               RCurl_1.98-1.17
## [63] gtools_3.9.5                glue_1.8.0
## [65] mltools_0.3.5               tools_4.5.1
## [67] data.table_1.17.8           openxlsx_4.2.8
## [69] GenomicAlignments_1.46.0    XML_3.99-0.19
## [71] rhdf5_2.54.0                grid_4.5.1
## [73] restfulr_0.0.16             cli_3.6.5
## [75] rappdirs_0.3.3              tfruns_1.5.4
## [77] S4Arrays_1.10.0             dplyr_1.1.4
## [79] hash_2.2.6.3                zeallot_0.2.0
## [81] sass_0.4.10                 digest_0.6.37
## [83] SparseArray_1.10.0          rjson_0.2.23
## [85] memoise_2.0.1               htmltools_0.5.8.1
## [87] lifecycle_1.0.4             httr_1.4.7
## [89] bit64_4.6.0-1               MASS_7.3-65
```

Anzalone, A. V., P. B. Randolph, J. R. Davis, A. A. Sousa, L. W. Koblan, J. M. Levy, P. J. Chen, et al. 2019. “Search-and-Replace Genome Editing Without Double-Strand Breaks or Donor Dna.” Journal Article. *Nature* 576 (7785): 149–57. <https://doi.org/10.1038/s41586-019-1711-4>.

Bae, S., J. Park, and J. S. Kim. 2014. “Cas-Offinder: A Fast and Versatile Algorithm That Searches for Potential Off-Target Sites of Cas9 Rna-Guided Endonucleases.” Journal Article. *Bioinformatics* 30 (10): 1473–5. <https://doi.org/10.1093/bioinformatics/btu048>.

Chen, W., A. McKenna, J. Schreiber, M. Haeussler, Y. Yin, V. Agarwal, W. S. Noble, and J. Shendure. 2019. “Massively Parallel Profiling and Predictive Modeling of the Outcomes of Crispr/Cas9-Mediated Double-Strand Break Repair.” Journal Article. *Nucleic Acids Res* 47 (15): 7989–8003. <https://doi.org/10.1093/nar/gkz487>.

Doench, J. G., N. Fusi, M. Sullender, M. Hegde, E. W. Vaimberg, K. F. Donovan, I. Smith, et al. 2016. “Optimized sgRNA Design to Maximize Activity and Minimize Off-Target Effects of Crispr-Cas9.” Journal Article. *Nat Biotechnol* 34 (2): 184–91. <https://doi.org/10.1038/nbt.3437>.

Doench, J. G., E. Hartenian, D. B. Graham, Z. Tothova, M. Hegde, I. Smith, M. Sullender, B. L. Ebert, R. J. Xavier, and D. E. Root. 2014. “Rational Design of Highly Active sgRNAs for Crispr-Cas9-Mediated Gene Inactivation.” Journal Article. *Nat Biotechnol* 32 (12): 1262–7. <https://doi.org/10.1038/nbt.3026>.

Gaudelli, N. M., A. C. Komor, H. A. Rees, M. S. Packer, A. H. Badran, D. I. Bryson, and D. R. Liu. 2017. “Programmable Base Editing of a\*T to G\*C in Genomic Dna Without Dna Cleavage.” Journal Article. *Nature* 551 (7681): 464–71. <https://doi.org/10.1038/nature24644>.

Hsu, P. D., D. A. Scott, J. A. Weinstein, F. A. Ran, S. Konermann, V. Agarwala, Y. Li, et al. 2013. “DNA Targeting Specificity of Rna-Guided Cas9 Nucleases.” Journal Article. *Nat Biotechnol* 31 (9): 827–32. <https://doi.org/10.1038/nbt.2647>.

Kim, H. K., S. Min, M. Song, S. Jung, J. W. Choi, Y. Kim, S. Lee, S. Yoon, and H. H. Kim. 2018. “Deep Learning Improves Prediction of Crispr-Cpf1 Guide Rna Activity.” Journal Article. *Nat Biotechnol* 36 (3): 239–41. <https://doi.org/10.1038/nbt.4061>.

Komor, A. C., Y. B. Kim, M. S. Packer, J. A. Zuris, and D. R. Liu. 2016. “Programmable Editing of a Target Base in Genomic Dna Without Double-Stranded Dna Cleavage.” Journal Article. *Nature* 533 (7603): 420–4. <https://doi.org/10.1038/nature17946>.

Mali, P., J. Aach, P. B. Stranges, K. M. Esvelt, M. Moosburner, S. Kosuri, L. Yang, and G. M. Church. 2013. “CAS9 Transcriptional Activators for Target Specificity Screening and Paired Nickases for Cooperative Genome Engineering.” Journal Article. *Nat Biotechnol* 31 (9): 833–8. <https://doi.org/10.1038/nbt.2675>.

Moreno-Mateos, M. A., C. E. Vejnar, J. D. Beaudoin, J. P. Fernandez, E. K. Mis, M. K. Khokha, and A. J. Giraldez. 2015. “CRISPRscan: Designing Highly Efficient sgRNAs for Crispr-Cas9 Targeting in Vivo.” Journal Article. *Nat Methods* 12 (10): 982–8. <https://doi.org/10.1038/nmeth.3543>.

Zhu, Lihua Julie. 2015. “Overview of Guide Rna Design Tools for Crispr-Cas9 Genome Editing Technology.” Journal Article. *Frontiers in Biology* 10 (4): 289–96. <https://doi.org/10.1007/s11515-015-1366-y>.

Zhu, L. J., B. R. Holmes, N. Aronin, and M. H. Brodsky. 2014. “CRISPRseek: A Bioconductor Package to Identify Target-Specific Guide Rnas for Crispr-Cas9 Genome-Editing Systems.” Journal Article. *PLoS One* 9 (9): e108424. <https://doi.org/10.1371/journal.pone.0108424>.
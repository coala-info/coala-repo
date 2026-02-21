# SpliceWiz: Quick Start

#### Alex CH Wong

#### 10/30/2025

Abstract

This Quick-Start is a runnable example showing the functionalities of the SpliceWiz workflow. Version 1.12.0

# Introduction

SpliceWiz is a graphical interface for differential alternative splicing and visualization in R. It differs from other alternative splicing tools as it is designed for users with basic bioinformatic skills to analyze datasets containing up to hundreds of samples! SpliceWiz contains a number of innovations including:

* Super-fast handling of alignment BAM files using ompBAM, our developer resource for multi-threaded BAM processing,
* Alternative splicing event (ASE) filters to remove problematic ASEs from analysis
* Group-averaged coverage plots: publication-ready figures to clearly visualize differential alternative splicing between biological / experimental conditions
* Interactive figures, including scatter and volcano plots, gene ontology (GO) analysis, heatmaps, and scrollable coverage plots, powered using the shinyDashboard interface

This vignette is a runnable working example of the SpliceWiz workflow. The purpose is to quickly demonstrate the basic functionalities of SpliceWiz.

We provide here a brief outline of the workflow for users to get started as quickly as possible. However, we also provide more details for those wishing to know more. Many sections will contain extra information that can be displayed when clicked on, such as these:

Click on me for more details
In most sections, we offer more details about each step of the workflow, that can be revealed in text segments like this one. Be sure to click on buttons like these, where available.

# FAQ

What are the system memory requirements for running SpliceWiz
We recommend the following memory requirements (RAM) for running various steps of SpliceWiz:

**buildRef()**

* Building human / mouse SpliceWiz reference: 8 gigabytes

**processBAM()**

* Processing small alignment (BAM) files (~20 million paired end reads): 8 gigabytes
* Processing large BAM files (~100 million paired end reads): 16 gigabytes

**collateData()**

* Collating routine experiments (e.g. 3 replicates, 2 conditions): 8-16 gigabytes
* Collating large experiments (20+ samples, using `lowMemoryMode=TRUE`): 32 gigabytes
* Collating large experiments (20+ samples, using `lowMemoryMode=FALSE`): 8 gigabytes per thread

**Differential analysis**

* Differential analysis (routine experiments): 8 gigabytes
* Differential analysis (large experiments - 20+ samples): 16 gigabytes
* DESeq2-based differential analysis of large experiments: 32 gigabytes

How does SpliceWiz measure alternative splicing?

SpliceWiz defines alternative splicing events (ASEs) as binary events between two possibilities, the included and excluded isoform. It detects and measures: skipped (casette) exons (SE), mutually-exclusive exons (MXE), alternative 5’/3’ splice site usage (A5SS / A3SS), alternate first / last exon usage (AFE / ALE), and retained introns (IR or RI).

SpliceWiz uses splice-specific read counts to measure ASEs. Namely, these are junction reads (reads that align across splice sites). The exception is intron retention (IR) whereby the (trimmed) mean read depth across the intron is measured (identical to the method used in IRFinder).

SpliceWiz provides two metrics:

* Percent spliced in (PSI): is the expression of the included isoform as a proportion of both included/excluded isoform. PSIs are measured for all types of alternative splicing, including annotated retained introns (RI)
* IR-ratio: For introns, we also measure IR-ratios, which is the expression of IR-transcript as a proportion of IR- and spliced-transcripts. Spliced transcript expression is measured using either `SpliceOver` or `SpliceMax` method (the latter is identical to that used in IRFinder)

Does SpliceWiz detect novel splicing events?
Novel splicing events are those in which at least one isoform is not an annotated transcript in the given gene annotation. SpliceWiz DOES detect novel splicing events.

It detects novel events by using novel junctions, using pairs of junctions that originate from or terminate at a common coordinate (novel alternate splice site usage).

Additionally, SpliceWiz detects “tandem junction reads”. These are reads that span across two or more splice junctions. The region between splice junctions can then be annotated as novel exons (if they are not identical to annotated exons). These novel exons can then be used to measure novel casette exon usage.

# Workflow from a glance

The basic steps of SpliceWiz are as follows:

* Building the SpliceWiz reference
* Process BAM files using SpliceWiz
* Collate results of individual samples into an experiment
* Importing the collated experiment as an NxtSE object
* Alternative splicing event filtering
* Differential ASE analysis
* Visualization

# Quick-Start

## Installation

To install SpliceWiz, start R (devel version) and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("SpliceWiz")
```

Setting up a Conda environment to use SpliceWiz
For those wishing to set up a self-contained environment with SpliceWiz installed (e.g. on a high performance cluster), we recommend using miniconda. For installation instructions, see the [documentation on how to install miniconda](https://docs.conda.io/en/latest/miniconda.html)

After installing miniconda, create a conda environment as follows:

```
conda create -n envSpliceWiz python=3.9
```

After following the prompts, activate the environment:

```
conda activate envSpliceWiz
```

Next, install R 4.2.1 as follows:

```
conda install -c conda-forge r-base=4.2.1
```

NB: We have not been able to successfuly use r-base=4.3, so we recommend using r-base=4.2.1 (until further notice).

Many of SpliceWiz’s dependencies are up-to-date from the conda-forge channel, so they are best installed via conda:

```
conda install -c conda-forge r-devtools r-essentials r-xml r-biocmanager \
  r-fst r-plotly r-rsqlite r-rcurl
```

After this is done, the remainder of the packages need to be installed from the R terminal. This is because most Bioconductor packages are from the bioconda channel and appear not to be routinely updated.

So, lets enter the R terminal from the command line:

```
R
```

Set up Bioconductor 3.16 (which is the latest version compatible with R 4.2):

```
BiocManager::install(version = "3.16")
```

Again, follow the prompts to update any necessary packages.

Once this is done, install SpliceWiz (devel) from github:

```
# BiocManager::install("SpliceWiz")
devtools::install_github("alexchwong/SpliceWiz")
```

The last step will install any remaining dependencies, taking approximately 20-30 minutes depending on your system.

Enabling OpenMP (multi-threading) for MacOS users (Optional)
For **MacOS** users, make sure OpenMP libraries are installed correctly. We recommend users follow this [guide](https://mac.r-project.org/openmp/), but the quickest way to get started is to install `libomp` via brew:

```
brew install libomp
```

Installing statistical package dependencies (Optional)
SpliceWiz uses established statistical tools to perform alternative splicing differential analysis:

* limma: models included and excluded counts as log-normal distributions
* DESeq2: models included and excluded counts as negative binomial distributions
* edgeR: models included and excluded counts as negative binomial distributions. SpliceWiz uses the quasi-likelihood method which deals better with zero-counts.
* DoubleExpSeq: models included and excluded counts using beta binomial distributions

To install all of these packages:

```
install.packages("DoubleExpSeq")

BiocManager::install(c("DESeq2", "limma", "edgeR"))
```

## Loading SpliceWiz

```
library(SpliceWiz)
```

Details
The SpliceWiz package loads the `NxtIRFdata` data package. This data package contains the example “chrZ” genome / annotations and 6 example BAM files that are used in this working example. Also, NxtIRFdata provides pre-generated mappability exclusion annotations for building human and mouse SpliceWiz references

## The SpliceWiz Graphics User Interface (GUI)

SpliceWiz offers a graphical user interface (GUI) for interactive users, e.g. in the RStudio environment. To start using SpliceWiz GUI:

```
if(interactive()) {
    spliceWiz(demo = TRUE)
}
```

### Navigating the GUI

The SpliceWiz GUI uses the `shinyDashboard` interface. Use the side menu on the left hand side of the interface to navigate across the various sub-panels in the SpliceWiz GUI.

![SpliceWiz GUI - Menu Side Bar](data:image/jpeg;base64...)

SpliceWiz GUI - Menu Side Bar

## Building the SpliceWiz reference

Why do we need the SpliceWiz reference?
SpliceWiz first needs to generate a set of reference files. The SpliceWiz reference is used to quantitate alternative splicing in BAM files, as well as in downstream collation, differential analysis and visualisation.

SpliceWiz generates a reference from a user-provided genome FASTA and genome annotation GTF file, and is optimised for Ensembl references but can accept other reference GTF files. Alternatively, SpliceWiz accepts AnnotationHub resources, using the record names of AnnotationHub records as input.

Using the example FASTA and GTF files, use the `buildRef()` function to build the SpliceWiz reference:

```
ref_path <- file.path(tempdir(), "Reference")
buildRef(
    reference_path = ref_path,
    fasta = chrZ_genome(),
    gtf = chrZ_gtf(),
    ontologySpecies = "Homo sapiens"
)
```

The SpliceWiz reference can be viewed as data frames using various getter functions. For example, to view the annotated alternative splicing events (ASE):

```
df <- viewASE(ref_path)
```

See `?View-Reference-methods` for a comprehensive list of getter functions

Using the GUI
After starting the SpliceWiz GUI in demo mode, click the `Reference` tab from the menu side bar. The following interface will be shown:

![Building the SpliceWiz reference using the GUI](data:image/jpeg;base64...)

Building the SpliceWiz reference using the GUI

1. The first step to building a SpliceWiz reference is to select a directory in which to create the reference.
2. SpliceWiz provides an interface to retrieve the genome sequence (FASTA) and transcriptome annotation (GTF) files from the Ensembl FTP server, by first selecting the “Release” and then “Species” from the drop-down boxes.
3. Alternatively, users can provide their own FASTA and GTF files.
4. Human (hg38, hg19) and mouse genomes (mm10, mm9) have the option of further refining IR analysis using built-in mappability exclusion annotations, allowing SpliceWiz to ignore intronic regions of low mappability.

For now, to continue with the demo and create the reference using the GUI, click on the `Load Demo FASTA/GTF` (5), and then click `Build Reference` (6)

Where did the FASTA and GTF files come from?
The helper functions `chrZ_genome()` and `chrZ_gtf()` returns the paths to the example genome (FASTA) and transcriptome (GTF) file included with the `NxtIRFdata` package that contains the working example used by SpliceWiz:

```
# Provides the path to the example genome:
chrZ_genome()
#> [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/NxtIRFdata/extdata/genome.fa"

# Provides the path to the example gene annotation:
chrZ_gtf()
#> [1] "/home/biocbuild/bbs-3.22-bioc/R/site-library/NxtIRFdata/extdata/transcripts.gtf"
```

What is the chrZ genome?
For the purpose of generating a running example to demonstrate SpliceWiz, we created an artificial genome / gene annotation. This was created using 7 human genes (SRSF1, SRSF2, SRSF3, TRA2A, TRA2B, TP53 and NSUN5). The SRSF and TRA family of genes all contain poison exons flanked by retained introns. Additionally, NSUN5 contains an annotated IR event in its terminal intron. Sequences from these 7 genes were aligned into one sequence to create an artificial chromosome Z (chrZ). The gene annotations were modified to only contain the 7 genes with the modified genomic coordinates.

What is the gene ontology species?
SpliceWiz supports gene ontology analysis. To enable this capability, we first need to generate the gene ontology annotations for the appropriate species.

To see a list of supported species:

```
getAvailableGO()
#>    [1] "Anopheles gambiae"
#>    [2] "Arabidopsis thaliana"
#>    [3] "Bos taurus"
#>    [4] "Canis familiaris"
#>    [5] "Gallus gallus"
#>    [6] "Pan troglodytes"
#>    [7] "Escherichia coli"
#>    [8] "Drosophila melanogaster"
#>    [9] "Homo sapiens"
#>   [10] "Mus musculus"
#>   [11] "Sus scrofa"
#>   [12] "Rattus norvegicus"
#>   [13] "Macaca mulatta"
#>   [14] "Caenorhabditis elegans"
#>   [15] "Xenopus laevis"
#>   [16] "Saccharomyces cerevisiae"
#>   [17] "Danio rerio"
#>   [18] "Pseudophryne corroboree"
#>   [19] "Triticum aestivum"
#>   [20] "Triticum aestivum_subsp._aestivum"
#>   [21] "Triticum sativum"
#>   [22] "Triticum vulgare"
#>   [23] "Ambystoma mexicanum"
#>   [24] "Gyrinus mexicanus"
#>   [25] "Musa acuminata_AAA_Group"
#>   [26] "Brassica napus"
#>   [27] "Arachis hypogaea"
#>   [28] "Hibiscus syriacus"
#>   [29] "Cortia elata"
#>   [30] "Eulalia japonica"
#>   [31] "Levisticum argutum"
#>   [32] "Ligusticum elatum"
#>   [33] "Miscanthus floridulus"
#>   [34] "Miscanthus japonicus"
#>   [35] "Oreocome arguta"
#>   [36] "Saccharum floridulum"
#>   [37] "Acridium cancellatum"
#>   [38] "Schistocerca cancellata"
#>   [39] "Triticum dicoccoides"
#>   [40] "Triticum turgidum_subsp._dicoccoides"
#>   [41] "Triticum turgidum_var._dicoccoides"
#>   [42] "Dendrohyas sarda"
#>   [43] "Hyla arborea_sarda"
#>   [44] "Hyla sarda"
#>   [45] "Gryllus gregarius"
#>   [46] "Locusta gregaria"
#>   [47] "Schistocerca gregaria"
#>   [48] "Gossypium hirsutum"
#>   [49] "Gossypium hirsutum_subsp._mexicanum"
#>   [50] "Gossypium lanceolatum"
#>   [51] "Gossypium purpurascens"
#>   [52] "Camelina sativa"
#>   [53] "Myagrum sativum"
#>   [54] "Carassius auratus_gibelio"
#>   [55] "Carassius gibelio_gibelio"
#>   [56] "Carassius gibelio"
#>   [57] "Carassius gibelio_subsp._gibelio"
#>   [58] "Cyprinus gibelio"
#>   [59] "Acridium piceifrons"
#>   [60] "Schistocerca piceifrons"
#>   [61] "Papaver somniferum"
#>   [62] "Zingiber officinale"
#>   [63] "Trichomonas vaginalis_G3"
#>   [64] "Trichomonas vaginalis_strain_G3"
#>   [65] "Helianthus annuus"
#>   [66] "Schistocerca americana"
#>   [67] "Coffea arabica"
#>   [68] "Acipenser ruthenus"
#>   [69] "Acridium cubense"
#>   [70] "Schistocerca serialis_cubense"
#>   [71] "Panicum virgatum"
#>   [72] "Nicotiana tabacum"
#>   [73] "Oncorhynchus mykiss"
#>   [74] "Oncorhynchus nerka_mykiss"
#>   [75] "Parasalmo mykiss"
#>   [76] "Salmo mykiss"
#>   [77] "Gryllus nitens"
#>   [78] "Schistocerca nitens"
#>   [79] "Schistocerca vaga"
#>   [80] "Misgurnus dabryanus"
#>   [81] "Paramisgurnus dabryanus"
#>   [82] "Salvia splendens"
#>   [83] "Carassius carassius"
#>   [84] "Cyprinus carassius"
#>   [85] "Vicia villosa"
#>   [86] "Camellia sinensis"
#>   [87] "Thea sinensis"
#>   [88] "Hyperolius riggenbachi"
#>   [89] "Rappia riggenbachi"
#>   [90] "Oncorhynchus keta"
#>   [91] "Salmo keta"
#>   [92] "Pisum sativum"
#>   [93] "Salmo salar"
#>   [94] "Rutidosis leptorhynchoides"
#>   [95] "Rutidosis leptorrhynchoides"
#>   [96] "Raphanus sativus"
#>   [97] "Oncorhynchus kisutch"
#>   [98] "Oncorhyncus kisutch"
#>   [99] "Salmo kisatch"
#>  [100] "Lolium rigidum"
#>  [101] "Aegilops squarrosa_subsp._squarrosa"
#>  [102] "Aegilops squarrosa"
#>  [103] "Aegilops tauschii"
#>  [104] "Patropyrum tauschii_subsp._tauschii"
#>  [105] "Patropyrum tauschii"
#>  [106] "Triticum aegilops"
#>  [107] "Triticum tauschii"
#>  [108] "Eleutherodactylus coqui"
#>  [109] "Salmo trutta"
#>  [110] "Cryptomeria japonica"
#>  [111] "Cupressus japonica"
#>  [112] "Amia calva"
#>  [113] "Coregonus clupeaformis"
#>  [114] "Salmo clupeaformis"
#>  [115] "Oncorhynchus clarkii_lewisi"
#>  [116] "Oncorhynchus clarki_lewisi"
#>  [117] "Salar lewisi"
#>  [118] "Oncorhynchus gorbuscha"
#>  [119] "Salmo gorbuscha"
#>  [120] "Cyprinus carpio"
#>  [121] "Glycine max_subsp._soja"
#>  [122] "Glycine soja"
#>  [123] "Salmo fontinalis"
#>  [124] "Salvelinus fontinalis"
#>  [125] "Glycine max"
#>  [126] "Phaseolus max"
#>  [127] "Pleurodeles waltlii"
#>  [128] "Pleurodeles waltl"
#>  [129] "Chenopodium quinoa"
#>  [130] "Hordeum sativum"
#>  [131] "Hordeum vulgare_subsp._vulgare"
#>  [132] "Hordeum vulgare_var._nudum"
#>  [133] "Hordeum vulgare_var._vulgare"
#>  [134] "Humulus lupulus"
#>  [135] "Leuciscus parvus"
#>  [136] "Pseudorasbora parva"
#>  [137] "Festuca perennis_(L.)_Columbus_&_J.P.Sm.,_2010"
#>  [138] "Festuca perennis"
#>  [139] "Lolium perenne"
#>  [140] "Lolium vulgare"
#>  [141] "Gasterosteus pungitius"
#>  [142] "Pungitius pungitius"
#>  [143] "Pristiophorus japonicus"
#>  [144] "Oncorhynchus masou_masou"
#>  [145] "Salmo masou_masou"
#>  [146] "Oncorhynchus nerka"
#>  [147] "Salmo nerka"
#>  [148] "Crassostrea cucullata"
#>  [149] "Ostrea cuccullata"
#>  [150] "Saccostrea cuccullata"
#>  [151] "Barbus grahami"
#>  [152] "Sinocyclocheilus grahami"
#>  [153] "Salmo alpinus"
#>  [154] "Salvelinus alpinus"
#>  [155] "Nerophis lumbriciformis"
#>  [156] "Syngnathus lumbriciformis"
#>  [157] "Nicotiana sylvestris"
#>  [158] "Sinocyclocheilus rhinocerous"
#>  [159] "Nicotiana tomentosiformis"
#>  [160] "Gossypium arboreum"
#>  [161] "Brassica oleracea"
#>  [162] "Malus sylvestris"
#>  [163] "Pyrus malus_var._sylvestris"
#>  [164] "Astyanax mexicanus"
#>  [165] "Tetragonopterus mexicanus"
#>  [166] "Arachis stenosperma"
#>  [167] "Prosopis alba"
#>  [168] "Sinocyclocheilus anshuiensis"
#>  [169] "Malus communis"
#>  [170] "Malus domestica"
#>  [171] "Malus pumila_auct."
#>  [172] "Malus pumila_var._domestica"
#>  [173] "Malus sylvestris_var._domestica"
#>  [174] "Malus x_domestica"
#>  [175] "Pyrus malus"
#>  [176] "Pyrus malus_var._domestica"
#>  [177] "Brassica rapa"
#>  [178] "Lactuca sativa"
#>  [179] "Dreissena polymorpha"
#>  [180] "Mytilus polymorphus"
#>  [181] "Hydractinia symbiolongicarpus"
#>  [182] "Triticum urartu"
#>  [183] "Cornus florida"
#>  [184] "Hevea brasiliensis"
#>  [185] "Siphonia brasiliensis"
#>  [186] "Salvelinus sp._IW2-2015"
#>  [187] "Oncorhynchus tschawytscha"
#>  [188] "Oncorhynchus tshawytscha"
#>  [189] "Salmo tshawytscha"
#>  [190] "Bombina fusca"
#>  [191] "Bombinator fuscus"
#>  [192] "Bufo fuscus"
#>  [193] "Pelobates fuscus"
#>  [194] "Rana fusca"
#>  [195] "Arachis ipaensis"
#>  [196] "Zea mays"
#>  [197] "Zea mays_var._japonica"
#>  [198] "Salmo namaycush"
#>  [199] "Salvelinus namaycush"
#>  [200] "Hydra attenuata"
#>  [201] "Hydra carnea"
#>  [202] "Hydra littoralis"
#>  [203] "Hydra magnipapillata"
#>  [204] "Hydra vulgaris"
#>  [205] "Lepisosteus oculatus"
#>  [206] "Mytilus edulis"
#>  [207] "Arundo australis"
#>  [208] "Phragmites australis"
#>  [209] "Phragmites communis"
#>  [210] "Capsicum annuum"
#>  [211] "Brienomyrus brachyistius"
#>  [212] "Marcusenius brachyistius"
#>  [213] "Ruditapes philippinarum"
#>  [214] "Ruditapes (Venerupis)_philippinarum"
#>  [215] "Tapes japonica"
#>  [216] "Tapes philippinarum"
#>  [217] "Venerupis japonica"
#>  [218] "Venerupis philippinarum"
#>  [219] "Venerupis (Ruditapes)_philippinarum"
#>  [220] "Venus philippinarum"
#>  [221] "Convolvulus nil"
#>  [222] "Ipomoea nil"
#>  [223] "Pharbitis nil"
#>  [224] "Lycium barbarum"
#>  [225] "Olea europaea_subsp._europaea_var._sylvestris"
#>  [226] "Olea europaea_var._oleaster"
#>  [227] "Olea europaea_var._sylvestris"
#>  [228] "Olea europea_subsp._sylvestris"
#>  [229] "Olea sylvestris"
#>  [230] "Mytilus trossulus"
#>  [231] "Alosa sapidissima"
#>  [232] "Clupea sapidissima"
#>  [233] "Montipora capricornis"
#>  [234] "Carpiodes asiaticus"
#>  [235] "Myxocyprinus asiaticus"
#>  [236] "Esox malabaricus"
#>  [237] "Hoplias malabaricus"
#>  [238] "Macrodon malabaricus"
#>  [239] "Actinidia eriantha"
#>  [240] "Gossypium raimondii"
#>  [241] "Cololabis saira"
#>  [242] "Scomberesox saira"
#>  [243] "Catostomus texanus"
#>  [244] "Xyrauchen texanus"
#>  [245] "Cambarus clarkii"
#>  [246] "Procambarus clarkii"
#>  [247] "Doryrhamphus excisus"
#>  [248] "Madrepora foliosa"
#>  [249] "Montipora foliosa"
#>  [250] "Exopalaemon carinicauda"
#>  [251] "Palaemon carinicauda"
#>  [252] "Heptranchias perlo"
#>  [253] "Squalus perlo"
#>  [254] "Quercus lobata"
#>  [255] "Carya illinoensis"
#>  [256] "Carya illinoinensis"
#>  [257] "Mercenaria mercenaria"
#>  [258] "Venus mercenaria"
#>  [259] "Quercus robur"
#>  [260] "Durio zibethinus"
#>  [261] "Acropora copiosa"
#>  [262] "Acropora muricata"
#>  [263] "Millepora muricata"
#>  [264] "Platichthys flesus"
#>  [265] "Platicthys flesus"
#>  [266] "Pleuronectes flesus"
#>  [267] "Haliotis asinina"
#>  [268] "Alosa pilchardus"
#>  [269] "Clupea harengus_pilchardus"
#>  [270] "Clupea pilchardus"
#>  [271] "Sardina pilchardus"
#>  [272] "Dendrobates imitator"
#>  [273] "Ranitomeya imitator"
#>  [274] "Mya arenaria"
#>  [275] "Arachis duranensis"
#>  [276] "Arachis spegazzinii"
#>  [277] "Pyrus x_bretschneideri"
#>  [278] "Trifolium pratense"
#>  [279] "Dasypus fenestratus"
#>  [280] "Dasypus novemcinctus"
#>  [281] "Cobitis anguillicaudata"
#>  [282] "Misgurnus anguillicaudatus"
#>  [283] "Quercus suber"
#>  [284] "Scaphiopus bombifrons"
#>  [285] "Spea bombifrons"
#>  [286] "Haliotis rufenscens"
#>  [287] "Haliotis rufescens"
#>  [288] "Oreochromis nilotica"
#>  [289] "Oreochromis niloticus"
#>  [290] "Perca nilotica"
#>  [291] "Tilapia nilotica"
#>  [292] "Acropora convexa"
#>  [293] "Acropora millepora"
#>  [294] "Acropora singularis"
#>  [295] "Channa argus"
#>  [296] "Ophicephalus argus"
#>  [297] "Ophiocephalus argus"
#>  [298] "Cebus apella"
#>  [299] "Sapajus apella"
#>  [300] "Simia apella"
#>  [301] "Eucalyptus grandis"
#>  [302] "Macaca nemestrina"
#>  [303] "Simia nemestrina"
#>  [304] "Callithrix jacchus_jacchus"
#>  [305] "Callithrix jacchus"
#>  [306] "Simia jacchus"
#>  [307] "Pyrus balansae"
#>  [308] "Pyrus communis"
#>  [309] "Pistacia vera"
#>  [310] "Pteropus medius"
#>  [311] "Salvia miltiorhiza"
#>  [312] "Salvia miltiorrhiza"
#>  [313] "Daphnia pulicaria"
#>  [314] "Labrus mixtus"
#>  [315] "Pongo abelii"
#>  [316] "Pongo pygmaeus_abelii"
#>  [317] "Pongo pygmaeus_abeli"
#>  [318] "Magnolia sinica"
#>  [319] "Manglietia sinica"
#>  [320] "Manglietiastrum sinicum"
#>  [321] "Pachylarnax sinica_(Y.W.Law)_N.H.Xia_&_C.Y.Wu"
#>  [322] "Lycopersicon esculentum"
#>  [323] "Lycopersicon esculentum_var._esculentum"
#>  [324] "Solanum esculentum"
#>  [325] "Solanum lycopersicum"
#>  [326] "Solanum lycopersicum_var._humboldtii"
#>  [327] "Rosa chinensis"
#>  [328] "Rosa indica_auct.,_non_L."
#>  [329] "Mytilus californianus"
#>  [330] "Gorilla gorilla_gorilla"
#>  [331] "greater Indian_fruit_bat"
#>  [332] "Pteropus giganteus"
#>  [333] "Pteropus vampyrus"
#>  [334] "Vespertilio vampyrus"
#>  [335] "Chinemys reevesii"
#>  [336] "Chinemys reevesi"
#>  [337] "Emys reevesii"
#>  [338] "Geoclemys reevesii"
#>  [339] "Geoclemys reevessi"
#>  [340] "Mauremys reevesii"
#>  [341] "Mauremys reevesi"
#>  [342] "Choloepus brasiliensis_Fitzinger_1871"
#>  [343] "Choloepus brasiliensis"
#>  [344] "Choloepus didactylus"
#>  [345] "Bubalus arnee_carabanensis"
#>  [346] "Bubalus bubalis_carabanesis"
#>  [347] "Bubalus carabanensis_carabanensis"
#>  [348] "Bubalus carabanensis"
#>  [349] "Bubalus kerabau"
#>  [350] "Lotus corniculatus_var._japonicus"
#>  [351] "Lotus japonicus"
#>  [352] "Tupaia belangeri_chinensis"
#>  [353] "Tupaia chinensis"
#>  [354] "Clarias gariepinus"
#>  [355] "Clarias lazera"
#>  [356] "Silurus gariepinus"
#>  [357] "Rosa rugosa"
#>  [358] "Barbus tetrazona"
#>  [359] "Capoeta tetrazona"
#>  [360] "Puntigrus tetrazona"
#>  [361] "Puntius tetrazona"
#>  [362] "Systomus tetrazona"
#>  [363] "Lycium ferocissimum"
#>  [364] "Nicotiana attenuata"
#>  [365] "Cestracion francisci"
#>  [366] "Heterodontus francisci"
#>  [367] "Octodon degus"
#>  [368] "Sciurus degus"
#>  [369] "Haliotis rubra"
#>  [370] "Equus caballus"
#>  [371] "Equus przewalskii_f._caballus"
#>  [372] "Equus przewalskii_forma_caballus"
#>  [373] "Spinacia oleracea"
#>  [374] "Haliotis cracherodii"
#>  [375] "Paramecium aurelia_syngen_4"
#>  [376] "Paramecium tetraurelia"
#>  [377] "Macaca cynomolgus"
#>  [378] "Macaca fascicularis"
#>  [379] "Macaca irus"
#>  [380] "Simia fascicularis"
#>  [381] "Salvia hispanica"
#>  [382] "Medicago truncatula"
#>  [383] "Crassostrea virginica"
#>  [384] "Ostrea virginica"
#>  [385] "Oryza sativa_(japonica_cultivar-group)"
#>  [386] "Oryza sativa_Japonica_Group"
#>  [387] "Oryza sativa_subsp._japonica"
#>  [388] "Felis catus"
#>  [389] "Felis domesticus"
#>  [390] "Felis silvestris_catus"
#>  [391] "Anubis baboon"
#>  [392] "Papio anubis"
#>  [393] "Papio cynocephalus_anubis"
#>  [394] "Papio doguera"
#>  [395] "Papio hamadryas_anubis"
#>  [396] "Papio hamadryas_doguera"
#>  [397] "Simia anubis"
#>  [398] "Dipodomys merriami"
#>  [399] "Sorex etruscus"
#>  [400] "Suncus etruscus"
#>  [401] "Daucus carota_subsp._sativus"
#>  [402] "Daucus carota_var._sativus"
#>  [403] "Mimosa cineraria"
#>  [404] "Prosopis cineraria"
#>  [405] "Lepus cuniculus"
#>  [406] "Oryctolagus cuniculus"
#>  [407] "Ptychodera erythraea"
#>  [408] "Ptychodera flava"
#>  [409] "Nycticebus coucang"
#>  [410] "Tardigradus coucang"
#>  [411] "Rhododendron vialii"
#>  [412] "Nematostella vectensis"
#>  [413] "Ixodes dammini"
#>  [414] "Ixodes scapularis"
#>  [415] "Lupinus angustifolius"
#>  [416] "Populus nigra"
#>  [417] "Populus pyramidalis"
#>  [418] "Littorina saxatilis"
#>  [419] "Turbo saxatilis"
#>  [420] "Ipomoea triloba"
#>  [421] "Pan paniscus"
#>  [422] "Emiliania huxleyi_CCMP1516"
#>  [423] "Emiliania huxleyi_CCMP2090"
#>  [424] "Mangifera indica"
#>  [425] "Nothobranchius furzeri"
#>  [426] "Pteropus alecto"
#>  [427] "Hylobates syndactylus"
#>  [428] "Simia syndactyla"
#>  [429] "Symphalangus syndactylus"
#>  [430] "Rana temporaria"
#>  [431] "Crassostrea angulata"
#>  [432] "Gryphaea angulata"
#>  [433] "Magallana angulata"
#>  [434] "Etheostoma spectabile"
#>  [435] "Poecilichthys spectabilis"
#>  [436] "Macadamia integrifolia"
#>  [437] "Megalobrama amblycephala"
#>  [438] "Halichoerus grypus"
#>  [439] "Phoca grypus"
#>  [440] "Juglans regia"
#>  [441] "Kungiselaginella moellendorffii"
#>  [442] "Selaginella moellendorffii"
#>  [443] "Selaginella moellendorfii"
#>  [444] "Pleuronectes platessa"
#>  [445] "Presbytis francoisi"
#>  [446] "Trachypithecus francoisi"
#>  [447] "Diadema antillarum"
#>  [448] "Tripterygium wilfordii"
#>  [449] "Dermacentor albipictus"
#>  [450] "Ixodes albipictus"
#>  [451] "Aotus nancymaae"
#>  [452] "Aotus nancymai"
#>  [453] "Aranea bruennichi"
#>  [454] "Argiope bruennichi"
#>  [455] "Rhinichthys klamathensis_goyatoka"
#>  [456] "Huro salmoides"
#>  [457] "Labrus salmoides"
#>  [458] "Labrus salmonides"
#>  [459] "Micropterus nigricans"
#>  [460] "Micropterus salmoides"
#>  [461] "Solanum stenotomum"
#>  [462] "Heterocephalus glaber"
#>  [463] "Pongo pygmaeus"
#>  [464] "Simia pygmaeus"
#>  [465] "Cavia aperea_porcellus"
#>  [466] "Cavia cobaya"
#>  [467] "Cavia porcellus"
#>  [468] "Mus porcellus"
#>  [469] "Arius graeffei"
#>  [470] "Neoarius graeffei"
#>  [471] "Dendropsophus ebraccatus"
#>  [472] "Hyla ebraccata"
#>  [473] "Neosciurus carolinensis"
#>  [474] "Sciurus carolinensis"
#>  [475] "Cervus elaphus"
#>  [476] "Polyodon spathula"
#>  [477] "Squalus spathula"
#>  [478] "Gadus chalcogrammus"
#>  [479] "Theragra chalcogramma"
#>  [480] "Bos bubalis"
#>  [481] "Bubalus arnee_bubalis"
#>  [482] "Bubalus bubalis"
#>  [483] "Pleuronectes solea"
#>  [484] "Solea solea"
#>  [485] "Solea vulgaris"
#>  [486] "Conger conger"
#>  [487] "Muraena conger"
#>  [488] "Mastomys coucha"
#>  [489] "Praomys coucha"
#>  [490] "Impatiens glandulifera"
#>  [491] "Dermacentor andersoni"
#>  [492] "Felis nebulosa"
#>  [493] "Neofelis nebulosa"
#>  [494] "Pteropus egyptiacus"
#>  [495] "Rousettus aegyptiacus"
#>  [496] "Rousettus aegypticus"
#>  [497] "Rousettus egyptiacus"
#>  [498] "Phoenix dactylifera"
#>  [499] "Pimephales promelas"
#>  [500] "Ostrea edulis"
#>  [501] "Peromyscus maniculatus_bairdii"
#>  [502] "Populus alba"
#>  [503] "Trichomycterus rosablanca"
#>  [504] "Odocoileus virginianus"
#>  [505] "Petaurus breviceps_papuanus"
#>  [506] "Petaurus sp._CYF-2022"
#>  [507] "Cricetus auratus"
#>  [508] "Golden hamsters"
#>  [509] "Mesocricetus auratus"
#>  [510] "Syrian hamsters"
#>  [511] "Ornithodoros americanus"
#>  [512] "Ornithodoros turicata_americanus"
#>  [513] "Ornithodoros turicata"
#>  [514] "Chromis aureus"
#>  [515] "Oreochromis aurea"
#>  [516] "Oreochromis aureus"
#>  [517] "Dermacentor silvarum"
#>  [518] "Chanodichthys erythropterus"
#>  [519] "Cullter erythropterus"
#>  [520] "Culter erythropterus"
#>  [521] "Cultrichthys erythropterus"
#>  [522] "Erythroculter erythropterus"
#>  [523] "Felis geoffroyi"
#>  [524] "Leopardus geoffroyi"
#>  [525] "Oncifelis geoffroyi"
#>  [526] "Atherina mordax"
#>  [527] "Osmerus mordax"
#>  [528] "Entelurus aequoreus"
#>  [529] "Syngnathus aequoreus"
#>  [530] "Euphorbia lathyris"
#>  [531] "Felis yagouaroundi"
#>  [532] "Herpailurus yagouaroundi"
#>  [533] "Herpailurus yaguarondi"
#>  [534] "Puma yagouaroundii"
#>  [535] "Puma yagouaroundi"
#>  [536] "Chrysemys bellii"
#>  [537] "Chrysemys picta_bellii"
#>  [538] "Chrysemys picta_subsp._bellii"
#>  [539] "Ovis ammon_aries"
#>  [540] "Ovis aries"
#>  [541] "Ovis orientalis_aries"
#>  [542] "Ovis ovis"
#>  [543] "Cervus canadensis"
#>  [544] "Populus diversifolia"
#>  [545] "Populus euphratica"
#>  [546] "Cucurbita pepo_subsp._pepo"
#>  [547] "Cucurbita pepo_var._medullosa"
#>  [548] "Cucurbita pepo_var._pepo"
#>  [549] "Emys muticus"
#>  [550] "Geoclemmys mutica"
#>  [551] "Mauremys mutica"
#>  [552] "Coffea eugeniodes"
#>  [553] "Coffea eugenioides"
#>  [554] "Suricata suricatta"
#>  [555] "Viverra suricatta"
#>  [556] "Hylobates moloch"
#>  [557] "Simia moloch"
#>  [558] "Solanum dulcamara"
#>  [559] "Cucurbita moschata"
#>  [560] "Clupea encrasicolus"
#>  [561] "Engraulis encrasicolus"
#>  [562] "Cucurbita maxima"
#>  [563] "Macaca thibetana_thibetana"
#>  [564] "Centropristis striata"
#>  [565] "Labrus striatus"
#>  [566] "Cannabis sativa"
#>  [567] "Bos banteng"
#>  [568] "Bos javanicus"
#>  [569] "Bos sondaicus"
#>  [570] "Panthera onca"
#>  [571] "Nerophis ophidion"
#>  [572] "Syngnathus ophidion"
#>  [573] "Gastrolobium bilobum"
#>  [574] "Jaculus jaculus"
#>  [575] "Mus jaculus"
#>  [576] "Dioscorea cayenensis_subsp._rotundata_(Poir.)_J.Miege,_1968"
#>  [577] "Dioscorea cayenensis_subsp._rotundata"
#>  [578] "Dioscorea rotundata"
#>  [579] "Cercopithecus aethiops_sabaeus"
#>  [580] "Cercopithecus sabaeus"
#>  [581] "Cercopithecus sabeus"
#>  [582] "Chlorocebus aethiops_sabaeus"
#>  [583] "Chlorocebus aethiops_sabeus"
#>  [584] "Chlorocebus sabaeus"
#>  [585] "Chlorocebus sabeus"
#>  [586] "Simia sabaea"
#>  [587] "Ovis canadensis"
#>  [588] "Ostrea echinata"
#>  [589] "Saccostrea echinata"
#>  [590] "Sexostrea echinata"
#>  [591] "Juglans microcarpa_x_Juglans_regia"
#>  [592] "Marmota monax"
#>  [593] "Mus monax"
#>  [594] "Equus caballus_przewalskii"
#>  [595] "Equus ferus_przewalskii"
#>  [596] "Equus przewalskii"
#>  [597] "Pygathrix roxellana"
#>  [598] "Rhinopithecus roxellana"
#>  [599] "Semnopithecus roxellana"
#>  [600] "Callorhinus ursinus"
#>  [601] "Callorhynus ursius"
#>  [602] "Phoca ursina"
#>  [603] "Cricetulus barabensis_griseus"
#>  [604] "Cricetulus griseus"
#>  [605] "Elephantulus edwardii"
#>  [606] "Macroscelides edwardii"
#>  [607] "Cobitis heteroclita"
#>  [608] "Fundulus heteroclitus"
#>  [609] "Neothunnus macropterus"
#>  [610] "Scomber albacares"
#>  [611] "Thunnus albacares"
#>  [612] "Meriones unguiculatus"
#>  [613] "Telopea speciosissima"
#>  [614] "Danio aesculapii"
#>  [615] "Danio sp._'snakeskin'"
#>  [616] "Danio sp._snakeskin"
#>  [617] "Apodemus sylvaticus"
#>  [618] "Mus sylvaticus"
#>  [619] "Sylvaemus sylvaticus"
#>  [620] "Populus balsamifera_subsp._trichocarpa"
#>  [621] "Populus trichocarpa"
#>  [622] "Cervus dama"
#>  [623] "Dama dama"
#>  [624] "Mercurialis ambigua"
#>  [625] "Mercurialis annua"
#>  [626] "Eugenia oleosa"
#>  [627] "Syzygium oleosum"
#>  [628] "Citellus tridecemlineatus"
#>  [629] "Ictidomys tridecemlineatus"
#>  [630] "Sciurus tridecemlineatus"
#>  [631] "Spermophilus tridecemlineatus"
#>  [632] "Arctomys flaviventer"
#>  [633] "Marmota flaviventris"
#>  [634] "Osmerus eperlanus"
#>  [635] "Salmo eperlanus"
#>  [636] "Solanum verrucosum"
#>  [637] "Felis pardus"
#>  [638] "Leo pardus"
#>  [639] "Panthera pardus"
#>  [640] "Microtus oregoni"
#>  [641] "Arabidopsis lyrata_subsp._lyrata"
#>  [642] "Arabis lyrata_subsp._lyrata"
#>  [643] "Manihot esculenta"
#>  [644] "Manihot utilissima"
#>  [645] "Mustela erminea"
#>  [646] "Dolichos unguiculatus"
#>  [647] "Phaseolus unguiculatus"
#>  [648] "Vigna unguiculata"
#>  [649] "Lycopersicon pennellii_(Correll)_D'Arcy,_1982"
#>  [650] "Solanum pennellii_Correll,_1958"
#>  [651] "Solanum pennellii"
#>  [652] "Panicum viride"
#>  [653] "Setaria viridis"
#>  [654] "Bos indicus"
#>  [655] "Bos primigenius_indicus"
#>  [656] "Bos taurus_indicus"
#>  [657] "Gymnostomus macrolepis"
#>  [658] "Onychostoma macrolepis"
#>  [659] "Scaphesthes macrolepis"
#>  [660] "Varicorhinus macrolepis"
#>  [661] "Varicorhinus (Scaphesthes)_macrolepis"
#>  [662] "Oryza glaberrima"
#>  [663] "Phaseolus vulgaris"
#>  [664] "Pelteobagrus fulvidraco"
#>  [665] "Pimelodus fulvidraco"
#>  [666] "Pseudobagrus fulvidraco"
#>  [667] "Tachysurus fulvidraco"
#>  [668] "Hylobates concolor_leucogenys"
#>  [669] "Hylobates concolor_leucogyneus"
#>  [670] "Hylobates leucogenys_leucogenys"
#>  [671] "Hylobates leucogenys"
#>  [672] "Nomascus leucogenys_leucogenys"
#>  [673] "Nomascus leucogenys"
#>  [674] "Nomascus leukogenys"
#>  [675] "Nannospalax ehrenbergi_galili"
#>  [676] "Nannospalax galili"
#>  [677] "Spalax galili"
#>  [678] "Scomber thynnus"
#>  [679] "Thunnus thynnus"
#>  [680] "Thunnus maccoyii"
#>  [681] "Thynnus maccoyii"
#>  [682] "Equus asinus"
#>  [683] "Chromis diagramma"
#>  [684] "Simochromis diagramma"
#>  [685] "Diplophysa dalaica"
#>  [686] "Triplophysa dalaica"
#>  [687] "Felis tigris"
#>  [688] "Panthera tigris"
#>  [689] "Echinus purpuratus"
#>  [690] "Strongylocentrotus purpuratus"
#>  [691] "Lucioperca lucioperca"
#>  [692] "Perca lucioperca"
#>  [693] "Sander lucioperca"
#>  [694] "Stizostedion lucioperca"
#>  [695] "Dipodomys spectabilis"
#>  [696] "Acinonyx jubatus"
#>  [697] "Felis jubata"
#>  [698] "Conyza canadensis"
#>  [699] "Erigeron canadensis"
#>  [700] "Mustela lutreola"
#>  [701] "Camelus bactrianus_ferus"
#>  [702] "Camelus ferus"
#>  [703] "Aristolochia californica"
#>  [704] "Crassostrea gigas"
#>  [705] "Magallana gigas"
#>  [706] "Ostrea gigas"
#>  [707] "Cajanus cajan"
#>  [708] "Dysidea avara"
#>  [709] "Spongelia avara"
#>  [710] "Didelphys domestica"
#>  [711] "Monodelphis domestica"
#>  [712] "Pygathrix bieti"
#>  [713] "Rhinopithecus bieti"
#>  [714] "Saimiri boliviensis"
#>  [715] "Hesperomys eremicus"
#>  [716] "Peromyscus eremicus"
#>  [717] "Arabidopsis salsuginea"
#>  [718] "Eutrema salsugineum"
#>  [719] "Hesperis salsuginea"
#>  [720] "Sisymbrium salsugineum"
#>  [721] "Stenophragma salsugineum"
#>  [722] "Thellungiella salsuginea"
#>  [723] "Thelypodium salsugineum"
#>  [724] "Coetomys damarensis"
#>  [725] "Cryptomys damarensis"
#>  [726] "Fukomys damarensis"
#>  [727] "Cervus reevesi"
#>  [728] "Muntiacus reevesi"
#>  [729] "Limanda limanda"
#>  [730] "Liopsetta limanda"
#>  [731] "Pleuronectes limanda"
#>  [732] "Rhamnus zizyphus"
#>  [733] "Ziziphus jujuba"
#>  [734] "Leptonychotes weddellii"
#>  [735] "Leptonychotes weddelli"
#>  [736] "Otaria weddellii"
#>  [737] "Grammomys dolichurus_surdaster"
#>  [738] "Grammomys surdaster"
#>  [739] "Thamnomys surdaster"
#>  [740] "Solanum aracc-papa"
#>  [741] "Solanum tuberosum"
#>  [742] "Andropogon sorghum"
#>  [743] "Holcus bicolor"
#>  [744] "Sorghum bicolor"
#>  [745] "Sorghum bicolor_subsp._bicolor"
#>  [746] "Sorghum nervosum"
#>  [747] "Sorghum saccharatum"
#>  [748] "Sorghum vulgare"
#>  [749] "Madrepora verrucosa"
#>  [750] "Pocillopora danae"
#>  [751] "Pocillopora verrucosa"
#>  [752] "Holocentrus calcarifer"
#>  [753] "Lates calcarifer"
#>  [754] "Hippopotamus amphibius_kiboko"
#>  [755] "Ixodes sanguineus"
#>  [756] "Rhipicephalus sanguineus"
#>  [757] "Clupea harengus_harengus"
#>  [758] "Clupea harengus"
#>  [759] "Bos indicus_x_Bos_taurus"
#>  [760] "Bos primigenius_indicus_x_Bos_primigenius_taurus"
#>  [761] "Bos taurus_indicus_x_Bos_taurus_taurus"
#>  [762] "Bos taurus_x_Bos_indicus"
#>  [763] "Chrysochloris asiatica"
#>  [764] "Talpa asiatica"
#>  [765] "Bufo bufo"
#>  [766] "Rana bufo"
#>  [767] "Pelmatolapia mariae"
#>  [768] "Tilapia mariae"
#>  [769] "Maylandia callainos"
#>  [770] "Maylandia zebra"
#>  [771] "Metriaclima callainos"
#>  [772] "Metriaclima zebra"
#>  [773] "Pseudotropheus callainos"
#>  [774] "Pseudotropheus sp._'Pseudotropheus_zebra_complex'"
#>  [775] "Pseudotropheus zebra"
#>  [776] "Tilapia zebra"
#>  [777] "Saccopteryx bilineata"
#>  [778] "Urocryptus bilineatus"
#>  [779] "Ictalurus punctatus"
#>  [780] "Silurus punctatus"
#>  [781] "Trachinotus anak"
#>  [782] "Antilope dammah"
#>  [783] "Oryx dammah"
#>  [784] "Asparagus litoralis"
#>  [785] "Asparagus officinalis"
#>  [786] "Amaranthus gangeticus"
#>  [787] "Amaranthus mangostanus"
#>  [788] "Amaranthus tricolor"
#>  [789] "Aequipecten irradians"
#>  [790] "Argopecten irradians"
#>  [791] "Pecten irradians"
#>  [792] "Macrobrachium nipponense"
#>  [793] "Palaemon nipponense"
#>  [794] "Pneumatophorus japonicus"
#>  [795] "Scomber japonicus"
#>  [796] "Alnus glutinosa"
#>  [797] "Betula alnus_var._glutinosa"
#>  [798] "Saccopteryx leptura"
#>  [799] "Vespertilio lepturus"
#>  [800] "Lutra lutra"
#>  [801] "Peromyscus leucopus"
#>  [802] "Perca fluviatilis"
#>  [803] "Elephas africanus"
#>  [804] "Loxodonta africana_africana"
#>  [805] "Loxodonta africana"
#>  [806] "Pagothenia bernacchii"
#>  [807] "Pseudotrematomus bernacchii"
#>  [808] "Trematomus bernacchii"
#>  [809] "Trematomus bernacchi"
#>  [810] "Lipurus cinereus"
#>  [811] "Phascolarctos cinereus"
#>  [812] "Anguilla rostrata"
#>  [813] "Muraena rostrata"
#>  [814] "Mustela furo"
#>  [815] "Mustela putorius_furo"
#>  [816] "Chaetochloa italica"
#>  [817] "Panicum italicum"
#>  [818] "Pennisetum macrochaetum"
#>  [819] "Setaria italica"
#>  [820] "Setaria viridis_subsp._italica"
#>  [821] "Elaeis guineensis"
#>  [822] "Mus rattus"
#>  [823] "Rattus rattoides"
#>  [824] "Rattus rattus"
#>  [825] "Rattus wroughtoni"
#>  [826] "Acropora digitifera"
#>  [827] "Madrepora digitifera"
#>  [828] "Echinops telfairii"
#>  [829] "Echinops telfairi"
#>  [830] "Myotis daubentonii"
#>  [831] "Myotis daubentoni"
#>  [832] "Vespertilio daubentonii"
#>  [833] "Limia formosa"
#>  [834] "Mollienesia formosa"
#>  [835] "Poecilia formosa"
#>  [836] "Macrorhinus angustirostris"
#>  [837] "Mirounga angustirostris"
#>  [838] "Phyllostomus discolor"
#>  [839] "Phocoena crassidens"
#>  [840] "Pseudoorca crassidens"
#>  [841] "Pseudorca crassidens"
#>  [842] "Erinaceus europaeus"
#>  [843] "Hemiscyllium ocellatum"
#>  [844] "Squalus ocellatus"
#>  [845] "Microcebus murinus"
#>  [846] "Peromyscus californicus_insignis"
#>  [847] "Peromyscus californicus_subsp._insignis"
#>  [848] "Galago garnettii"
#>  [849] "Galago garnetti"
#>  [850] "Otolemur garnettii"
#>  [851] "Otolicnus garnettii"
#>  [852] "Arvicanthis niloticus"
#>  [853] "Mus niloticus"
#>  [854] "Didelphis ursina"
#>  [855] "Vombatus ursinus"
#>  [856] "Phaseolus angularis"
#>  [857] "Vigna angularis"
#>  [858] "Haitia acuta"
#>  [859] "Physa acuta"
#>  [860] "Physa heterostropha"
#>  [861] "Physa integra"
#>  [862] "Physella acuta"
#>  [863] "Physella heterostropha"
#>  [864] "Physella integra"
#>  [865] "Ctenopharyngodon idella"
#>  [866] "Ctenopharyngodon idellus"
#>  [867] "Leuciscus idella"
#>  [868] "Thalassophryne amazonica"
#>  [869] "Macrobrachium dacqueti_(Sunier,_1925)"
#>  [870] "Macrobrachium rosenbergii"
#>  [871] "Palaemon rosenbergii"
#>  [872] "Cyprinus rohita"
#>  [873] "Labeo rohita"
#>  [874] "Talpa occidentalis"
#>  [875] "Bombina bombina"
#>  [876] "Rana bombina"
#>  [877] "Amphibalanus amphitrite"
#>  [878] "Balanus amphitrite"
#>  [879] "Cynocephalus volans"
#>  [880] "Lemur volans"
#>  [881] "Panicum hallii"
#>  [882] "Angill angill"
#>  [883] "Anguilla anguilla_anguilla"
#>  [884] "Anguilla anguilla"
#>  [885] "Muraena anguilla"
#>  [886] "Fringilla domestica"
#>  [887] "Passer domesticus"
#>  [888] "Delphinus orca"
#>  [889] "Orcinus orca"
#>  [890] "Penaeus bubulus"
#>  [891] "Penaeus carinatus"
#>  [892] "Penaeus durbani"
#>  [893] "Penaeus monodon"
#>  [894] "Penaeus (Penaeus)_monodon"
#>  [895] "Didelphis vulpecula"
#>  [896] "Trichosurus vulpecula"
#>  [897] "Myotis lucifugus"
#>  [898] "Vespertilio lucifugus"
#>  [899] "Brachypodium distachyon"
#>  [900] "Bromus distachyos"
#>  [901] "Ailuropoda melanoleuca"
#>  [902] "Micropterus dolomieu"
#>  [903] "Micropterus velox"
#>  [904] "Labrus bergylta"
#>  [905] "Poecilia mexicana"
#>  [906] "Manis pentadactyla"
#>  [907] "Meles meles"
#>  [908] "Ursus meles"
#>  [909] "Ornithorhynchus anatinus"
#>  [910] "Platypus anatinus"
#>  [911] "Camelus dromedarius"
#>  [912] "Felis uncia"
#>  [913] "Panthera uncia"
#>  [914] "Uncia uncia"
#>  [915] "Alligator mississippiensis"
#>  [916] "Crocodilus mississipiensis"
#>  [917] "Myrmecophaga aculeata"
#>  [918] "Tachyglossus aculeatus"
#>  [919] "Pseudochaenichthys georgianus"
#>  [920] "Colossoma macropomum"
#>  [921] "Myletes macropomus"
#>  [922] "Cordylus capensis"
#>  [923] "Cordylus (Hemicordylus)_capensis"
#>  [924] "Hemicordylus capensis"
#>  [925] "Pseudocordylus capensis"
#>  [926] "Zonurus capensis"
#>  [927] "Eptesicus fuscus"
#>  [928] "Vespertilio fuscus"
#>  [929] "Dromiciops australis"
#>  [930] "Dromiciops gliroides"
#>  [931] "Camelus pacos"
#>  [932] "Lama guanicoe_pacos"
#>  [933] "Lama pacos"
#>  [934] "Vicugna pacos"
#>  [935] "Mollienesia latipinna"
#>  [936] "Poecilia latipinna"
#>  [937] "Elephas maximus_indicus"
#>  [938] "Balaena glacialis"
#>  [939] "Eubalaena glacialis"
#>  [940] "Corylus avellana"
#>  [941] "Ostrea maxima"
#>  [942] "Pecten maximus"
#>  [943] "Felis viverrina"
#>  [944] "Prionailurus viverrinus"
#>  [945] "Gymnodraco acuticeps"
#>  [946] "Thalarctos maritimus"
#>  [947] "Ursus maritimus"
#>  [948] "Lemur catta"
#>  [949] "Bodianus pulcher"
#>  [950] "Labrus pulcher"
#>  [951] "Semicossyphus pulcher"
#>  [952] "Lepus capensis_europaeus"
#>  [953] "Lepus europaeus"
#>  [954] "Myotis myotis"
#>  [955] "Vespertilio myotis"
#>  [956] "Ursus arctos"
#>  [957] "Vitis riparia"
#>  [958] "Felis bengalensis"
#>  [959] "Prionailurus bengalensis"
#>  [960] "Clethrionomys glareolus"
#>  [961] "Mus glareolus"
#>  [962] "Myodes glareolus"
#>  [963] "Mustela nigripes"
#>  [964] "Putorius nigripes"
#>  [965] "Alopex lagopus"
#>  [966] "Canis lagopus"
#>  [967] "Vulpes lagopus"
#>  [968] "Cercocebus atys"
#>  [969] "Cercocebus torquatus_atys"
#>  [970] "Simia atys"
#>  [971] "Lepidosiren annectens"
#>  [972] "Protopterus annectens"
#>  [973] "Rhinocryptis annectens"
#>  [974] "Cerasus avium"
#>  [975] "Prunus avium"
#>  [976] "Prunus cerasus_var._avium"
#>  [977] "Gadus macrocephalus"
#>  [978] "Hippoglossus olivaceus"
#>  [979] "Paralichthys olivaceus"
#>  [980] "Sorex fumeus"
#>  [981] "Scomber scomber"
#>  [982] "Scomber scombrus"
#>  [983] "Beta vulgaris_subsp._vulgaris"
#>  [984] "Beta vulgaris_subsp._vulgaris_var._altissima"
#>  [985] "Beta vulgaris_Sugar_Beet_Group"
#>  [986] "Beta vulgaris_var._altissima"
#>  [987] "Balaenoptera ricei"
#>  [988] "Eumetopias jubatus"
#>  [989] "Phoca jubata"
#>  [990] "Centruroides sculpturatus"
#>  [991] "Diceros bicornis_minor"
#>  [992] "Myotis yumanensis"
#>  [993] "Vespertilio yumanensis"
#>  [994] "Cicer arietinum"
#>  [995] "Cleome hassleriana_Chodat,_1898"
#>  [996] "Tarenaya hassleriana"
#>  [997] "Sebastes umbrosus"
#>  [998] "Sebastichthys umbrosus"
#>  [999] "Dasyatis sabina"
#> [1000] "Hypanus sabinus"
#> [1001] "Trygon sabina"
#> [1002] "Eriocheir chinensis"
#> [1003] "Eriocheir japonica_sinensis"
#> [1004] "Eriocheir sinensis"
#> [1005] "Lacerta scincoides"
#> [1006] "Tiliqua scincoides"
#> [1007] "Cynara cardunculus_subsp._cardunculus"
#> [1008] "Bos grunniens_mutus"
#> [1009] "Bos mutus"
#> [1010] "Poephagus mutus"
#> [1011] "Acanthopagrus latus"
#> [1012] "Sparus latus"
#> [1013] "Xiphophorus hellerii"
#> [1014] "Xiphophorus helleri"
#> [1015] "Acanthochromis polyacanthus"
#> [1016] "Acanthochromis polyacathus"
#> [1017] "Dascyllus polyacanthus"
#> [1018] "Mustela vison"
#> [1019] "Neogale vison"
#> [1020] "Neovison vison"
#> [1021] "Lingula anatina"
#> [1022] "Lingula lingua"
#> [1023] "Lingula nipponica"
#> [1024] "Lingula unguis"
#> [1025] "Glomus irregulare_Blaszk.,_Wubet,_Renker_&_Buscot_2009"
#> [1026] "Rhizophagus irregularis_(Baszk.,_Wubet,_Renker_&_Buscot)_C._Walker_&_A._Schusler,_2010"
#> [1027] "Rhizophagus irregularis"
#> [1028] "Narcine bancroftii"
#> [1029] "Torpedo bancroftii"
#> [1030] "Madrepora faveolata"
#> [1031] "Montastraea faveolata"
#> [1032] "Montastrea faveolata"
#> [1033] "Orbicella faveolata"
#> [1034] "Esox lucius"
#> [1035] "Austroberyx affinis"
#> [1036] "Beryx affinis"
#> [1037] "Centroberyx affinis"
#> [1038] "Chinchilla lanigera"
#> [1039] "Chinchilla velligera"
#> [1040] "Chinchilla villidera"
#> [1041] "Mirounga leonina"
#> [1042] "Phoca leonina"
#> [1043] "Perognathus longimembris_pacificus"
#> [1044] "Cynocephalus variegatus"
#> [1045] "Galeopithecus variegatus"
#> [1046] "Galeopterus variegatus"
#> [1047] "Desmodus rotundus"
#> [1048] "Phyllostoma rotundum"
#> [1049] "Vigna radiata"
#> [1050] "Characodon multiradiatus"
#> [1051] "Girardinichthys multiradiatus"
#> [1052] "Phaseolus calcaratus"
#> [1053] "Phaseolus chrysanthos"
#> [1054] "Phaseolus chrysanthus"
#> [1055] "Vigna calcarata"
#> [1056] "Vigna umbellata"
#> [1057] "Balaenoptera acutorostrata"
#> [1058] "Canis procyonoides"
#> [1059] "Nyctereutes procyonoides"
#> [1060] "Amphioxus floridae"
#> [1061] "Branchiostoma floridae"
#> [1062] "Moschus berezovskii"
#> [1063] "Erythranthe guttata"
#> [1064] "Mimulus guttatus_subsp._guttatus"
#> [1065] "Mimulus guttatus"
#> [1066] "Camelus bactrianus"
#> [1067] "Octopus sinensis"
#> [1068] "Alexandromys fortis"
#> [1069] "Microtus fortis"
#> [1070] "Dendronephthya gigantea"
#> [1071] "Canis hyaena"
#> [1072] "Hyaena hyaena"
#> [1073] "Myxine glutinosa"
#> [1074] "Physeter catodon"
#> [1075] "Physeter macrocephalus"
#> [1076] "Vitis vinifera"
#> [1077] "Vitis vinifera_subsp._vinifera"
#> [1078] "Helicophagus hypophthalmus"
#> [1079] "Pangasianodon hypophthalmus"
#> [1080] "Pangasius hypophthalmus"
#> [1081] "Pangasius sutchi"
#> [1082] "Capsella rubella"
#> [1083] "Perkinsus marinus_ATCC_50983"
#> [1084] "Holocentrus leopardus"
#> [1085] "Plectropomus leopardus"
#> [1086] "Hippocampus zosterae"
#> [1087] "Artibeus jamaicensis"
#> [1088] "Citrus sinensis"
#> [1089] "Punica granatum"
#> [1090] "Abrus cyaneus"
#> [1091] "Abrus precatorius"
#> [1092] "Polypterus senegalus"
#> [1093] "Acomys russatus"
#> [1094] "Mus russatus"
#> [1095] "Hemibagrus wyckioides"
#> [1096] "Macrones wyckioides"
#> [1097] "Mystus wyckioides"
#> [1098] "Melanotaenia boesemani"
#> [1099] "Balaenoptera robusta"
#> [1100] "Eschrichtius gibbosus"
#> [1101] "Eschrichtius robustus"
#> [1102] "Sturnira hondurensis"
#> [1103] "Sturnira ludovici_hondurensis"
#> [1104] "Amphilophus centrarchus"
#> [1105] "Archocentrus centrarchus"
#> [1106] "Cichlasoma centrarchus"
#> [1107] "Heros centrarchus"
#> [1108] "Delphinus melas"
#> [1109] "Globicephala melaena"
#> [1110] "Globicephala melas"
#> [1111] "Manis javanica"
#> [1112] "Phyllostomus hastatus"
#> [1113] "Vespertilio hastatus"
#> [1114] "Scyliorhinus canicula"
#> [1115] "Squalus canicula"
#> [1116] "Pipistrellus deserti"
#> [1117] "Pipistrellus kuhlii_deserti"
#> [1118] "Pipistrellus kuhlii"
#> [1119] "Pipistrellus kuhli"
#> [1120] "Vespertilio kuhlii"
#> [1121] "Silurana tropicalis"
#> [1122] "Xenopus laevis_tropicalis"
#> [1123] "Xenopus (Silurana)_tropicalis"
#> [1124] "Xenopus tropicalis"
#> [1125] "Solea senegalensis"
#> [1126] "Branchiostoma lanceolatum"
#> [1127] "Limax lanceolatus"
#> [1128] "Mugil cephalotus"
#> [1129] "Mugil cephalus"
#> [1130] "Mugil galapagensis"
#> [1131] "Mugil japonicus"
#> [1132] "Capra aegagrus_hircus"
#> [1133] "Capra hircus"
#> [1134] "Poeciliopsis prolifica"
#> [1135] "Latimeria chalumnae"
#> [1136] "Gopherus flavomarginatus"
#> [1137] "Lontra canadensis"
#> [1138] "Lutra canadensis"
#> [1139] "Hesperomys torridus"
#> [1140] "Onychomys torridus"
#> [1141] "Boophilus microplus"
#> [1142] "Rhipicephalus (Boophilus)_microplus"
#> [1143] "Rhipicephalus microplus"
#> [1144] "Molossus molossus"
#> [1145] "Vespertilio molossus"
#> [1146] "Lagenorhynchus obliquidens"
#> [1147] "Sagmatias obliquidens"
#> [1148] "Syngnathus typhle"
#> [1149] "Delphinus cymodoce"
#> [1150] "Delphinus truncatus"
#> [1151] "Tursiops cymodoce"
#> [1152] "Tursiops truncatus"
#> [1153] "Antilope sumatraensis"
#> [1154] "Capricornis sumatraensis"
#> [1155] "Capricornis sumatrensis"
#> [1156] "Naemorhedus sumatraensis"
#> [1157] "Morone flavescens"
#> [1158] "Perca flavescens"
#> [1159] "Arvicola nivalis"
#> [1160] "Chionomys nivalis"
#> [1161] "Microtus nivalis"
#> [1162] "Felis rufus"
#> [1163] "Lynx rufus"
#> [1164] "Siphostoma scovelli"
#> [1165] "Syngnathus scovelli"
#> [1166] "Myotis brandtii"
#> [1167] "Vespertilio brandtii"
#> [1168] "Astatotilapia burtoni"
#> [1169] "Chromis burtoni"
#> [1170] "Haplochromis burtoni"
#> [1171] "Sorex araneus"
#> [1172] "Kogia breviceps"
#> [1173] "Physeter breviceps"
#> [1174] "Silurus meridionalis"
#> [1175] "Silurus soldatovi_meridionalis"
#> [1176] "Cucumis melo"
#> [1177] "Anoplopoma fimbria"
#> [1178] "Gadus fimbria"
#> [1179] "Lagenorhynchus albirostris"
#> [1180] "Alosa alosa"
#> [1181] "Clupea alosa"
#> [1182] "Chelonia mydas"
#> [1183] "Testudo mydas"
#> [1184] "Ctenocephalides felis"
#> [1185] "Stylophora pistillata"
#> [1186] "Eulemur rufifrons"
#> [1187] "Cyrtodiopsis dalmanii"
#> [1188] "Diopsis dalmanni"
#> [1189] "Teleopsis dalmanni"
#> [1190] "Rhagoletis zephyria"
#> [1191] "Rhodamnia argentea"
#> [1192] "Gasterosteus aculeatus"
#> [1193] "Labrus celidotus"
#> [1194] "Notolabrus celidotus"
#> [1195] "Budorcas taxicolor"
#> [1196] "Nelumbo nucifera"
#> [1197] "Amphiprion ocellaris"
#> [1198] "Arvicola amphibius"
#> [1199] "Arvicola terrestris_(Linnaeus,_1758)"
#> [1200] "Mus amphibius"
#> [1201] "Daphnia magna"
#> [1202] "Psammomys obesus"
#> [1203] "Carlito syrichta"
#> [1204] "Simia syrichta"
#> [1205] "Tarsius syrichta"
#> [1206] "Cyprinodon tularosa"
#> [1207] "Arvicola princeps"
#> [1208] "Ochotona princeps"
#> [1209] "Phytophthora sojae"
#> [1210] "Phoca vitulina"
#> [1211] "Coecilia bivitatum"
#> [1212] "Rhinatrema bivitattum"
#> [1213] "Rhinatrema bivittatum"
#> [1214] "Lagomys curzoniae"
#> [1215] "Ochotona curzonae"
#> [1216] "Ochotona curzoniae"
#> [1217] "Litopenaeus vannamei"
#> [1218] "Penaeus (Litopenaeus)_vannamei"
#> [1219] "Penaeus vannamei"
#> [1220] "Clupea cyprinoides"
#> [1221] "Megalops cyprinoides"
#> [1222] "Diospyros lotus"
#> [1223] "Hippoglossus stenolepis"
#> [1224] "Phacochoerus africanus"
#> [1225] "Sus africanus"
#> [1226] "Corythoichthys intestinalis"
#> [1227] "Syngnatus intestinalis"
#> [1228] "Mandrillus leucophaeus"
#> [1229] "Papio leucophaeus"
#> [1230] "Simia leucophaea"
#> [1231] "Scylla paramamosain"
#> [1232] "Lepidosternon floridanum"
#> [1233] "Rhineura floridana"
#> [1234] "Delphinus densirostris"
#> [1235] "Mesoplodon densirostris"
#> [1236] "Epinephelus fuscoguttatus"
#> [1237] "Perca summana_fuscoguttata"
#> [1238] "Asterias miniata"
#> [1239] "Asterina miniata"
#> [1240] "Patiria miniata"
#> [1241] "Lampris incognitus"
#> [1242] "Monachus schauinslandi"
#> [1243] "Neomonachus schauinslandi"
#> [1244] "Hippoglossus hippoglossus"
#> [1245] "Pleuronectes hippoglossus"
#> [1246] "Andrographis paniculata"
#> [1247] "Etheostoma cragini"
#> [1248] "Perca chuatsi"
#> [1249] "Siniperca chuatsi"
#> [1250] "Colobus angolensis_palliatus"
#> [1251] "Notothenia coriiceps"
#> [1252] "Hypomesus transpacificus"
#> [1253] "Clytia hemisphaerica"
#> [1254] "Clytia languida"
#> [1255] "Clytia viridicans"
#> [1256] "Medusa hemisphaerica"
#> [1257] "Dermochelys coriacea"
#> [1258] "Testudo coriacea"
#> [1259] "Bufo bufo_gargarizans"
#> [1260] "Bufo gargarizans"
#> [1261] "Bufo japonicus_gargarizans"
#> [1262] "Equus burchellii_quagga"
#> [1263] "Equus quagga"
#> [1264] "Delphinapterus leucas"
#> [1265] "Delphinus leucas"
#> [1266] "Fugu flavidus"
#> [1267] "Takifugu flavidus"
#> [1268] "Pteronotus mesoamericanus"
#> [1269] "Pteronotus parnellii_mesoamericanus"
#> [1270] "Citrus clementina"
#> [1271] "Citrus deliciosa_x_Citrus_sinensis"
#> [1272] "Citrus x_clementina"
#> [1273] "Fugu rubripes"
#> [1274] "Sphaeroides rubripes"
#> [1275] "Takifugu rubripes"
#> [1276] "Tetraodon rubripes"
#> [1277] "Homarus americanus"
#> [1278] "Osteoglossum formosum"
#> [1279] "Scleropages formosus"
#> [1280] "Larimichthys crocea"
#> [1281] "Pseudosciaena amblyceps"
#> [1282] "Pseudosciaena crocea"
#> [1283] "Sciaena crocea"
#> [1284] "Fragaria vesca"
#> [1285] "Folsomia candida"
#> [1286] "Seriola aureovittata"
#> [1287] "Seriola lalandi_aureovittata"
#> [1288] "Helops morio"
#> [1289] "Zophobas atratus_f._morio"
#> [1290] "Zophobas morio"
#> [1291] "Limulus polyphemus"
#> [1292] "Monoculus polyphemus"
#> [1293] "Doryrhamphus dactyliophorus"
#> [1294] "Dunckerocampus dactyliophorus"
#> [1295] "Syngnathus dactyliophorus"
#> [1296] "Epinephelus lanceolatus"
#> [1297] "Holocentrus lanceolatus"
#> [1298] "Promicrops lanceolatus"
#> [1299] "Mizuhopecten yessoensis"
#> [1300] "Patinopecten yessoensis"
#> [1301] "Patiopecten yessoensis"
#> [1302] "Pecten yessoensis"
#> [1303] "Platypoecilus maculatus"
#> [1304] "Xiphophorus maculatus"
#> [1305] "Fenneropenaeus indicus"
#> [1306] "Penaeus (Fenneropenaeus)_indicus"
#> [1307] "Penaeus indicus"
#> [1308] "Triplophysa rosa"
#> [1309] "Pempheris klunzingeri"
#> [1310] "Antechinus flavipes"
#> [1311] "Phascogale flavipes"
#> [1312] "Anolis carolinensis"
#> [1313] "Delphinus delphis"
#> [1314] "Anabrus simplex"
#> [1315] "Apodichthys violaceus"
#> [1316] "Cebidichthys violaceus"
#> [1317] "Oryza brachyantha"
#> [1318] "Emydura macquarii_macquarii"
#> [1319] "Emys macquaria_macquaria"
#> [1320] "Tetrahymena thermophila_SB210"
#> [1321] "Amygdalus communis"
#> [1322] "Amygdalus dulcis"
#> [1323] "Prunus amygdalus"
#> [1324] "Prunus communis"
#> [1325] "Prunus dulcis"
#> [1326] "Prunus dulcis_var._sativa"
#> [1327] "Oryzias latipes"
#> [1328] "Poecilia latipes"
#> [1329] "Bagrus vachellii"
#> [1330] "Pelteobagrus vachellii"
#> [1331] "Pseudobagrus vachellii"
#> [1332] "Pseudobagrus vachelli"
#> [1333] "Tachysurus vachellii"
#> [1334] "Sarcophilus harrisii"
#> [1335] "Sarcophilus laniarius_(Owen,_1838)"
#> [1336] "Sarcophilus laniarius"
#> [1337] "Ursinus harrisii"
#> [1338] "Ictalurus furcatus"
#> [1339] "Pimelodus furcatus"
#> [1340] "Amphioxus belcheri"
#> [1341] "Branchiostoma belcheri"
#> [1342] "Gigantopelta aegis"
#> [1343] "Echinus variegatus"
#> [1344] "Lytechinus variegatus"
#> [1345] "Antennarius striatus"
#> [1346] "Lophius striatus"
#> [1347] "Diaphorina citri"
#> [1348] "Diaphornia citri"
#> [1349] "Epinephelus moara"
#> [1350] "Serranus moara"
#> [1351] "Stegodyphus dumicola"
#> [1352] "Boleophthalmus pectinirostris"
#> [1353] "Gobius pectinirostris"
#> [1354] "Austrofundulus limnaeus"
#> [1355] "Scypha ciliata"
#> [1356] "Spongia ciliata"
#> [1357] "Sycon ciliatum"
#> [1358] "Pleuronectes maximus"
#> [1359] "Psetta maxima"
#> [1360] "Rhombus maximus"
#> [1361] "Scophthalmus maximus"
#> [1362] "Sesamum indicum"
#> [1363] "Sesamum orientale"
#> [1364] "Clinocottus analis"
#> [1365] "Oligocottus analis"
#> [1366] "Necator americanus"
#> [1367] "Armeniaca mume"
#> [1368] "Prunus mume"
#> [1369] "Myotis aurascens"
#> [1370] "Myotis davidii"
#> [1371] "Myotis hajastanicus"
#> [1372] "Vespertilio Davidii"
#> [1373] "Didelphys agilis"
#> [1374] "Gracilinanus agilis"
#> [1375] "Acanthophacelus reticulata"
#> [1376] "Poecilia (Acanthophacelus)_reticulata"
#> [1377] "Poecilia latipinna_reticulata"
#> [1378] "Poecilia reticulata"
#> [1379] "Armigeres subalbatus"
#> [1380] "Culex subalbatus"
#> [1381] "Australorbis glabratus"
#> [1382] "Biomphalaria glabrata"
#> [1383] "Planorbis glabratus"
#> [1384] "Hypudaeus ochrogaster"
#> [1385] "Microtus ochrogaster"
#> [1386] "Amygdalus persica"
#> [1387] "Persica vulgaris"
#> [1388] "Prunus persica"
#> [1389] "Prunus persica_var._densa"
#> [1390] "Xenia sp._Carnegie-2017"
#> [1391] "Chiloscyllium plagiosum"
#> [1392] "Scyllium plagiosum"
#> [1393] "Cheilinus undulatus"
#> [1394] "Coluber guttatus"
#> [1395] "Elaphe guttata"
#> [1396] "Pantherophis guttatus"
#> [1397] "Phodopus roborovskii"
#> [1398] "Caenorhabditis remanei"
#> [1399] "Caenorhabditis vulgaris"
#> [1400] "Lamprologus brichardi"
#> [1401] "Neolamprologus brichardi"
#> [1402] "Eleginops maclovinus"
#> [1403] "Eleginus maclovinus"
#> [1404] "Gymnopis unicolor"
#> [1405] "Microcaecilia unicolor"
#> [1406] "Rhinatrema unicolor"
#> [1407] "Sciaena jaculatrix"
#> [1408] "Toxotes jaculatrix"
#> [1409] "Emys pileata"
#> [1410] "Malaclemys terrapin_pileata"
#> [1411] "Lacerta sicula_raffonei"
#> [1412] "Podarcis raffoneae"
#> [1413] "Podarcis raffonei"
#> [1414] "Podarcis wagleriana_raffonei"
#> [1415] "Benincasa cerifera"
#> [1416] "Benincasa hispida"
#> [1417] "Benincasa pruriens"
#> [1418] "Cucurbita hispida"
#> [1419] "Lagenaria siceraria_var._hispida"
#> [1420] "Dendrobium catenatum"
#> [1421] "Chaetodon armatus"
#> [1422] "Enoplosus armatus"
#> [1423] "Marsupenaeus japonicus"
#> [1424] "Penaeus japonicus"
#> [1425] "Penaeus (Marsupenaeus)_japonicus"
#> [1426] "Penaeus (Melicertus)_japonicus"
#> [1427] "Chaetodon argus"
#> [1428] "Scatophagus argus"
#> [1429] "Anas boschas"
#> [1430] "Anas domesticus"
#> [1431] "Anas platyrhynchos_f._domestica"
#> [1432] "Anas platyrhynchos"
#> [1433] "Chanos chanos"
#> [1434] "Mugil chanos"
#> [1435] "Bison bison_bison"
#> [1436] "Bos bison_bison"
#> [1437] "Amblyraja radiata"
#> [1438] "Raja radiata"
#> [1439] "Delphinus phocoena"
#> [1440] "Phocoena phocoena"
#> [1441] "Phocoenoides phocoena"
#> [1442] "Amphimedon queenslandica"
#> [1443] "Hippocampus comes"
#> [1444] "Hipposideros armiger"
#> [1445] "Rhinolophus armiger"
#> [1446] "Cynoglossus (Arelia)_semilaevis"
#> [1447] "Cynoglossus semilaevis"
#> [1448] "Alecto japonica"
#> [1449] "Anneissia japonica"
#> [1450] "Oxycomanthus japonicus"
#> [1451] "Ananas comosus"
#> [1452] "Ananas comosus_var._comosus"
#> [1453] "Ananas lucidus"
#> [1454] "Bromelia comosa"
#> [1455] "Callionymus splendidus"
#> [1456] "Pterosynchiropus splendidus"
#> [1457] "Synchiropus splendidus"
#> [1458] "Neophocaena asiaeorientalis_asiaeorientalis"
#> [1459] "Pollicipes cornucopia"
#> [1460] "Pollicipes pollicipes"
#> [1461] "Pseudoliparis swirei"
#> [1462] "Blatta americana"
#> [1463] "Periplaneta americana"
#> [1464] "Rhincodon typus"
#> [1465] "Ricinus communis"
#> [1466] "Ricinus sanguineus"
#> [1467] "Anomalospiza imberbis"
#> [1468] "Crithagra imberbis"
#> [1469] "Phyllopteryx taeniolatus"
#> [1470] "Syngnatus taeniolatus"
#> [1471] "Lytechinus pictus"
#> [1472] "Psammechinus pictus"
#> [1473] "Brachionichthys hirsutus"
#> [1474] "Lophius hirsutus"
#> [1475] "Malania oleifera"
#> [1476] "Schizoporella aterrima_var._subatra"
#> [1477] "Watersipora subatra"
#> [1478] "Heteronota binoei"
#> [1479] "Heteronotia binoei"
#> [1480] "Trichomonas foetus"
#> [1481] "Tritrichomonas foetus"
#> [1482] "Aedes albopictus"
#> [1483] "Stegomyia albopicta"
#> [1484] "Ceratotherium simum_simum"
#> [1485] "Kryptolebias marmoratus"
#> [1486] "Rivulus marmoratus"
#> [1487] "Patella vulgata"
#> [1488] "Rhagoletis pomonella"
#> [1489] "Trypanosoma cruzi"
#> [1490] "Squalus fasciatus"
#> [1491] "Squalus tigrinus"
#> [1492] "Stegostoma fasciatum"
#> [1493] "Stegostoma tigrinum"
#> [1494] "Cistudo triunguis"
#> [1495] "Terrapene mexicana_triunguis"
#> [1496] "Terrapene triunguis"
#> [1497] "Odobenus rosmarus_divergens"
#> [1498] "Trichechus divergens"
#> [1499] "Manatus latirostris"
#> [1500] "Trichechus manatus_latirostris"
#> [1501] "Carcharodon carcharias"
#> [1502] "Squalus carcharias"
#> [1503] "Macrognathus armatus"
#> [1504] "Mastacembelus armatus"
#> [1505] "Theobroma cacao"
#> [1506] "Diabrotica virgifera_virgifera"
#> [1507] "Syngnathoides biaculeatus"
#> [1508] "Syngnathus biaculeatus"
#> [1509] "Actinia diaphana"
#> [1510] "Aiptasia pallida"
#> [1511] "Aiptasia pulchella"
#> [1512] "Dysactis pallida"
#> [1513] "Exaiptasia diaphana"
#> [1514] "Exaiptasia pallida"
#> [1515] "Syngnathus acus_rubescens"
#> [1516] "Syngnathus acus"
#> [1517] "Syngnathus rubescens"
#> [1518] "Guillardia theta_CCMP2712"
#> [1519] "Anarrhichthys ocellatus"
#> [1520] "Caretta caretta"
#> [1521] "Testudo caretta"
#> [1522] "Pelodiscus sinensis"
#> [1523] "Trionyx sinensis"
#> [1524] "Anas acuta"
#> [1525] "Xiphias gladius"
#> [1526] "Cyprinodon variegatus"
#> [1527] "Alligator sinensis"
#> [1528] "Morus notabilis"
#> [1529] "Embiotoca jacksonii"
#> [1530] "Embiotoca jacksoni"
#> [1531] "Nymphaea colorata"
#> [1532] "Lampyris pyralis"
#> [1533] "Photinus pyralis"
#> [1534] "Chaetodon trifascialis"
#> [1535] "Meleagris gallopavo"
#> [1536] "Pomacea canaliculata"
#> [1537] "Haplochromis nyererei"
#> [1538] "Pundamilia nyererei"
#> [1539] "Dixiphia pipra"
#> [1540] "Parus pipra"
#> [1541] "Pipra pipra"
#> [1542] "Pseudopipra pipra"
#> [1543] "Caranx dumerili"
#> [1544] "Seriola dumerili"
#> [1545] "Macrosteles (Macrosteles)_quadrilineatus"
#> [1546] "Macrosteles quadrilineatus"
#> [1547] "Lampetra reissneri"
#> [1548] "Lethenteron reissneri"
#> [1549] "Petromyzon reissneri"
#> [1550] "Enhydra lutris_kenyoni"
#> [1551] "Fluta alba"
#> [1552] "Monopterus albus"
#> [1553] "Muraena alba"
#> [1554] "Caecilia seraphini"
#> [1555] "Geotrypetes seraphini"
#> [1556] "Hypogeophis seraphini"
#> [1557] "Chaetodon rostratus"
#> [1558] "Chelmon rostratus"
#> [1559] "Cucumis sativus"
#> [1560] "Cyrtodactylus macularius"
#> [1561] "Eublepharis macularius"
#> [1562] "Aphelocoma coerulescens"
#> [1563] "Corvus coerulescens"
#> [1564] "Felis concolor"
#> [1565] "Panthera concolor"
#> [1566] "Puma concolor"
#> [1567] "Cephalopterus hypostomus"
#> [1568] "Mobula hypostoma"
#> [1569] "Cancer chinensis"
#> [1570] "Fenneropenaeus chinensis"
#> [1571] "Penaeus chinensis"
#> [1572] "Pomacentrus partitus"
#> [1573] "Stegastes partitus"
#> [1574] "Phascum patens"
#> [1575] "Physcomitrella patens_subsp._patens"
#> [1576] "Physcomitrella patens"
#> [1577] "Physcomitrium patens"
#> [1578] "Anas jamaicensis"
#> [1579] "Oxyura jamaicensis"
#> [1580] "Drosophila miranda"
#> [1581] "Lottia gigantea"
#> [1582] "Crotalus tigris"
#> [1583] "Eurytemora carolleeae"
#> [1584] "Argentina anserina"
#> [1585] "Potentilla anserina"
#> [1586] "Struthio camelus_domesticus"
#> [1587] "Struthio camelus"
#> [1588] "Uranotaenia lowii"
#> [1589] "Cynolebias whitei"
#> [1590] "Nematolebias whitei"
#> [1591] "Simpsonichthys whitei"
#> [1592] "Sceloporus undulatus"
#> [1593] "Stellio undulatus"
#> [1594] "Helobdella robusta"
#> [1595] "Anolis sagrei"
#> [1596] "Norops sagrei"
#> [1597] "Styela clava"
#> [1598] "Manis afer_afer"
#> [1599] "Orycteropus afer_afer"
#> [1600] "Leucoraja erinaceus"
#> [1601] "Raja erinaceus"
#> [1602] "Phytophthora nicotianae_INRA-310"
#> [1603] "Brachyistius frenatus"
#> [1604] "Micrometrus frenatus"
#> [1605] "Anas olor"
#> [1606] "Cygnus olor"
#> [1607] "Lacerta agilis"
#> [1608] "Phycodurus eques"
#> [1609] "Phyllopteryx eques"
#> [1610] "Coluber reginae"
#> [1611] "Erythrolamprus reginae"
#> [1612] "Leimadophis reginae"
#> [1613] "Liophis reginae"
#> [1614] "Millepora damicornis"
#> [1615] "Pocillopora caespitosa_laysanensis"
#> [1616] "Pocillopora damicornis_laysanensis"
#> [1617] "Pocillopora damicornis"
#> [1618] "Morone saxatilis"
#> [1619] "Perca saxatilis"
#> [1620] "Columba livia_domestica"
#> [1621] "Columba livia"
#> [1622] "Miniopterus natalensis"
#> [1623] "Miniopterus schreibersii_natalensis"
#> [1624] "Vespertilio natalensis"
#> [1625] "Buthus vittatus"
#> [1626] "Centruroides vittatus"
#> [1627] "Actinia tenebrosa"
#> [1628] "Neptunus trituberculatus"
#> [1629] "Portunus (Portunus)_trituberculatus"
#> [1630] "Portunus trituberculatus"
#> [1631] "Lacerta vivipara"
#> [1632] "Zootoca vivipara"
#> [1633] "Jatropha curcas"
#> [1634] "Propithecus coquereli"
#> [1635] "Propithecus verreauxi_coquereli"
#> [1636] "Amusium balloti"
#> [1637] "Amusium japonicum_balloti"
#> [1638] "Pecten balloti"
#> [1639] "Ylistrum balloti"
#> [1640] "Emys orbicularis"
#> [1641] "Testudo orbicularis"
#> [1642] "Caenorhabditis briggsae"
#> [1643] "Rhabditis briggsae"
#> [1644] "Homalodisca coagulata"
#> [1645] "Homalodisca vitripennis"
#> [1646] "Tettigonia coagulata"
#> [1647] "Tettigonia vitripennis"
#> [1648] "Corticium candelabrum"
#> [1649] "Python bivittatus"
#> [1650] "Python molurus_bivittatus"
#> [1651] "Chrysemys scripta_elegans"
#> [1652] "Emys elegans"
#> [1653] "Pseudemys scripta_elegans"
#> [1654] "Trachemys scripta_elegans"
#> [1655] "Protobothrops mucrosquamatus"
#> [1656] "Trigonocephalus mucrosquamatus"
#> [1657] "Trimeresurus mucrosquamatus"
#> [1658] "Daphnia pulex"
#> [1659] "Paramacrobiotus metropolitanus"
#> [1660] "Lipotes vexillifer"
#> [1661] "Columba fasciata"
#> [1662] "Patagioenas fasciata"
#> [1663] "Petromyzon marinus"
#> [1664] "Falco albicilla"
#> [1665] "Haliaeetus albicilla"
#> [1666] "Poephila guttata"
#> [1667] "Taeniopygia guttata"
#> [1668] "Taenopygia guttata"
#> [1669] "Aplysia californica"
#> [1670] "Phalaenopsis equestris"
#> [1671] "Stauroglottis equestris"
#> [1672] "Palinurus ornatus"
#> [1673] "Panulirus ornatus"
#> [1674] "Balanoglossus kowalevskii"
#> [1675] "Saccoglossus kowalevskii"
#> [1676] "Saccoglossus kowalevskyi"
#> [1677] "Momordica charantia"
#> [1678] "Numida meleagris"
#> [1679] "Phasianus meleagris"
#> [1680] "Callorhinchus milii"
#> [1681] "Halichondria (Halichondria)_panicea"
#> [1682] "Halichondria panicea"
#> [1683] "Spongia panicea"
#> [1684] "Sphaerodactylus townsendi"
#> [1685] "Achaearanea tepidariorum"
#> [1686] "Parasteatoda tepidariorum"
#> [1687] "Theridion tepidariorum"
#> [1688] "Elgaria multicarinata_webbii"
#> [1689] "Elgaria multicarinata_webbi"
#> [1690] "Gerrhonotus webbii"
#> [1691] "Eutainia elegans"
#> [1692] "Thamnophis elegans"
#> [1693] "Corvus hawaiiensis"
#> [1694] "Manacus candei"
#> [1695] "Pipra candei"
#> [1696] "Chamaea fasciata"
#> [1697] "Parus fasciatus"
#> [1698] "Pezoporus flaviventris"
#> [1699] "Pezoporus wallicus_flaviventris_North,_1911"
#> [1700] "Pezoporus wallicus_flaviventris"
#> [1701] "Apteryx mantelli"
#> [1702] "Euleptes europaea"
#> [1703] "Euleptes europea"
#> [1704] "Phyllodactylus europaea"
#> [1705] "Phyllodactylus europaeus"
#> [1706] "Ptyodactylus caudivolvolus"
#> [1707] "Megarhinus septentrionalis"
#> [1708] "Toxorhynchites rutilus_septentrionalis"
#> [1709] "Altirana parkeri"
#> [1710] "Nanorana parkeri"
#> [1711] "Ahaetulla prasina"
#> [1712] "Dryophis prasinus"
#> [1713] "Metopolophium dirhodum"
#> [1714] "Fusarium oxysporum_f._sp._lycopersici_4287"
#> [1715] "Heteropelma chrysocephalum"
#> [1716] "Neopelma chrysocephalum"
#> [1717] "Melanerpes formicivorus"
#> [1718] "Picus formicivorus"
#> [1719] "Lathamus discolor"
#> [1720] "Psittacus discolor"
#> [1721] "Musca domestica"
#> [1722] "Acanthopleura japonica"
#> [1723] "Chiton japonicus"
#> [1724] "Liolophura japonica"
#> [1725] "Ascaris longissima"
#> [1726] "Lineus longissimus"
#> [1727] "Pristis pectinata"
#> [1728] "Acinia solidaginis"
#> [1729] "Eurosta solidaginis"
#> [1730] "Fringilla melodia_melodia"
#> [1731] "Melospiza melodia_melodia"
#> [1732] "Astacus quadricarinatus"
#> [1733] "Cherax quadricarinatus"
#> [1734] "Ischnura elegans"
#> [1735] "Geopsittacus occidentalis"
#> [1736] "Pezoporus occidentalis"
#> [1737] "Fringilla chalybeata"
#> [1738] "Vidua chalybeata"
#> [1739] "Coturnix coturnix_japanica"
#> [1740] "Coturnix coturnix_japonica"
#> [1741] "Coturnix coturnix_Japonicus"
#> [1742] "Coturnix japonica_japonica"
#> [1743] "Coturnix japonica"
#> [1744] "Gekko japonicus"
#> [1745] "Platydactylus japonicus"
#> [1746] "Pelecanus carbo"
#> [1747] "Phalacrocorax carbo"
#> [1748] "Nilaparvata lugens"
#> [1749] "Ardea americana"
#> [1750] "Grus americana"
#> [1751] "Grus americanus"
#> [1752] "Aedes camptorhynchus"
#> [1753] "Culex camptorhynchus"
#> [1754] "Ochlerotatus camptorhynchus"
#> [1755] "Ochlerotatus (Ochlerotatus)_camptorhynchus"
#> [1756] "Harpia harpyja"
#> [1757] "Vultur harpyja"
#> [1758] "Pipra filicauda"
#> [1759] "Herrania umbratica"
#> [1760] "Ilyonectria robusta"
#> [1761] "Ramularia robusta"
#> [1762] "Agelaius tricolor"
#> [1763] "Icterus tricolor"
#> [1764] "Cupidonia cupido_pallidicincta"
#> [1765] "Tympanuchus pallidicinctus"
#> [1766] "Topomyia yanbarensis"
#> [1767] "Parus atricapillus"
#> [1768] "Poecile atricapilla"
#> [1769] "Poecile atricapillus"
#> [1770] "Corapipo altera"
#> [1771] "Candoia aspera"
#> [1772] "Erebophis aspera"
#> [1773] "Acyrthosiphon pisum"
#> [1774] "Acyrthosiphum pisum"
#> [1775] "Aphis pisum"
#> [1776] "Saprolegnia parasitica_CBS_223.65"
#> [1777] "Fringilla macroura"
#> [1778] "Vidua macroura"
#> [1779] "Carica papaya"
#> [1780] "Chiroxiphia lanceolata"
#> [1781] "Pipra lanceolata"
#> [1782] "Heliangelus exortis"
#> [1783] "Trochilus exortis"
#> [1784] "Euphema bourkii"
#> [1785] "Neophema bourkii"
#> [1786] "Neopsephotus bourkii"
#> [1787] "Octopus bimaculoides"
#> [1788] "Lagopus muta"
#> [1789] "Tetrao mutus"
#> [1790] "Bradysia coprophila"
#> [1791] "Sciara coprophila"
#> [1792] "Bucco pusillus"
#> [1793] "Pogoniulus pusillus"
#> [1794] "Coluber sirtalis"
#> [1795] "Thamnophis sirtalis"
#> [1796] "Falco peregrinus"
#> [1797] "Falco cherrug"
#> [1798] "Phytophthora cinnamomi"
#> [1799] "Leptothorax nylanderi"
#> [1800] "Temnothorax nylanderi"
#> [1801] "Burrica mexicana"
#> [1802] "Carpodacus mexicanus"
#> [1803] "Fringilla mexicana"
#> [1804] "Haemorhous mexicanus"
#> [1805] "Asteracanthion distichum"
#> [1806] "Asteracanthium distichum"
#> [1807] "Asterias attenuata"
#> [1808] "Asterias distichum"
#> [1809] "Asterias rubens"
#> [1810] "Asterias stimpsoni"
#> [1811] "Asterias vulgaris"
#> [1812] "Fringilla gambellii"
#> [1813] "Zonotrichia leucophrys_gambelii"
#> [1814] "Manduca sexta"
#> [1815] "Sphinx sexta"
#> [1816] "Pituophis catenifer_annectens"
#> [1817] "Condylura cristata"
#> [1818] "Sorex cristatus"
#> [1819] "Cuculus canorus"
#> [1820] "Pezoporus wallicus"
#> [1821] "Aedes aegypti"
#> [1822] "Aedes (Stegomyia)_aegypti"
#> [1823] "Culex aegypti"
#> [1824] "Stegomyia aegypti"
#> [1825] "Falco naumanni"
#> [1826] "Corvus kubaryi"
#> [1827] "Larus tridactylus"
#> [1828] "Rissa tridactyla"
#> [1829] "Aphanomyces astaci"
#> [1830] "Culex (Culex)_pipiens_pallens"
#> [1831] "Culex pipiens_pallens"
#> [1832] "Cydia pomonella"
#> [1833] "Phalaena pomonella"
#> [1834] "Tenebrio molitor"
#> [1835] "Accipiter gentilis"
#> [1836] "Accipiter gentillis"
#> [1837] "Falco gentilis"
#> [1838] "Crocodylus porosus"
#> [1839] "Pterocnemia pennata"
#> [1840] "Rhea pennata"
#> [1841] "Amborella trichopoda"
#> [1842] "Falco biarmicus"
#> [1843] "Lagopus leucura"
#> [1844] "Lagopus leucurus"
#> [1845] "Tetrao leucurus"
#> [1846] "Falco rusticolus"
#> [1847] "Chroicocephalus ridibundus"
#> [1848] "Larus ridibundus"
#> [1849] "Artemia franciscana"
#> [1850] "Agaricus tabescens"
#> [1851] "Armillaria tabescens"
#> [1852] "Armillariella tabescens"
#> [1853] "Desarmillaria tabescens"
#> [1854] "Convoluta roscoffensis"
#> [1855] "Symsagittifera roscoffensis"
#> [1856] "Corvus brachyrhynchos"
#> [1857] "Uloborus diversus"
#> [1858] "Phytophthora infestans_strain_T30-4"
#> [1859] "Phytophthora infestans_T30-4"
#> [1860] "Empidonax traillii"
#> [1861] "Muscicapa traillii"
#> [1862] "Bacillus redtenbacheri"
#> [1863] "Bacillus rossius_redtenbacheri"
#> [1864] "Motacilla subflava"
#> [1865] "Prinia subflava"
#> [1866] "Strix alba"
#> [1867] "Tyto alba"
#> [1868] "Parus major"
#> [1869] "Coccus citri"
#> [1870] "Phenacoccus citri"
#> [1871] "Planococcus citri"
#> [1872] "Caligus salmonis"
#> [1873] "Lepeophtheirus salmonis_salmonis"
#> [1874] "Lepeophtheirus salmonis"
#> [1875] "Fusarium solani"
#> [1876] "Fusisporium solani"
#> [1877] "Neocosmospora solani"
#> [1878] "Muscicapa melanoleuca"
#> [1879] "Oenanthe hispanica_melanoleuca"
#> [1880] "Oenanthe melanoleuca"
#> [1881] "Cuculus curvirostris"
#> [1882] "Phaenicophaeus curvirostris"
#> [1883] "Caloenas nicobarica"
#> [1884] "Columba nicobarica"
#> [1885] "Gavialis gangeticus"
#> [1886] "Lacerta gangetica"
#> [1887] "Daphnia carinata"
#> [1888] "Aphis gossypii"
#> [1889] "Ampithoe aztecus"
#> [1890] "Hyalella azteca"
#> [1891] "Hyalella knickerbockeri"
#> [1892] "Colletotrichum lupini"
#> [1893] "Gloeosporium lupini"
#> [1894] "Lonchura domestica"
#> [1895] "Lonchura striata"
#> [1896] "Loxia striata"
#> [1897] "Sphaeroforma arctica_JP610"
#> [1898] "Suillus fuscotomentosus"
#> [1899] "Mollisia scopiformis"
#> [1900] "Phialocephala scopiformis"
#> [1901] "Muscicapa cayanensis"
#> [1902] "Myiozetetes cayanensis"
#> [1903] "Hyaloscypha bicolor_E"
#> [1904] "Melopsittacus undulatus"
#> [1905] "Psittacus undulatus"
#> [1906] "Fringilla montana"
#> [1907] "Passer montanus"
#> [1908] "Coccinella axyridis"
#> [1909] "Harmonia axyridis"
#> [1910] "Aimophila crissalis"
#> [1911] "Kieneria crissalis"
#> [1912] "Kieneria crissalis_(Vigors,_1839)"
#> [1913] "Melozone crissalis"
#> [1914] "Pipilo crissalis"
#> [1915] "Pipilo fuscus_crissalis"
#> [1916] "Molothrus aeneus"
#> [1917] "Psarocolius aeneus"
#> [1918] "Conops calcitrans"
#> [1919] "Stomoxis calcitrans"
#> [1920] "Stomoxys calcitrans"
#> [1921] "Anas atrata"
#> [1922] "Cygnus atratus"
#> [1923] "Culex fatigans"
#> [1924] "Culex pipiens_fatigans"
#> [1925] "Culex pipiens_quinquefasciatus"
#> [1926] "Culex quinquefasciatus"
#> [1927] "Drosophila takahashii"
#> [1928] "Hirundo rustica"
#> [1929] "Bombyx mori"
#> [1930] "Phalaena mori"
#> [1931] "Drosophila suzukii"
#> [1932] "Leucophenga suzukii"
#> [1933] "Acanthaster planci"
#> [1934] "Asterias planci"
#> [1935] "Molothrus ater"
#> [1936] "Oriolus ater"
#> [1937] "Laccaria bicolor_S238N-H82"
#> [1938] "Anastrepha obliqua"
#> [1939] "Tephritis obliqua"
#> [1940] "Grapholitha glycinivorella"
#> [1941] "Leguminivora glycinivorella"
#> [1942] "Motacilla atricapilla"
#> [1943] "Sylvia atricapilla"
#> [1944] "Ammodromus caudacutus_nelsoni"
#> [1945] "Ammospiza nelsoni"
#> [1946] "Nylanderia fulva"
#> [1947] "Paratrechina fulva"
#> [1948] "Monocercomonoides exilis"
#> [1949] "Monocercomonoides sp._PA203"
#> [1950] "Agelaius phoeniceus"
#> [1951] "Agelaius phoniceus"
#> [1952] "Oriolus phoeniceus"
#> [1953] "Ammodramus caudacutus"
#> [1954] "Ammospiza caudacuta"
#> [1955] "Oriolus caudacutus"
#> [1956] "Colymbus stellatus"
#> [1957] "Gavia stellata"
#> [1958] "Musca vetustissima"
#> [1959] "Euthrips occidentalis"
#> [1960] "Frankliniella brunnescens"
#> [1961] "Frankliniella californica"
#> [1962] "Frankliniella occidentalis_brunnescens"
#> [1963] "Frankliniella occidentalis"
#> [1964] "Motacilla alba_alba"
#> [1965] "Sitophilus oryzae"
#> [1966] "Corvus cornix_cornix"
#> [1967] "Fringilla canaria"
#> [1968] "Serinus canaria"
#> [1969] "Serinus canarius"
#> [1970] "Drosophila subpulchrella"
#> [1971] "Chlamydomonas reinhardtii"
#> [1972] "Chlamydomonas smithii"
#> [1973] "Puccinia striiformis_f._sp._tritici"
#> [1974] "Colius striatus"
#> [1975] "Heterorhabditis bacteriophora"
```

Note that, if `genome_type` is specified to a supported genome, the human / mouse gene ontology annotation will be automatically generated.

What is Mappability and why should I care about it?
For the most part, the SpliceWiz reference can be built with just the FASTA and GTF files. This is sufficient for assessment for most forms of alternative splicing events.

For intron retention, accurate assessment of intron depth is important. However, introns contain many repetitive regions that are difficult to map. We refer to these regions as “mappability exclusions”.

We adopt IRFinder’s algorithm to identify these mappability exclusions. This is determined empirically by generating synthetic reads systematically from the genome, then aligning these reads back to the same genome. Regions that contain less than the expected coverage depth of reads define “mappability exclusions”.

See the vignette: SpliceWiz cookbook for details on how to generate “mappability exclusions” for any genome.

How do I use pre-built mappability exclusions to generate human and mouse references?
For human and mouse genomes, SpliceWiz provides pre-built mappability exclusion references that can be used to build the SpliceWiz reference. SpliceWiz provides these annotations via the `NxtIRFdata` package.

Simply specify the genome in the parameter `genome_type` in the `buildRef()` function (which accepts `hg38`, `hg19`, `mm10` and `mm9`).

Additionally, a reference for non-polyadenylated transcripts is used. This has a minor role in QC of samples (to assess the adequacy of polyA capture).

For example, assuming your genome file `"genome.fa"` and a transcript annotation `"transcripts.gtf"` are in the working directory, a SpliceWiz reference can be built using the built-in `hg38` low mappability regions and non-polyadenylated transcripts as follows:

```
## NOT RUN

ref_path_hg38 <- "./Reference"
buildRef(
    reference_path = ref_path_hg38,
    fasta = "genome.fa",
    gtf = "transcripts.gtf",
    genome_type = "hg38"
)
```

## Process BAM files using SpliceWiz

The function `SpliceWiz_example_bams()` retrieves 6 example BAM files from ExperimentHub and places a copy of these in the temporary directory.

```
bams <- SpliceWiz_example_bams()
```

What are these example BAM files and how were they generated?
In this vignette, we provide 6 example BAM files. These were generated based on aligned RNA-seq BAMs of 6 samples from the Leucegene AML dataset (GSE67039). Sequences aligned to hg38 were filtered to only include genes aligned to that used to create the chrZ chromosome. These sequences were then re-aligned to the chrZ reference using STAR.

How can I easily locate multiple BAM files?
Often, alignment pipelines process multiple samples. SpliceWiz provides convenience functions to recursively locate all the BAM files in a given folder, and tries to ascertain sample names. Often sample names can be gleaned when: \* The BAM files are named by their sample names, e.g. “sample1.bam”, “sample2.bam”. In this case, `level = 0` \* The BAM files have generic names but are contained inside parent directories labeled by their sample names, e.g. “sample1/Unsorted.bam”, “sample2/Unsorted.bam”. In this case, `level = 1`

```
# as BAM file names denote their sample names
bams <- findBAMS(tempdir(), level = 0)

# In the case where BAM files are labelled using sample names as parent
# directory names (which oftens happens with the STAR aligner), use level = 1
```

Process these BAM files using SpliceWiz:

```
pb_path <- file.path(tempdir(), "pb_output")
processBAM(
    bamfiles = bams$path,
    sample_names = bams$sample,
    reference_path = ref_path,
    output_path = pb_path
)
```

Using the GUI
After building the demo reference as shown in the previous section, start SpliceWiz GUI in demo mode. Then, click the `Experiment` tab from the menu side bar. The following interface will be shown:

![The Experiment Panel - GUI](data:image/jpeg;base64...)

The Experiment Panel - GUI

The buttons on the left hand side are as follows:

1. Set the folders containing the SpliceWiz reference, BAM files, and the output (NxtSE) folder
2. Run `processBAM` (process BAM files)
3. Import annotations from a tabular text file (such as a csv file)
4. Settings for `collateData` - collating the experiment
5. Run `collateData` (collating the experiment)
6. Import/Export current sample annotations from/to the NxtSE folder, or export annotations as a csv file
7. Set the number of threads used to run `processBAM` and `collateData functions

Also, (8) is a row of tabs that toggle between different tables, showing details of the Reference, BAM files, processBAM output Files, and sample Annotations

To continue with our example, click on (1) `Define Project Folders` to bring up the following drop-down box:

![Define Project Folders](data:image/jpeg;base64...)

Define Project Folders

We need to define the folders that contain our reference, BAM files, as well as the experiment (NxtSE) output folder for the final compiled experiment

* Click on `Choose Reference Folder` and select the `Reference` directory (where the SpliceWiz reference was generated by the previous step. Then,
* Click on `Choose BAM Folder` and select the `bams` directory (where the demo BAM files have been generated).
* Click on `Choose / Create Experiment (NxtSE) Folder` and select the `NxtSE` directory (which should currently be empty except for the `pbOutput` subdirectory). Note that when an Experiment folder is chosen via this step, a `pbOutput` subdirectory will be created if it does not already exist

After our folders have been defined, on the right hand side, an interactive table should be displayed that looks like the following:

![Running processBAM](data:image/jpeg;base64...)

Running processBAM

To process the example BAM files, first make sure the BAM files you wish to process have been selected (BAM files can be unselected by removing the ticks in the `selected` column). Also, users have the option of renaming the samples (by setting the names in the `sampleName` column).

To continue with our example, lets leave the names as-is. Click the `Process Selected BAMs` button. A prompt should pop up asking for confirmation. Click `OK` to start running processBAM.

What is the `processBAM()` function
SpliceWiz’s `processBAM()` function can process one or more BAM files. This function is ultra-fast, relying on an internal native C++ function that uses OpenMP multi-threading (via the `ompBAM` C++ API).

Input BAM files can be either read-name sorted or coordinate sorted (although SpliceWiz prefers the former). Indexing of coordinate-sorted BAMs are not necessary.

`processBAM()` loads the SpliceWiz reference. Then, it reads each BAM file in their entirety, and quantifies the following:

* Basic QC parameters including number of reads, directionality, etc
* Counts of gapped (junction) reads / fragments
* Intron coverage depths and other parameters (identical output to IRFinder)
* COV files (which are like BigWig files but record strand-specific coverage)
* Miscellaneous quants including coverage of chromosomes, intergenic regions, rRNAs, and non-polyadenylated regions

For each BAM file, `processBAM()` generates two output files. The first is a gzipped text file containing all the quantitation data. The second is a `COV` file which contains the per-nucleotide RNA-seq coverage of the sample.

More details on the `processBAM()` function
At minimum, `processBAM()` requires four parameters:

* `bamfiles` : The paths of the BAM files
* `sample_names` : The sample names corresponding to the given BAM files
* `reference_path` : The directory containing the SpliceWiz reference
* `output_path` : The directory where the output of `processBAM()` should go

```
pb_path <- file.path(tempdir(), "pb_output")
processBAM(
    bamfiles = bams$path,
    sample_names = bams$sample,
    reference_path = ref_path,
    output_path = pb_path
)
```

`processBAM()` also takes several optional, but useful, parameters:

* `n_threads` : The number of threads for multi-threading
* `overwrite` : Whether existing files in the output directory should be overwritten
* `run_featureCounts` : (Requires the Rsubread package) runs featureCounts to obtain gene counts (which outputs results as an RDS file)

For example, to run `processBAM()` using 2 threads, disallow overwrite of existing `processBAM()` outputs, and run featureCounts afterwards, one would run the following:

```
# NOT RUN

# Re-run IRFinder without overwrite, and run featureCounts
require(Rsubread)

processBAM(
    bamfiles = bams$path,
    sample_names = bams$sample,
    reference_path = ref_path,
    output_path = pb_path,
    n_threads = 2,
    overwrite = FALSE,
    run_featureCounts = TRUE
)

# Load gene counts
gene_counts <- readRDS(file.path(pb_path, "main.FC.Rds"))

# Access gene counts:
gene_counts$counts
```

## Collate the experiment

The helper function `findSpliceWizOutput()` organises the output files of SpliceWiz’s `processBAM()` function. It identifies matching `"txt.gz"` and `"cov"` files for each sample, and organises these file paths conveniently into a 3-column data frame:

```
expr <- findSpliceWizOutput(pb_path)
```

Using this data frame, collate the experiment using `collateData()`. We name the output directory as `NxtSE_output` as this folder will contain the data needed to import the NxtSE object:

```
nxtse_path <- file.path(tempdir(), "NxtSE_output")
collateData(
    Experiment = expr,
    reference_path = ref_path,
    output_path = nxtse_path
)
```

What is the `collateData()` function
`collateData()` combines the `processBAM()` output files of multiple samples and builds a single database. `collateData()` creates a number of files in the chosen output directory. These outputs can then be imported into the R session as a `NxtSE` data object for downstream analysis.

At minimum, `collateData()` takes the following parameters:

* `Experiment` : The 2- or 3- column data frame. The first column should contain (unique) sample names. The second and (optional) third columns contain the `"txt.gz"` and `"cov"` file paths
* `reference_path` : The directory containing the SpliceWiz reference
* `output_path` : The directory where the output of `processBAM()` should go

`collateData()` can take some optional parameters:

* `IRMode` : Whether to use SpliceWiz’s `SpliceOver` method, or IRFinder’s `SpliceMax` method, to determine total spliced transcript abundance. Briefly, `SpliceMax` considers junction reads that have either flanking splice site coordinate. `SpliceOver` considers additional junction reads that splices across exon clusters in common. Exon clusters are groups of mutually-overlapping exons. `SpliceOver` is the default option.
* `overwrite` : Whether files in the output directory should be overwritten
* `n_threads` : Use multi-threaded operations where possible
* `lowMemoryMode` : Minimise memory usage where possible. Note that most of the collateData pipeline will be single-threaded if this is set to `TRUE`.

`collateData()` is a memory-intensive operation when run using multiple threads. We estimate it can use up to 6-7 Gb per thread. `lowMemoryMode` will minimise RAM usage to ~ 8 Gb, but will be slower and run on a single thread.

Enabling novel splicing detection
Novel splicing detection can be switched on by setting `novelSplicing = TRUE` from within the `collateData()` function:

```
# Modified pipeline - collateData with novel ASE discovery:

nxtse_path <- file.path(tempdir(), "NxtSE_output_novel")
collateData(
    Experiment = expr,
    reference_path = ref_path,
    output_path = nxtse_path,
    novelSplicing = TRUE     ## NEW ##
)
```

`collateData()` uses split reads that are not annotated introns to help construct hypothetical minimal transcripts. These are then injected into the original transcriptome annotation (GTF) file, whereby the SpliceWiz reference is rebuilt. The new SpliceWiz reference (which contains these novel transcripts) is then used to collate the samples.

To reduce false positives in novel splicing detection, SpliceWiz provides several filters to reduce the number of novel junctions fed into the analysis:

* Novel junctions that are lowly expressed (only in a small number of samples) are removed. The minimum number of samples required to retain a novel junction is set using `novelSplicing_minSamples` parameter
* Alternately, junctions are retained if its expression exceeds a certain threshold (set using `novelSplicing_countThreshold`) in a smaller number of samples (set using `novelSplicing_minSamplesAboveThreshold`)
* Further, novel junctions can be filtered by requiring at least one end to be an annotated splice site (this is enabled using `novelSplicing_requireOneAnnotatedSJ = TRUE`).

For example, if one wished to retain novel reads seen in 3 or more samples, or novel spliced reads with 10 or more counts in at least 1 sample, and requiring at least one end of a novel junction being an annotated splice site:

By default, tandem junction reads (reads that align across two or more splice junctions) are used to detect novel exons. This can be turned off by setting `novelSplicing_useTJ = FALSE`.

```
nxtse_path <- file.path(tempdir(), "NxtSE_output_novel")
collateData(
    Experiment = expr,
    reference_path = ref_path,
    output_path = nxtse_path,

        ## NEW ##
    novelSplicing = TRUE,
        # switches on novel splice detection

    novelSplicing_requireOneAnnotatedSJ = TRUE,
        # novel junctions must share one annotated splice site

    novelSplicing_minSamples = 3,
        # retain junctions observed in 3+ samples (of any non-zero expression)

    novelSplicing_minSamplesAboveThreshold = 1,
        # only 1 sample required if its junction count exceeds a set threshold
    novelSplicing_countThreshold = 10  ,
        # threshold for previous parameter

    novelSplicing_useTJ = TRUE
        # whether tandem junction reads should be used to identify novel exons
)
```

Using the GUI to annotate the experiment
After running the Reference and processBAM steps as indicated in the previous sections (of the GUI instructions), there is an option to assign annotations to the experiment prior to collation. Annotations can be assigned from existing tabular files (such as csv files). For this example, we will demonstrate how to use a csv file containing annotations to annotate our experiment. Note that the annotation table should contain matching sample names in its leftmost column.

To select a file containing annotations, click on `Import Annotations from file`, then select the `demo_annotations.csv` file that should be in the working directory. Press ok. Your interface should now look like this:

![Importing annotations](data:image/jpeg;base64...)

Importing annotations

Note that an extra button `Add / Remove Annotation Columns` (\*) has appeared. Clicking on this button allows us to add/remove annotation columns

![Adding annotation columns](data:image/jpeg;base64...)

Adding annotation columns

Using this panel, columns can be added or removed by clicking their corresponding buttons. Data types for columns can also be defined here.

Using the GUI to collate the experiment

After annotating the experiment in the step above, click on the `Experiment Settings` button. Then enable `Look for Novel Splicing` to bring up the following display:

![Customizing the Experiment Settings](data:image/jpeg;base64...)

Customizing the Experiment Settings

This drop-down dialog box contains several parameters related to novel splicing detection:

1. Toggle on/off novel splice detection
2. Restrict novel junction reads to having one annotated splice site
3. Filter novel junction counts based on the number of samples in which the novel junction was observed (any non-zero amount)
4. Filter novel junction counts based on expression threshold (min number of samples set here)
5. Threshold junction read count (expression threshold based novel junction filter)
6. Whether to utilize tandem junction to define novel exons

Also, there is an option (7) to overwrite a previously-compiled NxtSE in the same folder. There is also an option to clear all the Reference/BAM/NxtSE folders (8).

For this example, we will leave the settings as above. Proceed to run collateData() by clicking on `Collate Experiment`. After several moments, a pop-up message should be shown when the experiment has been successfully collated.

## Importing the experiment

Before differential analysis can be performed, the collated experiment must be imported into the R session as an `NxtSE` data object.

After running `collateData()`, import the experiment using the `makeSE()` function:

```
se <- makeSE(nxtse_path)
```

Using the GUI
After running the steps in the previous GUI sections, navigate to `Analysis` and then click the `Load Experiment` on the menu bar. The display should look like this:

![Analysis - Loading the Experiment - GUI](data:image/jpeg;base64...)

Analysis - Loading the Experiment - GUI

The buttons on the left hand side are as follows:

1. Select the NxtSE folder containing the collated experiment
2. Import annotations from file (tabular format such as csv file)
3. Load NxtSE from folder (into current session for downstream analysis)
4. After NxtSE has been loaded, it can be saved as an RDS file to send to collaborators (note that COV files will be disconnected once the file has been moved to a different location; it is best to give your collaborators the NxtSE folder instead, with the COV files inside the `pbOutput` subdirectory)
5. Load NxtSE from RDS file (saved via the prior step)

To continue with our example, click the `Select Experiment (NxtSE) Folder`, then select the `NxtSE` directory. The interface should now look like this:

![Loading the NxtSE after reviewing the samples and annotations - GUI](data:image/jpeg;base64...)

Loading the NxtSE after reviewing the samples and annotations - GUI

To view any existing annotations, click the `Annotations` tab in the `Experiment Display` above the sample table. If you followed the prior steps in the `Collate the experiment` section, there should already be annotations here. If not, feel free to add annotations using the `Import Annotations from File` (and click on “demo\_annotations.csv” file), or manually add and annotate columns by clicking on the `Add / Remove Annotation Columns` button to open the drop-down box.

To load the NxtSE object, click the `Load NxtSE from Folder` to which will load the NxtSE object into the current session. A pop-up will appear once the NxtSE object has been successfully completed.

What is the `makeSE()` function
The `makeSE()` function imports the compiled data generated by the `collateData()` function. Data is imported as an `NxtSE` object. Downstream analysis, including differential analysis and visualization, is performed using the `NxtSE` object.

More details about the `makeSE()` function
By default, `makeSE()` uses delayed operations to avoid consuming memory until the data is actually needed. This is advantageous in analysis of hundreds of samples on a computer with limited resources. However, it will be slower. To load all the data into memory, we need to “realize” the NxtSE object, as follows:

```
se <- realize_NxtSE(se)
```

Alternatively, `makeSE()` can realize the NxtSE object at construction:

```
se <- makeSE(nxtse_path, realize = TRUE)
```

By default, `makeSE()` constructs the NxtSE object using all the samples in the collated data. It is possible (and particularly useful in large data sets) to read only a subset of samples. In this case, construct a data frame object with the first column containing the desired sample names and parse this into the `colData` parameter as shown:

```
subset_samples <- colnames(se)[1:4]
df <- data.frame(sample = subset_samples)
se_small <- makeSE(nxtse_path, colData = df, RemoveOverlapping = TRUE)
```

In complex transcriptomes including those of human and mouse, alternative splicing implies that introns are often overlapping. Thus, algorithms run the risk of over-calling intron retention where overlapping introns are assessed. SpliceWiz removes overlapping introns by considering only introns belonging to the major splice isoforms. It estimates a list of introns of major isoforms by assessing the compatible splice junctions of each isoform, and removes overlapping introns belonging to minor isoforms. To disable this functionality, set `RemoveOverlapping = FALSE`.

## Differential analysis

### Assigning annotations to samples

```
colData(se)$condition <- rep(c("A", "B"), each = 3)
colData(se)$batch <- rep(c("K", "L", "M"), 2)
```

NB: to add annotations via the GUI workflow, see the `Collate the experiment` section.

Saving and reloading the NxtSE as an RDS file (GUI)
Once an NxtSE object has been loaded into memory, you can save it as an RDS object so it can be reloaded in a later session. To do this, click the `Save NxtSE as RDS` button. Choose a file name and location and press `OK`. This RDS file can be loaded as an NxtSE object in a later GUI session by clicking the `Load NxtSE from RDS` button.

What is the `NxtSE` object
`NxtSE` is a data object which contains all the required data for downstream analysis after all the BAM alignment files have been process and the experiment is collated.

```
se
#> class: NxtSE
#> dim: 167 6
#> metadata(14): Up_Inc Down_Inc ... ref row_gr
#> assays(5): Included Excluded Depth Coverage minDepth
#> rownames(167): TRA2B/ENST00000453386_Intron8/clean
#>   TRA2B/ENST00000453386_Intron7/clean ...
#>   RI:SRSF2-203-exon2;SRSF2-202-intron2
#>   RI:SRSF2-203-exon2;SRSF2-206-intron1
#> rowData names(20): EventName EventType ... is_annotated_IR
#>   NMD_direction
#> colnames(6): 02H003 02H025 ... 02H043 02H046
#> colData names(2): condition batch
```

The `NxtSE` object inherits the `SummarizedExperiment` object. This means that the functions for SummarizedExperiment can be used on the NxtSE object. These include row and column annotations using the `rowData()` and `colData()` accessors.

Rows in the `NxtSE` object contain information about each alternate splicing event. For example:

```
head(rowData(se))
#> DataFrame with 6 rows and 20 columns
#>                                                  EventName   EventType
#>                                                <character> <character>
#> TRA2B/ENST00000453386_Intron8/clean TRA2B/ENST0000045338..          IR
#> TRA2B/ENST00000453386_Intron7/clean TRA2B/ENST0000045338..          IR
#> TRA2B/ENST00000453386_Intron6/clean TRA2B/ENST0000045338..          IR
#> TRA2B/ENST00000453386_Intron5/clean TRA2B/ENST0000045338..          IR
#> TRA2B/ENST00000453386_Intron4/clean TRA2B/ENST0000045338..          IR
#> TRA2B/ENST00000453386_Intron3/clean TRA2B/ENST0000045338..          IR
#>                                          EventRegion         gene_id
#>                                          <character>     <character>
#> TRA2B/ENST00000453386_Intron8/clean chrZ:1921-2559/- ENSG00000136527
#> TRA2B/ENST00000453386_Intron7/clean chrZ:2634-3631/- ENSG00000136527
#> TRA2B/ENST00000453386_Intron6/clean chrZ:3692-5298/- ENSG00000136527
#> TRA2B/ENST00000453386_Intron5/clean chrZ:5383-6205/- ENSG00000136527
#> TRA2B/ENST00000453386_Intron4/clean chrZ:6322-7990/- ENSG00000136527
#> TRA2B/ENST00000453386_Intron3/clean chrZ:8180-9658/- ENSG00000136527
#>                                           gene_id_b              intron_id
#>                                         <character>            <character>
#> TRA2B/ENST00000453386_Intron8/clean ENSG00000136527 ENST00000453386_Intr..
#> TRA2B/ENST00000453386_Intron7/clean ENSG00000136527 ENST00000453386_Intr..
#> TRA2B/ENST00000453386_Intron6/clean ENSG00000136527 ENST00000453386_Intr..
#> TRA2B/ENST00000453386_Intron5/clean ENSG00000136527 ENST00000453386_Intr..
#> TRA2B/ENST00000453386_Intron4/clean ENSG00000136527 ENST00000453386_Intr..
#> TRA2B/ENST00000453386_Intron3/clean ENSG00000136527 ENST00000453386_Intr..
#>                                     Inc_Is_Protein_Coding Exc_Is_Protein_Coding
#>                                                 <logical>             <logical>
#> TRA2B/ENST00000453386_Intron8/clean                  TRUE                  TRUE
#> TRA2B/ENST00000453386_Intron7/clean                  TRUE                  TRUE
#> TRA2B/ENST00000453386_Intron6/clean                  TRUE                  TRUE
#> TRA2B/ENST00000453386_Intron5/clean                  TRUE                  TRUE
#> TRA2B/ENST00000453386_Intron4/clean                  TRUE                  TRUE
#> TRA2B/ENST00000453386_Intron3/clean                  TRUE                  TRUE
#>                                     Exc_Is_NMD Inc_Is_NMD     Inc_TSL
#>                                      <logical>  <logical> <character>
#> TRA2B/ENST00000453386_Intron8/clean      FALSE       TRUE           1
#> TRA2B/ENST00000453386_Intron7/clean      FALSE       TRUE           1
#> TRA2B/ENST00000453386_Intron6/clean      FALSE       TRUE           1
#> TRA2B/ENST00000453386_Intron5/clean      FALSE       TRUE           1
#> TRA2B/ENST00000453386_Intron4/clean      FALSE       TRUE           1
#> TRA2B/ENST00000453386_Intron3/clean      FALSE       TRUE           1
#>                                         Exc_TSL          Event1a     Event2a
#>                                     <character>      <character> <character>
#> TRA2B/ENST00000453386_Intron8/clean           1 chrZ:1921-2559/-          NA
#> TRA2B/ENST00000453386_Intron7/clean           1 chrZ:2634-3631/-          NA
#> TRA2B/ENST00000453386_Intron6/clean           1 chrZ:3692-5298/-          NA
#> TRA2B/ENST00000453386_Intron5/clean           1 chrZ:5383-6205/-          NA
#> TRA2B/ENST00000453386_Intron4/clean           1 chrZ:6322-7990/-          NA
#> TRA2B/ENST00000453386_Intron3/clean           1 chrZ:8180-9658/-          NA
#>                                         Event1b     Event2b
#>                                     <character> <character>
#> TRA2B/ENST00000453386_Intron8/clean          NA          NA
#> TRA2B/ENST00000453386_Intron7/clean          NA          NA
#> TRA2B/ENST00000453386_Intron6/clean          NA          NA
#> TRA2B/ENST00000453386_Intron5/clean          NA          NA
#> TRA2B/ENST00000453386_Intron4/clean          NA          NA
#> TRA2B/ENST00000453386_Intron3/clean          NA          NA
#>                                     is_always_first_intron
#>                                                  <logical>
#> TRA2B/ENST00000453386_Intron8/clean                  FALSE
#> TRA2B/ENST00000453386_Intron7/clean                  FALSE
#> TRA2B/ENST00000453386_Intron6/clean                  FALSE
#> TRA2B/ENST00000453386_Intron5/clean                  FALSE
#> TRA2B/ENST00000453386_Intron4/clean                  FALSE
#> TRA2B/ENST00000453386_Intron3/clean                  FALSE
#>                                     is_always_last_intron is_annotated_IR
#>                                                 <logical>       <logical>
#> TRA2B/ENST00000453386_Intron8/clean                 FALSE           FALSE
#> TRA2B/ENST00000453386_Intron7/clean                 FALSE           FALSE
#> TRA2B/ENST00000453386_Intron6/clean                 FALSE           FALSE
#> TRA2B/ENST00000453386_Intron5/clean                 FALSE           FALSE
#> TRA2B/ENST00000453386_Intron4/clean                 FALSE            TRUE
#> TRA2B/ENST00000453386_Intron3/clean                 FALSE           FALSE
#>                                     NMD_direction
#>                                         <numeric>
#> TRA2B/ENST00000453386_Intron8/clean             1
#> TRA2B/ENST00000453386_Intron7/clean             1
#> TRA2B/ENST00000453386_Intron6/clean             1
#> TRA2B/ENST00000453386_Intron5/clean             1
#> TRA2B/ENST00000453386_Intron4/clean             1
#> TRA2B/ENST00000453386_Intron3/clean             1
```

Columns contain information about each sample. By default, no annotations are assigned to each sample. These can be assigned as shown above.

Also, `NxtSE` objects can be subsetted by rows (ASEs) or columns (samples). This is useful if one wishes to perform analysis on a subset of the dataset, or only on a subset of ASEs (say for example, only skipped exon events). Subsetting is performed just like for `SummarizedExperiment` objects:

```
# Subset by columns: select the first 2 samples
se_sample_subset <- se[,1:2]

# Subset by rows: select the first 10 ASE events
se_ASE_subset <- se[1:10,]
```

### Filtering high-confidence events

SpliceWiz offers default filters to identify and remove low confidence alternative splice events (ASEs). Run the default filter using the following:

```
se.filtered <- se[applyFilters(se),]
#> Running Depth filter
#> Running Participation filter
#> Running Participation filter
#> Running Consistency filter
#> Running Terminus filter
#> Running ExclusiveMXE filter
#> Running StrictAltSS filter
```

Using the GUI
After following the GUI tutorials in the prior sections, click on `Analysis` and then `Filters` from the menu bar. It should look like this:

![Analysis - Filters - GUI](data:image/jpeg;base64...)

Analysis - Filters - GUI

To load SpliceWiz’s default filters, click the top right button `Load Default Filters`. Then to apply these filters to the NxtSE, click `Apply Filters`. After the filters have been run, your session should now look like this:

![SpliceWiz default filters - GUI](data:image/jpeg;base64...)

SpliceWiz default filters - GUI

Why do we need to filter alternative splicing events?
Often, the gene annotations contain isoforms for all discovered splicing events. Most annotated transcripts are not expressed, and their inclusion in differential analysis complicates results including adjusting for multiple testing. It is prudent to filter these out using various approaches, akin to removing genes with low gene counts in differential gene analysis. We suggest using the default filters which work well for small experiments with sequencing depths at 100-million paired-end reads.

To learn more about filters, consult the documentation via `?ASEFilters`

### Performing differential analysis

Using the edgeR wrapper `ASE_edgeR()`, perform differential ASE analysis between conditions “A” and “B”:

```
# Requires edgeR to be installed:
require("edgeR")
res_edgeR <- ASE_edgeR(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A"
)
```

Using the GUI
After running the previous sections (of the GUI instructions), click `Analysis` and then `Differential Expression Analysis` on the menu side bar. It should look something like this:

![Analysis - Differential Expression Analysis - GUI](data:image/jpeg;base64...)

Analysis - Differential Expression Analysis - GUI

To perform edgeR-based differential analysis, first ensure `Method` is set to `edgeR`. Using the `Variable` drop-down box, select `condition`. Then, select the `Nominator` and `Denominator` fields to `B` and `A`, respectively. Leave the batch factor fields as `(none)`. Then, click `Perform DE`.

Once differential expression analysis has finished, your session should look like below. The output is a DT-based data table equivalent to the `ASE_edgeR()` function.

![Example Differential Analysis using edgeR - GUI](data:image/jpeg;base64...)

Example Differential Analysis using edgeR - GUI

NB: The interface allows users to choose to sort the results either by nominal or (multiple-testing) adjusted P values

NB2: There are 3 different ways Intron Retention events can be quantified and analysed - see “What are the different ways intron retention is measured?” below for further details.

NB3: Analyses can be saved or loaded to/from RDS files using the corresponding buttons.

What are the options for differential ASE analysis?
SpliceWiz provides wrappers to three established algorithms:

* `ASE_limma` uses `limma` to model isoform counts as log-normal distributions. Limma is probably the fastest method and is ideal for large datasets. Time series analysis is available for this mode.
* `ASE_DESeq` uses `DESeq2` to model isoform counts as negative binomial distribution. This method is the most computationally expensive, but gives robust results. Time series analysis is also available for this mode
* `ASE_edgeR` uses `edgeR` to model isoform counts as negative binomial distributions. SpliceWiz uses the quasi-likelihood method that deals better with variance at near-zero junction counts, resulting in reduced false positives.
* `ASE_DoubleExpSeq` uses the lesser-known CRAN package `DoubleExpSeq`. This package uses the beta-binomial distribution to model isoform counts. The method is at least as fast as `limma`, but for now it is restricted to analysis between two groups (i.e. batch correction is not implemented)

We recommend the following for differential analysis:

* For quick comparisons between two groups, where no batch factors are involved, we recommend **DoubleExpSeq**
* For large complex experiments where quick results are required for a preliminary or exploratory analysis, we recommend **limma**
* For final analysis where accuracy is paramount, we recommend **edgeR** or **DESeq2**

```
# Requires limma to be installed:
require("limma")
res_limma <- ASE_limma(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A"
)

# Requires DoubleExpSeq to be installed:
require("DoubleExpSeq")
res_DES <- ASE_DoubleExpSeq(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A"
)

# Requires DESeq2 to be installed:
require("DESeq2")
res_deseq <- ASE_DESeq(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A",
    n_threads = 1
)

# Requires edgeR to be installed:
require("edgeR")
res_edgeR <- ASE_edgeR(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A"
)
```

What are the different ways intron retention is measured?
Intron retention can be measured via two approaches.

The first (and preferred) approach is using IR-ratio. We presume that every intron is potentially retained (thus ignoring annotation). Given this results in many overlapping introns, SpliceWiz adjusts for this via the following:

* Where there are mutually-overlapping introns, the less abundant intron is removed from the analysis. Abundance is estimated across the entire dataset, and less-abundant overlapping introns are removed at the `makeSE()` step.
* IR-ratio measures included (intronic) abundance using an identical approach to IRFinder, i.e., it calculates the trimmed mean of sequencing depth across the intron, excluding annotated outliers (other exons, intronic elements). Given we cannot assume whether the exact intron corresponds to the major isoform, we estimate splicing abundance by summing junction reads that share either exon cluster as the intron of interest (`SpliceOver` method in SpliceWiz). Alternately, users can choose to use IRFinder’s `SpliceMax` method, summing junction reads that share either splice junction with the intron of interest. This choice is also made by the user at the `makeSE()` step.

At the differential analysis step, users can choose the following:

* `IRmode = "all"` - all introns are potentially retained, use IR-ratio to quantify IR (`EventType = "IR"`)
* `IRmode = "annotated"` - only annotated retained intron events are considered, but use IR-ratio to quantify IR (`EventType = "IR"`)
* `IRmode = "annotated_binary"` - only annotated retained intron events are considered, use PSI to quantify IR - which considers the IR-transcript and the transcript isoform with the exactly-spliced intron as binary alternatives. Splicing of overlapping introns are not considered in PSI quantitation.

```
res_edgeR_allIntrons <- ASE_edgeR(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A",
    IRmode = "all"
)

res_edgeR_annotatedIR <- ASE_edgeR(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A",
    IRmode = "annotated"
)

res_edgeR_annotated_binaryIR <- ASE_edgeR(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A",
    IRmode = "annotated_binary"
)
```

Can I account for batch factors?
`ASE_limma`, `ASE_edgeR`, and `ASE_DESeq` can accept up to 2 categories of batches from which to normalize. For example, to normalize the analysis by the `batch` category, one would run:

```
require("edgeR")
res_edgeR_batchnorm <- ASE_edgeR(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A",
    batch1 = "batch"
)
```

Can I do time series analysis?
Time series analysis can be performed using limma, edgeR, and DESeq2.

For limma and edgeR, time series analysis is done using the `ASE_limma_timeseries()` and `ASE_edgeR_timeseries()` function. `test_factor`, despite its name, should be a column in `colData(se)` containing numerical values that represent time series data.

Note that these time series wrappers function requires the `splines` package.

```
colData(se.filtered)$timevar <- rep(c(0,1,2), 2)

require("splines")
require("limma")
res_limma_cont <- ASE_limma_timeseries(
    se = se.filtered,
    test_factor = "timevar"
)

require("splines")
require("edgeR")
res_edgeR_cont <- ASE_edgeR_timeseries(
    se = se.filtered,
    test_factor = "timevar"
)
```

For DESeq2, time series analysis is performed using the `ASE_DESeq()` funcction. The key difference is that, for time series analysis, simply do not specify the `test_nom` and `test_denom` parameters. As long as the `test_factor` contains numeric values, `ASE_DESeq` will treat it as a continuous variable. See the following example:

```
colData(se.filtered)$timevar <- rep(c(0,1,2), 2)

require("DESeq2")
res_deseq_cont <- ASE_DESeq(
    se = se.filtered,
    test_factor = "timevar"
)
```

Advanced GLM-based differential ASE analysis with edgeR

We have implemented wrapper functions enabling advanced users to perform differential ASE analysis by constructing their own design matrices. This allows users to evaluate effects of covariates in complex experimental models.

We will be building a separate vignette to illustrate the full functionality of these edgeR-based functions, but for now a quick example can be found in the relevant documentation, which can be viewed via:

```
?`ASE-GLM-edgeR`
```

## Visualization

### Volcano plots

Volcano plots show changes in PSI levels (log fold change, x axis) against statistical significance (-log10 p values, y axis):

```
library(ggplot2)

ggplot(res_edgeR,
        aes(x = logFC, y = -log10(FDR))) +
    geom_point() +
    labs(title = "Differential analysis - B vs A",
         x = "Log2-fold change", y = "FDR (-log10)")
```

![](data:image/png;base64...)

Can I visualize significant events for each modality of alternative splicing events?
Yes. We can use `ggplot2`’s `facet_wrap` function to separately plot volcanos for each modality of ASE. The type of ASE is contained in the `EventType` column of the differential results data frame.

```
ggplot(res_edgeR,
        aes(x = logFC, y = -log10(FDR))) +
    geom_point() + facet_wrap(vars(EventType)) +
    labs(title = "Differential analysis - B vs A",
         x = "Log2-fold change", y = "FDR (-log10)")
```

![](data:image/png;base64...)

Using the GUI
After following the previous sections including differential analysis, navigate to `Display` and then `Volcano Plot`. Notice that there will be a message that says “No events found. Consider relaxing some filters”.

This message occurs because our example dataset has no differential events that surpass an adjusted P value of less than 0.05 (which is the default filter setting). The SpliceWiz GUI avoids plotting all ASEs as this will crowd the visualization. In this example, change the `Filter Events by` to `Nominal P value`, and move the `P-value/FDR threshold` all the way to the right. There should now be a volcano plot but most events have near-zero significance because the default y-axis setting is to `Plot adjusted P values`. Switch this off to show the following:

![Volcano Plot - GUI](data:image/jpeg;base64...)

Volcano Plot - GUI

You can customize this volcano plot using the following controls:

1. Use the filtering panel to adjust the number of events to show. Here, events can be filtered by Nominal or adjusted P values, or by top events. We can also filter by “highlighted events” which is useful for gene ontology analysis and heatmaps later. Events can also be filtered by the type of alternative splicing
2. The volcano plot can be faceted by the type of alternative splicing.
3. The y axis can show either nominal or adjusted P values (Benjamini Hochberg).
4. If `NMD Mode` is `ON`, the horizontal axis represents whether splicing is shifted towards (positive values) or away from (negative values) a NMD substrate transcript
5. The plot can be exported as a pdf file (ggplot object)
6. Clear settings

Also, on the (right hand side) main panel:

7. This clears any selected events (selected events are highlighted in red)
8. Toggle between using tools to select or deselect events
9. Plotly interactive toolbox. Users can use the box-select (9a) or lasso- select (9b) to select (or de-select) one or more events of interest. Selected events are highlighted in other plots and non-selected points can be removed by selecting “highlighted events” in the event filter panel (1).

### Scatter plots

Scatter plots are useful for showing splicing levels (percent-spliced-in, PSI) between two conditions. The results from differential analysis contains these values and can be plotted:

```
library(ggplot2)

ggplot(res_edgeR, aes(x = 100 * AvgPSI_B, y = 100 * AvgPSI_A)) +
    geom_point() + xlim(0, 100) + ylim(0, 100) +
    labs(title = "PSI values across conditions",
         x = "PSI of condition B", y = "PSI of condition A")
#> Warning: Removed 1 row containing missing values or values outside the scale range
#> (`geom_point()`).
```

![](data:image/png;base64...)

Using the GUI
After following the previous sections including differential analysis, navigate to `Display` and then `Scatter Plot`. After relaxing the event filters similar to the previous section, change the `Variable` to `condition`, `X-axis condition` to `A` and `Y-axis condition` to `B`. A scatter plot should be automatically generated as follows:

![Scatter plot - GUI](data:image/jpeg;base64...)

Scatter plot - GUI

You can customize the scatter plot using the following controls:

1. Again, the filtering panel is available to filter the number of events by significance threshold, rank, or by highlighted events, as explained in the previous section (volcano plots - GUI)
2. `Variable` refers to the annotation table column name
3. and (4) - `X-axis` and `Y-axis` dropdowns refer to the condition categories (that are used to contrast between two experimental conditions)
4. If `NMD Mode` is `ON`, the PSI values are altered such that they represent the inclusion values of the NMD substrate (instead of that of the “included” isoform)
5. The plot can be exported as a pdf file (ggplot object)
6. Clear settings

As in the volcano plot, the scatter plot is interactive and points highlighted on this plot will stay highlighted in other plots.

8. Clears all highlighted events
9. Toggles between tools that select or de-select events
10. Plotly interactive plot where users can use box or lasso select tools to select / de-select events.

Selecting ASEs of interest using the interactive plots (GUI)
SpliceWiz GUI generates plotly interactive figures. For volcano and scatter plots, points of interest can be selected using the lasso or box select tools. For example, we can select the top hits from the faceted volcano plot as shown:

![Volcano plot - selecting ASEs of interest via the GUI](data:image/jpeg;base64...)

Volcano plot - selecting ASEs of interest via the GUI

These ASEs of interest will then be highlighted in other plots, for example scatter plot:

![Scatter plot - highlighted ASE events](data:image/jpeg;base64...)

Scatter plot - highlighted ASE events

How do I generate average PSI values for many conditions?
SpliceWiz provides the `makeMeanPSI()` function that can generate mean PSI values for each condition of a condition category. For example, the below code will calculate the mean PSIs of each “batch” of this example experiment:

```
meanPSIs <- makeMeanPSI(
    se = se,
    condition = "batch",
    conditionList = list("K", "L", "M")
)
```

### Gene ontology (GO) analysis

Gene ontology analysis using the GUI
Our working example does not have enough genes to demonstrate a workable gene ontology analysis. Instead, the following explains the controls found in the `Gene Ontology` panel:

![Gene ontology analysis](data:image/jpeg;base64...)

Gene ontology analysis

The controls are as follows:

1. Again, the filtering panel is available to filter the number of events by significance threshold, rank, or by highlighted events, as explained in the previous sections. Filtered events are considered “enriched events” in the analysis.
2. Type of gene ontology category - “Biological Function”, “Molecular Function” or “Cellular Compartment”
3. Enrich for upregulated, downregulated events, or both
4. Which set of genes to consider as background. Default is genes belonging to All ASE Events (as they contain introns). Alternatives are to either test for genes of ASEs of the specified modality (a popup select input box will appear, allowing users to select which modalities of ASE to derive background genes), or by all genes in the genome (NB this option will contain intronless genes which may bias the result).
5. Gene ontology plots can be saved to PDF
6. Gene ID’s of enriched genes (6a) or background genes (6b) can be exported to file, allowing users to repeat GO analysis using their own gene ontology enrichment tool of choice.

SpliceWiz has built-in gene ontology analysis. For now, only a limited number of species are supported for Ensembl gene ID’s. To see a list of supported organisms:

```
getAvailableGO()
#>    [1] "Anopheles gambiae"
#>    [2] "Arabidopsis thaliana"
#>    [3] "Bos taurus"
#>    [4] "Canis familiaris"
#>    [5] "Gallus gallus"
#>    [6] "Pan troglodytes"
#>    [7] "Escherichia coli"
#>    [8] "Drosophila melanogaster"
#>    [9] "Homo sapiens"
#>   [10] "Mus musculus"
#>   [11] "Sus scrofa"
#>   [12] "Rattus norvegicus"
#>   [13] "Macaca mulatta"
#>   [14] "Caenorhabditis elegans"
#>   [15] "Xenopus laevis"
#>   [16] "Saccharomyces cerevisiae"
#>   [17] "Danio rerio"
#>   [18] "Pseudophryne corroboree"
#>   [19] "Triticum aestivum"
#>   [20] "Triticum aestivum_subsp._aestivum"
#>   [21] "Triticum sativum"
#>   [22] "Triticum vulgare"
#>   [23] "Ambystoma mexicanum"
#>   [24] "Gyrinus mexicanus"
#>   [25] "Musa acuminata_AAA_Group"
#>   [26] "Brassica napus"
#>   [27] "Arachis hypogaea"
#>   [28] "Hibiscus syriacus"
#>   [29] "Cortia elata"
#>   [30] "Eulalia japonica"
#>   [31] "Levisticum argutum"
#>   [32] "Ligusticum elatum"
#>   [33] "Miscanthus floridulus"
#>   [34] "Miscanthus japonicus"
#>   [35] "Oreocome arguta"
#>   [36] "Saccharum floridulum"
#>   [37] "Acridium cancellatum"
#>   [38] "Schistocerca cancellata"
#>   [39] "Triticum dicoccoides"
#>   [40] "Triticum turgidum_subsp._dicoccoides"
#>   [41] "Triticum turgidum_var._dicoccoides"
#>   [42] "Dendrohyas sarda"
#>   [43] "Hyla arborea_sarda"
#>   [44] "Hyla sarda"
#>   [45] "Gryllus gregarius"
#>   [46] "Locusta gregaria"
#>   [47] "Schistocerca gregaria"
#>   [48] "Gossypium hirsutum"
#>   [49] "Gossypium hirsutum_subsp._mexicanum"
#>   [50] "Gossypium lanceolatum"
#>   [51] "Gossypium purpurascens"
#>   [52] "Camelina sativa"
#>   [53] "Myagrum sativum"
#>   [54] "Carassius auratus_gibelio"
#>   [55] "Carassius gibelio_gibelio"
#>   [56] "Carassius gibelio"
#>   [57] "Carassius gibelio_subsp._gibelio"
#>   [58] "Cyprinus gibelio"
#>   [59] "Acridium piceifrons"
#>   [60] "Schistocerca piceifrons"
#>   [61] "Papaver somniferum"
#>   [62] "Zingiber officinale"
#>   [63] "Trichomonas vaginalis_G3"
#>   [64] "Trichomonas vaginalis_strain_G3"
#>   [65] "Helianthus annuus"
#>   [66] "Schistocerca americana"
#>   [67] "Coffea arabica"
#>   [68] "Acipenser ruthenus"
#>   [69] "Acridium cubense"
#>   [70] "Schistocerca serialis_cubense"
#>   [71] "Panicum virgatum"
#>   [72] "Nicotiana tabacum"
#>   [73] "Oncorhynchus mykiss"
#>   [74] "Oncorhynchus nerka_mykiss"
#>   [75] "Parasalmo mykiss"
#>   [76] "Salmo mykiss"
#>   [77] "Gryllus nitens"
#>   [78] "Schistocerca nitens"
#>   [79] "Schistocerca vaga"
#>   [80] "Misgurnus dabryanus"
#>   [81] "Paramisgurnus dabryanus"
#>   [82] "Salvia splendens"
#>   [83] "Carassius carassius"
#>   [84] "Cyprinus carassius"
#>   [85] "Vicia villosa"
#>   [86] "Camellia sinensis"
#>   [87] "Thea sinensis"
#>   [88] "Hyperolius riggenbachi"
#>   [89] "Rappia riggenbachi"
#>   [90] "Oncorhynchus keta"
#>   [91] "Salmo keta"
#>   [92] "Pisum sativum"
#>   [93] "Salmo salar"
#>   [94] "Rutidosis leptorhynchoides"
#>   [95] "Rutidosis leptorrhynchoides"
#>   [96] "Raphanus sativus"
#>   [97] "Oncorhynchus kisutch"
#>   [98] "Oncorhyncus kisutch"
#>   [99] "Salmo kisatch"
#>  [100] "Lolium rigidum"
#>  [101] "Aegilops squarrosa_subsp._squarrosa"
#>  [102] "Aegilops squarrosa"
#>  [103] "Aegilops tauschii"
#>  [104] "Patropyrum tauschii_subsp._tauschii"
#>  [105] "Patropyrum tauschii"
#>  [106] "Triticum aegilops"
#>  [107] "Triticum tauschii"
#>  [108] "Eleutherodactylus coqui"
#>  [109] "Salmo trutta"
#>  [110] "Cryptomeria japonica"
#>  [111] "Cupressus japonica"
#>  [112] "Amia calva"
#>  [113] "Coregonus clupeaformis"
#>  [114] "Salmo clupeaformis"
#>  [115] "Oncorhynchus clarkii_lewisi"
#>  [116] "Oncorhynchus clarki_lewisi"
#>  [117] "Salar lewisi"
#>  [118] "Oncorhynchus gorbuscha"
#>  [119] "Salmo gorbuscha"
#>  [120] "Cyprinus carpio"
#>  [121] "Glycine max_subsp._soja"
#>  [122] "Glycine soja"
#>  [123] "Salmo fontinalis"
#>  [124] "Salvelinus fontinalis"
#>  [125] "Glycine max"
#>  [126] "Phaseolus max"
#>  [127] "Pleurodeles waltlii"
#>  [128] "Pleurodeles waltl"
#>  [129] "Chenopodium quinoa"
#>  [130] "Hordeum sativum"
#>  [131] "Hordeum vulgare_subsp._vulgare"
#>  [132] "Hordeum vulgare_var._nudum"
#>  [133] "Hordeum vulgare_var._vulgare"
#>  [134] "Humulus lupulus"
#>  [135] "Leuciscus parvus"
#>  [136] "Pseudorasbora parva"
#>  [137] "Festuca perennis_(L.)_Columbus_&_J.P.Sm.,_2010"
#>  [138] "Festuca perennis"
#>  [139] "Lolium perenne"
#>  [140] "Lolium vulgare"
#>  [141] "Gasterosteus pungitius"
#>  [142] "Pungitius pungitius"
#>  [143] "Pristiophorus japonicus"
#>  [144] "Oncorhynchus masou_masou"
#>  [145] "Salmo masou_masou"
#>  [146] "Oncorhynchus nerka"
#>  [147] "Salmo nerka"
#>  [148] "Crassostrea cucullata"
#>  [149] "Ostrea cuccullata"
#>  [150] "Saccostrea cuccullata"
#>  [151] "Barbus grahami"
#>  [152] "Sinocyclocheilus grahami"
#>  [153] "Salmo alpinus"
#>  [154] "Salvelinus alpinus"
#>  [155] "Nerophis lumbriciformis"
#>  [156] "Syngnathus lumbriciformis"
#>  [157] "Nicotiana sylvestris"
#>  [158] "Sinocyclocheilus rhinocerous"
#>  [159] "Nicotiana tomentosiformis"
#>  [160] "Gossypium arboreum"
#>  [161] "Brassica oleracea"
#>  [162] "Malus sylvestris"
#>  [163] "Pyrus malus_var._sylvestris"
#>  [164] "Astyanax mexicanus"
#>  [165] "Tetragonopterus mexicanus"
#>  [166] "Arachis stenosperma"
#>  [167] "Prosopis alba"
#>  [168] "Sinocyclocheilus anshuiensis"
#>  [169] "Malus communis"
#>  [170] "Malus domestica"
#>  [171] "Malus pumila_auct."
#>  [172] "Malus pumila_var._domestica"
#>  [173] "Malus sylvestris_var._domestica"
#>  [174] "Malus x_domestica"
#>  [175] "Pyrus malus"
#>  [176] "Pyrus malus_var._domestica"
#>  [177] "Brassica rapa"
#>  [178] "Lactuca sativa"
#>  [179] "Dreissena polymorpha"
#>  [180] "Mytilus polymorphus"
#>  [181] "Hydractinia symbiolongicarpus"
#>  [182] "Triticum urartu"
#>  [183] "Cornus florida"
#>  [184] "Hevea brasiliensis"
#>  [185] "Siphonia brasiliensis"
#>  [186] "Salvelinus sp._IW2-2015"
#>  [187] "Oncorhynchus tschawytscha"
#>  [188] "Oncorhynchus tshawytscha"
#>  [189] "Salmo tshawytscha"
#>  [190] "Bombina fusca"
#>  [191] "Bombinator fuscus"
#>  [192] "Bufo fuscus"
#>  [193] "Pelobates fuscus"
#>  [194] "Rana fusca"
#>  [195] "Arachis ipaensis"
#>  [196] "Zea mays"
#>  [197] "Zea mays_var._japonica"
#>  [198] "Salmo namaycush"
#>  [199] "Salvelinus namaycush"
#>  [200] "Hydra attenuata"
#>  [201] "Hydra carnea"
#>  [202] "Hydra littoralis"
#>  [203] "Hydra magnipapillata"
#>  [204] "Hydra vulgaris"
#>  [205] "Lepisosteus oculatus"
#>  [206] "Mytilus edulis"
#>  [207] "Arundo australis"
#>  [208] "Phragmites australis"
#>  [209] "Phragmites communis"
#>  [210] "Capsicum annuum"
#>  [211] "Brienomyrus brachyistius"
#>  [212] "Marcusenius brachyistius"
#>  [213] "Ruditapes philippinarum"
#>  [214] "Ruditapes (Venerupis)_philippinarum"
#>  [215] "Tapes japonica"
#>  [216] "Tapes philippinarum"
#>  [217] "Venerupis japonica"
#>  [218] "Venerupis philippinarum"
#>  [219] "Venerupis (Ruditapes)_philippinarum"
#>  [220] "Venus philippinarum"
#>  [221] "Convolvulus nil"
#>  [222] "Ipomoea nil"
#>  [223] "Pharbitis nil"
#>  [224] "Lycium barbarum"
#>  [225] "Olea europaea_subsp._europaea_var._sylvestris"
#>  [226] "Olea europaea_var._oleaster"
#>  [227] "Olea europaea_var._sylvestris"
#>  [228] "Olea europea_subsp._sylvestris"
#>  [229] "Olea sylvestris"
#>  [230] "Mytilus trossulus"
#>  [231] "Alosa sapidissima"
#>  [232] "Clupea sapidissima"
#>  [233] "Montipora capricornis"
#>  [234] "Carpiodes asiaticus"
#>  [235] "Myxocyprinus asiaticus"
#>  [236] "Esox malabaricus"
#>  [237] "Hoplias malabaricus"
#>  [238] "Macrodon malabaricus"
#>  [239] "Actinidia eriantha"
#>  [240] "Gossypium raimondii"
#>  [241] "Cololabis saira"
#>  [242] "Scomberesox saira"
#>  [243] "Catostomus texanus"
#>  [244] "Xyrauchen texanus"
#>  [245] "Cambarus clarkii"
#>  [246] "Procambarus clarkii"
#>  [247] "Doryrhamphus excisus"
#>  [248] "Madrepora foliosa"
#>  [249] "Montipora foliosa"
#>  [250] "Exopalaemon carinicauda"
#>  [251] "Palaemon carinicauda"
#>  [252] "Heptranchias perlo"
#>  [253] "Squalus perlo"
#>  [254] "Quercus lobata"
#>  [255] "Carya illinoensis"
#>  [256] "Carya illinoinensis"
#>  [257] "Mercenaria mercenaria"
#>  [258] "Venus mercenaria"
#>  [259] "Quercus robur"
#>  [260] "Durio zibethinus"
#>  [261] "Acropora copiosa"
#>  [262] "Acropora muricata"
#>  [263] "Millepora muricata"
#>  [264] "Platichthys flesus"
#>  [265] "Platicthys flesus"
#>  [266] "Pleuronectes flesus"
#>  [267] "Haliotis asinina"
#>  [268] "Alosa pilchardus"
#>  [269] "Clupea harengus_pilchardus"
#>  [270] "Clupea pilchardus"
#>  [271] "Sardina pilchardus"
#>  [272] "Dendrobates imitator"
#>  [273] "Ranitomeya imitator"
#>  [274] "Mya arenaria"
#>  [275] "Arachis duranensis"
#>  [276] "Arachis spegazzinii"
#>  [277] "Pyrus x_bretschneideri"
#>  [278] "Trifolium pratense"
#>  [279] "Dasypus fenestratus"
#>  [280] "Dasypus novemcinctus"
#>  [281] "Cobitis anguillicaudata"
#>  [282] "Misgurnus anguillicaudatus"
#>  [283] "Quercus suber"
#>  [284] "Scaphiopus bombifrons"
#>  [285] "Spea bombifrons"
#>  [286] "Haliotis rufenscens"
#>  [287] "Haliotis rufescens"
#>  [288] "Oreochromis nilotica"
#>  [289] "Oreochromis niloticus"
#>  [290] "Perca nilotica"
#>  [291] "Tilapia nilotica"
#>  [292] "Acropora convexa"
#>  [293] "Acropora millepora"
#>  [294] "Acropora singularis"
#>  [295] "Channa argus"
#>  [296] "Ophicephalus argus"
#>  [297] "Ophiocephalus argus"
#>  [298] "Cebus apella"
#>  [299] "Sapajus apella"
#>  [300] "Simia apella"
#>  [301] "Eucalyptus grandis"
#>  [302] "Macaca nemestrina"
#>  [303] "Simia nemestrina"
#>  [304] "Callithrix jacchus_jacchus"
#>  [305] "Callithrix jacchus"
#>  [306] "Simia jacchus"
#>  [307] "Pyrus balansae"
#>  [308] "Pyrus communis"
#>  [309] "Pistacia vera"
#>  [310] "Pteropus medius"
#>  [311] "Salvia miltiorhiza"
#>  [312] "Salvia miltiorrhiza"
#>  [313] "Daphnia pulicaria"
#>  [314] "Labrus mixtus"
#>  [315] "Pongo abelii"
#>  [316] "Pongo pygmaeus_abelii"
#>  [317] "Pongo pygmaeus_abeli"
#>  [318] "Magnolia sinica"
#>  [319] "Manglietia sinica"
#>  [320] "Manglietiastrum sinicum"
#>  [321] "Pachylarnax sinica_(Y.W.Law)_N.H.Xia_&_C.Y.Wu"
#>  [322] "Lycopersicon esculentum"
#>  [323] "Lycopersicon esculentum_var._esculentum"
#>  [324] "Solanum esculentum"
#>  [325] "Solanum lycopersicum"
#>  [326] "Solanum lycopersicum_var._humboldtii"
#>  [327] "Rosa chinensis"
#>  [328] "Rosa indica_auct.,_non_L."
#>  [329] "Mytilus californianus"
#>  [330] "Gorilla gorilla_gorilla"
#>  [331] "greater Indian_fruit_bat"
#>  [332] "Pteropus giganteus"
#>  [333] "Pteropus vampyrus"
#>  [334] "Vespertilio vampyrus"
#>  [335] "Chinemys reevesii"
#>  [336] "Chinemys reevesi"
#>  [337] "Emys reevesii"
#>  [338] "Geoclemys reevesii"
#>  [339] "Geoclemys reevessi"
#>  [340] "Mauremys reevesii"
#>  [341] "Mauremys reevesi"
#>  [342] "Choloepus brasiliensis_Fitzinger_1871"
#>  [343] "Choloepus brasiliensis"
#>  [344] "Choloepus didactylus"
#>  [345] "Bubalus arnee_carabanensis"
#>  [346] "Bubalus bubalis_carabanesis"
#>  [347] "Bubalus carabanensis_carabanensis"
#>  [348] "Bubalus carabanensis"
#>  [349] "Bubalus kerabau"
#>  [350] "Lotus corniculatus_var._japonicus"
#>  [351] "Lotus japonicus"
#>  [352] "Tupaia belangeri_chinensis"
#>  [353] "Tupaia chinensis"
#>  [354] "Clarias gariepinus"
#>  [355] "Clarias lazera"
#>  [356] "Silurus gariepinus"
#>  [357] "Rosa rugosa"
#>  [358] "Barbus tetrazona"
#>  [359] "Capoeta tetrazona"
#>  [360] "Puntigrus tetrazona"
#>  [361] "Puntius tetrazona"
#>  [362] "Systomus tetrazona"
#>  [363] "Lycium ferocissimum"
#>  [364] "Nicotiana attenuata"
#>  [365] "Cestracion francisci"
#>  [366] "Heterodontus francisci"
#>  [367] "Octodon degus"
#>  [368] "Sciurus degus"
#>  [369] "Haliotis rubra"
#>  [370] "Equus caballus"
#>  [371] "Equus przewalskii_f._caballus"
#>  [372] "Equus przewalskii_forma_caballus"
#>  [373] "Spinacia oleracea"
#>  [374] "Haliotis cracherodii"
#>  [375] "Paramecium aurelia_syngen_4"
#>  [376] "Paramecium tetraurelia"
#>  [377] "Macaca cynomolgus"
#>  [378] "Macaca fascicularis"
#>  [379] "Macaca irus"
#>  [380] "Simia fascicularis"
#>  [381] "Salvia hispanica"
#>  [382] "Medicago truncatula"
#>  [383] "Crassostrea virginica"
#>  [384] "Ostrea virginica"
#>  [385] "Oryza sativa_(japonica_cultivar-group)"
#>  [386] "Oryza sativa_Japonica_Group"
#>  [387] "Oryza sativa_subsp._japonica"
#>  [388] "Felis catus"
#>  [389] "Felis domesticus"
#>  [390] "Felis silvestris_catus"
#>  [391] "Anubis baboon"
#>  [392] "Papio anubis"
#>  [393] "Papio cynocephalus_anubis"
#>  [394] "Papio doguera"
#>  [395] "Papio hamadryas_anubis"
#>  [396] "Papio hamadryas_doguera"
#>  [397] "Simia anubis"
#>  [398] "Dipodomys merriami"
#>  [399] "Sorex etruscus"
#>  [400] "Suncus etruscus"
#>  [401] "Daucus carota_subsp._sativus"
#>  [402] "Daucus carota_var._sativus"
#>  [403] "Mimosa cineraria"
#>  [404] "Prosopis cineraria"
#>  [405] "Lepus cuniculus"
#>  [406] "Oryctolagus cuniculus"
#>  [407] "Ptychodera erythraea"
#>  [408] "Ptychodera flava"
#>  [409] "Nycticebus coucang"
#>  [410] "Tardigradus coucang"
#>  [411] "Rhododendron vialii"
#>  [412] "Nematostella vectensis"
#>  [413] "Ixodes dammini"
#>  [414] "Ixodes scapularis"
#>  [415] "Lupinus angustifolius"
#>  [416] "Populus nigra"
#>  [417] "Populus pyramidalis"
#>  [418] "Littorina saxatilis"
#>  [419] "Turbo saxatilis"
#>  [420] "Ipomoea triloba"
#>  [421] "Pan paniscus"
#>  [422] "Emiliania huxleyi_CCMP1516"
#>  [423] "Emiliania huxleyi_CCMP2090"
#>  [424] "Mangifera indica"
#>  [425] "Nothobranchius furzeri"
#>  [426] "Pteropus alecto"
#>  [427] "Hylobates syndactylus"
#>  [428] "Simia syndactyla"
#>  [429] "Symphalangus syndactylus"
#>  [430] "Rana temporaria"
#>  [431] "Crassostrea angulata"
#>  [432] "Gryphaea angulata"
#>  [433] "Magallana angulata"
#>  [434] "Etheostoma spectabile"
#>  [435] "Poecilichthys spectabilis"
#>  [436] "Macadamia integrifolia"
#>  [437] "Megalobrama amblycephala"
#>  [438] "Halichoerus grypus"
#>  [439] "Phoca grypus"
#>  [440] "Juglans regia"
#>  [441] "Kungiselaginella moellendorffii"
#>  [442] "Selaginella moellendorffii"
#>  [443] "Selaginella moellendorfii"
#>  [444] "Pleuronectes platessa"
#>  [445] "Presbytis francoisi"
#>  [446] "Trachypithecus francoisi"
#>  [447] "Diadema antillarum"
#>  [448] "Tripterygium wilfordii"
#>  [449] "Dermacentor albipictus"
#>  [450] "Ixodes albipictus"
#>  [451] "Aotus nancymaae"
#>  [452] "Aotus nancymai"
#>  [453] "Aranea bruennichi"
#>  [454] "Argiope bruennichi"
#>  [455] "Rhinichthys klamathensis_goyatoka"
#>  [456] "Huro salmoides"
#>  [457] "Labrus salmoides"
#>  [458] "Labrus salmonides"
#>  [459] "Micropterus nigricans"
#>  [460] "Micropterus salmoides"
#>  [461] "Solanum stenotomum"
#>  [462] "Heterocephalus glaber"
#>  [463] "Pongo pygmaeus"
#>  [464] "Simia pygmaeus"
#>  [465] "Cavia aperea_porcellus"
#>  [466] "Cavia cobaya"
#>  [467] "Cavia porcellus"
#>  [468] "Mus porcellus"
#>  [469] "Arius graeffei"
#>  [470] "Neoarius graeffei"
#>  [471] "Dendropsophus ebraccatus"
#>  [472] "Hyla ebraccata"
#>  [473] "Neosciurus carolinensis"
#>  [474] "Sciurus carolinensis"
#>  [475] "Cervus elaphus"
#>  [476] "Polyodon spathula"
#>  [477] "Squalus spathula"
#>  [478] "Gadus chalcogrammus"
#>  [479] "Theragra chalcogramma"
#>  [480] "Bos bubalis"
#>  [481] "Bubalus arnee_bubalis"
#>  [482] "Bubalus bubalis"
#>  [483] "Pleuronectes solea"
#>  [484] "Solea solea"
#>  [485] "Solea vulgaris"
#>  [486] "Conger conger"
#>  [487] "Muraena conger"
#>  [488] "Mastomys coucha"
#>  [489] "Praomys coucha"
#>  [490] "Impatiens glandulifera"
#>  [491] "Dermacentor andersoni"
#>  [492] "Felis nebulosa"
#>  [493] "Neofelis nebulosa"
#>  [494] "Pteropus egyptiacus"
#>  [495] "Rousettus aegyptiacus"
#>  [496] "Rousettus aegypticus"
#>  [497] "Rousettus egyptiacus"
#>  [498] "Phoenix dactylifera"
#>  [499] "Pimephales promelas"
#>  [500] "Ostrea edulis"
#>  [501] "Peromyscus maniculatus_bairdii"
#>  [502] "Populus alba"
#>  [503] "Trichomycterus rosablanca"
#>  [504] "Odocoileus virginianus"
#>  [505] "Petaurus breviceps_papuanus"
#>  [506] "Petaurus sp._CYF-2022"
#>  [507] "Cricetus auratus"
#>  [508] "Golden hamsters"
#>  [509] "Mesocricetus auratus"
#>  [510] "Syrian hamsters"
#>  [511] "Ornithodoros americanus"
#>  [512] "Ornithodoros turicata_americanus"
#>  [513] "Ornithodoros turicata"
#>  [514] "Chromis aureus"
#>  [515] "Oreochromis aurea"
#>  [516] "Oreochromis aureus"
#>  [517] "Dermacentor silvarum"
#>  [518] "Chanodichthys erythropterus"
#>  [519] "Cullter erythropterus"
#>  [520] "Culter erythropterus"
#>  [521] "Cultrichthys erythropterus"
#>  [522] "Erythroculter erythropterus"
#>  [523] "Felis geoffroyi"
#>  [524] "Leopardus geoffroyi"
#>  [525] "Oncifelis geoffroyi"
#>  [526] "Atherina mordax"
#>  [527] "Osmerus mordax"
#>  [528] "Entelurus aequoreus"
#>  [529] "Syngnathus aequoreus"
#>  [530] "Euphorbia lathyris"
#>  [531] "Felis yagouaroundi"
#>  [532] "Herpailurus yagouaroundi"
#>  [533] "Herpailurus yaguarondi"
#>  [534] "Puma yagouaroundii"
#>  [535] "Puma yagouaroundi"
#>  [536] "Chrysemys bellii"
#>  [537] "Chrysemys picta_bellii"
#>  [538] "Chrysemys picta_subsp._bellii"
#>  [539] "Ovis ammon_aries"
#>  [540] "Ovis aries"
#>  [541] "Ovis orientalis_aries"
#>  [542] "Ovis ovis"
#>  [543] "Cervus canadensis"
#>  [544] "Populus diversifolia"
#>  [545] "Populus euphratica"
#>  [546] "Cucurbita pepo_subsp._pepo"
#>  [547] "Cucurbita pepo_var._medullosa"
#>  [548] "Cucurbita pepo_var._pepo"
#>  [549] "Emys muticus"
#>  [550] "Geoclemmys mutica"
#>  [551] "Mauremys mutica"
#>  [552] "Coffea eugeniodes"
#>  [553] "Coffea eugenioides"
#>  [554] "Suricata suricatta"
#>  [555] "Viverra suricatta"
#>  [556] "Hylobates moloch"
#>  [557] "Simia moloch"
#>  [558] "Solanum dulcamara"
#>  [559] "Cucurbita moschata"
#>  [560] "Clupea encrasicolus"
#>  [561] "Engraulis encrasicolus"
#>  [562] "Cucurbita maxima"
#>  [563] "Macaca thibetana_thibetana"
#>  [564] "Centropristis striata"
#>  [565] "Labrus striatus"
#>  [566] "Cannabis sativa"
#>  [567] "Bos banteng"
#>  [568] "Bos javanicus"
#>  [569] "Bos sondaicus"
#>  [570] "Panthera onca"
#>  [571] "Nerophis ophidion"
#>  [572] "Syngnathus ophidion"
#>  [573] "Gastrolobium bilobum"
#>  [574] "Jaculus jaculus"
#>  [575] "Mus jaculus"
#>  [576] "Dioscorea cayenensis_subsp._rotundata_(Poir.)_J.Miege,_1968"
#>  [577] "Dioscorea cayenensis_subsp._rotundata"
#>  [578] "Dioscorea rotundata"
#>  [579] "Cercopithecus aethiops_sabaeus"
#>  [580] "Cercopithecus sabaeus"
#>  [581] "Cercopithecus sabeus"
#>  [582] "Chlorocebus aethiops_sabaeus"
#>  [583] "Chlorocebus aethiops_sabeus"
#>  [584] "Chlorocebus sabaeus"
#>  [585] "Chlorocebus sabeus"
#>  [586] "Simia sabaea"
#>  [587] "Ovis canadensis"
#>  [588] "Ostrea echinata"
#>  [589] "Saccostrea echinata"
#>  [590] "Sexostrea echinata"
#>  [591] "Juglans microcarpa_x_Juglans_regia"
#>  [592] "Marmota monax"
#>  [593] "Mus monax"
#>  [594] "Equus caballus_przewalskii"
#>  [595] "Equus ferus_przewalskii"
#>  [596] "Equus przewalskii"
#>  [597] "Pygathrix roxellana"
#>  [598] "Rhinopithecus roxellana"
#>  [599] "Semnopithecus roxellana"
#>  [600] "Callorhinus ursinus"
#>  [601] "Callorhynus ursius"
#>  [602] "Phoca ursina"
#>  [603] "Cricetulus barabensis_griseus"
#>  [604] "Cricetulus griseus"
#>  [605] "Elephantulus edwardii"
#>  [606] "Macroscelides edwardii"
#>  [607] "Cobitis heteroclita"
#>  [608] "Fundulus heteroclitus"
#>  [609] "Neothunnus macropterus"
#>  [610] "Scomber albacares"
#>  [611] "Thunnus albacares"
#>  [612] "Meriones unguiculatus"
#>  [613] "Telopea speciosissima"
#>  [614] "Danio aesculapii"
#>  [615] "Danio sp._'snakeskin'"
#>  [616] "Danio sp._snakeskin"
#>  [617] "Apodemus sylvaticus"
#>  [618] "Mus sylvaticus"
#>  [619] "Sylvaemus sylvaticus"
#>  [620] "Populus balsamifera_subsp._trichocarpa"
#>  [621] "Populus trichocarpa"
#>  [622] "Cervus dama"
#>  [623] "Dama dama"
#>  [624] "Mercurialis ambigua"
#>  [625] "Mercurialis annua"
#>  [626] "Eugenia oleosa"
#>  [627] "Syzygium oleosum"
#>  [628] "Citellus tridecemlineatus"
#>  [629] "Ictidomys tridecemlineatus"
#>  [630] "Sciurus tridecemlineatus"
#>  [631] "Spermophilus tridecemlineatus"
#>  [632] "Arctomys flaviventer"
#>  [633] "Marmota flaviventris"
#>  [634] "Osmerus eperlanus"
#>  [635] "Salmo eperlanus"
#>  [636] "Solanum verrucosum"
#>  [637] "Felis pardus"
#>  [638] "Leo pardus"
#>  [639] "Panthera pardus"
#>  [640] "Microtus oregoni"
#>  [641] "Arabidopsis lyrata_subsp._lyrata"
#>  [642] "Arabis lyrata_subsp._lyrata"
#>  [643] "Manihot esculenta"
#>  [644] "Manihot utilissima"
#>  [645] "Mustela erminea"
#>  [646] "Dolichos unguiculatus"
#>  [647] "Phaseolus unguiculatus"
#>  [648] "Vigna unguiculata"
#>  [649] "Lycopersicon pennellii_(Correll)_D'Arcy,_1982"
#>  [650] "Solanum pennellii_Correll,_1958"
#>  [651] "Solanum pennellii"
#>  [652] "Panicum viride"
#>  [653] "Setaria viridis"
#>  [654] "Bos indicus"
#>  [655] "Bos primigenius_indicus"
#>  [656] "Bos taurus_indicus"
#>  [657] "Gymnostomus macrolepis"
#>  [658] "Onychostoma macrolepis"
#>  [659] "Scaphesthes macrolepis"
#>  [660] "Varicorhinus macrolepis"
#>  [661] "Varicorhinus (Scaphesthes)_macrolepis"
#>  [662] "Oryza glaberrima"
#>  [663] "Phaseolus vulgaris"
#>  [664] "Pelteobagrus fulvidraco"
#>  [665] "Pimelodus fulvidraco"
#>  [666] "Pseudobagrus fulvidraco"
#>  [667] "Tachysurus fulvidraco"
#>  [668] "Hylobates concolor_leucogenys"
#>  [669] "Hylobates concolor_leucogyneus"
#>  [670] "Hylobates leucogenys_leucogenys"
#>  [671] "Hylobates leucogenys"
#>  [672] "Nomascus leucogenys_leucogenys"
#>  [673] "Nomascus leucogenys"
#>  [674] "Nomascus leukogenys"
#>  [675] "Nannospalax ehrenbergi_galili"
#>  [676] "Nannospalax galili"
#>  [677] "Spalax galili"
#>  [678] "Scomber thynnus"
#>  [679] "Thunnus thynnus"
#>  [680] "Thunnus maccoyii"
#>  [681] "Thynnus maccoyii"
#>  [682] "Equus asinus"
#>  [683] "Chromis diagramma"
#>  [684] "Simochromis diagramma"
#>  [685] "Diplophysa dalaica"
#>  [686] "Triplophysa dalaica"
#>  [687] "Felis tigris"
#>  [688] "Panthera tigris"
#>  [689] "Echinus purpuratus"
#>  [690] "Strongylocentrotus purpuratus"
#>  [691] "Lucioperca lucioperca"
#>  [692] "Perca lucioperca"
#>  [693] "Sander lucioperca"
#>  [694] "Stizostedion lucioperca"
#>  [695] "Dipodomys spectabilis"
#>  [696] "Acinonyx jubatus"
#>  [697] "Felis jubata"
#>  [698] "Conyza canadensis"
#>  [699] "Erigeron canadensis"
#>  [700] "Mustela lutreola"
#>  [701] "Camelus bactrianus_ferus"
#>  [702] "Camelus ferus"
#>  [703] "Aristolochia californica"
#>  [704] "Crassostrea gigas"
#>  [705] "Magallana gigas"
#>  [706] "Ostrea gigas"
#>  [707] "Cajanus cajan"
#>  [708] "Dysidea avara"
#>  [709] "Spongelia avara"
#>  [710] "Didelphys domestica"
#>  [711] "Monodelphis domestica"
#>  [712] "Pygathrix bieti"
#>  [713] "Rhinopithecus bieti"
#>  [714] "Saimiri boliviensis"
#>  [715] "Hesperomys eremicus"
#>  [716] "Peromyscus eremicus"
#>  [717] "Arabidopsis salsuginea"
#>  [718] "Eutrema salsugineum"
#>  [719] "Hesperis salsuginea"
#>  [720] "Sisymbrium salsugineum"
#>  [721] "Stenophragma salsugineum"
#>  [722] "Thellungiella salsuginea"
#>  [723] "Thelypodium salsugineum"
#>  [724] "Coetomys damarensis"
#>  [725] "Cryptomys damarensis"
#>  [726] "Fukomys damarensis"
#>  [727] "Cervus reevesi"
#>  [728] "Muntiacus reevesi"
#>  [729] "Limanda limanda"
#>  [730] "Liopsetta limanda"
#>  [731] "Pleuronectes limanda"
#>  [732] "Rhamnus zizyphus"
#>  [733] "Ziziphus jujuba"
#>  [734] "Leptonychotes weddellii"
#>  [735] "Leptonychotes weddelli"
#>  [736] "Otaria weddellii"
#>  [737] "Grammomys dolichurus_surdaster"
#>  [738] "Grammomys surdaster"
#>  [739] "Thamnomys surdaster"
#>  [740] "Solanum aracc-papa"
#>  [741] "Solanum tuberosum"
#>  [742] "Andropogon sorghum"
#>  [743] "Holcus bicolor"
#>  [744] "Sorghum bicolor"
#>  [745] "Sorghum bicolor_subsp._bicolor"
#>  [746] "Sorghum nervosum"
#>  [747] "Sorghum saccharatum"
#>  [748] "Sorghum vulgare"
#>  [749] "Madrepora verrucosa"
#>  [750] "Pocillopora danae"
#>  [751] "Pocillopora verrucosa"
#>  [752] "Holocentrus calcarifer"
#>  [753] "Lates calcarifer"
#>  [754] "Hippopotamus amphibius_kiboko"
#>  [755] "Ixodes sanguineus"
#>  [756] "Rhipicephalus sanguineus"
#>  [757] "Clupea harengus_harengus"
#>  [758] "Clupea harengus"
#>  [759] "Bos indicus_x_Bos_taurus"
#>  [760] "Bos primigenius_indicus_x_Bos_primigenius_taurus"
#>  [761] "Bos taurus_indicus_x_Bos_taurus_taurus"
#>  [762] "Bos taurus_x_Bos_indicus"
#>  [763] "Chrysochloris asiatica"
#>  [764] "Talpa asiatica"
#>  [765] "Bufo bufo"
#>  [766] "Rana bufo"
#>  [767] "Pelmatolapia mariae"
#>  [768] "Tilapia mariae"
#>  [769] "Maylandia callainos"
#>  [770] "Maylandia zebra"
#>  [771] "Metriaclima callainos"
#>  [772] "Metriaclima zebra"
#>  [773] "Pseudotropheus callainos"
#>  [774] "Pseudotropheus sp._'Pseudotropheus_zebra_complex'"
#>  [775] "Pseudotropheus zebra"
#>  [776] "Tilapia zebra"
#>  [777] "Saccopteryx bilineata"
#>  [778] "Urocryptus bilineatus"
#>  [779] "Ictalurus punctatus"
#>  [780] "Silurus punctatus"
#>  [781] "Trachinotus anak"
#>  [782] "Antilope dammah"
#>  [783] "Oryx dammah"
#>  [784] "Asparagus litoralis"
#>  [785] "Asparagus officinalis"
#>  [786] "Amaranthus gangeticus"
#>  [787] "Amaranthus mangostanus"
#>  [788] "Amaranthus tricolor"
#>  [789] "Aequipecten irradians"
#>  [790] "Argopecten irradians"
#>  [791] "Pecten irradians"
#>  [792] "Macrobrachium nipponense"
#>  [793] "Palaemon nipponense"
#>  [794] "Pneumatophorus japonicus"
#>  [795] "Scomber japonicus"
#>  [796] "Alnus glutinosa"
#>  [797] "Betula alnus_var._glutinosa"
#>  [798] "Saccopteryx leptura"
#>  [799] "Vespertilio lepturus"
#>  [800] "Lutra lutra"
#>  [801] "Peromyscus leucopus"
#>  [802] "Perca fluviatilis"
#>  [803] "Elephas africanus"
#>  [804] "Loxodonta africana_africana"
#>  [805] "Loxodonta africana"
#>  [806] "Pagothenia bernacchii"
#>  [807] "Pseudotrematomus bernacchii"
#>  [808] "Trematomus bernacchii"
#>  [809] "Trematomus bernacchi"
#>  [810] "Lipurus cinereus"
#>  [811] "Phascolarctos cinereus"
#>  [812] "Anguilla rostrata"
#>  [813] "Muraena rostrata"
#>  [814] "Mustela furo"
#>  [815] "Mustela putorius_furo"
#>  [816] "Chaetochloa italica"
#>  [817] "Panicum italicum"
#>  [818] "Pennisetum macrochaetum"
#>  [819] "Setaria italica"
#>  [820] "Setaria viridis_subsp._italica"
#>  [821] "Elaeis guineensis"
#>  [822] "Mus rattus"
#>  [823] "Rattus rattoides"
#>  [824] "Rattus rattus"
#>  [825] "Rattus wroughtoni"
#>  [826] "Acropora digitifera"
#>  [827] "Madrepora digitifera"
#>  [828] "Echinops telfairii"
#>  [829] "Echinops telfairi"
#>  [830] "Myotis daubentonii"
#>  [831] "Myotis daubentoni"
#>  [832] "Vespertilio daubentonii"
#>  [833] "Limia formosa"
#>  [834] "Mollienesia formosa"
#>  [835] "Poecilia formosa"
#>  [836] "Macrorhinus angustirostris"
#>  [837] "Mirounga angustirostris"
#>  [838] "Phyllostomus discolor"
#>  [839] "Phocoena crassidens"
#>  [840] "Pseudoorca crassidens"
#>  [841] "Pseudorca crassidens"
#>  [842] "Erinaceus europaeus"
#>  [843] "Hemiscyllium ocellatum"
#>  [844] "Squalus ocellatus"
#>  [845] "Microcebus murinus"
#>  [846] "Peromyscus californicus_insignis"
#>  [847] "Peromyscus californicus_subsp._insignis"
#>  [848] "Galago garnettii"
#>  [849] "Galago garnetti"
#>  [850] "Otolemur garnettii"
#>  [851] "Otolicnus garnettii"
#>  [852] "Arvicanthis niloticus"
#>  [853] "Mus niloticus"
#>  [854] "Didelphis ursina"
#>  [855] "Vombatus ursinus"
#>  [856] "Phaseolus angularis"
#>  [857] "Vigna angularis"
#>  [858] "Haitia acuta"
#>  [859] "Physa acuta"
#>  [860] "Physa heterostropha"
#>  [861] "Physa integra"
#>  [862] "Physella acuta"
#>  [863] "Physella heterostropha"
#>  [864] "Physella integra"
#>  [865] "Ctenopharyngodon idella"
#>  [866] "Ctenopharyngodon idellus"
#>  [867] "Leuciscus idella"
#>  [868] "Thalassophryne amazonica"
#>  [869] "Macrobrachium dacqueti_(Sunier,_1925)"
#>  [870] "Macrobrachium rosenbergii"
#>  [871] "Palaemon rosenbergii"
#>  [872] "Cyprinus rohita"
#>  [873] "Labeo rohita"
#>  [874] "Talpa occidentalis"
#>  [875] "Bombina bombina"
#>  [876] "Rana bombina"
#>  [877] "Amphibalanus amphitrite"
#>  [878] "Balanus amphitrite"
#>  [879] "Cynocephalus volans"
#>  [880] "Lemur volans"
#>  [881] "Panicum hallii"
#>  [882] "Angill angill"
#>  [883] "Anguilla anguilla_anguilla"
#>  [884] "Anguilla anguilla"
#>  [885] "Muraena anguilla"
#>  [886] "Fringilla domestica"
#>  [887] "Passer domesticus"
#>  [888] "Delphinus orca"
#>  [889] "Orcinus orca"
#>  [890] "Penaeus bubulus"
#>  [891] "Penaeus carinatus"
#>  [892] "Penaeus durbani"
#>  [893] "Penaeus monodon"
#>  [894] "Penaeus (Penaeus)_monodon"
#>  [895] "Didelphis vulpecula"
#>  [896] "Trichosurus vulpecula"
#>  [897] "Myotis lucifugus"
#>  [898] "Vespertilio lucifugus"
#>  [899] "Brachypodium distachyon"
#>  [900] "Bromus distachyos"
#>  [901] "Ailuropoda melanoleuca"
#>  [902] "Micropterus dolomieu"
#>  [903] "Micropterus velox"
#>  [904] "Labrus bergylta"
#>  [905] "Poecilia mexicana"
#>  [906] "Manis pentadactyla"
#>  [907] "Meles meles"
#>  [908] "Ursus meles"
#>  [909] "Ornithorhynchus anatinus"
#>  [910] "Platypus anatinus"
#>  [911] "Camelus dromedarius"
#>  [912] "Felis uncia"
#>  [913] "Panthera uncia"
#>  [914] "Uncia uncia"
#>  [915] "Alligator mississippiensis"
#>  [916] "Crocodilus mississipiensis"
#>  [917] "Myrmecophaga aculeata"
#>  [918] "Tachyglossus aculeatus"
#>  [919] "Pseudochaenichthys georgianus"
#>  [920] "Colossoma macropomum"
#>  [921] "Myletes macropomus"
#>  [922] "Cordylus capensis"
#>  [923] "Cordylus (Hemicordylus)_capensis"
#>  [924] "Hemicordylus capensis"
#>  [925] "Pseudocordylus capensis"
#>  [926] "Zonurus capensis"
#>  [927] "Eptesicus fuscus"
#>  [928] "Vespertilio fuscus"
#>  [929] "Dromiciops australis"
#>  [930] "Dromiciops gliroides"
#>  [931] "Camelus pacos"
#>  [932] "Lama guanicoe_pacos"
#>  [933] "Lama pacos"
#>  [934] "Vicugna pacos"
#>  [935] "Mollienesia latipinna"
#>  [936] "Poecilia latipinna"
#>  [937] "Elephas maximus_indicus"
#>  [938] "Balaena glacialis"
#>  [939] "Eubalaena glacialis"
#>  [940] "Corylus avellana"
#>  [941] "Ostrea maxima"
#>  [942] "Pecten maximus"
#>  [943] "Felis viverrina"
#>  [944] "Prionailurus viverrinus"
#>  [945] "Gymnodraco acuticeps"
#>  [946] "Thalarctos maritimus"
#>  [947] "Ursus maritimus"
#>  [948] "Lemur catta"
#>  [949] "Bodianus pulcher"
#>  [950] "Labrus pulcher"
#>  [951] "Semicossyphus pulcher"
#>  [952] "Lepus capensis_europaeus"
#>  [953] "Lepus europaeus"
#>  [954] "Myotis myotis"
#>  [955] "Vespertilio myotis"
#>  [956] "Ursus arctos"
#>  [957] "Vitis riparia"
#>  [958] "Felis bengalensis"
#>  [959] "Prionailurus bengalensis"
#>  [960] "Clethrionomys glareolus"
#>  [961] "Mus glareolus"
#>  [962] "Myodes glareolus"
#>  [963] "Mustela nigripes"
#>  [964] "Putorius nigripes"
#>  [965] "Alopex lagopus"
#>  [966] "Canis lagopus"
#>  [967] "Vulpes lagopus"
#>  [968] "Cercocebus atys"
#>  [969] "Cercocebus torquatus_atys"
#>  [970] "Simia atys"
#>  [971] "Lepidosiren annectens"
#>  [972] "Protopterus annectens"
#>  [973] "Rhinocryptis annectens"
#>  [974] "Cerasus avium"
#>  [975] "Prunus avium"
#>  [976] "Prunus cerasus_var._avium"
#>  [977] "Gadus macrocephalus"
#>  [978] "Hippoglossus olivaceus"
#>  [979] "Paralichthys olivaceus"
#>  [980] "Sorex fumeus"
#>  [981] "Scomber scomber"
#>  [982] "Scomber scombrus"
#>  [983] "Beta vulgaris_subsp._vulgaris"
#>  [984] "Beta vulgaris_subsp._vulgaris_var._altissima"
#>  [985] "Beta vulgaris_Sugar_Beet_Group"
#>  [986] "Beta vulgaris_var._altissima"
#>  [987] "Balaenoptera ricei"
#>  [988] "Eumetopias jubatus"
#>  [989] "Phoca jubata"
#>  [990] "Centruroides sculpturatus"
#>  [991] "Diceros bicornis_minor"
#>  [992] "Myotis yumanensis"
#>  [993] "Vespertilio yumanensis"
#>  [994] "Cicer arietinum"
#>  [995] "Cleome hassleriana_Chodat,_1898"
#>  [996] "Tarenaya hassleriana"
#>  [997] "Sebastes umbrosus"
#>  [998] "Sebastichthys umbrosus"
#>  [999] "Dasyatis sabina"
#> [1000] "Hypanus sabinus"
#> [1001] "Trygon sabina"
#> [1002] "Eriocheir chinensis"
#> [1003] "Eriocheir japonica_sinensis"
#> [1004] "Eriocheir sinensis"
#> [1005] "Lacerta scincoides"
#> [1006] "Tiliqua scincoides"
#> [1007] "Cynara cardunculus_subsp._cardunculus"
#> [1008] "Bos grunniens_mutus"
#> [1009] "Bos mutus"
#> [1010] "Poephagus mutus"
#> [1011] "Acanthopagrus latus"
#> [1012] "Sparus latus"
#> [1013] "Xiphophorus hellerii"
#> [1014] "Xiphophorus helleri"
#> [1015] "Acanthochromis polyacanthus"
#> [1016] "Acanthochromis polyacathus"
#> [1017] "Dascyllus polyacanthus"
#> [1018] "Mustela vison"
#> [1019] "Neogale vison"
#> [1020] "Neovison vison"
#> [1021] "Lingula anatina"
#> [1022] "Lingula lingua"
#> [1023] "Lingula nipponica"
#> [1024] "Lingula unguis"
#> [1025] "Glomus irregulare_Blaszk.,_Wubet,_Renker_&_Buscot_2009"
#> [1026] "Rhizophagus irregularis_(Baszk.,_Wubet,_Renker_&_Buscot)_C._Walker_&_A._Schusler,_2010"
#> [1027] "Rhizophagus irregularis"
#> [1028] "Narcine bancroftii"
#> [1029] "Torpedo bancroftii"
#> [1030] "Madrepora faveolata"
#> [1031] "Montastraea faveolata"
#> [1032] "Montastrea faveolata"
#> [1033] "Orbicella faveolata"
#> [1034] "Esox lucius"
#> [1035] "Austroberyx affinis"
#> [1036] "Beryx affinis"
#> [1037] "Centroberyx affinis"
#> [1038] "Chinchilla lanigera"
#> [1039] "Chinchilla velligera"
#> [1040] "Chinchilla villidera"
#> [1041] "Mirounga leonina"
#> [1042] "Phoca leonina"
#> [1043] "Perognathus longimembris_pacificus"
#> [1044] "Cynocephalus variegatus"
#> [1045] "Galeopithecus variegatus"
#> [1046] "Galeopterus variegatus"
#> [1047] "Desmodus rotundus"
#> [1048] "Phyllostoma rotundum"
#> [1049] "Vigna radiata"
#> [1050] "Characodon multiradiatus"
#> [1051] "Girardinichthys multiradiatus"
#> [1052] "Phaseolus calcaratus"
#> [1053] "Phaseolus chrysanthos"
#> [1054] "Phaseolus chrysanthus"
#> [1055] "Vigna calcarata"
#> [1056] "Vigna umbellata"
#> [1057] "Balaenoptera acutorostrata"
#> [1058] "Canis procyonoides"
#> [1059] "Nyctereutes procyonoides"
#> [1060] "Amphioxus floridae"
#> [1061] "Branchiostoma floridae"
#> [1062] "Moschus berezovskii"
#> [1063] "Erythranthe guttata"
#> [1064] "Mimulus guttatus_subsp._guttatus"
#> [1065] "Mimulus guttatus"
#> [1066] "Camelus bactrianus"
#> [1067] "Octopus sinensis"
#> [1068] "Alexandromys fortis"
#> [1069] "Microtus fortis"
#> [1070] "Dendronephthya gigantea"
#> [1071] "Canis hyaena"
#> [1072] "Hyaena hyaena"
#> [1073] "Myxine glutinosa"
#> [1074] "Physeter catodon"
#> [1075] "Physeter macrocephalus"
#> [1076] "Vitis vinifera"
#> [1077] "Vitis vinifera_subsp._vinifera"
#> [1078] "Helicophagus hypophthalmus"
#> [1079] "Pangasianodon hypophthalmus"
#> [1080] "Pangasius hypophthalmus"
#> [1081] "Pangasius sutchi"
#> [1082] "Capsella rubella"
#> [1083] "Perkinsus marinus_ATCC_50983"
#> [1084] "Holocentrus leopardus"
#> [1085] "Plectropomus leopardus"
#> [1086] "Hippocampus zosterae"
#> [1087] "Artibeus jamaicensis"
#> [1088] "Citrus sinensis"
#> [1089] "Punica granatum"
#> [1090] "Abrus cyaneus"
#> [1091] "Abrus precatorius"
#> [1092] "Polypterus senegalus"
#> [1093] "Acomys russatus"
#> [1094] "Mus russatus"
#> [1095] "Hemibagrus wyckioides"
#> [1096] "Macrones wyckioides"
#> [1097] "Mystus wyckioides"
#> [1098] "Melanotaenia boesemani"
#> [1099] "Balaenoptera robusta"
#> [1100] "Eschrichtius gibbosus"
#> [1101] "Eschrichtius robustus"
#> [1102] "Sturnira hondurensis"
#> [1103] "Sturnira ludovici_hondurensis"
#> [1104] "Amphilophus centrarchus"
#> [1105] "Archocentrus centrarchus"
#> [1106] "Cichlasoma centrarchus"
#> [1107] "Heros centrarchus"
#> [1108] "Delphinus melas"
#> [1109] "Globicephala melaena"
#> [1110] "Globicephala melas"
#> [1111] "Manis javanica"
#> [1112] "Phyllostomus hastatus"
#> [1113] "Vespertilio hastatus"
#> [1114] "Scyliorhinus canicula"
#> [1115] "Squalus canicula"
#> [1116] "Pipistrellus deserti"
#> [1117] "Pipistrellus kuhlii_deserti"
#> [1118] "Pipistrellus kuhlii"
#> [1119] "Pipistrellus kuhli"
#> [1120] "Vespertilio kuhlii"
#> [1121] "Silurana tropicalis"
#> [1122] "Xenopus laevis_tropicalis"
#> [1123] "Xenopus (Silurana)_tropicalis"
#> [1124] "Xenopus tropicalis"
#> [1125] "Solea senegalensis"
#> [1126] "Branchiostoma lanceolatum"
#> [1127] "Limax lanceolatus"
#> [1128] "Mugil cephalotus"
#> [1129] "Mugil cephalus"
#> [1130] "Mugil galapagensis"
#> [1131] "Mugil japonicus"
#> [1132] "Capra aegagrus_hircus"
#> [1133] "Capra hircus"
#> [1134] "Poeciliopsis prolifica"
#> [1135] "Latimeria chalumnae"
#> [1136] "Gopherus flavomarginatus"
#> [1137] "Lontra canadensis"
#> [1138] "Lutra canadensis"
#> [1139] "Hesperomys torridus"
#> [1140] "Onychomys torridus"
#> [1141] "Boophilus microplus"
#> [1142] "Rhipicephalus (Boophilus)_microplus"
#> [1143] "Rhipicephalus microplus"
#> [1144] "Molossus molossus"
#> [1145] "Vespertilio molossus"
#> [1146] "Lagenorhynchus obliquidens"
#> [1147] "Sagmatias obliquidens"
#> [1148] "Syngnathus typhle"
#> [1149] "Delphinus cymodoce"
#> [1150] "Delphinus truncatus"
#> [1151] "Tursiops cymodoce"
#> [1152] "Tursiops truncatus"
#> [1153] "Antilope sumatraensis"
#> [1154] "Capricornis sumatraensis"
#> [1155] "Capricornis sumatrensis"
#> [1156] "Naemorhedus sumatraensis"
#> [1157] "Morone flavescens"
#> [1158] "Perca flavescens"
#> [1159] "Arvicola nivalis"
#> [1160] "Chionomys nivalis"
#> [1161] "Microtus nivalis"
#> [1162] "Felis rufus"
#> [1163] "Lynx rufus"
#> [1164] "Siphostoma scovelli"
#> [1165] "Syngnathus scovelli"
#> [1166] "Myotis brandtii"
#> [1167] "Vespertilio brandtii"
#> [1168] "Astatotilapia burtoni"
#> [1169] "Chromis burtoni"
#> [1170] "Haplochromis burtoni"
#> [1171] "Sorex araneus"
#> [1172] "Kogia breviceps"
#> [1173] "Physeter breviceps"
#> [1174] "Silurus meridionalis"
#> [1175] "Silurus soldatovi_meridionalis"
#> [1176] "Cucumis melo"
#> [1177] "Anoplopoma fimbria"
#> [1178] "Gadus fimbria"
#> [1179] "Lagenorhynchus albirostris"
#> [1180] "Alosa alosa"
#> [1181] "Clupea alosa"
#> [1182] "Chelonia mydas"
#> [1183] "Testudo mydas"
#> [1184] "Ctenocephalides felis"
#> [1185] "Stylophora pistillata"
#> [1186] "Eulemur rufifrons"
#> [1187] "Cyrtodiopsis dalmanii"
#> [1188] "Diopsis dalmanni"
#> [1189] "Teleopsis dalmanni"
#> [1190] "Rhagoletis zephyria"
#> [1191] "Rhodamnia argentea"
#> [1192] "Gasterosteus aculeatus"
#> [1193] "Labrus celidotus"
#> [1194] "Notolabrus celidotus"
#> [1195] "Budorcas taxicolor"
#> [1196] "Nelumbo nucifera"
#> [1197] "Amphiprion ocellaris"
#> [1198] "Arvicola amphibius"
#> [1199] "Arvicola terrestris_(Linnaeus,_1758)"
#> [1200] "Mus amphibius"
#> [1201] "Daphnia magna"
#> [1202] "Psammomys obesus"
#> [1203] "Carlito syrichta"
#> [1204] "Simia syrichta"
#> [1205] "Tarsius syrichta"
#> [1206] "Cyprinodon tularosa"
#> [1207] "Arvicola princeps"
#> [1208] "Ochotona princeps"
#> [1209] "Phytophthora sojae"
#> [1210] "Phoca vitulina"
#> [1211] "Coecilia bivitatum"
#> [1212] "Rhinatrema bivitattum"
#> [1213] "Rhinatrema bivittatum"
#> [1214] "Lagomys curzoniae"
#> [1215] "Ochotona curzonae"
#> [1216] "Ochotona curzoniae"
#> [1217] "Litopenaeus vannamei"
#> [1218] "Penaeus (Litopenaeus)_vannamei"
#> [1219] "Penaeus vannamei"
#> [1220] "Clupea cyprinoides"
#> [1221] "Megalops cyprinoides"
#> [1222] "Diospyros lotus"
#> [1223] "Hippoglossus stenolepis"
#> [1224] "Phacochoerus africanus"
#> [1225] "Sus africanus"
#> [1226] "Corythoichthys intestinalis"
#> [1227] "Syngnatus intestinalis"
#> [1228] "Mandrillus leucophaeus"
#> [1229] "Papio leucophaeus"
#> [1230] "Simia leucophaea"
#> [1231] "Scylla paramamosain"
#> [1232] "Lepidosternon floridanum"
#> [1233] "Rhineura floridana"
#> [1234] "Delphinus densirostris"
#> [1235] "Mesoplodon densirostris"
#> [1236] "Epinephelus fuscoguttatus"
#> [1237] "Perca summana_fuscoguttata"
#> [1238] "Asterias miniata"
#> [1239] "Asterina miniata"
#> [1240] "Patiria miniata"
#> [1241] "Lampris incognitus"
#> [1242] "Monachus schauinslandi"
#> [1243] "Neomonachus schauinslandi"
#> [1244] "Hippoglossus hippoglossus"
#> [1245] "Pleuronectes hippoglossus"
#> [1246] "Andrographis paniculata"
#> [1247] "Etheostoma cragini"
#> [1248] "Perca chuatsi"
#> [1249] "Siniperca chuatsi"
#> [1250] "Colobus angolensis_palliatus"
#> [1251] "Notothenia coriiceps"
#> [1252] "Hypomesus transpacificus"
#> [1253] "Clytia hemisphaerica"
#> [1254] "Clytia languida"
#> [1255] "Clytia viridicans"
#> [1256] "Medusa hemisphaerica"
#> [1257] "Dermochelys coriacea"
#> [1258] "Testudo coriacea"
#> [1259] "Bufo bufo_gargarizans"
#> [1260] "Bufo gargarizans"
#> [1261] "Bufo japonicus_gargarizans"
#> [1262] "Equus burchellii_quagga"
#> [1263] "Equus quagga"
#> [1264] "Delphinapterus leucas"
#> [1265] "Delphinus leucas"
#> [1266] "Fugu flavidus"
#> [1267] "Takifugu flavidus"
#> [1268] "Pteronotus mesoamericanus"
#> [1269] "Pteronotus parnellii_mesoamericanus"
#> [1270] "Citrus clementina"
#> [1271] "Citrus deliciosa_x_Citrus_sinensis"
#> [1272] "Citrus x_clementina"
#> [1273] "Fugu rubripes"
#> [1274] "Sphaeroides rubripes"
#> [1275] "Takifugu rubripes"
#> [1276] "Tetraodon rubripes"
#> [1277] "Homarus americanus"
#> [1278] "Osteoglossum formosum"
#> [1279] "Scleropages formosus"
#> [1280] "Larimichthys crocea"
#> [1281] "Pseudosciaena amblyceps"
#> [1282] "Pseudosciaena crocea"
#> [1283] "Sciaena crocea"
#> [1284] "Fragaria vesca"
#> [1285] "Folsomia candida"
#> [1286] "Seriola aureovittata"
#> [1287] "Seriola lalandi_aureovittata"
#> [1288] "Helops morio"
#> [1289] "Zophobas atratus_f._morio"
#> [1290] "Zophobas morio"
#> [1291] "Limulus polyphemus"
#> [1292] "Monoculus polyphemus"
#> [1293] "Doryrhamphus dactyliophorus"
#> [1294] "Dunckerocampus dactyliophorus"
#> [1295] "Syngnathus dactyliophorus"
#> [1296] "Epinephelus lanceolatus"
#> [1297] "Holocentrus lanceolatus"
#> [1298] "Promicrops lanceolatus"
#> [1299] "Mizuhopecten yessoensis"
#> [1300] "Patinopecten yessoensis"
#> [1301] "Patiopecten yessoensis"
#> [1302] "Pecten yessoensis"
#> [1303] "Platypoecilus maculatus"
#> [1304] "Xiphophorus maculatus"
#> [1305] "Fenneropenaeus indicus"
#> [1306] "Penaeus (Fenneropenaeus)_indicus"
#> [1307] "Penaeus indicus"
#> [1308] "Triplophysa rosa"
#> [1309] "Pempheris klunzingeri"
#> [1310] "Antechinus flavipes"
#> [1311] "Phascogale flavipes"
#> [1312] "Anolis carolinensis"
#> [1313] "Delphinus delphis"
#> [1314] "Anabrus simplex"
#> [1315] "Apodichthys violaceus"
#> [1316] "Cebidichthys violaceus"
#> [1317] "Oryza brachyantha"
#> [1318] "Emydura macquarii_macquarii"
#> [1319] "Emys macquaria_macquaria"
#> [1320] "Tetrahymena thermophila_SB210"
#> [1321] "Amygdalus communis"
#> [1322] "Amygdalus dulcis"
#> [1323] "Prunus amygdalus"
#> [1324] "Prunus communis"
#> [1325] "Prunus dulcis"
#> [1326] "Prunus dulcis_var._sativa"
#> [1327] "Oryzias latipes"
#> [1328] "Poecilia latipes"
#> [1329] "Bagrus vachellii"
#> [1330] "Pelteobagrus vachellii"
#> [1331] "Pseudobagrus vachellii"
#> [1332] "Pseudobagrus vachelli"
#> [1333] "Tachysurus vachellii"
#> [1334] "Sarcophilus harrisii"
#> [1335] "Sarcophilus laniarius_(Owen,_1838)"
#> [1336] "Sarcophilus laniarius"
#> [1337] "Ursinus harrisii"
#> [1338] "Ictalurus furcatus"
#> [1339] "Pimelodus furcatus"
#> [1340] "Amphioxus belcheri"
#> [1341] "Branchiostoma belcheri"
#> [1342] "Gigantopelta aegis"
#> [1343] "Echinus variegatus"
#> [1344] "Lytechinus variegatus"
#> [1345] "Antennarius striatus"
#> [1346] "Lophius striatus"
#> [1347] "Diaphorina citri"
#> [1348] "Diaphornia citri"
#> [1349] "Epinephelus moara"
#> [1350] "Serranus moara"
#> [1351] "Stegodyphus dumicola"
#> [1352] "Boleophthalmus pectinirostris"
#> [1353] "Gobius pectinirostris"
#> [1354] "Austrofundulus limnaeus"
#> [1355] "Scypha ciliata"
#> [1356] "Spongia ciliata"
#> [1357] "Sycon ciliatum"
#> [1358] "Pleuronectes maximus"
#> [1359] "Psetta maxima"
#> [1360] "Rhombus maximus"
#> [1361] "Scophthalmus maximus"
#> [1362] "Sesamum indicum"
#> [1363] "Sesamum orientale"
#> [1364] "Clinocottus analis"
#> [1365] "Oligocottus analis"
#> [1366] "Necator americanus"
#> [1367] "Armeniaca mume"
#> [1368] "Prunus mume"
#> [1369] "Myotis aurascens"
#> [1370] "Myotis davidii"
#> [1371] "Myotis hajastanicus"
#> [1372] "Vespertilio Davidii"
#> [1373] "Didelphys agilis"
#> [1374] "Gracilinanus agilis"
#> [1375] "Acanthophacelus reticulata"
#> [1376] "Poecilia (Acanthophacelus)_reticulata"
#> [1377] "Poecilia latipinna_reticulata"
#> [1378] "Poecilia reticulata"
#> [1379] "Armigeres subalbatus"
#> [1380] "Culex subalbatus"
#> [1381] "Australorbis glabratus"
#> [1382] "Biomphalaria glabrata"
#> [1383] "Planorbis glabratus"
#> [1384] "Hypudaeus ochrogaster"
#> [1385] "Microtus ochrogaster"
#> [1386] "Amygdalus persica"
#> [1387] "Persica vulgaris"
#> [1388] "Prunus persica"
#> [1389] "Prunus persica_var._densa"
#> [1390] "Xenia sp._Carnegie-2017"
#> [1391] "Chiloscyllium plagiosum"
#> [1392] "Scyllium plagiosum"
#> [1393] "Cheilinus undulatus"
#> [1394] "Coluber guttatus"
#> [1395] "Elaphe guttata"
#> [1396] "Pantherophis guttatus"
#> [1397] "Phodopus roborovskii"
#> [1398] "Caenorhabditis remanei"
#> [1399] "Caenorhabditis vulgaris"
#> [1400] "Lamprologus brichardi"
#> [1401] "Neolamprologus brichardi"
#> [1402] "Eleginops maclovinus"
#> [1403] "Eleginus maclovinus"
#> [1404] "Gymnopis unicolor"
#> [1405] "Microcaecilia unicolor"
#> [1406] "Rhinatrema unicolor"
#> [1407] "Sciaena jaculatrix"
#> [1408] "Toxotes jaculatrix"
#> [1409] "Emys pileata"
#> [1410] "Malaclemys terrapin_pileata"
#> [1411] "Lacerta sicula_raffonei"
#> [1412] "Podarcis raffoneae"
#> [1413] "Podarcis raffonei"
#> [1414] "Podarcis wagleriana_raffonei"
#> [1415] "Benincasa cerifera"
#> [1416] "Benincasa hispida"
#> [1417] "Benincasa pruriens"
#> [1418] "Cucurbita hispida"
#> [1419] "Lagenaria siceraria_var._hispida"
#> [1420] "Dendrobium catenatum"
#> [1421] "Chaetodon armatus"
#> [1422] "Enoplosus armatus"
#> [1423] "Marsupenaeus japonicus"
#> [1424] "Penaeus japonicus"
#> [1425] "Penaeus (Marsupenaeus)_japonicus"
#> [1426] "Penaeus (Melicertus)_japonicus"
#> [1427] "Chaetodon argus"
#> [1428] "Scatophagus argus"
#> [1429] "Anas boschas"
#> [1430] "Anas domesticus"
#> [1431] "Anas platyrhynchos_f._domestica"
#> [1432] "Anas platyrhynchos"
#> [1433] "Chanos chanos"
#> [1434] "Mugil chanos"
#> [1435] "Bison bison_bison"
#> [1436] "Bos bison_bison"
#> [1437] "Amblyraja radiata"
#> [1438] "Raja radiata"
#> [1439] "Delphinus phocoena"
#> [1440] "Phocoena phocoena"
#> [1441] "Phocoenoides phocoena"
#> [1442] "Amphimedon queenslandica"
#> [1443] "Hippocampus comes"
#> [1444] "Hipposideros armiger"
#> [1445] "Rhinolophus armiger"
#> [1446] "Cynoglossus (Arelia)_semilaevis"
#> [1447] "Cynoglossus semilaevis"
#> [1448] "Alecto japonica"
#> [1449] "Anneissia japonica"
#> [1450] "Oxycomanthus japonicus"
#> [1451] "Ananas comosus"
#> [1452] "Ananas comosus_var._comosus"
#> [1453] "Ananas lucidus"
#> [1454] "Bromelia comosa"
#> [1455] "Callionymus splendidus"
#> [1456] "Pterosynchiropus splendidus"
#> [1457] "Synchiropus splendidus"
#> [1458] "Neophocaena asiaeorientalis_asiaeorientalis"
#> [1459] "Pollicipes cornucopia"
#> [1460] "Pollicipes pollicipes"
#> [1461] "Pseudoliparis swirei"
#> [1462] "Blatta americana"
#> [1463] "Periplaneta americana"
#> [1464] "Rhincodon typus"
#> [1465] "Ricinus communis"
#> [1466] "Ricinus sanguineus"
#> [1467] "Anomalospiza imberbis"
#> [1468] "Crithagra imberbis"
#> [1469] "Phyllopteryx taeniolatus"
#> [1470] "Syngnatus taeniolatus"
#> [1471] "Lytechinus pictus"
#> [1472] "Psammechinus pictus"
#> [1473] "Brachionichthys hirsutus"
#> [1474] "Lophius hirsutus"
#> [1475] "Malania oleifera"
#> [1476] "Schizoporella aterrima_var._subatra"
#> [1477] "Watersipora subatra"
#> [1478] "Heteronota binoei"
#> [1479] "Heteronotia binoei"
#> [1480] "Trichomonas foetus"
#> [1481] "Tritrichomonas foetus"
#> [1482] "Aedes albopictus"
#> [1483] "Stegomyia albopicta"
#> [1484] "Ceratotherium simum_simum"
#> [1485] "Kryptolebias marmoratus"
#> [1486] "Rivulus marmoratus"
#> [1487] "Patella vulgata"
#> [1488] "Rhagoletis pomonella"
#> [1489] "Trypanosoma cruzi"
#> [1490] "Squalus fasciatus"
#> [1491] "Squalus tigrinus"
#> [1492] "Stegostoma fasciatum"
#> [1493] "Stegostoma tigrinum"
#> [1494] "Cistudo triunguis"
#> [1495] "Terrapene mexicana_triunguis"
#> [1496] "Terrapene triunguis"
#> [1497] "Odobenus rosmarus_divergens"
#> [1498] "Trichechus divergens"
#> [1499] "Manatus latirostris"
#> [1500] "Trichechus manatus_latirostris"
#> [1501] "Carcharodon carcharias"
#> [1502] "Squalus carcharias"
#> [1503] "Macrognathus armatus"
#> [1504] "Mastacembelus armatus"
#> [1505] "Theobroma cacao"
#> [1506] "Diabrotica virgifera_virgifera"
#> [1507] "Syngnathoides biaculeatus"
#> [1508] "Syngnathus biaculeatus"
#> [1509] "Actinia diaphana"
#> [1510] "Aiptasia pallida"
#> [1511] "Aiptasia pulchella"
#> [1512] "Dysactis pallida"
#> [1513] "Exaiptasia diaphana"
#> [1514] "Exaiptasia pallida"
#> [1515] "Syngnathus acus_rubescens"
#> [1516] "Syngnathus acus"
#> [1517] "Syngnathus rubescens"
#> [1518] "Guillardia theta_CCMP2712"
#> [1519] "Anarrhichthys ocellatus"
#> [1520] "Caretta caretta"
#> [1521] "Testudo caretta"
#> [1522] "Pelodiscus sinensis"
#> [1523] "Trionyx sinensis"
#> [1524] "Anas acuta"
#> [1525] "Xiphias gladius"
#> [1526] "Cyprinodon variegatus"
#> [1527] "Alligator sinensis"
#> [1528] "Morus notabilis"
#> [1529] "Embiotoca jacksonii"
#> [1530] "Embiotoca jacksoni"
#> [1531] "Nymphaea colorata"
#> [1532] "Lampyris pyralis"
#> [1533] "Photinus pyralis"
#> [1534] "Chaetodon trifascialis"
#> [1535] "Meleagris gallopavo"
#> [1536] "Pomacea canaliculata"
#> [1537] "Haplochromis nyererei"
#> [1538] "Pundamilia nyererei"
#> [1539] "Dixiphia pipra"
#> [1540] "Parus pipra"
#> [1541] "Pipra pipra"
#> [1542] "Pseudopipra pipra"
#> [1543] "Caranx dumerili"
#> [1544] "Seriola dumerili"
#> [1545] "Macrosteles (Macrosteles)_quadrilineatus"
#> [1546] "Macrosteles quadrilineatus"
#> [1547] "Lampetra reissneri"
#> [1548] "Lethenteron reissneri"
#> [1549] "Petromyzon reissneri"
#> [1550] "Enhydra lutris_kenyoni"
#> [1551] "Fluta alba"
#> [1552] "Monopterus albus"
#> [1553] "Muraena alba"
#> [1554] "Caecilia seraphini"
#> [1555] "Geotrypetes seraphini"
#> [1556] "Hypogeophis seraphini"
#> [1557] "Chaetodon rostratus"
#> [1558] "Chelmon rostratus"
#> [1559] "Cucumis sativus"
#> [1560] "Cyrtodactylus macularius"
#> [1561] "Eublepharis macularius"
#> [1562] "Aphelocoma coerulescens"
#> [1563] "Corvus coerulescens"
#> [1564] "Felis concolor"
#> [1565] "Panthera concolor"
#> [1566] "Puma concolor"
#> [1567] "Cephalopterus hypostomus"
#> [1568] "Mobula hypostoma"
#> [1569] "Cancer chinensis"
#> [1570] "Fenneropenaeus chinensis"
#> [1571] "Penaeus chinensis"
#> [1572] "Pomacentrus partitus"
#> [1573] "Stegastes partitus"
#> [1574] "Phascum patens"
#> [1575] "Physcomitrella patens_subsp._patens"
#> [1576] "Physcomitrella patens"
#> [1577] "Physcomitrium patens"
#> [1578] "Anas jamaicensis"
#> [1579] "Oxyura jamaicensis"
#> [1580] "Drosophila miranda"
#> [1581] "Lottia gigantea"
#> [1582] "Crotalus tigris"
#> [1583] "Eurytemora carolleeae"
#> [1584] "Argentina anserina"
#> [1585] "Potentilla anserina"
#> [1586] "Struthio camelus_domesticus"
#> [1587] "Struthio camelus"
#> [1588] "Uranotaenia lowii"
#> [1589] "Cynolebias whitei"
#> [1590] "Nematolebias whitei"
#> [1591] "Simpsonichthys whitei"
#> [1592] "Sceloporus undulatus"
#> [1593] "Stellio undulatus"
#> [1594] "Helobdella robusta"
#> [1595] "Anolis sagrei"
#> [1596] "Norops sagrei"
#> [1597] "Styela clava"
#> [1598] "Manis afer_afer"
#> [1599] "Orycteropus afer_afer"
#> [1600] "Leucoraja erinaceus"
#> [1601] "Raja erinaceus"
#> [1602] "Phytophthora nicotianae_INRA-310"
#> [1603] "Brachyistius frenatus"
#> [1604] "Micrometrus frenatus"
#> [1605] "Anas olor"
#> [1606] "Cygnus olor"
#> [1607] "Lacerta agilis"
#> [1608] "Phycodurus eques"
#> [1609] "Phyllopteryx eques"
#> [1610] "Coluber reginae"
#> [1611] "Erythrolamprus reginae"
#> [1612] "Leimadophis reginae"
#> [1613] "Liophis reginae"
#> [1614] "Millepora damicornis"
#> [1615] "Pocillopora caespitosa_laysanensis"
#> [1616] "Pocillopora damicornis_laysanensis"
#> [1617] "Pocillopora damicornis"
#> [1618] "Morone saxatilis"
#> [1619] "Perca saxatilis"
#> [1620] "Columba livia_domestica"
#> [1621] "Columba livia"
#> [1622] "Miniopterus natalensis"
#> [1623] "Miniopterus schreibersii_natalensis"
#> [1624] "Vespertilio natalensis"
#> [1625] "Buthus vittatus"
#> [1626] "Centruroides vittatus"
#> [1627] "Actinia tenebrosa"
#> [1628] "Neptunus trituberculatus"
#> [1629] "Portunus (Portunus)_trituberculatus"
#> [1630] "Portunus trituberculatus"
#> [1631] "Lacerta vivipara"
#> [1632] "Zootoca vivipara"
#> [1633] "Jatropha curcas"
#> [1634] "Propithecus coquereli"
#> [1635] "Propithecus verreauxi_coquereli"
#> [1636] "Amusium balloti"
#> [1637] "Amusium japonicum_balloti"
#> [1638] "Pecten balloti"
#> [1639] "Ylistrum balloti"
#> [1640] "Emys orbicularis"
#> [1641] "Testudo orbicularis"
#> [1642] "Caenorhabditis briggsae"
#> [1643] "Rhabditis briggsae"
#> [1644] "Homalodisca coagulata"
#> [1645] "Homalodisca vitripennis"
#> [1646] "Tettigonia coagulata"
#> [1647] "Tettigonia vitripennis"
#> [1648] "Corticium candelabrum"
#> [1649] "Python bivittatus"
#> [1650] "Python molurus_bivittatus"
#> [1651] "Chrysemys scripta_elegans"
#> [1652] "Emys elegans"
#> [1653] "Pseudemys scripta_elegans"
#> [1654] "Trachemys scripta_elegans"
#> [1655] "Protobothrops mucrosquamatus"
#> [1656] "Trigonocephalus mucrosquamatus"
#> [1657] "Trimeresurus mucrosquamatus"
#> [1658] "Daphnia pulex"
#> [1659] "Paramacrobiotus metropolitanus"
#> [1660] "Lipotes vexillifer"
#> [1661] "Columba fasciata"
#> [1662] "Patagioenas fasciata"
#> [1663] "Petromyzon marinus"
#> [1664] "Falco albicilla"
#> [1665] "Haliaeetus albicilla"
#> [1666] "Poephila guttata"
#> [1667] "Taeniopygia guttata"
#> [1668] "Taenopygia guttata"
#> [1669] "Aplysia californica"
#> [1670] "Phalaenopsis equestris"
#> [1671] "Stauroglottis equestris"
#> [1672] "Palinurus ornatus"
#> [1673] "Panulirus ornatus"
#> [1674] "Balanoglossus kowalevskii"
#> [1675] "Saccoglossus kowalevskii"
#> [1676] "Saccoglossus kowalevskyi"
#> [1677] "Momordica charantia"
#> [1678] "Numida meleagris"
#> [1679] "Phasianus meleagris"
#> [1680] "Callorhinchus milii"
#> [1681] "Halichondria (Halichondria)_panicea"
#> [1682] "Halichondria panicea"
#> [1683] "Spongia panicea"
#> [1684] "Sphaerodactylus townsendi"
#> [1685] "Achaearanea tepidariorum"
#> [1686] "Parasteatoda tepidariorum"
#> [1687] "Theridion tepidariorum"
#> [1688] "Elgaria multicarinata_webbii"
#> [1689] "Elgaria multicarinata_webbi"
#> [1690] "Gerrhonotus webbii"
#> [1691] "Eutainia elegans"
#> [1692] "Thamnophis elegans"
#> [1693] "Corvus hawaiiensis"
#> [1694] "Manacus candei"
#> [1695] "Pipra candei"
#> [1696] "Chamaea fasciata"
#> [1697] "Parus fasciatus"
#> [1698] "Pezoporus flaviventris"
#> [1699] "Pezoporus wallicus_flaviventris_North,_1911"
#> [1700] "Pezoporus wallicus_flaviventris"
#> [1701] "Apteryx mantelli"
#> [1702] "Euleptes europaea"
#> [1703] "Euleptes europea"
#> [1704] "Phyllodactylus europaea"
#> [1705] "Phyllodactylus europaeus"
#> [1706] "Ptyodactylus caudivolvolus"
#> [1707] "Megarhinus septentrionalis"
#> [1708] "Toxorhynchites rutilus_septentrionalis"
#> [1709] "Altirana parkeri"
#> [1710] "Nanorana parkeri"
#> [1711] "Ahaetulla prasina"
#> [1712] "Dryophis prasinus"
#> [1713] "Metopolophium dirhodum"
#> [1714] "Fusarium oxysporum_f._sp._lycopersici_4287"
#> [1715] "Heteropelma chrysocephalum"
#> [1716] "Neopelma chrysocephalum"
#> [1717] "Melanerpes formicivorus"
#> [1718] "Picus formicivorus"
#> [1719] "Lathamus discolor"
#> [1720] "Psittacus discolor"
#> [1721] "Musca domestica"
#> [1722] "Acanthopleura japonica"
#> [1723] "Chiton japonicus"
#> [1724] "Liolophura japonica"
#> [1725] "Ascaris longissima"
#> [1726] "Lineus longissimus"
#> [1727] "Pristis pectinata"
#> [1728] "Acinia solidaginis"
#> [1729] "Eurosta solidaginis"
#> [1730] "Fringilla melodia_melodia"
#> [1731] "Melospiza melodia_melodia"
#> [1732] "Astacus quadricarinatus"
#> [1733] "Cherax quadricarinatus"
#> [1734] "Ischnura elegans"
#> [1735] "Geopsittacus occidentalis"
#> [1736] "Pezoporus occidentalis"
#> [1737] "Fringilla chalybeata"
#> [1738] "Vidua chalybeata"
#> [1739] "Coturnix coturnix_japanica"
#> [1740] "Coturnix coturnix_japonica"
#> [1741] "Coturnix coturnix_Japonicus"
#> [1742] "Coturnix japonica_japonica"
#> [1743] "Coturnix japonica"
#> [1744] "Gekko japonicus"
#> [1745] "Platydactylus japonicus"
#> [1746] "Pelecanus carbo"
#> [1747] "Phalacrocorax carbo"
#> [1748] "Nilaparvata lugens"
#> [1749] "Ardea americana"
#> [1750] "Grus americana"
#> [1751] "Grus americanus"
#> [1752] "Aedes camptorhynchus"
#> [1753] "Culex camptorhynchus"
#> [1754] "Ochlerotatus camptorhynchus"
#> [1755] "Ochlerotatus (Ochlerotatus)_camptorhynchus"
#> [1756] "Harpia harpyja"
#> [1757] "Vultur harpyja"
#> [1758] "Pipra filicauda"
#> [1759] "Herrania umbratica"
#> [1760] "Ilyonectria robusta"
#> [1761] "Ramularia robusta"
#> [1762] "Agelaius tricolor"
#> [1763] "Icterus tricolor"
#> [1764] "Cupidonia cupido_pallidicincta"
#> [1765] "Tympanuchus pallidicinctus"
#> [1766] "Topomyia yanbarensis"
#> [1767] "Parus atricapillus"
#> [1768] "Poecile atricapilla"
#> [1769] "Poecile atricapillus"
#> [1770] "Corapipo altera"
#> [1771] "Candoia aspera"
#> [1772] "Erebophis aspera"
#> [1773] "Acyrthosiphon pisum"
#> [1774] "Acyrthosiphum pisum"
#> [1775] "Aphis pisum"
#> [1776] "Saprolegnia parasitica_CBS_223.65"
#> [1777] "Fringilla macroura"
#> [1778] "Vidua macroura"
#> [1779] "Carica papaya"
#> [1780] "Chiroxiphia lanceolata"
#> [1781] "Pipra lanceolata"
#> [1782] "Heliangelus exortis"
#> [1783] "Trochilus exortis"
#> [1784] "Euphema bourkii"
#> [1785] "Neophema bourkii"
#> [1786] "Neopsephotus bourkii"
#> [1787] "Octopus bimaculoides"
#> [1788] "Lagopus muta"
#> [1789] "Tetrao mutus"
#> [1790] "Bradysia coprophila"
#> [1791] "Sciara coprophila"
#> [1792] "Bucco pusillus"
#> [1793] "Pogoniulus pusillus"
#> [1794] "Coluber sirtalis"
#> [1795] "Thamnophis sirtalis"
#> [1796] "Falco peregrinus"
#> [1797] "Falco cherrug"
#> [1798] "Phytophthora cinnamomi"
#> [1799] "Leptothorax nylanderi"
#> [1800] "Temnothorax nylanderi"
#> [1801] "Burrica mexicana"
#> [1802] "Carpodacus mexicanus"
#> [1803] "Fringilla mexicana"
#> [1804] "Haemorhous mexicanus"
#> [1805] "Asteracanthion distichum"
#> [1806] "Asteracanthium distichum"
#> [1807] "Asterias attenuata"
#> [1808] "Asterias distichum"
#> [1809] "Asterias rubens"
#> [1810] "Asterias stimpsoni"
#> [1811] "Asterias vulgaris"
#> [1812] "Fringilla gambellii"
#> [1813] "Zonotrichia leucophrys_gambelii"
#> [1814] "Manduca sexta"
#> [1815] "Sphinx sexta"
#> [1816] "Pituophis catenifer_annectens"
#> [1817] "Condylura cristata"
#> [1818] "Sorex cristatus"
#> [1819] "Cuculus canorus"
#> [1820] "Pezoporus wallicus"
#> [1821] "Aedes aegypti"
#> [1822] "Aedes (Stegomyia)_aegypti"
#> [1823] "Culex aegypti"
#> [1824] "Stegomyia aegypti"
#> [1825] "Falco naumanni"
#> [1826] "Corvus kubaryi"
#> [1827] "Larus tridactylus"
#> [1828] "Rissa tridactyla"
#> [1829] "Aphanomyces astaci"
#> [1830] "Culex (Culex)_pipiens_pallens"
#> [1831] "Culex pipiens_pallens"
#> [1832] "Cydia pomonella"
#> [1833] "Phalaena pomonella"
#> [1834] "Tenebrio molitor"
#> [1835] "Accipiter gentilis"
#> [1836] "Accipiter gentillis"
#> [1837] "Falco gentilis"
#> [1838] "Crocodylus porosus"
#> [1839] "Pterocnemia pennata"
#> [1840] "Rhea pennata"
#> [1841] "Amborella trichopoda"
#> [1842] "Falco biarmicus"
#> [1843] "Lagopus leucura"
#> [1844] "Lagopus leucurus"
#> [1845] "Tetrao leucurus"
#> [1846] "Falco rusticolus"
#> [1847] "Chroicocephalus ridibundus"
#> [1848] "Larus ridibundus"
#> [1849] "Artemia franciscana"
#> [1850] "Agaricus tabescens"
#> [1851] "Armillaria tabescens"
#> [1852] "Armillariella tabescens"
#> [1853] "Desarmillaria tabescens"
#> [1854] "Convoluta roscoffensis"
#> [1855] "Symsagittifera roscoffensis"
#> [1856] "Corvus brachyrhynchos"
#> [1857] "Uloborus diversus"
#> [1858] "Phytophthora infestans_strain_T30-4"
#> [1859] "Phytophthora infestans_T30-4"
#> [1860] "Empidonax traillii"
#> [1861] "Muscicapa traillii"
#> [1862] "Bacillus redtenbacheri"
#> [1863] "Bacillus rossius_redtenbacheri"
#> [1864] "Motacilla subflava"
#> [1865] "Prinia subflava"
#> [1866] "Strix alba"
#> [1867] "Tyto alba"
#> [1868] "Parus major"
#> [1869] "Coccus citri"
#> [1870] "Phenacoccus citri"
#> [1871] "Planococcus citri"
#> [1872] "Caligus salmonis"
#> [1873] "Lepeophtheirus salmonis_salmonis"
#> [1874] "Lepeophtheirus salmonis"
#> [1875] "Fusarium solani"
#> [1876] "Fusisporium solani"
#> [1877] "Neocosmospora solani"
#> [1878] "Muscicapa melanoleuca"
#> [1879] "Oenanthe hispanica_melanoleuca"
#> [1880] "Oenanthe melanoleuca"
#> [1881] "Cuculus curvirostris"
#> [1882] "Phaenicophaeus curvirostris"
#> [1883] "Caloenas nicobarica"
#> [1884] "Columba nicobarica"
#> [1885] "Gavialis gangeticus"
#> [1886] "Lacerta gangetica"
#> [1887] "Daphnia carinata"
#> [1888] "Aphis gossypii"
#> [1889] "Ampithoe aztecus"
#> [1890] "Hyalella azteca"
#> [1891] "Hyalella knickerbockeri"
#> [1892] "Colletotrichum lupini"
#> [1893] "Gloeosporium lupini"
#> [1894] "Lonchura domestica"
#> [1895] "Lonchura striata"
#> [1896] "Loxia striata"
#> [1897] "Sphaeroforma arctica_JP610"
#> [1898] "Suillus fuscotomentosus"
#> [1899] "Mollisia scopiformis"
#> [1900] "Phialocephala scopiformis"
#> [1901] "Muscicapa cayanensis"
#> [1902] "Myiozetetes cayanensis"
#> [1903] "Hyaloscypha bicolor_E"
#> [1904] "Melopsittacus undulatus"
#> [1905] "Psittacus undulatus"
#> [1906] "Fringilla montana"
#> [1907] "Passer montanus"
#> [1908] "Coccinella axyridis"
#> [1909] "Harmonia axyridis"
#> [1910] "Aimophila crissalis"
#> [1911] "Kieneria crissalis"
#> [1912] "Kieneria crissalis_(Vigors,_1839)"
#> [1913] "Melozone crissalis"
#> [1914] "Pipilo crissalis"
#> [1915] "Pipilo fuscus_crissalis"
#> [1916] "Molothrus aeneus"
#> [1917] "Psarocolius aeneus"
#> [1918] "Conops calcitrans"
#> [1919] "Stomoxis calcitrans"
#> [1920] "Stomoxys calcitrans"
#> [1921] "Anas atrata"
#> [1922] "Cygnus atratus"
#> [1923] "Culex fatigans"
#> [1924] "Culex pipiens_fatigans"
#> [1925] "Culex pipiens_quinquefasciatus"
#> [1926] "Culex quinquefasciatus"
#> [1927] "Drosophila takahashii"
#> [1928] "Hirundo rustica"
#> [1929] "Bombyx mori"
#> [1930] "Phalaena mori"
#> [1931] "Drosophila suzukii"
#> [1932] "Leucophenga suzukii"
#> [1933] "Acanthaster planci"
#> [1934] "Asterias planci"
#> [1935] "Molothrus ater"
#> [1936] "Oriolus ater"
#> [1937] "Laccaria bicolor_S238N-H82"
#> [1938] "Anastrepha obliqua"
#> [1939] "Tephritis obliqua"
#> [1940] "Grapholitha glycinivorella"
#> [1941] "Leguminivora glycinivorella"
#> [1942] "Motacilla atricapilla"
#> [1943] "Sylvia atricapilla"
#> [1944] "Ammodromus caudacutus_nelsoni"
#> [1945] "Ammospiza nelsoni"
#> [1946] "Nylanderia fulva"
#> [1947] "Paratrechina fulva"
#> [1948] "Monocercomonoides exilis"
#> [1949] "Monocercomonoides sp._PA203"
#> [1950] "Agelaius phoeniceus"
#> [1951] "Agelaius phoniceus"
#> [1952] "Oriolus phoeniceus"
#> [1953] "Ammodramus caudacutus"
#> [1954] "Ammospiza caudacuta"
#> [1955] "Oriolus caudacutus"
#> [1956] "Colymbus stellatus"
#> [1957] "Gavia stellata"
#> [1958] "Musca vetustissima"
#> [1959] "Euthrips occidentalis"
#> [1960] "Frankliniella brunnescens"
#> [1961] "Frankliniella californica"
#> [1962] "Frankliniella occidentalis_brunnescens"
#> [1963] "Frankliniella occidentalis"
#> [1964] "Motacilla alba_alba"
#> [1965] "Sitophilus oryzae"
#> [1966] "Corvus cornix_cornix"
#> [1967] "Fringilla canaria"
#> [1968] "Serinus canaria"
#> [1969] "Serinus canarius"
#> [1970] "Drosophila subpulchrella"
#> [1971] "Chlamydomonas reinhardtii"
#> [1972] "Chlamydomonas smithii"
#> [1973] "Puccinia striiformis_f._sp._tritici"
#> [1974] "Colius striatus"
#> [1975] "Heterorhabditis bacteriophora"
```

To enable gene ontology analysis, one must use a SpliceWiz reference with prepared GO annotations for the specified organism. To view the gene ontology annotation for a given SpliceWiz reference:

```
ref_path <- file.path(tempdir(), "Reference")
ontology <- viewGO(ref_path)
head(ontology)
#>           gene_id      go_id evidence
#> 1 ENSG00000121410 GO:0002764      IBA
#> 2 ENSG00000121410 GO:0005576      HDA
#> 3 ENSG00000121410 GO:0005576      IDA
#> 4 ENSG00000121410 GO:0005576      TAS
#> 5 ENSG00000121410 GO:0005615      HDA
#> 6 ENSG00000121410 GO:0005886      IBA
#>                                        go_term ontology gene_name
#> 1 immune response-regulating signaling pathway       BP      <NA>
#> 2                         extracellular region       CC      <NA>
#> 3                         extracellular region       CC      <NA>
#> 4                         extracellular region       CC      <NA>
#> 5                          extracellular space       CC      <NA>
#> 6                              plasma membrane       CC      <NA>
```

Note that `gene_name`s are not available for our example reference because there are only 7 genes in the example reference. Nevertheless, the GO annotation is complete and relies on Ensembl `gene_id`s for matching.

For simple gene over-representation analysis, we use the `goGenes` function. As an example, to analyse for enriched biological functions of the first 1000 genes in the reference:

```
allGenes <- sort(unique(ontology$gene_id))
exampleGeneID <- allGenes[1:1000]
exampleBkgdID <- allGenes

go_byGenes <- goGenes(
    enrichedGenes = exampleGeneID,
    universeGenes = exampleBkgdID,
    ontologyRef = ontology
)
```

To visualize the top gene ontology categories of the above analysis:

```
plotGO(go_byGenes, filter_n_terms = 12)
```

![](data:image/png;base64...)

Of course, we wish to perform GO analysis on the top differential events in our analysis:

```
res_edgeR <- ASE_edgeR(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A"
)
#> Oct 30 20:23:33 Performing edgeR contrast for included / excluded counts separately
#> Oct 30 20:23:35 Performing edgeR contrast for included / excluded counts together

go_byASE <- goASE(
  enrichedEventNames = res_edgeR$EventName[1:10],
  universeEventNames = NULL,
  se = se
)
head(go_byASE)
#>         go_id                                                   go_term
#>        <char>                                                    <char>
#> 1: GO:0000381  regulation of alternative mRNA splicing, via spliceosome
#> 2: GO:0045892        negative regulation of DNA-templated transcription
#> 3: GO:0048026     positive regulation of mRNA splicing, via spliceosome
#> 4: GO:0000122 negative regulation of transcription by RNA polymerase II
#> 5: GO:0000375           RNA splicing, via transesterification reactions
#> 6: GO:0000423                                                 mitophagy
#>         pval      padj foldEnrichment overlap  size overlapGenes expected
#>        <num>     <num>          <num>   <int> <int>       <list>    <num>
#> 1: 0.4761905 0.7989418              1       2     2 ENSG0000....        2
#> 2: 0.4761905 0.7989418              1       2     2 ENSG0000....        2
#> 3: 0.4761905 0.7989418              1       2     2 ENSG0000....        2
#> 4: 0.7142857 0.7989418              1       1     1 ENSG0000....        1
#> 5: 0.7142857 0.7989418              1       1     1 ENSG0000....        1
#> 6: 0.7142857 0.7989418              1       1     1 ENSG0000....        1
```

In most cases, users will wish to use the set of genes represented in the background ASEs as the background genes. This is because some genes do not have alternative splicing events, most often because they are intronless genes!

To perform GO analysis using background genes from analysed ASEs:

```
go_byASE <- goASE(
  enrichedEventNames = res_edgeR$EventName[1:10],
  universeEventNames = res_edgeR$EventName,
  se = se
)
```

### Heatmaps

Heatmaps are useful for visualizing differential expression of individual samples, as well as potential patterns of expression.

First, obtain a matrix of PSI values:

```
# Create a matrix of values of the top 10 differentially expressed events:
mat <- makeMatrix(
    se.filtered,
    event_list = res_edgeR$EventName[1:10],
    method = "PSI"
)
```

How does `makeMatrix()` work?
`makeMatrix()` provides a matrix of PSI values from the given `NxtSE` object. The parameters `event_list` and `sample_list` allows subsetting for ASEs and/or samples, respectively.

The parameter `method` accepts 3 options:

* `"PSI"` : outputs raw PSI values
* `"logit"` : outputs logit PSI values
* `"Z-score"` : outputs Z-score transformed PSI values

Also, `makeMatrix()` facilitates exclusion of low confidence PSI values. These can occur when counts of both isoforms are too low. Setting the `depth_threshold` (default `10`) will set samples with total isoform count below this value to be converted to `NA`.

Splicing events (ASEs) with too many `NA` values are filtered out. Setting the parameter `na.percent.max` (default `0.1`) means any ASE with the proportion of `NA` above this threshold will be removed from the final matrix.

Plot this matrix of values in a heatmap:

```
library(pheatmap)

anno_col_df <- as.data.frame(colData(se.filtered))
anno_col_df <- anno_col_df[, 1, drop=FALSE]

pheatmap(mat, annotation_col = anno_col_df)
```

![](data:image/png;base64...)

Using the GUI
Navigate to `Display`, then `Heatmap` in the menu side bar. After relaxing the event filters as per the prior sections, a heatmap will be automatically generated:

![Heatmap - GUI](data:image/jpeg;base64...)

Heatmap - GUI

The heatmap can be customized as follows:

1. Again, the filtering panel is available to filter the number of events by significance threshold, rank, or by highlighted events, as explained in the previous sections. Highlighted events are particularly useful for heatmaps as users can (if they want) cherry-pick events of interest
2. After above filtering, an additional filter by gene ontology category can be performed. GO analysis must first be performed, and the top enriched categories are listed here
3. Samples can be annotated by one or more annotation categories
4. Samples can be sorted by the chosen annotation category
5. If (4) is selected, whether the sort order should be ascendeng or descending
6. The maximum number of rows of the heatmap to display
7. Whether the heatmap values are raw PSI, logit-transformed PSI, or Z-score transformed values
8. Users can customize their heatmap color palettes from this list
9. A static plot (using the pheatmap R package) will be saved to PDF

## SpliceWiz Coverage Plots

Coverage plots visualize RNA-seq coverage in individual samples. SpliceWiz uses its coverage normalization algorithm to visualize group differences in PSIs.

What are SpliceWiz coverage plots and how are they generated?
SpliceWiz produces RNA-seq coverage plots of analysed samples. Coverage data is compiled simultaneous to the IR and junction quantitation performed by `processBAM()`. This data is saved in “COV” files, which is a BGZF compressed and indexed file. COV files show compression and performance gains over BigWig files.

Additionally, SpliceWiz visualizes plots group-averaged coverages, based on user-defined experimental conditions. This is a powerful tool to illustrate group-specific differential splicing or IR. SpliceWiz does this by normalising the coverage depths of each sample based on transcript depth at the splice junction / intron of interest. By doing so, the coverage depths of constitutively expressed flanking exons are normalised to unity. As a result, the intron depths reflect the fraction of transcripts with retained introns and can be compared across samples.

### Coverage plots of individual samples

First, lets obtain a list of differential events with delta PSI > 5%:

```
res_edgeR <- ASE_edgeR(
    se = se.filtered,
    test_factor = "condition",
    test_nom = "B",
    test_denom = "A"
)
#> Oct 30 20:23:38 Performing edgeR contrast for included / excluded counts separately
#> Oct 30 20:23:39 Performing edgeR contrast for included / excluded counts together

res_edgeR.filtered <- res_edgeR[res_edgeR$abs_deltaPSI > 0.05,]
res_edgeR.filtered$EventName[1]
#> [1] "NSUN5/ENST00000252594_Intron2/clean"
```

We can see here the top differential event belongs to NSUN5. The first step to plotting this event is to create a data object that contains the requisite data for the gene NSUN5:

```
dataObj <- getCoverageData(se, Gene = "NSUN5", tracks = colnames(se))
```

This step retrieves all coverage and junction data for NSUN5 (and surrounding genes).

Next, we need to create event-specific data for the IR event in NSUN5 intron 2.

```
plotObj <- getPlotObject(dataObj, Event = res_edgeR.filtered$EventName[1])
```

This step normalizes the coverage and junction data from the viewpoint of NSUN5 intron 2.

The final step is to generate the plot:

```
plotView(
    plotObj,
    centerByEvent = TRUE, # whether the plot should be centered at the `Event`
    trackList = list(1,2,3,4,5,6),
    plotJunctions = TRUE
)
```

![](data:image/png;base64...)

This plots all 6 individual coverage plots, each in its own track.

Why are the tracks referred to using numbers

In the covPlotObject which is returned by the above function, each “track” is a sample. These can be viewed using the `tracks()` function:

```
tracks(plotObj)
#> [1] "02H003" "02H025" "02H026" "02H033" "02H043" "02H046"
```

For convenience, users have the option of referring to tracks by their actual names, or by numbers. So, in the above example, the two parameters below are equivalent:

* `trackList = list(1,2)`
* `trackList = list(“02H003”, “02H025”)

### Normalized Coverage plots of individual samples

To plot “normalized” coverage plots, where coverage is normalized to transcript depth (i.e. sum of all transcripts = 1), set `normalizeCoverage = TRUE`. We can also include multiple samples in each trace, so lets stack all samples in the same condition in the same trace:

```
plotView(
    plotObj,
    centerByEvent = TRUE,
    trackList = list(c(1,2,3), c(4,5,6)),
    # Each list element contains a vector of track id's

    normalizeCoverage = TRUE
)
```

![](data:image/png;base64...)

NB: junction (sashimi) arcs are not plotted in tracks with more than 1 trace (to avoid cluttering)

### Group Coverage plots

To plot group coverage plots, first we need to generate a new `covPlotObject`. This is because the previous `covPlotObject` was generated on the basis of each track being an individual sample. To generate a plot object where each track represents a condition:

```
plotObj_group <- getPlotObject(
    dataObj,
    Event = res_edgeR.filtered$EventName[1],
    condition = "condition",
    tracks = c("A", "B")
)

# NB:
# when `condition` is not specified, tracks are assumed to be the same samples
# as that of the covDataObject
# when `condition` is specified, tracks must refer to the condition categories
# that are desired for the final plot
```

Note that there are several scenarios where a new covPlotObject is required:

* When plotting normalized coverages using a different normalization ASE,
* When plotting by a different condition or different tracks,
* When plotting on a different strand (default is `*` - unstranded)

To generate the group coverage plot, with the two conditions on the same track:

```
plotView(
    plotObj_group,
    centerByEvent = TRUE,
    trackList = list(c("A", "B"))
)
```

![](data:image/png;base64...)

### Coverage plots using exon windows

Sometimes, we are interested in the differential coverage of exons but not of the intervening introns. Given introns are often much longer than exons, it is useful to plot by the exons of interest.

For example, to plot the skipped casette exon in TRA2B:

```
dataObj <- getCoverageData(se, Gene = "TRA2B", tracks = colnames(se))

plotObj <- getPlotObject(
    dataObj,
    Event = "SE:TRA2B-206-exon2;TRA2B-205-int1",
    condition = "condition", tracks = c("A", "B")
)

plotView(
    plotObj,
    centerByEvent = TRUE,
    trackList = list(c(1,2)),
    filterByEventTranscripts = TRUE
)
```

![](data:image/png;base64...)

NB: setting `filterByEventTranscripts = TRUE` means only transcripts involved in the specified splicing event are plotted in the annotation

Note that the involved exons are in only a small area of the coverage plot. To zoom in on the exons, we first have to plot an “exon view” so the exons are labelled, and at the same time return their coordinates:

```
gr <- plotView(
    plotObj,
    centerByEvent = TRUE,
    trackList = list(c(1,2)),
    filterByEventTranscripts = TRUE,
    showExonRanges = TRUE
)
```

![](data:image/png;base64...)

By setting the parameter `showExonRanges = TRUE`, the `plotView` function shows a plot with exons and their names in the annotation track, and returns a GRanges object, with ranges named by their corresponding exon names:

```
names(gr)
#> [1] "TRA2B-205-E3" "TRA2B-206-E4" "TRA2B-206-E3" "TRA2B-206-E2" "TRA2B-206-E1"
#> [6] "TRA2B-205-E2" "TRA2B-213-E2" "TRA2B-213-E1" "TRA2B-205-E1"
```

We can see in the above figure that he exons of interest are `c("TRA2B-206-E1", "TRA2B-206-E2", "TRA2B-206-E3")`. To plot these in an “exons view” coverage plot:

```
plotView(
    plotObj,
    centerByEvent = TRUE,
    trackList = list(c(1,2)),
    filterByEventTranscripts = TRUE,
    plotRanges = gr[c("TRA2B-206-E1", "TRA2B-206-E2", "TRA2B-206-E3")]
)
```

![](data:image/png;base64...)

### Using the GUI

The main coverage plot interface is as follows

![Coverage Plots Main Panel - GUI](data:image/jpeg;base64...)

Coverage Plots Main Panel - GUI

The top bar contains controls to locate the genomic loci of interest:

1. Genes - locate by the specified gene
2. Events - locate by the specified alternate splicing event. The list of events can be modified by the right-hand controls in the top bar
3. Coordinates - locate by the specified chromosome and start/end coordinate
4. Zoom in or out (each step by a factor of 3)
5. Strand - view coverage by strand-specific (+/-) or non-specific (\*) modes
6. Select events either by all events in differential analysis (which can be filtered using the html-table column filters), user-highlighted events (using volcano/scatter plots), or by gene ontology category. If using gene-ontology category, an extra drop-down box will appear allowing users to specify from the top gene ontology categories from prior GO analysis
7. Limit the number of events displayed in the Event drop-down box (2)

In the plot control panel on the left hand side of the main plot area:

8. Select which alternative splicing event that should be normalized against. This is critical when plotting normalized coverages (14) or plotting by condition (9)
9. Select whether to plot by individual samples, or specify the condition to plot group-plots. See the next section for condition-specific controls.
10. The track list table allows users to specify track ID’s for one or more of the specified controls. The left hand column displays available sample names (if plotting by individual samples), or condition categories (if a condition is specified)
11. Interactive plots can be slow to render because of too many data points. Resolution (the number of data points across the main display) can be controlled using this slider.
12. For group plots, variance of each group can be displayed either as standard deviation (SD), standard error of the mean (SEM), 95% confidence interval (95% CI) or none.
13. Whether junction (sashimi) arcs should be plotted. Note that junction arcs will be disabled if there are multiple traces on the same track
14. When plotting individual samples, whether raw or normalized coverages should be displayed. Junction counts will also be normalized (they are automatically normalized in group coverage plots)
15. Whether to display isoforms belonging to the included / excluded isoform described in the selected normalizing alternative splicing event
16. Whether transcripts should be condensed by gene. This is useful if there are too many transcripts cluttering the display.
17. If selected, brings up a transcript table where users can select 1 or more transcripts to display in the annotation track.
18. If selected, converts the annotation track into an exons display track with named exons. A table will pop up allowing users to select 2 or more exon ranges. Selecting these exons will generate a static exons-only coverage plot.

The main plot (19) is a plotly-based interactive plot. Users can zoom in to a genomic loci of interest using the zoom tool.

There are several options that appear if a specific condition is set:

![Group Coverage Plots - GUI](data:image/jpeg;base64...)

Group Coverage Plots - GUI

1. Note that the track list table now shows condition categories instead of names of samples
2. Difference of normalized coverage between conditions can be objectively measured. Users have the option to use the Student’s T-test to measure difference in normalized coverage between replicates of a pair of conditions
3. Two drop-down boxes allowing users to select a pair of conditions to assess difference in normalized coverage

As mentioned, when the “Exon Plot mode” is selected, an exons table is displayed where users can select one or more exon ranges can be selected, as shown below:

![Generating Exon Coverage (Static) Plots - GUI](data:image/jpeg;base64...)

Generating Exon Coverage (Static) Plots - GUI

Selecting 2 or more exon ranges will trigger (after a 3 second delay) a static exon-window coverage plot to be generated.

Note that at the bottom of the left hand panel, users can save the interactive (top) plot, or the static exon-window coverage (bottom) plot to PDF as ggplot- based figures.

# SessionInfo

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
#> [1] splines   stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] pheatmap_1.0.13             ggplot2_4.0.0
#>  [3] DESeq2_1.50.0               SummarizedExperiment_1.40.0
#>  [5] Biobase_2.70.0              MatrixGenerics_1.22.0
#>  [7] matrixStats_1.5.0           GenomicRanges_1.62.0
#>  [9] Seqinfo_1.0.0               IRanges_2.44.0
#> [11] S4Vectors_0.48.0            DoubleExpSeq_1.1
#> [13] edgeR_4.8.0                 limma_3.66.0
#> [15] fstcore_0.10.0              AnnotationHub_4.0.0
#> [17] BiocFileCache_3.0.0         dbplyr_2.5.1
#> [19] BiocGenerics_0.56.0         generics_0.1.4
#> [21] SpliceWiz_1.12.0            NxtIRFdata_1.16.0
#>
#> loaded via a namespace (and not attached):
#>   [1] later_1.4.4               BiocIO_1.20.0
#>   [3] bitops_1.0-9              filelock_1.0.3
#>   [5] tibble_3.3.0              R.oo_1.27.1
#>   [7] XML_3.99-0.19             lifecycle_1.0.4
#>   [9] httr2_1.2.1               processx_3.8.6
#>  [11] lattice_0.22-7            dendextend_1.19.1
#>  [13] magrittr_2.0.4            plotly_4.11.0
#>  [15] sass_0.4.10               rmarkdown_2.30
#>  [17] jquerylib_0.1.4           yaml_2.3.10
#>  [19] httpuv_1.6.16             otel_0.2.0
#>  [21] cowplot_1.2.0             chromote_0.5.1
#>  [23] DBI_1.2.3                 RColorBrewer_1.1-3
#>  [25] abind_1.4-8               rvest_1.0.5
#>  [27] purrr_1.1.0               R.utils_2.13.0
#>  [29] RCurl_1.98-1.17           rappdirs_0.3.3
#>  [31] seriation_1.5.8           genefilter_1.92.0
#>  [33] annotate_1.88.0           DelayedMatrixStats_1.32.0
#>  [35] codetools_0.2-20          DelayedArray_0.36.0
#>  [37] DT_0.34.0                 xml2_1.4.1
#>  [39] tidyselect_1.2.1          UCSC.utils_1.6.0
#>  [41] farver_2.1.2              rhandsontable_0.3.8
#>  [43] viridis_0.6.5             TSP_1.2-5
#>  [45] shinyWidgets_0.9.0        webshot_0.5.5
#>  [47] GenomicAlignments_1.46.0  jsonlite_2.0.0
#>  [49] fst_0.9.8                 survival_3.8-3
#>  [51] iterators_1.0.14          foreach_1.5.2
#>  [53] tools_4.5.1               progress_1.2.3
#>  [55] Rcpp_1.1.0                glue_1.8.0
#>  [57] gridExtra_2.3             SparseArray_1.10.0
#>  [59] xfun_0.54                 GenomeInfoDb_1.46.0
#>  [61] websocket_1.4.4           dplyr_1.1.4
#>  [63] ca_0.71.1                 HDF5Array_1.38.0
#>  [65] numDeriv_2016.8-1.1       shinydashboard_0.7.3
#>  [67] withr_3.0.2               BiocManager_1.30.26
#>  [69] fastmap_1.2.0             rhdf5filters_1.22.0
#>  [71] digest_0.6.37             R6_2.6.1
#>  [73] mime_0.13                 GO.db_3.22.0
#>  [75] dichromat_2.0-0.1         RSQLite_2.4.3
#>  [77] cigarillo_1.0.0           R.methodsS3_1.8.2
#>  [79] h5mread_1.2.0             tidyr_1.3.1
#>  [81] data.table_1.17.8         rtracklayer_1.70.0
#>  [83] prettyunits_1.2.0         httr_1.4.7
#>  [85] htmlwidgets_1.6.4         S4Arrays_1.10.0
#>  [87] pkgconfig_2.0.3           gtable_0.3.6
#>  [89] blob_1.2.4                registry_0.5-1
#>  [91] S7_0.2.0                  XVector_0.50.0
#>  [93] htmltools_0.5.8.1         fgsea_1.36.0
#>  [95] scales_1.4.0              ompBAM_1.14.0
#>  [97] png_0.1-8                 knitr_1.50
#>  [99] rjson_0.2.23              curl_7.0.0
#> [101] cachem_1.1.0              rhdf5_2.54.0
#> [103] BiocVersion_3.22.0        parallel_4.5.1
#> [105] AnnotationDbi_1.72.0      restfulr_0.0.16
#> [107] pillar_1.11.1             grid_4.5.1
#> [109] vctrs_0.6.5               promises_1.4.0
#> [111] shinyFiles_0.9.3          xtable_1.8-4
#> [113] evaluate_1.0.5            locfit_1.5-9.12
#> [115] cli_3.6.5                 compiler_4.5.1
#> [117] Rsamtools_2.26.0          rlang_1.1.6
#> [119] crayon_1.5.3              heatmaply_1.6.0
#> [121] labeling_0.4.3            ps_1.9.1
#> [123] fs_1.6.6                  stringi_1.8.7
#> [125] viridisLite_0.4.2         BiocParallel_1.44.0
#> [127] assertthat_0.2.1          Biostrings_2.78.0
#> [129] lazyeval_0.2.2            Matrix_1.7-4
#> [131] BSgenome_1.78.0           hms_1.1.4
#> [133] patchwork_1.3.2           sparseMatrixStats_1.22.0
#> [135] bit64_4.6.0-1             Rhdf5lib_1.32.0
#> [137] statmod_1.5.1             KEGGREST_1.50.0
#> [139] shiny_1.11.1              memoise_2.0.1
#> [141] bslib_0.9.0               fastmatch_1.1-6
#> [143] bit_4.6.0
```
Code

* Show All Code
* Hide All Code

# Import and representation of BioPlex PPI data and related resources

Ludwig Geistlinger and Robert Gentleman

#### 6 March 2022

#### Package

BioPlex 1.0.2

# 1 Setup

The [BioPlex project](https://bioplex.hms.harvard.edu/) uses
affinity-purification mass spectrometry to profile protein-protein interactions (PPIs)
in human cell lines.

To date, the BioPlex project has created two proteome-scale, cell-line-specific
PPI networks. The first, BioPlex 3.0, results from affinity purification of
10,128 human proteins —- half the proteome —- in 293T cells and includes 118,162
interactions among 14,586 proteins.
The second results from 5,522 immunoprecipitations in HCT116 cells and includes
70,966 interactions between 10,531 proteins.

For more information, please see:

* Huttlin et al. [The BioPlex network: a systematic exploration of the human interactome](https://doi.org/10.1016/j.cell.2015.06.043). *Cell*, 2015.
* Huttlin et al. [Architecture of the human interactome defines protein communities and disease networks](https://doi.org/10.1038/nature22366), *Nature*, 2017.
* Huttlin et al. [Dual proteome-scale networks reveal cell-specific remodeling of the human interactome](https://doi.org/10.1016/j.cell.2021.04.011), *Cell*, 2021.

The [BioPlex R package](https://github.com/ccb-hms/BioPlex)
implements access to the BioPlex protein-protein interaction networks and
related resources from within R.
Besides protein-protein interaction networks for 293T and HCT116 cells,
this includes access to [CORUM](http://mips.helmholtz-muenchen.de/corum)
protein complex data, and transcriptome and proteome data for the two cell lines.

Functionality focuses on importing these data resources and
storing them in dedicated Bioconductor data structures, as a foundation for
integrative downstream analysis of the data. For a set of downstream analyses
and applications, please see the
[BioPlexAnalysis package](https://github.com/ccb-hms/BioPlexAnalysis)
and
[analysis vignettes](https://ccb-hms.github.io/BioPlexAnalysis/).

# 2 Installation

To install the package, start R and enter:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("BioPlex")
```

After the installation, we proceed by loading the package and additional packages
used in the vignette.

```
library(BioPlex)
library(AnnotationHub)
library(ExperimentHub)
library(graph)
```

# 3 Data resources

## 3.1 General

Connect to
[AnnotationHub](http://bioconductor.org/packages/AnnotationHub):

```
ah <- AnnotationHub::AnnotationHub()
```

Connect to
[ExperimentHub](http://bioconductor.org/packages/ExperimentHub):

```
eh <- ExperimentHub::ExperimentHub()
```

OrgDb package for human:

```
orgdb <- AnnotationHub::query(ah, c("orgDb", "Homo sapiens"))
orgdb <- orgdb[[1]]
orgdb
#> OrgDb object:
#> | DBSCHEMAVERSION: 2.1
#> | Db type: OrgDb
#> | Supporting package: AnnotationDbi
#> | DBSCHEMA: HUMAN_DB
#> | ORGANISM: Homo sapiens
#> | SPECIES: Human
#> | EGSOURCEDATE: 2021-Sep13
#> | EGSOURCENAME: Entrez Gene
#> | EGSOURCEURL: ftp://ftp.ncbi.nlm.nih.gov/gene/DATA
#> | CENTRALID: EG
#> | TAXID: 9606
#> | GOSOURCENAME: Gene Ontology
#> | GOSOURCEURL: http://current.geneontology.org/ontology/go-basic.obo
#> | GOSOURCEDATE: 2021-09-01
#> | GOEGSOURCEDATE: 2021-Sep13
#> | GOEGSOURCENAME: Entrez Gene
#> | GOEGSOURCEURL: ftp://ftp.ncbi.nlm.nih.gov/gene/DATA
#> | KEGGSOURCENAME: KEGG GENOME
#> | KEGGSOURCEURL: ftp://ftp.genome.jp/pub/kegg/genomes
#> | KEGGSOURCEDATE: 2011-Mar15
#> | GPSOURCENAME: UCSC Genome Bioinformatics (Homo sapiens)
#> | GPSOURCEURL:
#> | GPSOURCEDATE: 2021-Jul20
#> | ENSOURCEDATE: 2021-Apr13
#> | ENSOURCENAME: Ensembl
#> | ENSOURCEURL: ftp://ftp.ensembl.org/pub/current_fasta
#> | UPSOURCENAME: Uniprot
#> | UPSOURCEURL: http://www.UniProt.org/
#> | UPSOURCEDATE: Wed Sep 15 18:21:59 2021
keytypes(orgdb)
#>  [1] "ACCNUM"       "ALIAS"        "ENSEMBL"      "ENSEMBLPROT"  "ENSEMBLTRANS"
#>  [6] "ENTREZID"     "ENZYME"       "EVIDENCE"     "EVIDENCEALL"  "GENENAME"
#> [11] "GENETYPE"     "GO"           "GOALL"        "IPI"          "MAP"
#> [16] "OMIM"         "ONTOLOGY"     "ONTOLOGYALL"  "PATH"         "PFAM"
#> [21] "PMID"         "PROSITE"      "REFSEQ"       "SYMBOL"       "UCSCKG"
#> [26] "UNIPROT"
```

## 3.2 BioPlex PPIs

[Available networks](https://bioplex.hms.harvard.edu/interactions.php) include:

* BioPlex PPI network for human embryonic kidney [293T](https://en.wikipedia.org/wiki/293T) cells (versions 1.0, 2.0, and 3.0)
* BioPlex PPI network for human colon cancer [HCT116](https://en.wikipedia.org/wiki/HCT116_cells) cells (version 1.0)

Let’s get the latest version of the 293T PPI network:

```
bp.293t <- getBioPlex(cell.line = "293T", version = "3.0")
#> Using cached version from 2022-03-06 08:58:14
head(bp.293t)
#>    GeneA  GeneB UniprotA UniprotB SymbolA SymbolB           pW          pNI
#> 1    100    100   P00813   A5A3E0     ADA   POTEF 6.881844e-10 0.0001176357
#> 2 222389 222389 Q8N7W2-2   P26373   BEND7   RPL13 1.340380e-18 0.2256644741
#> 3 222389 222389 Q8N7W2-2 Q09028-3   BEND7   RBBP4 7.221401e-21 0.0000641669
#> 4 222389 222389 Q8N7W2-2   Q9Y3U8   BEND7   RPL36 7.058372e-17 0.1281827343
#> 5 222389 222389 Q8N7W2-2   P36578   BEND7    RPL4 1.632313e-22 0.2006379109
#> 6 222389 222389 Q8N7W2-2   P23396   BEND7    RPS3 3.986270e-26 0.0010264311
#>        pInt
#> 1 0.9998824
#> 2 0.7743355
#> 3 0.9999358
#> 4 0.8718173
#> 5 0.7993621
#> 6 0.9989736
nrow(bp.293t)
#> [1] 118162
```

Each row corresponds to a PPI between a bait protein A and a prey protein B, for which
NCBI Entrez Gene IDs, Uniprot IDs, and gene symbols are annotated.
The last three columns reflect the likelihood that each interaction resulted
from either an incorrect protein identification (`pW`), background (`pNI`), or
a bona fide interacting partner (`pInt`) as determined using the
[CompPASS algorithm](https://github.com/dnusinow/cRomppass).

Analgously, we can obtain the latest version of the HCT116 PPI network:

```
bp.hct116 <- getBioPlex(cell.line = "HCT116", version = "1.0")
head(bp.hct116)
#>   GeneA GeneB UniprotA UniprotB  SymbolA SymbolB           pW          pNI
#> 1 88455 88455   Q8IZ07 Q9NR80-4 ANKRD13A ARHGEF4 3.959215e-04 3.298003e-05
#> 2 88455 88455   Q8IZ07   Q96CS2 ANKRD13A   HAUS1 4.488473e-02 1.934731e-03
#> 3 88455 88455   Q8IZ07 Q8NEV8-2 ANKRD13A   EXPH5 7.402394e-05 9.296226e-04
#> 4 88455 88455   Q8IZ07   Q9H6D7 ANKRD13A   HAUS4 9.180959e-07 1.278318e-04
#> 5 88455 88455   Q8IZ07   Q68CZ6 ANKRD13A   HAUS3 8.709394e-07 1.495480e-03
#> 6 88455 88455   Q8IZ07 Q9BT25-2 ANKRD13A   HAUS8 9.147659e-06 2.061483e-03
#>        pInt
#> 1 0.9995711
#> 2 0.9531805
#> 3 0.9989964
#> 4 0.9998713
#> 5 0.9985036
#> 6 0.9979294
nrow(bp.hct116)
#> [1] 70966
```

### 3.2.1 ID mapping

The protein-to-gene mappings from BioPlex (i.e. UNIPROT-to-SYMBOL and UNIPROT-to-ENTREZID) are based on the mappings available from Uniprot at the time of publication of the BioPlex 3.0 networks.

We can update those based on Bioc annotation functionality:

```
bp.293t.remapped <- getBioPlex(cell.line = "293T",
                               version = "3.0",
                               remap.uniprot.ids = TRUE)
#> Using cached version from 2022-03-06 08:58:14
```

### 3.2.2 Data structures for BioPlex PPIs

We can also represent a given version of the BioPlex PPI network for a given
cell line as one big graph where bait and prey relationship are represented
by directed edges from bait to prey.

```
bp.gr <- bioplex2graph(bp.293t)
bp.gr
#> A graphNEL graph with directed edges
#> Number of Nodes = 13689
#> Number of Edges = 115868
head(graph::nodeData(bp.gr))
#> $P00813
#> $P00813$ENTREZID
#> [1] "100"
#>
#> $P00813$SYMBOL
#> [1] "ADA"
#>
#> $P00813$ISOFORM
#> [1] "P00813"
#>
#>
#> $Q8N7W2
#> $Q8N7W2$ENTREZID
#> [1] "222389"
#>
#> $Q8N7W2$SYMBOL
#> [1] "BEND7"
#>
#> $Q8N7W2$ISOFORM
#> [1] "Q8N7W2-2"
#>
#>
#> $Q6ZMN8
#> $Q6ZMN8$ENTREZID
#> [1] "645121"
#>
#> $Q6ZMN8$SYMBOL
#> [1] "CCNI2"
#>
#> $Q6ZMN8$ISOFORM
#> [1] "Q6ZMN8"
#>
#>
#> $P20138
#> $P20138$ENTREZID
#> [1] "945"
#>
#> $P20138$SYMBOL
#> [1] "CD33"
#>
#> $P20138$ISOFORM
#> [1] "P20138"
#>
#>
#> $P55039
#> $P55039$ENTREZID
#> [1] "1819"
#>
#> $P55039$SYMBOL
#> [1] "DRG2"
#>
#> $P55039$ISOFORM
#> [1] "P55039"
#>
#>
#> $Q17R55
#> $Q17R55$ENTREZID
#> [1] "148109"
#>
#> $Q17R55$SYMBOL
#> [1] "FAM187B"
#>
#> $Q17R55$ISOFORM
#> [1] "Q17R55"
head(graph::edgeData(bp.gr))
#> $`P00813|A5A3E0`
#> $`P00813|A5A3E0`$weight
#> [1] 1
#>
#> $`P00813|A5A3E0`$pW
#> [1] 6.881844e-10
#>
#> $`P00813|A5A3E0`$pNI
#> [1] 0.0001176357
#>
#> $`P00813|A5A3E0`$pInt
#> [1] 0.9998824
#>
#>
#> $`Q8N7W2|P26373`
#> $`Q8N7W2|P26373`$weight
#> [1] 1
#>
#> $`Q8N7W2|P26373`$pW
#> [1] 1.34038e-18
#>
#> $`Q8N7W2|P26373`$pNI
#> [1] 0.2256645
#>
#> $`Q8N7W2|P26373`$pInt
#> [1] 0.7743355
#>
#>
#> $`Q8N7W2|Q09028`
#> $`Q8N7W2|Q09028`$weight
#> [1] 1
#>
#> $`Q8N7W2|Q09028`$pW
#> [1] 7.221401e-21
#>
#> $`Q8N7W2|Q09028`$pNI
#> [1] 6.41669e-05
#>
#> $`Q8N7W2|Q09028`$pInt
#> [1] 0.9999358
#>
#>
#> $`Q8N7W2|Q9Y3U8`
#> $`Q8N7W2|Q9Y3U8`$weight
#> [1] 1
#>
#> $`Q8N7W2|Q9Y3U8`$pW
#> [1] 7.058372e-17
#>
#> $`Q8N7W2|Q9Y3U8`$pNI
#> [1] 0.1281827
#>
#> $`Q8N7W2|Q9Y3U8`$pInt
#> [1] 0.8718173
#>
#>
#> $`Q8N7W2|P36578`
#> $`Q8N7W2|P36578`$weight
#> [1] 1
#>
#> $`Q8N7W2|P36578`$pW
#> [1] 1.632313e-22
#>
#> $`Q8N7W2|P36578`$pNI
#> [1] 0.2006379
#>
#> $`Q8N7W2|P36578`$pInt
#> [1] 0.7993621
#>
#>
#> $`Q8N7W2|P23396`
#> $`Q8N7W2|P23396`$weight
#> [1] 1
#>
#> $`Q8N7W2|P23396`$pW
#> [1] 3.98627e-26
#>
#> $`Q8N7W2|P23396`$pNI
#> [1] 0.001026431
#>
#> $`Q8N7W2|P23396`$pInt
#> [1] 0.9989736
```

When starting off with ordinary dfs we’ll be losing the ability
to annotate graph-level annotation such as cell line, version, PMID, …
We might need to work with `DataFrame`s where we have `mcols` and `metadata`.

### 3.2.3 PFAM domains

We can easily add [PFAM](http://pfam.xfam.org) domain annotations to the node metadata:

```
bp.gr <- annotatePFAM(bp.gr, orgdb)
head(graph::nodeData(bp.gr, graph::nodes(bp.gr), "PFAM"))
#> $P00813
#> [1] "PF00962"
#>
#> $Q8N7W2
#> [1] "PF10523"
#>
#> $Q6ZMN8
#> [1] "PF00134"
#>
#> $P20138
#> [1] "PF07686" "PF00047"
#>
#> $P55039
#> [1] "PF16897" "PF01926" "PF02824"
#>
#> $Q17R55
#> [1] NA
```

## 3.3 CORUM complexes

Obtain the complete set of human protein complexes from
[CORUM](http://mips.helmholtz-muenchen.de/corum/#download):

```
all <- getCorum(set = "all", organism = "Human")
dim(all)
#> [1] 2916   20
colnames(all)
#>  [1] "ComplexID"                           "ComplexName"
#>  [3] "Organism"                            "Synonyms"
#>  [5] "Cell.line"                           "subunits.UniProt.IDs."
#>  [7] "subunits.Entrez.IDs."                "Protein.complex.purification.method"
#>  [9] "GO.ID"                               "GO.description"
#> [11] "FunCat.ID"                           "FunCat.description"
#> [13] "subunits.Gene.name."                 "Subunits.comment"
#> [15] "PubMed.ID"                           "Complex.comment"
#> [17] "Disease.comment"                     "SWISSPROT.organism"
#> [19] "subunits.Gene.name.syn."             "subunits.Protein.name."
all[1:5, 1:5]
#>   ComplexID                           ComplexName Organism
#> 1         1                    BCL6-HDAC4 complex    Human
#> 2         2                    BCL6-HDAC5 complex    Human
#> 3         3                    BCL6-HDAC7 complex    Human
#> 4         4 Multisubunit ACTR coactivator complex    Human
#> 6        10                   Condensin I complex    Human
#>                Synonyms Cell.line
#> 1                  None      None
#> 2                  None      None
#> 3                  None      None
#> 4                  None      None
#> 6 13S condensin complex      None
```

Core set of complexes:

```
core <- getCorum(set = "core", organism = "Human")
#> Using cached version from 2022-03-06 08:58:06
dim(core)
#> [1] 2417   20
```

Complexes with splice variants:

```
splice <- getCorum(set = "splice", organism = "Human")
dim(splice)
#> [1] 44 20
```

### 3.3.1 ID mapping

The protein-to-gene mappings from CORUM (i.e. UNIPROT-to-SYMBOL and UNIPROT-to-ENTREZID) might not be fully up-to-date.

We can update those based on Bioc annotation functionality:

```
core.remapped <- getCorum(set = "core",
                          organism = "Human",
                          remap.uniprot.ids = TRUE)
#> Using cached version from 2022-03-06 08:58:06
```

### 3.3.2 Data structures for CORUM complexes

We can represent the CORUM complexes as a list of character vectors.
The names of the list are the complex IDs/names, and each element of the list is
a vector of UniProt IDs for each complex.

```
core.list <- corum2list(core, subunit.id.type = "UNIPROT")
head(core.list)
#> $`CORUM1_BCL6-HDAC4_complex`
#> [1] "P41182" "P56524"
#>
#> $`CORUM2_BCL6-HDAC5_complex`
#> [1] "P41182" "Q9UQL6"
#>
#> $`CORUM3_BCL6-HDAC7_complex`
#> [1] "P41182" "Q8WUI4"
#>
#> $CORUM4_Multisubunit_ACTR_coactivator_complex
#> [1] "Q09472" "Q92793" "Q92831" "Q9Y6Q9"
#>
#> $`CORUM11_BLOC-3_(biogenesis_of_lysosome-related_organelles_complex_3)`
#> [1] "Q92902" "Q9NQG7"
#>
#> $`CORUM12_BLOC-2_(biogenesis_of_lysosome-related_organelles_complex_2)`
#> [1] "Q86YV9" "Q969F9" "Q9UPZ3"
length(core.list)
#> [1] 2417
```

If we’d like to add metadata in a more structured form to each complex,
a suitable option is a
[GeneSetCollection](https://bioconductor.org/packages/GSEABase).

We can also represent the CORUM complexes as a list of graph instances,
where all nodes of a complex are connected to all other nodes of that complex
with undirected edges.

```
core.glist <- corum2graphlist(core, subunit.id.type = "UNIPROT")
head(core.glist)
#> $`CORUM1_BCL6-HDAC4_complex`
#> A graphNEL graph with undirected edges
#> Number of Nodes = 2
#> Number of Edges = 1
#>
#> $`CORUM2_BCL6-HDAC5_complex`
#> A graphNEL graph with undirected edges
#> Number of Nodes = 2
#> Number of Edges = 1
#>
#> $`CORUM3_BCL6-HDAC7_complex`
#> A graphNEL graph with undirected edges
#> Number of Nodes = 2
#> Number of Edges = 1
#>
#> $CORUM4_Multisubunit_ACTR_coactivator_complex
#> A graphNEL graph with undirected edges
#> Number of Nodes = 4
#> Number of Edges = 6
#>
#> $`CORUM11_BLOC-3_(biogenesis_of_lysosome-related_organelles_complex_3)`
#> A graphNEL graph with undirected edges
#> Number of Nodes = 2
#> Number of Edges = 1
#>
#> $`CORUM12_BLOC-2_(biogenesis_of_lysosome-related_organelles_complex_2)`
#> A graphNEL graph with undirected edges
#> Number of Nodes = 3
#> Number of Edges = 3
length(core.glist)
#> [1] 2417
core.glist[[1]]@graphData
#> $edgemode
#> [1] "undirected"
#>
#> $ComplexID
#> [1] 1
#>
#> $ComplexName
#> [1] "BCL6-HDAC4 complex"
#>
#> $GO.ID
#> [1] "GO:0006265" "GO:0045892" "GO:0051276" "GO:0030183" "GO:0005634"
#> [6] "GO:0016575"
#>
#> $PubMed.ID
#> [1] 11929873
graph::nodeData(core.glist[[1]])
#> $P41182
#> $P41182$ENTREZID
#> [1] "604"
#>
#> $P41182$SYMBOL
#> [1] "BCL6"
#>
#>
#> $P56524
#> $P56524$ENTREZID
#> [1] "9759"
#>
#> $P56524$SYMBOL
#> [1] "HDAC4"
```

Note that we can easily convert a
[graph](https://bioconductor.org/packages/graph) object into an
[igraph](https://cran.r-project.org/package%3Digraph) object using
`igraph::graph_from_graphnel`.

## 3.4 Transcriptome data

### 3.4.1 HEK293 cells

#### 3.4.1.1 GSE122425

Obtain transcriptome data for 293T cells from GEO dataset:
[GSE122425](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE122425).

```
se <- getGSE122425()
#> Using cached version from 2022-03-06 08:58:27
se
#> class: SummarizedExperiment
#> dim: 57905 6
#> metadata(0):
#> assays(2): raw rpkm
#> rownames(57905): ENSG00000223972 ENSG00000227232 ... ENSG00000231514
#>   ENSG00000235857
#> rowData names(4): SYMBOL KO GO length
#> colnames(6): GSM3466389 GSM3466390 ... GSM3466393 GSM3466394
#> colData names(41): title geo_accession ... passages.ch1 strain.ch1
head(assay(se, "raw"))
#>                 GSM3466389 GSM3466390 GSM3466391 GSM3466392 GSM3466393
#> ENSG00000223972          1          2          2          0          0
#> ENSG00000227232        732        690        804        705        812
#> ENSG00000243485          0          0          2          0          0
#> ENSG00000237613          0          0          0          0          0
#> ENSG00000268020          0          0          0          0          0
#> ENSG00000240361          0          0          0          0          0
#>                 GSM3466394
#> ENSG00000223972          2
#> ENSG00000227232       1121
#> ENSG00000243485          0
#> ENSG00000237613          0
#> ENSG00000268020          0
#> ENSG00000240361          1
head(assay(se, "rpkm"))
#>                 GSM3466389 GSM3466390 GSM3466391 GSM3466392 GSM3466393
#> ENSG00000223972       0.01       0.01       0.01       0.00       0.00
#> ENSG00000227232       5.43       5.07       5.39       4.77       5.21
#> ENSG00000243485       0.00       0.00       0.04       0.00       0.00
#> ENSG00000237613       0.00       0.00       0.00       0.00       0.00
#> ENSG00000268020       0.00       0.00       0.00       0.00       0.00
#> ENSG00000240361       0.00       0.00       0.00       0.00       0.00
#>                 GSM3466394
#> ENSG00000223972       0.01
#> ENSG00000227232       6.80
#> ENSG00000243485       0.00
#> ENSG00000237613       0.00
#> ENSG00000268020       0.00
#> ENSG00000240361       0.02
colData(se)
#> DataFrame with 6 rows and 41 columns
#>                    title geo_accession                status submission_date
#>              <character>   <character>           <character>     <character>
#> GSM3466389       WT rep1    GSM3466389 Public on Nov 16 2018     Nov 12 2018
#> GSM3466390       WT rep2    GSM3466390 Public on Nov 16 2018     Nov 12 2018
#> GSM3466391       WT rep3    GSM3466391 Public on Nov 16 2018     Nov 12 2018
#> GSM3466392 NSUN2-KO rep1    GSM3466392 Public on Nov 16 2018     Nov 12 2018
#> GSM3466393 NSUN2-KO rep2    GSM3466393 Public on Nov 16 2018     Nov 12 2018
#> GSM3466394 NSUN2-KO rep3    GSM3466394 Public on Nov 16 2018     Nov 12 2018
#>            last_update_date        type channel_count source_name_ch1
#>                 <character> <character>   <character>     <character>
#> GSM3466389      Nov 16 2018         SRA             1          kidney
#> GSM3466390      Nov 16 2018         SRA             1          kidney
#> GSM3466391      Nov 16 2018         SRA             1          kidney
#> GSM3466392      Nov 16 2018         SRA             1          kidney
#> GSM3466393      Nov 16 2018         SRA             1          kidney
#> GSM3466394      Nov 16 2018         SRA             1          kidney
#>            organism_ch1 characteristics_ch1 characteristics_ch1.1
#>             <character>         <character>           <character>
#> GSM3466389 Homo sapiens      strain: HEK293        passages: 8-12
#> GSM3466390 Homo sapiens      strain: HEK293        passages: 8-12
#> GSM3466391 Homo sapiens      strain: HEK293        passages: 8-12
#> GSM3466392 Homo sapiens      strain: HEK293        passages: 8-12
#> GSM3466393 Homo sapiens      strain: HEK293        passages: 8-12
#> GSM3466394 Homo sapiens      strain: HEK293        passages: 8-12
#>            treatment_protocol_ch1    growth_protocol_ch1 molecule_ch1
#>                       <character>            <character>  <character>
#> GSM3466389 The NSUN2-deficient .. Cells were grown in ..    polyA RNA
#> GSM3466390 The NSUN2-deficient .. Cells were grown in ..    polyA RNA
#> GSM3466391 The NSUN2-deficient .. Cells were grown in ..    polyA RNA
#> GSM3466392 The NSUN2-deficient .. Cells were grown in ..    polyA RNA
#> GSM3466393 The NSUN2-deficient .. Cells were grown in ..    polyA RNA
#> GSM3466394 The NSUN2-deficient .. Cells were grown in ..    polyA RNA
#>              extract_protocol_ch1 extract_protocol_ch1.1   taxid_ch1
#>                       <character>            <character> <character>
#> GSM3466389 Total RNA of cells w.. Next generation sequ..        9606
#> GSM3466390 Total RNA of cells w.. Next generation sequ..        9606
#> GSM3466391 Total RNA of cells w.. Next generation sequ..        9606
#> GSM3466392 Total RNA of cells w.. Next generation sequ..        9606
#> GSM3466393 Total RNA of cells w.. Next generation sequ..        9606
#> GSM3466394 Total RNA of cells w.. Next generation sequ..        9606
#>                   data_processing      data_processing.1      data_processing.2
#>                       <character>            <character>            <character>
#> GSM3466389 Bcl2fastq (v2.17.1.1.. 3’ adaptor-trimming .. The high quality tri..
#> GSM3466390 Bcl2fastq (v2.17.1.1.. 3’ adaptor-trimming .. The high quality tri..
#> GSM3466391 Bcl2fastq (v2.17.1.1.. 3’ adaptor-trimming .. The high quality tri..
#> GSM3466392 Bcl2fastq (v2.17.1.1.. 3’ adaptor-trimming .. The high quality tri..
#> GSM3466393 Bcl2fastq (v2.17.1.1.. 3’ adaptor-trimming .. The high quality tri..
#> GSM3466394 Bcl2fastq (v2.17.1.1.. 3’ adaptor-trimming .. The high quality tri..
#>                 data_processing.3      data_processing.4  data_processing.5
#>                       <character>            <character>        <character>
#> GSM3466389 Reads Per Kilobase o.. Differential express.. Genome_build: HG19
#> GSM3466390 Reads Per Kilobase o.. Differential express.. Genome_build: HG19
#> GSM3466391 Reads Per Kilobase o.. Differential express.. Genome_build: HG19
#> GSM3466392 Reads Per Kilobase o.. Differential express.. Genome_build: HG19
#> GSM3466393 Reads Per Kilobase o.. Differential express.. Genome_build: HG19
#> GSM3466394 Reads Per Kilobase o.. Differential express.. Genome_build: HG19
#>                 data_processing.6 platform_id contact_name   contact_institute
#>                       <character> <character>  <character>         <character>
#> GSM3466389 Supplementary_files_..    GPL11154    Zhen,,Sun Yangzhou University
#> GSM3466390 Supplementary_files_..    GPL11154    Zhen,,Sun Yangzhou University
#> GSM3466391 Supplementary_files_..    GPL11154    Zhen,,Sun Yangzhou University
#> GSM3466392 Supplementary_files_..    GPL11154    Zhen,,Sun Yangzhou University
#> GSM3466393 Supplementary_files_..    GPL11154    Zhen,,Sun Yangzhou University
#> GSM3466394 Supplementary_files_..    GPL11154    Zhen,,Sun Yangzhou University
#>            contact_address contact_city contact_zip.postal_code contact_country
#>                <character>  <character>             <character>     <character>
#> GSM3466389          Wenhui     Yangzhou                  225009           China
#> GSM3466390          Wenhui     Yangzhou                  225009           China
#> GSM3466391          Wenhui     Yangzhou                  225009           China
#> GSM3466392          Wenhui     Yangzhou                  225009           China
#> GSM3466393          Wenhui     Yangzhou                  225009           China
#> GSM3466394          Wenhui     Yangzhou                  225009           China
#>            data_row_count    instrument_model library_selection library_source
#>               <character>         <character>       <character>    <character>
#> GSM3466389              0 Illumina HiSeq 2000              cDNA transcriptomic
#> GSM3466390              0 Illumina HiSeq 2000              cDNA transcriptomic
#> GSM3466391              0 Illumina HiSeq 2000              cDNA transcriptomic
#> GSM3466392              0 Illumina HiSeq 2000              cDNA transcriptomic
#> GSM3466393              0 Illumina HiSeq 2000              cDNA transcriptomic
#> GSM3466394              0 Illumina HiSeq 2000              cDNA transcriptomic
#>            library_strategy               relation             relation.1
#>                 <character>            <character>            <character>
#> GSM3466389          RNA-Seq BioSample: https://w.. SRA: https://www.ncb..
#> GSM3466390          RNA-Seq BioSample: https://w.. SRA: https://www.ncb..
#> GSM3466391          RNA-Seq BioSample: https://w.. SRA: https://www.ncb..
#> GSM3466392          RNA-Seq BioSample: https://w.. SRA: https://www.ncb..
#> GSM3466393          RNA-Seq BioSample: https://w.. SRA: https://www.ncb..
#> GSM3466394          RNA-Seq BioSample: https://w.. SRA: https://www.ncb..
#>            supplementary_file_1 passages.ch1  strain.ch1
#>                     <character>  <character> <character>
#> GSM3466389                 NONE         8-12      HEK293
#> GSM3466390                 NONE         8-12      HEK293
#> GSM3466391                 NONE         8-12      HEK293
#> GSM3466392                 NONE         8-12      HEK293
#> GSM3466393                 NONE         8-12      HEK293
#> GSM3466394                 NONE         8-12      HEK293
rowData(se)
#> DataFrame with 57905 rows and 4 columns
#>                      SYMBOL          KO          GO    length
#>                 <character> <character> <character> <integer>
#> ENSG00000223972     DDX11L1      K11273           _      2544
#> ENSG00000227232      WASH7P      K18461           _     15444
#> ENSG00000243485  MIR1302-10           _           _      1556
#> ENSG00000237613     FAM138A           _           _      1528
#> ENSG00000268020      OR4G4P      K04257           _      2464
#> ...                     ...         ...         ...       ...
#> ENSG00000224240     CYCSP49      K08738           _       319
#> ENSG00000227629  SLC25A15P1      K15101           _      4960
#> ENSG00000237917     PARP4P1      K10798           _     39802
#> ENSG00000231514     FAM58CP           _           _       640
#> ENSG00000235857     CTBP2P1      K04496           _       245
```

The dataset includes three wild type samples and three NSUN2 knockout samples.

### 3.4.2 HCT116 cells

#### 3.4.2.1 Cancer Cell Line Encyclopedia (CCLE)

RNA-seq data for 934 cancer cell lines (incl. HCT116) from the
[Cancer Cell Line Encyclopedia](https://portals.broadinstitute.org/ccle)
is available from the [ArrayExpress-ExpressionAtlas](https://www.ebi.ac.uk/gxa)
(Accession: [E-MTAB-2770](https://www.ebi.ac.uk/gxa/experiments/E-MTAB-2770)).

The data can be obtained as a `SummarizedExperiment` using the
[ExpressionAtlas](https://bioconductor.org/packages/ExpressionAtlas) package.

```
ccle.trans <- ExpressionAtlas::getAtlasExperiment("E-MTAB-2770")
```

See also the [Transcriptome-Proteome analysis vignette](https://ccb-hms.github.io/BioPlexAnalysis/articles/TranscriptomeProteome.html)
for further exploration of the correlation between CCLE HCT116 transcript and
protein expression.

#### 3.4.2.2 Klijn et al., 2015

RNA-seq data of 675 commonly used human cancer cell lines (incl. HCT116) from
[Klijn et al., 2015](https://pubmed.ncbi.nlm.nih.gov/25485619)
is available from the [ArrayExpress-ExpressionAtlas](https://www.ebi.ac.uk/gxa)
(Accession: [E-MTAB-2706](https://www.ebi.ac.uk/gxa/experiments/E-MTAB-2706))

The data can be obtained as a `SummarizedExperiment` using the
[ExpressionAtlas](https://bioconductor.org/packages/ExpressionAtlas) package.

```
klijn <- ExpressionAtlas::getAtlasExperiment("E-MTAB-2706")
```

See also the [Transcriptome-Proteome analysis vignette](https://ccb-hms.github.io/BioPlexAnalysis/articles/TranscriptomeProteome.html)
for further exploration of differential transcript and
protein expression between 293T and HCT116 cells.

## 3.5 Proteome data

### 3.5.1 CCLE

Pull the [CCLE proteome data](https://doi.org/10.1016/j.cell.2019.12.023) from ExperimentHub. The dataset profiles 12,755 proteins by mass spectrometry across 375 cancer cell lines.

```
AnnotationHub::query(eh, c("gygi", "depmap"))
#> ExperimentHub with 1 record
#> # snapshotDate(): 2021-10-19
#> # names(): EH3459
#> # package(): depmap
#> # $dataprovider: Broad Institute
#> # $species: Homo sapiens
#> # $rdataclass: tibble
#> # $rdatadateadded: 2020-05-19
#> # $title: proteomic_20Q2
#> # $description: Quantitative profiling of 12399 proteins in 375 cell lines, ...
#> # $taxonomyid: 9606
#> # $genome:
#> # $sourcetype: CSV
#> # $sourceurl: https://gygi.med.harvard.edu/sites/gygi.med.harvard.edu/files/...
#> # $sourcesize: NA
#> # $tags: c("ExperimentHub", "ExperimentData", "ReproducibleResearch",
#> #   "RepositoryData", "AssayDomainData", "CopyNumberVariationData",
#> #   "DiseaseModel", "CancerData", "BreastCancerData", "ColonCancerData",
#> #   "KidneyCancerData", "LeukemiaCancerData", "LungCancerData",
#> #   "OvarianCancerData", "ProstateCancerData", "OrganismData",
#> #   "Homo_sapiens_Data", "PackageTypeData", "SpecimenSource",
#> #   "CellCulture", "Genome", "Proteome", "StemCell", "Tissue")
#> # retrieve record with 'object[["EH3459"]]'
ccle.prot <- eh[["EH3459"]]
#> snapshotDate(): 2021-10-19
#> see ?depmap and browseVignettes('depmap') for documentation
#> loading from cache
ccle.prot <- as.data.frame(ccle.prot)
```

Explore the data:

```
dim(ccle.prot)
#> [1] 4821390      12
colnames(ccle.prot)
#>  [1] "depmap_id"          "gene_name"          "entrez_id"
#>  [4] "protein"            "protein_expression" "protein_id"
#>  [7] "desc"               "group_id"           "uniprot"
#> [10] "uniprot_acc"        "TenPx"              "cell_line"
head(ccle.prot)
#>    depmap_id gene_name entrez_id                 protein protein_expression
#> 1 ACH-000849   SLC12A2      6558 MDAMB468_BREAST_TenPx01         2.11134846
#> 2 ACH-000441   SLC12A2      6558        SH4_SKIN_TenPx01         0.07046807
#> 3 ACH-000248   SLC12A2      6558    AU565_BREAST_TenPx01        -0.46392793
#> 4 ACH-000684   SLC12A2      6558    KMRC1_KIDNEY_TenPx01        -0.88364548
#> 5 ACH-000856   SLC12A2      6558    CAL51_BREAST_TenPx01         0.78856534
#> 6 ACH-000348   SLC12A2      6558   RPMI7951_SKIN_TenPx01        -0.91235198
#>              protein_id                                          desc group_id
#> 1 sp|P55011|S12A2_HUMAN S12A2_HUMAN Solute carrier family 12 member 2        0
#> 2 sp|P55011|S12A2_HUMAN S12A2_HUMAN Solute carrier family 12 member 2        0
#> 3 sp|P55011|S12A2_HUMAN S12A2_HUMAN Solute carrier family 12 member 2        0
#> 4 sp|P55011|S12A2_HUMAN S12A2_HUMAN Solute carrier family 12 member 2        0
#> 5 sp|P55011|S12A2_HUMAN S12A2_HUMAN Solute carrier family 12 member 2        0
#> 6 sp|P55011|S12A2_HUMAN S12A2_HUMAN Solute carrier family 12 member 2        0
#>       uniprot uniprot_acc   TenPx       cell_line
#> 1 S12A2_HUMAN      P55011 TenPx01 MDAMB468_BREAST
#> 2 S12A2_HUMAN      P55011 TenPx01        SH4_SKIN
#> 3 S12A2_HUMAN      P55011 TenPx01    AU565_BREAST
#> 4 S12A2_HUMAN      P55011 TenPx01    KMRC1_KIDNEY
#> 5 S12A2_HUMAN      P55011 TenPx01    CAL51_BREAST
#> 6 S12A2_HUMAN      P55011 TenPx01   RPMI7951_SKIN
```

Restrict to HCT116:

```
ccle.prot.hct116 <- subset(ccle.prot, cell_line == "HCT116_LARGE_INTESTINE")
dim(ccle.prot.hct116)
#> [1] 12755    12
head(ccle.prot.hct116)
#>       depmap_id gene_name entrez_id                        protein
#> 28   ACH-000971   SLC12A2      6558 HCT116_LARGE_INTESTINE_TenPx04
#> 406  ACH-000971    HOXD13      3239 HCT116_LARGE_INTESTINE_TenPx04
#> 784  ACH-000971     KDM1A     23028 HCT116_LARGE_INTESTINE_TenPx04
#> 1162 ACH-000971      SOX1      6656 HCT116_LARGE_INTESTINE_TenPx04
#> 1540 ACH-000971      SOX2      6657 HCT116_LARGE_INTESTINE_TenPx04
#> 1918 ACH-000971      SOX3      6658 HCT116_LARGE_INTESTINE_TenPx04
#>      protein_expression            protein_id
#> 28           -0.2422502 sp|P55011|S12A2_HUMAN
#> 406                  NA sp|P35453|HXD13_HUMAN
#> 784          -0.1941110 sp|O60341|KDM1A_HUMAN
#> 1162                 NA  sp|O00570|SOX1_HUMAN
#> 1540         -1.5306584  sp|P48431|SOX2_HUMAN
#> 1918                 NA  sp|P41225|SOX3_HUMAN
#>                                                    desc group_id     uniprot
#> 28        S12A2_HUMAN Solute carrier family 12 member 2        0 S12A2_HUMAN
#> 406                HXD13_HUMAN Homeobox protein Hox-D13        1 HXD13_HUMAN
#> 784  KDM1A_HUMAN Lysine-specific histone demethylase 1A        2 KDM1A_HUMAN
#> 1162              SOX1_HUMAN Transcription factor SOX-1        4  SOX1_HUMAN
#> 1540              SOX2_HUMAN Transcription factor SOX-2        4  SOX2_HUMAN
#> 1918              SOX3_HUMAN Transcription factor SOX-3        4  SOX3_HUMAN
#>      uniprot_acc   TenPx              cell_line
#> 28        P55011 TenPx04 HCT116_LARGE_INTESTINE
#> 406       P35453 TenPx04 HCT116_LARGE_INTESTINE
#> 784       O60341 TenPx04 HCT116_LARGE_INTESTINE
#> 1162      O00570 TenPx04 HCT116_LARGE_INTESTINE
#> 1540      P48431 TenPx04 HCT116_LARGE_INTESTINE
#> 1918      P41225 TenPx04 HCT116_LARGE_INTESTINE
```

Or turn into a `SummarizedExperiment` for convenience (we can restrict
this to selected cell lines, but here we keep all cell lines):

```
se <- ccleProteome2SummarizedExperiment(ccle.prot, cell.line = NULL)
assay(se)[1:5, 1:5]
#>             22RV1         697       769P       786O      8305C
#> P55011  1.8112046 -0.01482998 -0.5658598 -1.2205591 -0.1713740
#> P35453         NA          NA -2.5433313         NA         NA
#> O60341 -0.3379936  0.37121437 -0.8170886 -0.9183874  0.1141192
#> O00570         NA          NA         NA -0.5043593         NA
#> P48431 -1.2617033          NA         NA -3.4006509         NA
assay(se)[1:5, "HCT116"]
#>     P55011     P35453     O60341     O00570     P48431
#> -0.2422502         NA -0.1941110         NA -1.5306584
rowData(se)
#> DataFrame with 12755 rows and 2 columns
#>             SYMBOL  ENTREZID
#>        <character> <numeric>
#> P55011     SLC12A2      6558
#> P35453      HOXD13      3239
#> O60341       KDM1A     23028
#> O00570        SOX1      6656
#> P48431        SOX2      6657
#> ...            ...       ...
#> Q9Y258       CCL26     10344
#> P20292     ALOX5AP       241
#> Q9H1C7      CYSTM1     84418
#> Q99735       MGST2      4258
#> Q9P003       CNIH4     29097
```

### 3.5.2 Relative protein expression data from BioPlex3.0

The [BioPlex 3.0 publication](https://doi.org/10.1016/j.cell.2021.04.011),
Supplementary Table S4A, provides relative protein expression data comparing
293T and HCT116 cells based on tandem mass tag analysis.

```
bp.prot <- getBioplexProteome()
#> Using cached version from 2022-03-06 08:58:37
assay(bp.prot)[1:5,1:5]
#>               HCT1      HCT2      HCT3      HCT4      HCT5
#> P0CG40    1.526690  3.479370  2.223500  2.258470  2.923410
#> Q8IXZ3-4  1.758790  1.610220  2.004360  1.800270  1.371470
#> P55011   12.570100 11.637500 12.495700 11.374500 12.377400
#> O60341    8.914910  9.677760  8.397850  8.745780  8.746410
#> O14654    0.196305  0.277787  0.425389  0.199624  0.491558
colData(bp.prot)
#> DataFrame with 10 rows and 1 column
#>        cell.line
#>      <character>
#> HCT1      HCT116
#> HCT2      HCT116
#> HCT3      HCT116
#> HCT4      HCT116
#> HCT5      HCT116
#> HEK1        293T
#> HEK2        293T
#> HEK3        293T
#> HEK4        293T
#> HEK5        293T
rowData(bp.prot)
#> DataFrame with 9604 rows and 5 columns
#>             ENTREZID      SYMBOL nr.peptides log2ratio  adj.pvalue
#>          <character> <character>   <integer> <numeric>   <numeric>
#> P0CG40     100131390         SP9           1 -2.819071 6.66209e-08
#> Q8IXZ3-4      221833         SP8           3 -3.419888 6.94973e-07
#> P55011          6558     SLC12A2           4  0.612380 4.85602e-06
#> O60341         23028       KDM1A           7 -0.319695 5.08667e-04
#> O14654          8471        IRS4           4 -5.951096 1.45902e-06
#> ...              ...         ...         ...       ...         ...
#> Q9H6X4         80194     TMEM134           2 -0.379342 7.67195e-05
#> Q9BS91         55032     SLC35A5           1 -2.237634 8.75523e-05
#> Q9UKJ5         26511       CHIC2           1 -0.614932 1.78756e-03
#> Q9H3S5         93183        PIGM           1 -1.011397 8.91589e-06
#> Q8WYQ3        400916     CHCHD10           1  0.743852 1.17163e-03
```

The data contains 5 replicates each for 293T and for HCT116 cells.
As a result of the data collection process, the data represent relative protein abundance
scaled to add up to 100% in each row.

# 4 Caching

Note that calling functions like `getCorum` or `getBioPlex` with argument
`cache = FALSE` will automatically overwrite the corresponding object in your
cache. It is thus typically not required for a user to interact with the cache.

For more extended control of the cache, use from within R:

```
cache.dir <- tools::R_user_dir("BioPlex", which = "cache")
bfc <- BiocFileCache::BiocFileCache(cache.dir)
```

and then proceed as described in the
[BiocFileCache vignette, Section 1.10](https://www.bioconductor.org/packages/release/bioc/vignettes/BiocFileCache/inst/doc/BiocFileCache.html#cleaning-or-removing-cache)
either via `cleanbfc()` to clean or `removebfc()` to remove your cache.

To do a hard reset (use with caution!):

```
BiocFileCache::removebfc(bfc)
```

# 5 SessionInfo

```
sessionInfo()
#> R version 4.1.2 (2021-11-01)
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
#>  [1] depmap_1.8.0                dplyr_1.0.8
#>  [3] ExperimentHub_2.2.1         graph_1.72.0
#>  [5] AnnotationHub_3.2.2         BiocFileCache_2.2.1
#>  [7] dbplyr_2.1.1                AnnotationDbi_1.56.2
#>  [9] BioPlex_1.0.2               SummarizedExperiment_1.24.0
#> [11] Biobase_2.54.0              GenomicRanges_1.46.1
#> [13] GenomeInfoDb_1.30.1         IRanges_2.28.0
#> [15] S4Vectors_0.32.3            BiocGenerics_0.40.0
#> [17] MatrixGenerics_1.6.0        matrixStats_0.61.0
#> [19] BiocStyle_2.22.0
#>
#> loaded via a namespace (and not attached):
#>  [1] bitops_1.0-7                  bit64_4.0.5
#>  [3] filelock_1.0.2                httr_1.4.2
#>  [5] tools_4.1.2                   bslib_0.3.1
#>  [7] utf8_1.2.2                    R6_2.5.1
#>  [9] DBI_1.1.2                     withr_2.5.0
#> [11] tidyselect_1.1.2              bit_4.0.4
#> [13] curl_4.3.2                    compiler_4.1.2
#> [15] cli_3.2.0                     xml2_1.3.3
#> [17] DelayedArray_0.20.0           bookdown_0.24
#> [19] sass_0.4.0                    readr_2.1.2
#> [21] rappdirs_0.3.3                stringr_1.4.0
#> [23] digest_0.6.29                 rmarkdown_2.12
#> [25] R.utils_2.11.0                GEOquery_2.62.2
#> [27] XVector_0.34.0                pkgconfig_2.0.3
#> [29] htmltools_0.5.2               highr_0.9
#> [31] fastmap_1.1.0                 limma_3.50.1
#> [33] rlang_1.0.2                   RSQLite_2.2.10
#> [35] shiny_1.7.1                   jquerylib_0.1.4
#> [37] generics_0.1.2                jsonlite_1.8.0
#> [39] R.oo_1.24.0                   RCurl_1.98-1.6
#> [41] magrittr_2.0.2                GenomeInfoDbData_1.2.7
#> [43] Matrix_1.4-0                  Rcpp_1.0.8
#> [45] fansi_1.0.2                   lifecycle_1.0.1
#> [47] R.methodsS3_1.8.1             stringi_1.7.6
#> [49] yaml_2.3.5                    zlibbioc_1.40.0
#> [51] grid_4.1.2                    blob_1.2.2
#> [53] promises_1.2.0.1              crayon_1.5.0
#> [55] lattice_0.20-45               Biostrings_2.62.0
#> [57] hms_1.1.1                     KEGGREST_1.34.0
#> [59] knitr_1.37                    pillar_1.7.0
#> [61] glue_1.6.2                    BiocVersion_3.14.0
#> [63] evaluate_0.15                 data.table_1.14.2
#> [65] BiocManager_1.30.16           png_0.1-7
#> [67] vctrs_0.3.8                   tzdb_0.2.0
#> [69] httpuv_1.6.5                  purrr_0.3.4
#> [71] tidyr_1.2.0                   assertthat_0.2.1
#> [73] cachem_1.0.6                  xfun_0.30
#> [75] mime_0.12                     xtable_1.8-4
#> [77] later_1.3.0                   tibble_3.1.6
#> [79] memoise_2.0.1                 ellipsis_0.3.2
#> [81] interactiveDisplayBase_1.32.0
```
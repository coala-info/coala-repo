hpAnnot

Marta R. Hidalgo ∗1, Francisco Salavert 2, Alicia Amadoz 3,
Çankut Cubuk 4, José Carbonell-Caballero 5, and Joaquín
Dopazo 4,6,7

1Unidad de Bioinformática y Bioestadística, Centro de Investigación Príncipe Felipe (CIPF),
Valencia, 46012, Spain
2BioBam Bioinformatics S.L., Valencia, 46012, Spain
3Department of Bioinformatics, Igenomix S.A., Valencia, 46980, Spain
4Clinical Bioinformatics Area, Fundación Progreso y Salud (FPS), Hospital Virgen del Rocio,
Sevilla, 41013, Spain
5Chromatin and Gene expression Lab, Gene Regulation, Stem Cells and Cancer Program,
Centre de Regulació Genòmica (CRG), The Barcelona Institute of Science and Technology,
PRBB, Barcelona, 08003, Spain
6Functional Genomics Node (INB), FPS, Hospital Virgen del Rocio, Sevilla, 41013, Spain.
7Bioinformatics in Rare Diseases (BiER), Centro de Investigación Biomédica en Red de
Enfermedades Raras (CIBERER), FPS, Hospital Virgen del Rocio, Sevilla, 41013, Spain

∗marta.hidalgo@outlook.es

2025-10-15

Abstract

HpAnnot is the annotation and data package of the hipathia package. Hipathia is a method
for the computation of signal transduction along signaling pathways. The method is based on
an iterative algorithm which is able to compute the signal intensity passing through the nodes
of a network by taking into account the level of expression of each gene and the intensity of
the signal arriving to it.

Contents

1

Usage .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

2

hpAnnot

1

Usage

In order to access to the files stored in AnnotationHub, type:

library(AnnotationHub)

ah <- AnnotationHub()

hp <- query(ah, "hpAnnot")

hp

## AnnotationHub with 64 records

## # snapshotDate(): 2025-10-10

## # $dataprovider: BioMart, KEGG, GeneOntology

## # $species: Rattus norvegicus, Mus musculus, Homo sapiens, NA

## # $rdataclass: data.frame, list, igraph

## # additional mcols(): taxonomyid, genome, description,

## #

## #

coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
rdatapath, sourceurl, sourcetype

## # retrieve records with, e.g., 'object[["AH60887"]]'

##

##

title

##

##

##

##

##

##

AH60887 | annofuns_GO_hsa.rda
AH60888 | annofuns_GO_mmu.rda
AH60889 | annofuns_GO_rno.rda
AH60890 | annofuns_uniprot_hsa.rda
AH60891 | annofuns_uniprot_mmu.rda
...
AH69121 | pmgi_rno_GO_v2.rda
AH69122 | pmgi_rno_uniprot_v2.rda
AH69123 | xref_hsa_v2.rda
AH69124 | xref_mmu_v2.rda
AH69125 | xref_rno_v2.rda
mcols(hp)[,c("title", "description")]

...

##

##

##

##

##

## DataFrame with 64 rows and 2 columns

##

title

description

##

## AH60888

## AH60887

<character>

<character>
annofuns_GO_hsa.rda Annotations from pat..
annofuns_GO_mmu.rda Annotations from pat..
annofuns_GO_rno.rda Annotations from pat..
## AH60889
## AH60890 annofuns_uniprot_hsa.. Annotations from pat..
## AH60891 annofuns_uniprot_mmu.. Annotations from pat..
...
## ...
pmgi_rno_GO_v2.rda Pseudo-pathways topo..
## AH69121
## AH69122 pmgi_rno_uniprot_v2... Pseudo-pathways topo..
xref_hsa_v2.rda XRef transformation ..
## AH69123
xref_mmu_v2.rda XRef transformation ..
xref_rno_v2.rda XRef transformation ..

## AH69125

## AH69124

...

xtabs(~dataprovider + species, mcols(hp))

##

species

## dataprovider

Homo sapiens Mus musculus Rattus norvegicus

##

##

##

BioMart

GeneOntology

KEGG

12

0

8

12

0

8

12

0

8

2

hpAnnot

head(hp[["AH60887"]])

##

effector.nodes

paths

## hsa03320.N-hsa03320-37

N-hsa03320-37 P-hsa03320-37

## hsa03320.N-hsa03320-611 N-hsa03320-61 P-hsa03320-61

## hsa03320.N-hsa03320-612 N-hsa03320-61 P-hsa03320-61

## hsa03320.N-hsa03320-613 N-hsa03320-61 P-hsa03320-61

## hsa03320.N-hsa03320-614 N-hsa03320-61 P-hsa03320-61

## hsa03320.N-hsa03320-615 N-hsa03320-61 P-hsa03320-61

##

## hsa03320.N-hsa03320-37

funs

<NA>

## hsa03320.N-hsa03320-611 negative regulation of very-low-density lipoprotein particle remodeling

## hsa03320.N-hsa03320-612

## hsa03320.N-hsa03320-613

## hsa03320.N-hsa03320-614

## hsa03320.N-hsa03320-615

hp$title

high-density lipoprotein particle remodeling

phospholipid efflux

regulation of Cdc42 protein signal transduction

cholesterol efflux

##

##

##

##

"annofuns_GO_mmu.rda"
[1] "annofuns_GO_hsa.rda"
"annofuns_uniprot_hsa.rda"
[3] "annofuns_GO_rno.rda"
"annofuns_uniprot_rno.rda"
[5] "annofuns_uniprot_mmu.rda"
"annot_GO_mmu.rda"
[7] "annot_GO_hsa.rda"
"annot_uniprot_hsa.rda"
[9] "annot_GO_rno.rda"
##
"annot_uniprot_rno.rda"
## [11] "annot_uniprot_mmu.rda"
"entrez_hgnc_mmu.rda"
## [13] "entrez_hgnc_hsa.rda"
"go_bp_frame.rda"
## [15] "entrez_hgnc_rno.rda"
"meta_graph_info_hsa.rda"
## [17] "go_bp_net.rda"
"meta_graph_info_rno.rda"
## [19] "meta_graph_info_mmu.rda"
"pmgi_hsa_GO.rda"
## [21] "pmgi_hsa_genes.rda"
"pmgi_mmu_genes.rda"
## [23] "pmgi_hsa_uniprot.rda"
"pmgi_mmu_uniprot.rda"
## [25] "pmgi_mmu_GO.rda"
"pmgi_rno_GO.rda"
## [27] "pmgi_rno_genes.rda"
"xref_hsa.rda"
## [29] "pmgi_rno_uniprot.rda"
"xref_rno.rda"
## [31] "xref_mmu.rda"
"annofuns_GO_mmu_v2.rda"
## [33] "annofuns_GO_hsa_v2.rda"
## [35] "annofuns_GO_rno_v2.rda"
"annofuns_uniprot_hsa_v2.rda"
## [37] "annofuns_uniprot_mmu_v2.rda" "annofuns_uniprot_rno_v2.rda"
## [39] "annot_GO_hsa_v2.rda"
## [41] "annot_GO_rno_v2.rda"
## [43] "annot_uniprot_mmu_v2.rda"
## [45] "entrez_hgnc_hsa_v2.rda"
## [47] "entrez_hgnc_rno_v2.rda"
## [49] "go_bp_net_v2.rda"
## [51] "meta_graph_info_mmu_v2.rda"
## [53] "pmgi_hsa_genes_v2.rda"
## [55] "pmgi_hsa_uniprot_v2.rda"
## [57] "pmgi_mmu_GO_v2.rda"
## [59] "pmgi_rno_genes_v2.rda"
## [61] "pmgi_rno_uniprot_v2.rda"
## [63] "xref_mmu_v2.rda"

"annot_GO_mmu_v2.rda"
"annot_uniprot_hsa_v2.rda"
"annot_uniprot_rno_v2.rda"
"entrez_hgnc_mmu_v2.rda"
"go_bp_frame_v2.rda"
"meta_graph_info_hsa_v2.rda"
"meta_graph_info_rno_v2.rda"
"pmgi_hsa_GO_v2.rda"
"pmgi_mmu_genes_v2.rda"
"pmgi_mmu_uniprot_v2.rda"
"pmgi_rno_GO_v2.rda"
"xref_hsa_v2.rda"
"xref_rno_v2.rda"

For further information on this please refer to AnnotationHub.

3


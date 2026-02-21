# SpliceWiz: the cookbook

#### Alex CH Wong

#### 10/30/2025

Abstract

This vignette is a guide containing example code for performing real-life tasks. Importantly, it covers some functionality that were not covered in the Quick-Start vignette (because they are too computationally intensive to be reproducible in a vignette). Version 1.12.0

# Loading SpliceWiz

For instructions on installing and configuring SpliceWiz, please see the Quick-Start vignette.

```
library(SpliceWiz)
#> Loading required package: NxtIRFdata
#> SpliceWiz package loaded with 2 threads
#> Use setSWthreads() to set the number of SpliceWiz threads
```

# Reference Generation

First, define the path to the directory in which the reference should be stored. This directory will be made by SpliceWiz, but its parent directory must exist, otherwise an error will be returned.

```
ref_path <- "./Reference"
```

### Create a SpliceWiz reference from user-defined FASTA and GTF files locally

Note that setting `genome_path = "hg38"` will prompt SpliceWiz to use the default files for nonPolyA and Mappability exclusion references in the generation of its reference. Valid options for `genome_path` are “hg38”, “hg19”, “mm10” and “mm9”.

```
buildRef(
    reference_path = ref_path,
    fasta = "genome.fa", gtf = "transcripts.gtf",
    genome_type = "hg38"
)
```

### Prepare genome resources and building the reference as separate steps

`buildRef()` first runs `getResources()`, which prepares the genome and gene annotations by storing a compressed local copy in the `resources` subdirectory of the given reference path. Specifically, a binary compressed version of the FASTA file (a.k.a. TwoBitFile), and a gzipped GTF file. If `fasta` and/or `gtf` are https or ftp links, the resources will be downloaded from the internet (which may take a while).

After local compressed versions of the genome and gene annotations are prepared, `buildRef()` will proceed to generate the SpliceWiz reference.

Note that these two steps can be run separately. `getResources()` will prepare local compressed copies of the FASTA / GTF resources without generating the SpliceWiz reference. Running `buildRef()`, with `reference_path` specifying where the resources were prepared previously with `getResources()`, will perform the 2nd step (SpliceWiz reference generation) without needing to prepare the genome resources (in this case, set the parameters `fasta = ""` and `gtf = ""`).

As an example, the below steps:

```
getResources(
    reference_path = ref_path,
    fasta = "genome.fa",
    gtf = "transcripts.gtf"
)

buildRef(
    reference_path = ref_path,
    fasta = "", gtf = "",
    genome_type = "hg38"
)
```

is equivalent to this:

```
buildRef(
    reference_path = ref_path,
    fasta = "genome.fa",
    gtf = "transcripts.gtf"
    genome_type = "hg38"
)
```

### Overwriting an existing reference, but using the same annotations

To re-build and overwrite an existing reference, using the same resource annotations, set `overwrite = TRUE`

```
# Assuming hg38 genome:

buildRef(
    reference_path = ref_path,
    genome_type = "hg38",
    overwrite = TRUE
)
```

If `buildRef()` is run without setting `overwrite = TRUE`, it will terminate if the file `SpliceWiz.ref.gz` is found within the reference directory.

### Create a SpliceWiz reference using web resources from Ensembl’s FTP

The following will first download the genome and gene annotation files from the online resource and store a local copy of it in a file cache, facilitated by BiocFileCache. Then, it uses the downloaded resource to create the SpliceWiz reference.

```
FTP <- "ftp://ftp.ensembl.org/pub/release-94/"

buildRef(
    reference_path = ref_path,
    fasta = paste0(FTP, "fasta/homo_sapiens/dna/",
        "Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz"),
    gtf = paste0(FTP, "gtf/homo_sapiens/",
        "Homo_sapiens.GRCh38.94.chr.gtf.gz"),
    genome_type = "hg38"
)
```

### Create a SpliceWiz reference using AnnotationHub resources

AnnotationHub contains Ensembl references for many genomes. To browse what is available:

```
require(AnnotationHub)
#> Loading required package: AnnotationHub
#> Loading required package: BiocGenerics
#> Loading required package: generics
#>
#> Attaching package: 'generics'
#> The following objects are masked from 'package:base':
#>
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> Loading required package: BiocFileCache
#> Loading required package: dbplyr

ah <- AnnotationHub()
query(ah, "Ensembl")
#> AnnotationHub with 36544 records
#> # snapshotDate(): 2025-10-28
#> # $dataprovider: Ensembl, FANTOM5,DLRP,IUPHAR,HPRD,STRING,SWISSPROT,TREMBL,E...
#> # $species: Mus musculus, Sus scrofa, Homo sapiens, Rattus norvegicus, Danio...
#> # $rdataclass: TwoBitFile, GRanges, EnsDb, SQLiteFile, data.frame, OrgDb, li...
#> # additional mcols(): taxonomyid, genome, description,
#> #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
#> #   rdatapath, sourceurl, sourcetype
#> # retrieve records with, e.g., 'object[["AH5046"]]'
#>
#>              title
#>   AH5046   | Ensembl Genes
#>   AH5160   | Ensembl Genes
#>   AH5311   | Ensembl Genes
#>   AH5434   | Ensembl Genes
#>   AH5435   | Ensembl EST Genes
#>   ...        ...
#>   AH121867 | LRBaseDb for Tursiops truncatus (Dolphin, v010)
#>   AH121868 | LRBaseDb for Ursus maritimus (Polar bear, v010)
#>   AH121869 | LRBaseDb for Vombatus ursinus (Common wombat, v010)
#>   AH121870 | LRBaseDb for Vulpes vulpes (Red fox, v010)
#>   AH121871 | LRBaseDb for Xenopus tropicalis (Tropical clawed frog, v010)
```

For a more specific query:

```
query(ah, c("Homo Sapiens", "release-94"))
#> AnnotationHub with 9 records
#> # snapshotDate(): 2025-10-28
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
buildRef(
    reference_path = ref_path,
    fasta = "AH65745",
    gtf = "AH64631",
    genome_type = "hg38"
)
```

`Build-Reference-methods` will recognise the inputs of `fasta` and `gtf` as AnnotationHub resources if they begin with “AH”.

### Create a SpliceWiz reference from species other than human or mouse

For human and mouse genomes, we highly recommend specifying `genome_type` as the default mappability file is used to exclude intronic regions with repeat sequences from intron retention analysis. For other species, one could generate a SpliceWiz reference without this reference:

```
buildRef(
    reference_path = ref_path,
    fasta = "genome.fa", gtf = "transcripts.gtf",
    genome_type = ""
)
```

If one wishes to prepare a Mappability Exclusion for species other than human or mouse, please see the `Calculating Mappability Exclusions using STAR` section below.

### (NEW) Gene ontology annotations

For human and mouse genomes, gene ontology annotations are automatically generated. This is inferred by specifying `genome_type` to the human or mouse genome. For other species, or to specify human/mouse, this should be specified in the `ontologySpecies` parameter of `buildRef()`.

Only Ensembl/orgDB resources are supported (for now). For a list of available species:

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

For example, to specify arabidopsis:

```
buildRef(
    reference_path = ref_path,
    fasta = "genome.fa", gtf = "transcripts.gtf",
    genome_type = "",
    ontologySpecies = "Arabidopsis thaliana"
)
```

# STAR reference generation (using SpliceWiz wrappers)

### Checking if STAR is installed

To use `STAR` to align FASTQ files, one must be using a system with `STAR` installed. This software is not available in Windows. To check if `STAR` is available:

```
STAR_version()
#> Oct 30 20:20:26 STAR is not installed
#> NULL
```

### Building a STAR reference

```
ref_path = "./Reference"

# Ensure genome resources are prepared from genome FASTA and GTF file:

if(!dir.exists(file.path(ref_path, "resource"))) {
    getResources(
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

Note that, by default, `STAR_BuildRef` will store the STAR genome reference in the `STAR` subdirectory within `reference_path`. To override this setting, set the `STAR_ref_path` parameter to a directory path of your choice, e.g.:

```
STAR_BuildRef(
    reference_path = ref_path,
    STAR_ref_path = "/path/to/another/directory",
    n_threads = 8
)
```

### Building a STAR genome without specifying gene annotations

Sometimes, one might wish to build a genome annotation without first specifying the gene annotations. Reasons one might want to do this include:

* Making a STAR reference is computationally intensive, so one might wish to use the same STAR reference for all projects involving the same species
* Reducing any potential bias for annotated splice junctions during alignment.

We can use `STAR_buildGenome` to do this:

```
# Generate a STAR genome reference:
STAR_buildGenome(
    reference_path = ref_path,
    STAR_ref_path = "/path/to/hg38"
    n_threads = 8
)
```

This STAR reference is derived from the genome FASTA file but not the gene annotation GTF file. Prior to alignment, additional parameters need to be supplied (which should take 5 minutes). These include:

* gene annotation (GTF) file, which is automatically generated by setting the SpliceWiz reference path to the `reference_path` parameter
* sjdbOverhang (default 100), which is ideally the read length (minus 1)
* sequences for any spike-in standards, such as ERCC FASTA files

To generate an on-the-fly (i.e., alignment-ready) STAR reference from a genome-derived reference:

```
STAR_new_ref <- STAR_loadGenomeGTF(
    reference_path = ref_path,
    STAR_ref_path = "/path/to/hg38",
    STARgenome_output = file.path(tempdir(), "STAR"),
    n_threads = 8,
    sjdbOverhang = 100,
    extraFASTA = "./ercc.fasta"
)
```

The path to the on-the-fly reference is specified by the return value (`STAR_new_ref` in the above example).

As already explained, this step allows a single STAR reference to be built for each species, which can be adapted for different projects based on their specific technical specifications (e.g. different read length can be adapted by setting different `sjdbOverhang`, or any spike-ins by setting the spike-in FASTA using `extraFASTA`).

### Calculating Mappability Exclusions using STAR (optional)

Genomes contain regions of low mappability (i.e. areas which are difficult for reads or fragments to align to). A common computational cause of low mappability include repeat sequences. IRFinder uses an empirical method to determine regions of low mappability, which we adopted in SpliceWiz. These resources are used automatically when generating the SpliceWiz reference and setting the `genome_type` to supported genomes (hg38, hg19, mm10, mm9). For other species, one may wish to generate their own annotations of low mappability regions using the STAR aligner.

The `STAR_mappability` wrapper function will use the STAR aligner to calculate regions of low mappability within the given genome.

```
STAR_mappability(
  reference_path = ref_path,
  STAR_ref_path = file.path(ref_path, "STAR"),
  map_depth_threshold = 4,
  n_threads = 8,
  read_len = 70,
  read_stride = 10,
  error_pos = 35
)
```

In the above example, `STAR_mappability()` will use the given STAR reference (inside the `STAR_ref_path` directory), and the genome found within the `reference_path` SpliceWiz reference, to generate synthetic reads.

* `read_len` specifies the length of these synthetic reads (default `70`)
* `read_stride` specifies the nucleotide distance between adjacent synthetic reads (default `10`). These will be generated with alternate `+` / `-` strand
* `error_pos` introduces a single nucleotide error at the specified position (default `35`), which will generate an SNP at the center of the 70-nt synthetic read.

These synthetic reads will then be aligned back to the STAR genome to create a BAM file, which is later processed to measure the coverage depth of the genome by these synthetic reads.

Finally, regions with coverage depth of `map_depth_threshold` or below will be defined as regions of “low mappability”. In the above example, 70-nt reads of 10-nt stride will produce synthetic reads such that each nucleotide is expected to have a coverage of `70 / 10 = 7` nucleotides. A coverage of `4` nucleotides or less equates to a coverage of < ~60% of expected depth.

### Building BOTH STAR and SpliceWiz references together

If `STAR` is available on the same computer or server where R/RStudio is being run, we can use the one-line function `buildFullRef`. This function will:

* Prepare the resources from the given FASTA and GTF files (runs `getResources`)
* Generate a STAR genome (runs `STAR_BuildRef`)
* Use the STAR genome and the FASTA file to *de-novo* calculate and define low mappability regions (runs `STAR_mappability`)
* Build the SpliceWiz reference using the genome resources and mappability file (runs `buildRef`)

This step is recommended when one wishes to build a non-human/mouse genome in a single step, including generating low-mappability regions to exclude measuring IR events with low mappability.

```
buildFullRef(
    reference_path = ref_path,
    fasta = "genome.fa", gtf = "transcripts.gtf",
    genome_type = "",
    use_STAR_mappability = TRUE,
    n_threads = 8
)
```

`n_threads` specify how many threads should be used to build the STAR reference and to calculate the low mappability regions

### Mappability exclusion generation using Rsubread

If `STAR` is not available, `Rsubread` is available on Bioconductor for alignment and can be used to perform mappability calculations. The example code in the manual is displayed here for convenience, to demonstrate how this would be done:

```
require(Rsubread)

# (1a) Creates genome resource files

ref_path <- file.path(tempdir(), "Reference")

getResources(
    reference_path = ref_path,
    fasta = chrZ_genome(),
    gtf = chrZ_gtf()
)

# (1b) Systematically generate reads based on the SpliceWiz example genome:

generateSyntheticReads(
    reference_path = ref_path
)

# (2) Align the generated reads using Rsubread:

# (2a) Build the Rsubread genome index:

subreadIndexPath <- file.path(ref_path, "Rsubread")
if(!dir.exists(subreadIndexPath)) dir.create(subreadIndexPath)
Rsubread::buildindex(
    basename = file.path(subreadIndexPath, "reference_index"),
    reference = chrZ_genome()
)

# (2b) Align the synthetic reads using Rsubread::subjunc()

Rsubread::subjunc(
    index = file.path(subreadIndexPath, "reference_index"),
    readfile1 = file.path(ref_path, "Mappability", "Reads.fa"),
    output_file = file.path(ref_path, "Mappability", "AlignedReads.bam"),
    useAnnotation = TRUE,
    annot.ext = chrZ_gtf(),
    isGTF = TRUE
)

# (3) Analyse the aligned reads in the BAM file for low-mappability regions:

calculateMappability(
    reference_path = ref_path,
    aligned_bam = file.path(ref_path, "Mappability", "AlignedReads.bam")
)

# (4) Build the SpliceWiz reference using the calculated Mappability Exclusions

buildRef(ref_path)
```

Note that the default output file for `calculateMappability()` (step 3) is `Mappability/MappabilityExclusion.bed.gz` found within the `reference_path` directory. Then `buildRef()` (step 4) will automatically use this file, regardless of the `genome_type` parameter. The exception is if `MappabilityRef` parameter is set to a different file.

This conveniences users to generate their own human/mouse mappability files but use the default non-polyA reference, e.g.:

```
buildRef(ref_path, genome_type = "hg38")
```

# STAR alignment (using SpliceWiz wrappers)

First, remember to check that STAR is available via command line:

```
STAR_version()
#> Oct 30 20:20:26 STAR is not installed
#> NULL
```

### Aligning a single sample using STAR

```
STAR_alignReads(
    fastq_1 = "sample1_1.fastq", fastq_2 = "sample1_2.fastq",
    STAR_ref_path = file.path(ref_path, "STAR"),
    BAM_output_path = "./bams/sample1",
    n_threads = 8,
    trim_adaptor = "AGATCGGAAG"
)
```

Note that by default, `STAR_alignReads()` will “trim” Illumina adapters (in fact they will be soft-clipped using STAR’s `--clip3pAdapterSeq` option). To disable this feature, set `trim_adapter = ""` in the `STAR_alignReads()` function.

### Aligning multiple samples using STAR

```
Experiment <- data.frame(
    sample = c("sample_A", "sample_B"),
    forward = file.path("raw_data", c("sample_A", "sample_B"),
        c("sample_A_1.fastq", "sample_B_1.fastq")),
    reverse = file.path("raw_data", c("sample_A", "sample_B"),
        c("sample_A_2.fastq", "sample_B_2.fastq"))
)

STAR_alignExperiment(
    Experiment = Experiment,
    STAR_ref_path = file.path("Reference_FTP", "STAR"),
    BAM_output_path = "./bams",
    n_threads = 8,
    two_pass = FALSE
)
```

To use two-pass mapping, set `two_pass = TRUE`. We recommend disabling this feature, as one-pass mapping is adequate in typical-use cases. Two-pass mapping is recommended if one expects a large number of novel splicing events or if the gene annotations (of transcript isoforms) is likely to be incomplete. Additionally, two-pass mapping is highly memory intensive and should be reserved for systems with high memory resources.

### Finding FASTQ files recursively from a given directory

SpliceWiz can identify sequencing FASTQ files recursively from a given directory. It assumes that forward and reverse reads are suffixed as `_1` and `_2`, respectively. Users can choose to identify such files using a specified file extension. For example, to recursively identify FASTQ files of the format `{sample}_1.fq.gz` and `{sample}_2.fq.gz`, use the following:

```
# Assuming sequencing files are named by their respective sample names
fastq_files <- findFASTQ(
    sample_path = "./sequencing_files",
    paired = TRUE,
    fastq_suffix = ".fq.gz", level = 0
)
```

For gzipped fastq files, `fastq_suffix` should be `".fq.gz"` or `".fastq.gz"`. For uncompressed fastq files, it should be `".fq"` or `".fastq"`. Please check your files in order to correctly set this option.

`findFASTQ()` will return a 2- or 3-column data frame (depending if `paired` was set to `FALSE` or `TRUE`, respectively). The first column is the sample name (the file name, if `level = 0`, or the parent directory name, if `level = 1`). The subsequent columns are the paths of the forward and reverse reads.

The data.frame returned by the `findFASTQ()` function can be parsed into the `STAR_alignExperiment` function. This will align all samples contained in the data.frame parsed via the `Experiment` parameter.

```
STAR_alignExperiment(
    Experiment = fastq_files,
    STAR_ref_path = file.path("Reference_FTP", "STAR"),
    BAM_output_path = "./bams",
    n_threads = 8,
    two_pass = FALSE
)
```

Note that, if a directory contains multiple forward and reverse FASTQ files, they will be aligned to the same BAM file. This can be done by setting `level = 1` in the `findFASTQ()` function, resulting in multiple rows with the same sample name.

# Processing BAM files

To conveniently find all BAM files recursively in a given path:

```
bams <- findBAMS("./bams", level = 1)
```

This convenience function returns the putative sample names, either from BAM file names themselves (`level = 0`), or from the names of their parent directories (`level = 1`).

First, ensure that a SpliceWiz reference has been generated using the `buildRef()` function. This reference should be parsed into the `reference_path` parameter of the `processBAM()` function.

To run `processBAM()` using 4 OpenMP threads:

```
# assume SpliceWiz reference has been generated in `ref_path` using the
# `buildRef()` function.

processBAM(
    bamfiles = bams$path,
    sample_names = bams$sample,
    reference_path = ref_path,
    output_path = "./pb_output",
    n_threads = 4,
    useOpenMP = TRUE
)
```

### Creating COV files from BAM files without running processBAM

Sometimes one may wish to create a COV file from a BAM file without running `processBAM()`. One reason might be because a SpliceWiz reference is not available.

To convert a list of BAM files, run `BAM2COV()`. This is a function structurally similar to `processBAM()` but without the need to give the path to the SpliceWiz reference:

```
BAM2COV(
    bamfiles = bams$path,
    sample_names = bams$sample,
    output_path = "./cov_output",
    n_threads = 4,
    useOpenMP = TRUE
)
```

### Converting COV files to BigWig

Sometimes, users may wish to convert COV files to BigWig. One common reason may be to generate strand-specific coverage to compare with BigWig files on IGV.

For example, to generate a BigWig file containing reads on the negative strand:

```
se <- SpliceWiz_example_NxtSE()

cov_file <- covfile(se)[1]

cov_negstrand <- getCoverage(cov_file, strand = "-")
bw_file <- file.path(tempdir(), "sample_negstrand.bw")
rtracklayer::export(cov_negstrand, bw_file, "bw")
```

### The OpenMP parameter explained

SpliceWiz processes BAM files using OpenMP-based parallelisation (multi-threading), using our ompBAM C++ library (available via the ompBAM Bioconductor package). The advantage of using this approach (instead of processing multiple BAM files each using a single thread) is that the latter approach uses a lot more memory. Our OpenMP-based approach processes BAM files one at a time, avoiding the memory cost when analysing multiple BAM files simultaneously.

Note that, by default, `processBAM` and `BAM2COV` will use OpenMP where available (which is natively supported on Windows and Linux). For MacOS, if OpenMP is not available, these functions will use BiocParallel’s `MulticoreParam` to multi-thread process BAM files (1 BAM per thread). Beware that this may take a lot of RAM! (Typically 5-10 Gb per BAM file). We highly suggest considering installing OpenMP libraries on MacOS, as this will lower RAM usage.

# Collating the experiment

Assuming the SpliceWiz reference is in `ref_path`, after running `processBAM()` as shown in the previous section, use the convenience function `findSpliceWizOutput()` to tabulate a list of samples and their corresponding `processBAM()` outputs:

```
expr <- findSpliceWizOutput("./pb_output")
```

This data.frame can be directly used to run `collateData`:

```
collateData(
    Experiment = expr,
    reference_path = ref_path,
    output_path = "./NxtSE_output"
)
```

* NB: Novel splicing detection can be enabled by setting `novelSplicing = TRUE`. See the Quick-Start vignette for more details about the various parameters associated with novel splicing detection.

```
collateData(
    Experiment = expr,
    reference_path = ref_path,
    output_path = "./NxtSE_output_novelSplicing",
    novelSplicing = TRUE
)
```

Then, the collated data can be imported as a `NxtSE` object, which is an object that inherits `SummarizedExperiment` and has specialized containers to hold additional data required by SpliceWiz.

```
se <- makeSE("./NxtSE_output")
```

# Downstream analysis using SpliceWiz

Please refer to SpliceWiz: Quick-Start vignette for worked examples using the example dataset.

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
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] AnnotationHub_4.0.0 BiocFileCache_3.0.0 dbplyr_2.5.1
#> [4] BiocGenerics_0.56.0 generics_0.1.4      SpliceWiz_1.12.0
#> [7] NxtIRFdata_1.16.0
#>
#> loaded via a namespace (and not attached):
#>   [1] splines_4.5.1               later_1.4.4
#>   [3] BiocIO_1.20.0               bitops_1.0-9
#>   [5] filelock_1.0.3              tibble_3.3.0
#>   [7] R.oo_1.27.1                 XML_3.99-0.19
#>   [9] lifecycle_1.0.4             httr2_1.2.1
#>  [11] processx_3.8.6              lattice_0.22-7
#>  [13] dendextend_1.19.1           magrittr_2.0.4
#>  [15] plotly_4.11.0               sass_0.4.10
#>  [17] rmarkdown_2.30              jquerylib_0.1.4
#>  [19] yaml_2.3.10                 httpuv_1.6.16
#>  [21] otel_0.2.0                  chromote_0.5.1
#>  [23] DBI_1.2.3                   RColorBrewer_1.1-3
#>  [25] abind_1.4-8                 rvest_1.0.5
#>  [27] GenomicRanges_1.62.0        purrr_1.1.0
#>  [29] R.utils_2.13.0              RCurl_1.98-1.17
#>  [31] rappdirs_0.3.3              seriation_1.5.8
#>  [33] IRanges_2.44.0              S4Vectors_0.48.0
#>  [35] genefilter_1.92.0           pheatmap_1.0.13
#>  [37] annotate_1.88.0             DelayedMatrixStats_1.32.0
#>  [39] codetools_0.2-20            DelayedArray_0.36.0
#>  [41] DT_0.34.0                   xml2_1.4.1
#>  [43] tidyselect_1.2.1            UCSC.utils_1.6.0
#>  [45] farver_2.1.2                rhandsontable_0.3.8
#>  [47] viridis_0.6.5               TSP_1.2-5
#>  [49] shinyWidgets_0.9.0          matrixStats_1.5.0
#>  [51] stats4_4.5.1                Seqinfo_1.0.0
#>  [53] webshot_0.5.5               GenomicAlignments_1.46.0
#>  [55] jsonlite_2.0.0              fst_0.9.8
#>  [57] survival_3.8-3              iterators_1.0.14
#>  [59] foreach_1.5.2               tools_4.5.1
#>  [61] progress_1.2.3              Rcpp_1.1.0
#>  [63] glue_1.8.0                  gridExtra_2.3
#>  [65] SparseArray_1.10.0          xfun_0.54
#>  [67] MatrixGenerics_1.22.0       GenomeInfoDb_1.46.0
#>  [69] websocket_1.4.4             dplyr_1.1.4
#>  [71] ca_0.71.1                   HDF5Array_1.38.0
#>  [73] shinydashboard_0.7.3        withr_3.0.2
#>  [75] BiocManager_1.30.26         fastmap_1.2.0
#>  [77] rhdf5filters_1.22.0         digest_0.6.37
#>  [79] R6_2.6.1                    mime_0.13
#>  [81] dichromat_2.0-0.1           RSQLite_2.4.3
#>  [83] cigarillo_1.0.0             R.methodsS3_1.8.2
#>  [85] h5mread_1.2.0               tidyr_1.3.1
#>  [87] data.table_1.17.8           rtracklayer_1.70.0
#>  [89] prettyunits_1.2.0           httr_1.4.7
#>  [91] htmlwidgets_1.6.4           S4Arrays_1.10.0
#>  [93] pkgconfig_2.0.3             gtable_0.3.6
#>  [95] blob_1.2.4                  registry_0.5-1
#>  [97] S7_0.2.0                    XVector_0.50.0
#>  [99] htmltools_0.5.8.1           scales_1.4.0
#> [101] Biobase_2.70.0              ompBAM_1.14.0
#> [103] png_0.1-8                   knitr_1.50
#> [105] rjson_0.2.23                curl_7.0.0
#> [107] cachem_1.1.0                rhdf5_2.54.0
#> [109] BiocVersion_3.22.0          parallel_4.5.1
#> [111] AnnotationDbi_1.72.0        restfulr_0.0.16
#> [113] pillar_1.11.1               grid_4.5.1
#> [115] vctrs_0.6.5                 promises_1.4.0
#> [117] shinyFiles_0.9.3            xtable_1.8-4
#> [119] evaluate_1.0.5              cli_3.6.5
#> [121] compiler_4.5.1              Rsamtools_2.26.0
#> [123] rlang_1.1.6                 crayon_1.5.3
#> [125] heatmaply_1.6.0             ps_1.9.1
#> [127] fs_1.6.6                    stringi_1.8.7
#> [129] viridisLite_0.4.2           BiocParallel_1.44.0
#> [131] assertthat_0.2.1            Biostrings_2.78.0
#> [133] lazyeval_0.2.2              Matrix_1.7-4
#> [135] BSgenome_1.78.0             fstcore_0.10.0
#> [137] hms_1.1.4                   patchwork_1.3.2
#> [139] sparseMatrixStats_1.22.0    bit64_4.6.0-1
#> [141] ggplot2_4.0.0               Rhdf5lib_1.32.0
#> [143] KEGGREST_1.50.0             shiny_1.11.1
#> [145] SummarizedExperiment_1.40.0 memoise_2.0.1
#> [147] bslib_0.9.0                 bit_4.6.0
```
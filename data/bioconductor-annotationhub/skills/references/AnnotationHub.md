# AnnotationHub: Access the AnnotationHub Web Service

#### 29 October 2025

# Contents

* [1 AnnotationHub objects](#annotationhub-objects)
  + [1.1 Interactive retrieval of resources with BiocHubsShiny](#interactive-retrieval-of-resources-with-biochubsshiny)
* [2 Using `AnnotationHub` to retrieve data](#using-annotationhub-to-retrieve-data)
* [3 Configuring `AnnotationHub` objects](#configuring-annotationhub-objects)
* [4 AnnotationHub objects in a cluster environment](#annotationhub-objects-in-a-cluster-environment)
* [5 Creating an AnnotationHub Package or Converting to an AnnotationHub Package](#creating-an-annotationhub-package-or-converting-to-an-annotationhub-package)
* [6 Troubleshooting](#troubleshooting)
* [7 Accessing Behind A Proxy](#accessing-behind-a-proxy)
* [8 Other configuration options for resource downloading](#other-configuration-options-for-resource-downloading)
* [9 Session info](#session-info)

**Package**: *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)*
**Authors**: Bioconductor Package Maintainer [cre],
Martin Morgan [aut],
Marc Carlson [ctb],
Dan Tenenbaum [ctb],
Sonali Arora [ctb],
Valerie Oberchain [ctb],
Kayla Morrell [ctb],
Lori Shepherd [aut]
**Modified**: 27 May, 2016
**Compiled**: Wed Oct 29 22:32:01 2025

The `AnnotationHub` server provides easy *R / Bioconductor* access to
large collections of publicly available whole genome resources,
e.g,. ENSEMBL genome fasta or gtf files, UCSC chain resources, ENCODE
data tracks at UCSC, etc.

# 1 AnnotationHub objects

The *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* package provides a client interface
to resources stored at the AnnotationHub web service.

```
library(AnnotationHub)
```

The *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* package is straightforward to use.
Create an `AnnotationHub` object

```
ah = AnnotationHub()
```

Now at this point you have already done everything you need in order
to start retrieving annotations. For most operations, using the
`AnnotationHub` object should feel a lot like working with a familiar
`list` or `data.frame`.

Lets take a minute to look at the show method for the hub object ah

```
ah
```

```
## AnnotationHub with 70862 records
## # snapshotDate(): 2025-10-28
## # $dataprovider: Ensembl, BroadInstitute, UCSC, ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/, Haemcode,...
## # $species: Homo sapiens, Mus musculus, Drosophila melanogaster, Rattus norvegicus, Bos taurus, ...
## # $rdataclass: GRanges, TwoBitFile, BigWigFile, EnsDb, Rle, OrgDb, ChainFile, TxDb, SQLiteFile, ...
## # additional mcols(): taxonomyid, genome, description, coordinate_1_based, maintainer,
## #   rdatadateadded, preparerclass, tags, rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["AH5012"]]'
##
##              title
##   AH5012   | Chromosome Band
##   AH5013   | STS Markers
##   AH5014   | FISH Clones
##   AH5015   | Recomb Rate
##   AH5016   | ENCODE Pilot
##   ...        ...
##   AH121939 | MeSHDb for Xenopus tropicalis (Tropical clawed frog, v010)
##   AH121940 | MeSHDb for Zea mays (Corn, v010)
##   AH121941 | MeSHDb for MeSH.db (v010)
##   AH121942 | MeSHDb for MeSH.AOR.db (v010)
##   AH121943 | MeSHDb for MeSH.PCR.db (v010)
```

You can see that it gives you an idea about the different types of data that are present inside the hub. You can see where the data is coming from (dataprovider), as well as what species have samples present (species), what kinds of R data objects could be returned (rdataclass). We can take a closer look at all the kinds of data providers that are available by simply looking at the contents of dataprovider as if it were the column of a data.frame object like this:

```
unique(ah$dataprovider)
```

```
##  [1] "UCSC"
##  [2] "Ensembl"
##  [3] "RefNet"
##  [4] "Inparanoid8"
##  [5] "NHLBI"
##  [6] "ChEA"
##  [7] "Pazar"
##  [8] "NIH Pathway Interaction Database"
##  [9] "Haemcode"
## [10] "BroadInstitute"
## [11] "PRIDE"
## [12] "Gencode"
## [13] "CRIBI"
## [14] "Genoscope"
## [15] "MISO, VAST-TOOLS, UCSC"
## [16] "Stanford"
## [17] "dbSNP"
## [18] "BioMart"
## [19] "GeneOntology"
## [20] "KEGG"
## [21] "URGI"
## [22] "EMBL-EBI"
## [23] "MicrosporidiaDB"
## [24] "FungiDB"
## [25] "TriTrypDB"
## [26] "ToxoDB"
## [27] "AmoebaDB"
## [28] "PlasmoDB"
## [29] "PiroplasmaDB"
## [30] "CryptoDB"
## [31] "TrichDB"
## [32] "GiardiaDB"
## [33] "The Gene Ontology Consortium"
## [34] "ENCODE Project"
## [35] "SchistoDB"
## [36] "NCBI/UniProt"
## [37] "GENCODE"
## [38] "http://www.pantherdb.org"
## [39] "RMBase v2.0"
## [40] "snoRNAdb"
## [41] "tRNAdb"
## [42] "NCBI"
## [43] "DrugAge, DrugBank, Broad Institute"
## [44] "DrugAge"
## [45] "DrugBank"
## [46] "Broad Institute"
## [47] "HMDB, EMBL-EBI, EPA"
## [48] "STRING"
## [49] "OMA"
## [50] "OrthoDB"
## [51] "PathBank"
## [52] "EBI/EMBL"
## [53] "WikiPathways"
## [54] "VAST-TOOLS"
## [55] "pyGenomeTracks "
## [56] "NA"
## [57] "UoE"
## [58] "TargetScan,miRTarBase,USCS,ENSEMBL"
## [59] "TargetScan"
## [60] "QuickGO"
## [61] "CIS-BP"
## [62] "CTCFBSDB 2.0"
## [63] "HOCOMOCO v11"
## [64] "JASPAR 2022"
## [65] "Jolma 2013"
## [66] "SwissRegulon"
## [67] "ENCODE SCREEN v3"
## [68] "MassBank"
## [69] "excluderanges"
## [70] "ENCODE"
## [71] "GitHub"
## [72] "Stanford.edu"
## [73] "Publication"
## [74] "CHM13"
## [75] "UCSChub"
## [76] "Google DeepMind"
## [77] "UWashington"
## [78] "Bioconductor"
## [79] "ENCODE cCREs"
## [80] "MGI"
## [81] "GreyListChIP"
## [82] "ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/"
## [83] "FANTOM5,DLRP,IUPHAR,HPRD,STRING,SWISSPROT,TREMBL,ENSEMBL,CELLPHONEDB,BADERLAB,SINGLECELLSIGNALR,HOMOLOGENE"
## [84] "NCBI,DBCLS"
## [85] "ICAR-IARI, New Delhi"
## [86] "The Human Phenotype Ontology"
## [87] "JASPAR is brought to you by a collaborative effort of several research labs and it is licensed under the  Creative Commons Attribution 4.0 International License"
```

In the same way, you can also see data from different species inside the hub by looking at the contents of species like this:

```
head(unique(ah$species))
```

```
## [1] "Homo sapiens"         "Vicugna pacos"        "Dasypus novemcinctus" "Otolemur garnettii"
## [5] "Papio hamadryas"      "Papio anubis"
```

And this will also work for any of the other types of metadata present. You can learn which kinds of metadata are available by simply hitting the tab key after you type ‘ah$’. In this way you can explore for yourself what kinds of data are present in the hub right from the command line. This interface also allows you to access the hub programatically to extract data that matches a particular set of criteria.

Another valuable types of metadata to pay attention to is the rdataclass.

```
head(unique(ah$rdataclass))
```

```
## [1] "GRanges"          "data.frame"       "Inparanoid8Db"    "TwoBitFile"       "ChainFile"
## [6] "SQLiteConnection"
```

The rdataclass allows you to see which kinds of R objects the hub will return to you. This kind of information is valuable both as a means to filter results and also as a means to explore and learn about some of the kinds of annotation objects that are widely available for the project. Right now this is a pretty short list, but over time it should grow as we support more of the different kinds of annotation objects via the hub.

Now lets try getting the Chain Files from UCSC using the query and subset methods to selectively pare down the hub based on specific criteria.
The query method lets you search rows for
specific strings, returning an `AnnotationHub` instance with just the
rows matching the query.

From the show method, one can easily see that one of the dataprovider is
UCSC and there is a rdataclass for ChainFile

One can get chain files for Drosophila melanogaster from UCSC with:

```
dm <- query(ah, c("ChainFile", "UCSC", "Drosophila melanogaster"))
dm
```

```
## AnnotationHub with 45 records
## # snapshotDate(): 2025-10-28
## # $dataprovider: UCSC
## # $species: Drosophila melanogaster
## # $rdataclass: ChainFile
## # additional mcols(): taxonomyid, genome, description, coordinate_1_based, maintainer,
## #   rdatadateadded, preparerclass, tags, rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["AH15102"]]'
##
##             title
##   AH15102 | dm3ToAnoGam1.over.chain.gz
##   AH15103 | dm3ToApiMel3.over.chain.gz
##   AH15104 | dm3ToDm2.over.chain.gz
##   AH15105 | dm3ToDm6.over.chain.gz
##   AH15106 | dm3ToDp3.over.chain.gz
##   ...       ...
##   AH15142 | dm2ToDroVir3.over.chain.gz
##   AH15143 | dm2ToDroWil1.over.chain.gz
##   AH15144 | dm2ToDroYak1.over.chain.gz
##   AH15145 | dm2ToDroYak2.over.chain.gz
##   AH15146 | dm1ToDm2.over.chain.gz
```

Query has worked and you can now see that the only species present is
Drosophila melanogaster.

The metadata underlying this hub object can be retrieved by you

```
df <- mcols(dm)
```

By default the show method will only display the first 5 and last 5 rows.
There are already thousands of records present in the hub.

```
length(ah)
```

```
## [1] 70862
```

Lets look at another example, where we pull down only Inparanoid8 data
from the hub and use subset to return a smaller base object (here we
are finding cases where the genome column is set to panda).

```
ahs <- query(ah, c('inparanoid8', 'ailuropoda'))
ahs
```

```
## AnnotationHub with 1 record
## # snapshotDate(): 2025-10-28
## # names(): AH10451
## # $dataprovider: Inparanoid8
## # $species: Ailuropoda melanoleuca
## # $rdataclass: Inparanoid8Db
## # $rdatadateadded: 2014-03-31
## # $title: hom.Ailuropoda_melanoleuca.inp8.sqlite
## # $description: Inparanoid 8 annotations about Ailuropoda melanoleuca
## # $taxonomyid: 9646
## # $genome: inparanoid8 genomes
## # $sourcetype: Inparanoid
## # $sourceurl: http://inparanoid.sbc.su.se/download/current/Orthologs/A.melanoleuca
## # $sourcesize: NA
## # $tags: c("Inparanoid", "Gene", "Homology", "Annotation")
## # retrieve record with 'object[["AH10451"]]'
```

## 1.1 Interactive retrieval of resources with BiocHubsShiny

We can perform the same query using the `BiocHubsShiny()` function from the
eponymous package. In the ‘dataprovider’ field we enter `inparanoid8` and
`ailuropoda` in the species field.

```
BiocHubsShiny::BiocHubsShiny()
```

![BiocHubsShiny query with terms dataprovider = 'inparanoid' and species = 'ailuropoda'](data:image/png;base64...)

Figure 1: BiocHubsShiny query with terms dataprovider = ‘inparanoid’ and species = ‘ailuropoda’

By default 6 entries are displayed per page, we can change this using
the drop down menu at the top of the table. We can also navigate through
different pages using the page scrolling feature at the bottom right of the
table.

We can select the rows of interest and send the metadata back to
the R session using the ‘Send metadata’ button. The resource identifiers
are located in the “HUBID” column of the metadata table (`ah_meta`) returned.

# 2 Using `AnnotationHub` to retrieve data

Looking back at our chain file example, if we are interested in the file
dm1ToDm2.over.chain.gz, we can gets its metadata using

```
dm
```

```
## AnnotationHub with 45 records
## # snapshotDate(): 2025-10-28
## # $dataprovider: UCSC
## # $species: Drosophila melanogaster
## # $rdataclass: ChainFile
## # additional mcols(): taxonomyid, genome, description, coordinate_1_based, maintainer,
## #   rdatadateadded, preparerclass, tags, rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["AH15102"]]'
##
##             title
##   AH15102 | dm3ToAnoGam1.over.chain.gz
##   AH15103 | dm3ToApiMel3.over.chain.gz
##   AH15104 | dm3ToDm2.over.chain.gz
##   AH15105 | dm3ToDm6.over.chain.gz
##   AH15106 | dm3ToDp3.over.chain.gz
##   ...       ...
##   AH15142 | dm2ToDroVir3.over.chain.gz
##   AH15143 | dm2ToDroWil1.over.chain.gz
##   AH15144 | dm2ToDroYak1.over.chain.gz
##   AH15145 | dm2ToDroYak2.over.chain.gz
##   AH15146 | dm1ToDm2.over.chain.gz
```

```
dm["AH15146"]
```

```
## AnnotationHub with 1 record
## # snapshotDate(): 2025-10-28
## # names(): AH15146
## # $dataprovider: UCSC
## # $species: Drosophila melanogaster
## # $rdataclass: ChainFile
## # $rdatadateadded: 2014-12-15
## # $title: dm1ToDm2.over.chain.gz
## # $description: UCSC liftOver chain file from dm1 to dm2
## # $taxonomyid: 7227
## # $genome: dm1
## # $sourcetype: Chain
## # $sourceurl: http://hgdownload.cse.ucsc.edu/goldenpath/dm1/liftOver/dm1ToDm2.over.chain.gz
## # $sourcesize: NA
## # $tags: c("liftOver", "chain", "UCSC", "genome", "homology")
## # retrieve record with 'object[["AH15146"]]'
```

We can download the file using

```
dm[["AH15146"]]
```

```
## loading from cache
```

```
## Chain of length 11
## names(11): chr2L chr2R chr3L chr3R chr4 chrX chrU chr2h chr3h chrXh chrYh
```

Each file is retrieved from the AnnotationHub server and the file is
also cache locally, so that the next time you need to retrieve it,
it should download much more quickly.

# 3 Configuring `AnnotationHub` objects

When you create the `AnnotationHub` object, it will set up the object
for you with some default settings. See `?AnnotationHub` for ways to
customize the hub source, the local cache, and other instance-specific
options, and `?getAnnotationHubOption` to get or set package-global
options for use across sessions.

If you look at the object you will see some helpful information about
it such as where the data is cached and where online the hub server is
set to.

```
ah
```

```
## AnnotationHub with 70862 records
## # snapshotDate(): 2025-10-28
## # $dataprovider: Ensembl, BroadInstitute, UCSC, ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/, Haemcode,...
## # $species: Homo sapiens, Mus musculus, Drosophila melanogaster, Rattus norvegicus, Bos taurus, ...
## # $rdataclass: GRanges, TwoBitFile, BigWigFile, EnsDb, Rle, OrgDb, ChainFile, TxDb, SQLiteFile, ...
## # additional mcols(): taxonomyid, genome, description, coordinate_1_based, maintainer,
## #   rdatadateadded, preparerclass, tags, rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["AH5012"]]'
##
##              title
##   AH5012   | Chromosome Band
##   AH5013   | STS Markers
##   AH5014   | FISH Clones
##   AH5015   | Recomb Rate
##   AH5016   | ENCODE Pilot
##   ...        ...
##   AH121939 | MeSHDb for Xenopus tropicalis (Tropical clawed frog, v010)
##   AH121940 | MeSHDb for Zea mays (Corn, v010)
##   AH121941 | MeSHDb for MeSH.db (v010)
##   AH121942 | MeSHDb for MeSH.AOR.db (v010)
##   AH121943 | MeSHDb for MeSH.PCR.db (v010)
```

By default the `AnnotationHub` object is set to the latest
`snapshotData` and a snapshot version that matches the version of
*Bioconductor* that you are using. You can also learn about these data
with the appropriate methods.

```
snapshotDate(ah)
```

```
## [1] "2025-10-28"
```

If you are interested in using an older version of a snapshot, you can
list previous versions with the `possibleDates()` like this:

```
pd <- possibleDates(ah)
pd
```

```
##   [1] "2013-03-19" "2013-03-21" "2013-03-26" "2013-04-04" "2013-04-29" "2013-06-24" "2013-06-25"
##   [8] "2013-06-26" "2013-06-27" "2013-10-29" "2013-11-20" "2013-12-19" "2014-02-12" "2014-02-13"
##  [15] "2014-03-31" "2014-04-27" "2014-05-11" "2014-05-13" "2014-05-14" "2014-05-22" "2014-07-02"
##  [22] "2014-07-09" "2014-12-15" "2014-12-24" "2015-01-08" "2015-01-14" "2015-03-09" "2015-03-11"
##  [29] "2015-03-12" "2015-03-25" "2015-03-26" "2015-05-06" "2015-05-07" "2015-05-08" "2015-05-11"
##  [36] "2015-05-14" "2015-05-21" "2015-05-22" "2015-05-26" "2015-07-17" "2015-07-27" "2015-07-31"
##  [43] "2015-08-10" "2015-08-13" "2015-08-14" "2015-08-17" "2015-08-26" "2015-12-28" "2015-12-29"
##  [50] "2016-01-25" "2016-03-07" "2016-05-03" "2016-05-25" "2016-06-06" "2016-07-20" "2016-08-15"
##  [57] "2016-10-11" "2016-11-03" "2016-11-08" "2016-11-09" "2016-11-13" "2016-11-14" "2016-12-22"
##  [64] "2016-12-28" "2017-01-05" "2017-02-07" "2017-04-03" "2017-04-04" "2017-04-05" "2017-04-10"
##  [71] "2017-04-11" "2017-04-13" "2017-04-24" "2017-04-25" "2017-05-31" "2017-06-06" "2017-06-07"
##  [78] "2017-06-08" "2017-06-29" "2017-08-28" "2017-08-31" "2017-09-07" "2017-10-18" "2017-10-23"
##  [85] "2017-10-24" "2017-10-27" "2017-11-24" "2017-10-26" "2017-10-20" "2017-12-21" "2018-01-18"
##  [92] "2018-02-20" "2018-04-11" "2018-04-13" "2018-04-16" "2018-04-19" "2018-04-20" "2018-04-23"
##  [99] "2018-04-30" "2018-06-27" "2018-07-31" "2018-08-01" "2018-08-20" "2018-10-04" "2018-10-11"
## [106] "2018-10-15" "2018-10-16" "2018-10-18" "2018-10-22" "2018-10-24" "2018-12-20" "2019-01-14"
## [113] "2019-02-14" "2019-02-15" "2019-04-15" "2019-04-18" "2019-04-22" "2019-04-29" "2019-05-01"
## [120] "2019-05-02" "2019-09-17" "2019-10-08" "2019-10-17" "2019-10-21" "2019-10-22" "2019-10-28"
## [127] "2019-10-29" "2020-01-28" "2020-02-28" "2020-10-14" "2020-05-01" "2020-04-27" "2020-05-11"
## [134] "2020-06-18" "2020-07-20" "2020-09-03" "2020-10-20" "2020-10-26" "2020-10-27" "2020-12-16"
## [141] "2021-01-14" "2021-02-24" "2021-04-12" "2021-04-19" "2021-04-30" "2021-05-04" "2021-05-14"
## [148] "2021-05-17" "2021-05-18" "2021-06-15" "2021-08-03" "2021-09-10" "2021-09-23" "2021-10-08"
## [155] "2021-10-13" "2021-10-15" "2021-10-18" "2021-10-20" "2022-01-20" "2022-01-31" "2022-04-12"
## [162] "2022-04-18" "2022-04-21" "2022-06-28" "2022-07-22" "2022-04-25" "2022-09-09" "2022-09-29"
## [169] "2022-09-30" "2022-10-17" "2022-10-18" "2022-10-19" "2022-10-26" "2022-10-31" "2022-10-30"
## [176] "2023-03-21" "2023-03-28" "2023-04-03" "2023-04-06" "2023-05-15" "2023-06-20" "2023-04-24"
## [183] "2023-04-25" "2023-09-27" "2023-09-29" "2023-10-03" "2023-10-05" "2023-10-19" "2023-10-20"
## [190] "2023-10-21" "2023-10-23" "2024-02-09" "2024-03-18" "2024-04-02" "2024-04-29" "2024-04-30"
## [197] "2024-08-01" "2024-09-30" "2024-10-03" "2024-10-04" "2024-10-28" "2024-12-24" "2025-01-21"
## [204] "2025-03-11" "2025-03-21" "2025-04-08" "2025-06-23" "2025-09-08" "2025-10-10" "2025-10-17"
## [211] "2025-10-28" "2025-10-28"
```

Set the dates like this:

```
snapshotDate(ah) <- pd[1]
```

# 4 AnnotationHub objects in a cluster environment

Resources in AnnotationHub aren’t loaded with the standard `R` package approach
and therefore can’t be loaded on cluster nodes with library(). There are a
couple of options to sharing AnnotationHub objects across a cluster when
researchers are using the same R install and want access to the same
annotations.

As an example, we create a TxDb object from a GRanges stored in AnnotationHub
contributed by contributed by Timothée Flutre. The GRanges was created from a
GFF file and contains gene information for Vitis vinifera.

* Download once and build on the fly

One option is that each user downloads the resource with hub[[“AH50773”]] and
the GRanges is saved in the cache. Each subsequent call to
hub[[“AH50773”]] retrieves the resource from the cache which is very fast.

The necessary code extracts the resource then calls makeTxDbFromGRanges().

```
library(AnnotationHub)
hub <- AnnotationHub()
gr <- hub[["AH50773"]]  ## downloaded once
txdb <- makeTxDbFromGRanges(gr)  ## build on the fly
```

* Build once and share

Another approach is that one user builds the TxDb and saves it as a .sqlite
file. The cluster admin installs this in a common place on all cluster nodes
and each user can load it with loadDb(). Loading the file is as quick and
easy as calling library() on a TxDb package.

Once the .sqlite file is install each user’s code would include:

```
library(AnnotationDbi)  ## if not already loaded
txdb <- loadDb("/locationToFile/mytxdb.sqlite")
```

# 5 Creating an AnnotationHub Package or Converting to an AnnotationHub Package

Please see *[HubPub](https://bioconductor.org/packages/3.22/HubPub)* Vignette “CreateAHubPackage”.

```
vignette("CreateAHubPackage", package="HubPub")
```

# 6 Troubleshooting

Please see AnnotationHub vignette “TroubleshootingTheHubs”.

```
vignette("TroubleshootingTheHubs", package="AnnotationHub")
```

# 7 Accessing Behind A Proxy

The ExperimentHub and AnnotationHub use CRAN package `httr2` functions for accessing and downloading
web resources. This can be problematic if operating behind a
proxy. You can pass proxy information for Hubs by setting the options like the following:

```
proxy <- "http://my_user:my_password@myproxy:8080"
AnnotationHub::setAnnotationHubOption("PROXY", proxy)
## or
ExperimentHub::setExperimentHubOption("PROXY", proxy)
```

Unfortunately unlike the previously used `httr::set_config`, there is no
option to globally set the proxy for httr2 requests. To get around this you can
also set a system wide environment variable “ANNOTATION\_HUB\_PROXY” for
AnnotationHub, “EXPERIMENT\_HUB\_PROXY” for ExperimentHub, or “HUB\_PROXY” that
will work across all Hub classes (e.g. AnnotationHub and ExperimentHub)}

# 8 Other configuration options for resource downloading

As mentioned previously, There is no global option like `httr::set_config` to
set configuration options when using httr2. A `config` argument may be passed to
`[[` and `cache` functions. This argument is a R list object that will be passed
to `httr2::req_options`. The names of the items should be valid curl options as
defined in `curl::curl_options`.

```
ssl_opts <- list(verbose = 1L,ssl_verifypeer = 0L, ssl_verifyhost = 0L)
```

# 9 Session info

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
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
##  [1] GenomeInfoDb_1.46.0               BSgenome.Hsapiens.UCSC.hg19_1.4.3
##  [3] BSgenome_1.78.0                   BiocIO_1.20.0
##  [5] rtracklayer_1.70.0                VariantAnnotation_1.56.0
##  [7] SummarizedExperiment_1.40.0       MatrixGenerics_1.22.0
##  [9] matrixStats_1.5.0                 Rsamtools_2.26.0
## [11] Biostrings_2.78.0                 XVector_0.50.0
## [13] txdbmaker_1.6.0                   GenomicFeatures_1.62.0
## [15] AnnotationDbi_1.72.0              Biobase_2.70.0
## [17] GenomicRanges_1.62.0              IRanges_2.44.0
## [19] Seqinfo_1.0.0                     S4Vectors_0.48.0
## [21] AnnotationHub_4.0.0               BiocFileCache_3.0.0
## [23] dbplyr_2.5.1                      BiocGenerics_0.56.0
## [25] generics_0.1.4                    BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1         dplyr_1.1.4              blob_1.2.4
##  [4] filelock_1.0.3           bitops_1.0-9             fastmap_1.2.0
##  [7] RCurl_1.98-1.17          GenomicAlignments_1.46.0 XML_3.99-0.19
## [10] digest_0.6.37            lifecycle_1.0.4          KEGGREST_1.50.0
## [13] RSQLite_2.4.3            magrittr_2.0.4           compiler_4.5.1
## [16] rlang_1.1.6              sass_0.4.10              progress_1.2.3
## [19] tools_4.5.1              yaml_2.3.10              knitr_1.50
## [22] prettyunits_1.2.0        S4Arrays_1.10.0          bit_4.6.0
## [25] curl_7.0.0               DelayedArray_0.36.0      abind_1.4-8
## [28] BiocParallel_1.44.0      withr_3.0.2              purrr_1.1.0
## [31] grid_4.5.1               biomaRt_2.66.0           cli_3.6.5
## [34] rmarkdown_2.30           crayon_1.5.3             httr_1.4.7
## [37] rjson_0.2.23             DBI_1.2.3                cachem_1.1.0
## [40] stringr_1.5.2            parallel_4.5.1           BiocManager_1.30.26
## [43] restfulr_0.0.16          vctrs_0.6.5              Matrix_1.7-4
## [46] jsonlite_2.0.0           bookdown_0.45            hms_1.1.4
## [49] bit64_4.6.0-1            jquerylib_0.1.4          glue_1.8.0
## [52] codetools_0.2-20         stringi_1.8.7            BiocVersion_3.22.0
## [55] UCSC.utils_1.6.0         tibble_3.3.0             pillar_1.11.1
## [58] rappdirs_0.3.3           htmltools_0.5.8.1        R6_2.6.1
## [61] httr2_1.2.1              evaluate_1.0.5           lattice_0.22-7
## [64] png_0.1-8                cigarillo_1.0.0          memoise_2.0.1
## [67] bslib_0.9.0              SparseArray_1.10.0       xfun_0.53
## [70] pkgconfig_2.0.3
```
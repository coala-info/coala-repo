# ExperimentHub: Access the ExperimentHub Web Service

#### 29 October 2025

# Contents

* [1 ExperimentHub objects](#experimenthub-objects)
  + [1.1 Interactive retrieval of resources with BiocHubsShiny](#interactive-retrieval-of-resources-with-biochubsshiny)
* [2 Using `ExperimentHub` to retrieve data](#using-experimenthub-to-retrieve-data)
* [3 Configuring `ExperimentHub` objects](#configuring-experimenthub-objects)
* [4 Creating an ExperimentHub Package or Converting to an ExperimentHub Package](#creating-an-experimenthub-package-or-converting-to-an-experimenthub-package)
* [5 Troubleshooting](#troubleshooting)
* [6 Accessing Behind A Proxy](#accessing-behind-a-proxy)
* [7 Other configuration options for resource downloading](#other-configuration-options-for-resource-downloading)
* [8 Group Hub/Cache Access](#group-hubcache-access)
* [9 Default Caching Location Update](#default-caching-location-update)
  + [9.1 Option 1: Move cache and files to new location](#option-1-move-cache-and-files-to-new-location)
  + [9.2 Option 2: Create a system environment variable](#option-2-create-a-system-environment-variable)
  + [9.3 Option 3: Delete the old cache](#option-3-delete-the-old-cache)
* [10 Session info](#session-info)

The `ExperimentHub` server provides easy *R / Bioconductor* access to
large files of data.

# 1 ExperimentHub objects

The *[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)* package provides a client interface
to resources stored at the ExperimentHub web service. It has similar
functionality to *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* package.

```
library(ExperimentHub)
```

The *[ExperimentHub](https://bioconductor.org/packages/3.22/ExperimentHub)* package is straightforward to use.
Create an `ExperimentHub` object

```
eh = ExperimentHub()
```

Now at this point you have already done everything you need in order
to start retrieving experiment data. For most operations, using the
`ExperimentHub` object should feel a lot like working with a familiar
`list` or `data.frame` and has all of the functionality of an `Hub`
object like *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* package’s `AnnotationHub`
object.

Lets take a minute to look at the show method for the hub object eh

```
eh
```

```
## ExperimentHub with 8991 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Eli and Edythe L. Broad Institute of Harvard and MIT, NCBI,...
## # $species: Homo sapiens, Mus musculus, Saccharomyces cerevisiae, Drosophila...
## # $rdataclass: SummarizedExperiment, data.frame, ExpressionSet, matrix, char...
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH1"]]'
##
##             title
##   EH1     | RNA-Sequencing and clinical data for 7706 tumor samples from The...
##   EH166   | ERR188297
##   EH167   | ERR188088
##   EH168   | ERR188204
##   EH169   | ERR188317
##   ...       ...
##   EH10266 | Exp2_R2_pept
##   EH10267 | Exp2_R10_prot
##   EH10268 | Exp2_R10_pept
##   EH10269 | Exp2_R100_prot
##   EH10270 | Exp2_R100_pept
```

You can see that it gives you an idea about the different types of data that are present inside the hub. You can see where the data is coming from (dataprovider), as well as what species have samples present (species), what kinds of R data objects could be returned (rdataclass). We can take a closer look at all the kinds of data providers that are available by simply looking at the contents of dataprovider as if it were the column of a data.frame object like this:

```
head(unique(eh$dataprovider))
```

```
## [1] "GEO"
## [2] "GEUVADIS"
## [3] "Allen Brain Atlas"
## [4] "ArrayExpress"
## [5] "Department of Psychology, Abdul Haq Campus, Federal Urdu University for Arts, Science and Technology, Karachi, Pakistan. shahiq_psy@yahoo.com"
## [6] "Department of Chemical and Biological Engineering, Chalmers University of Technology, SE-412 96 Gothenburg, Sweden."
```

In the same way, you can also see data from different species inside the hub by looking at the contents of species like this:

```
head(unique(eh$species))
```

```
## [1] "Homo sapiens"            "Mus musculus"
## [3] "Mus musculus (E18 mice)" NA
## [5] "Rattus norvegicus"       "human gut metagenome"
```

And this will also work for any of the other types of metadata present. You can learn which kinds of metadata are available by simply hitting the tab key after you type ‘eh$’. In this way you can explore for yourself what kinds of data are present in the hub right from the command line. This interface also allows you to access the hub programmatically to extract data that matches a particular set of criteria.

Another valuable types of metadata to pay attention to is the rdataclass.

```
head(unique(eh$rdataclass))
```

```
## [1] "ExpressionSet"              "GAlignmentPairs"
## [3] "CellMapperList"             "gds.class"
## [5] "RangedSummarizedExperiment" "GRanges"
```

The rdataclass allows you to see which kinds of R objects the hub will return to you. This kind of information is valuable both as a means to filter results and also as a means to explore and learn about some of the kinds of `ExperimentHub` objects that are widely available for the project. Right now this is a pretty short list, but over time it should grow as we support more of the different kinds of `ExperimentHub` objects via the hub.

Now let’s try getting the data files associated with the `r Biocpkg("alpineData")` package using the query method. The query method lets you
search rows for specific strings, returning an `ExperimentHub` instance with
just the rows matching the query. The `ExperimentHub::package()` function
indicates the package responsible for original preparation and documentation of
the ExperimentHub data, and is a useful resource to find out more about the
data. This package may also depend, import or suggest other packages required
for manipulating the data, and for this reason the package may need to be
installed and loaded to use the resource. The package is also available in the
(cryptically named) `preparerclass` column of the metadata of the ExperimentHub
object.

One can get chain files for Drosophila melanogaster from UCSC with:

```
apData <- query(eh, "alpineData")
apData
```

```
## ExperimentHub with 4 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: GEUVADIS
## # $species: Homo sapiens
## # $rdataclass: GAlignmentPairs
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH166"]]'
##
##           title
##   EH166 | ERR188297
##   EH167 | ERR188088
##   EH168 | ERR188204
##   EH169 | ERR188317
```

Query has worked and you can now see that the only data present is provided by
the *[alpineData](https://bioconductor.org/packages/3.22/alpineData)* package.

The metadata underlying this hub object can be retrieved by you

```
apData$preparerclass
```

```
## [1] "alpineData" "alpineData" "alpineData" "alpineData"
```

```
df <- mcols(apData)
```

By default the show method will only display the first 5 and last 5 rows.
There are hundreds of records present in the hub.

```
length(eh)
```

```
## [1] 8991
```

Let’s look at another example, where we pull down only data
from the hub for species “mus musculus”.

```
mm <- query(eh, "mus musculus")
mm
```

```
## ExperimentHub with 1729 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Jonathan Griffiths, The Tabula Muris Consortium, GEO, mulea...
## # $species: Mus musculus, Mus musculus (E18 mice)
## # $rdataclass: character, matrix, data.frame, DFrame, SummarizedExperiment, ...
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH173"]]'
##
##            title
##   EH173  | Pre-processed microarray data from the Affymetrix MG-U74Av2 plat...
##   EH552  | st100k
##   EH553  | st400k
##   EH557  | tasicST6
##   EH1039 | Brain scRNA-seq data, 'HDF5-based 10X Genomics' format
##   ...      ...
##   EH9898 | SE_Mukherjee_2019_InVivo_GSE114142_GPL11202
##   EH9899 | SE_Amundson_2018_InVivo_GSE101402_GPL11202
##   EH9900 | SE_Amundson_2018_InVivo_GSE99176_GPL11202
##   EH9901 | SE_Paul_2015_InVivo_GSE62623_GPL10333
##   EH9903 | SE_Broustas_2021_InVivo_GSE133451_GPL11202
```

## 1.1 Interactive retrieval of resources with BiocHubsShiny

We can perform the same query using the `BiocHubsShiny()` function from the
eponymous package. In the ‘species’ field we can enter `musculus` as the
search term.

```
BiocHubsShiny::BiocHubsShiny()
```

![BiocHubsShiny query with species term 'musculus'](data:image/png;base64...)

Figure 1: BiocHubsShiny query with species term ‘musculus’

# 2 Using `ExperimentHub` to retrieve data

Looking back at our alpineData file example, if we are interested in the first file, we can get its metadata using

```
apData
```

```
## ExperimentHub with 4 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: GEUVADIS
## # $species: Homo sapiens
## # $rdataclass: GAlignmentPairs
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH166"]]'
##
##           title
##   EH166 | ERR188297
##   EH167 | ERR188088
##   EH168 | ERR188204
##   EH169 | ERR188317
```

```
apData["EH166"]
```

```
## ExperimentHub with 1 record
## # snapshotDate(): 2025-10-29
## # names(): EH166
## # package(): alpineData
## # $dataprovider: GEUVADIS
## # $species: Homo sapiens
## # $rdataclass: GAlignmentPairs
## # $rdatadateadded: 2016-07-21
## # $title: ERR188297
## # $description: Subset of aligned reads from sample ERR188297
## # $taxonomyid: 9606
## # $genome: GRCh38
## # $sourcetype: FASTQ
## # $sourceurl: ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR188/ERR188297/ERR188297_...
## # $sourcesize: NA
## # $tags: c("Sequencing", "RNASeq", "GeneExpression", "Transcription")
## # retrieve record with 'object[["EH166"]]'
```

We can download the file using

```
apData[["EH166"]]
```

```
## alpineData not installed.
##   Full functionality, documentation, and loading of data might not be possible without installing
```

```
## loading from cache
```

```
## require("GenomicAlignments")
```

```
## GAlignmentPairs object with 25531 pairs, strandMode=1, and 0 metadata columns:
##           seqnames strand   :              ranges  --              ranges
##              <Rle>  <Rle>   :           <IRanges>  --           <IRanges>
##       [1]        1      +   : 108560389-108560463  -- 108560454-108560528
##       [2]        1      -   : 108560454-108560528  -- 108560383-108560457
##       [3]        1      +   : 108560534-108600608  -- 108600626-108606236
##       [4]        1      -   : 108569920-108569994  -- 108569825-108569899
##       [5]        1      -   : 108587954-108588028  -- 108587881-108587955
##       ...      ...    ... ...                 ... ...                 ...
##   [25527]        X      +   : 119790596-119790670  -- 119790717-119790791
##   [25528]        X      +   : 119790988-119791062  -- 119791086-119791160
##   [25529]        X      +   : 119791037-119791111  -- 119791142-119791216
##   [25530]        X      +   : 119791348-119791422  -- 119791475-119791549
##   [25531]        X      +   : 119791376-119791450  -- 119791481-119791555
##   -------
##   seqinfo: 194 sequences from an unspecified genome
```

Each file is retrieved from the ExperimentHub server and the file is
also cached locally, so that the next time you need to retrieve it,
it should download much more quickly.

# 3 Configuring `ExperimentHub` objects

When you create the `ExperimentHub` object, it will set up the object
for you with some default settings. See `?ExperimentHub` for ways to
customize the hub source, the local cache, and other instance-specific
options, and `?getExperimentHubOption` to get or set package-global
options for use across sessions.

If you look at the object you will see some helpful information about
it such as where the data is cached and where online the hub server is
set to.

```
eh
```

```
## ExperimentHub with 8991 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: Eli and Edythe L. Broad Institute of Harvard and MIT, NCBI,...
## # $species: Homo sapiens, Mus musculus, Saccharomyces cerevisiae, Drosophila...
## # $rdataclass: SummarizedExperiment, data.frame, ExpressionSet, matrix, char...
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH1"]]'
##
##             title
##   EH1     | RNA-Sequencing and clinical data for 7706 tumor samples from The...
##   EH166   | ERR188297
##   EH167   | ERR188088
##   EH168   | ERR188204
##   EH169   | ERR188317
##   ...       ...
##   EH10266 | Exp2_R2_pept
##   EH10267 | Exp2_R10_prot
##   EH10268 | Exp2_R10_pept
##   EH10269 | Exp2_R100_prot
##   EH10270 | Exp2_R100_pept
```

By default the `ExperimentHub` object is set to the latest
`snapshotData` and a snapshot version that matches the version of
*Bioconductor* that you are using. You can also learn about these data
with the appropriate methods.

```
snapshotDate(eh)
```

```
## [1] "2025-10-29"
```

If you are interested in using an older version of a snapshot, you can
list previous versions with the `possibleDates()` like this:

```
pd <- possibleDates(eh)
pd
```

```
##   [1] "2016-02-23" "2016-06-07" "2016-07-14" "2016-07-21" "2016-08-08"
##   [6] "2016-10-01" "2017-06-09" "2017-08-25" "2017-10-06" "2017-10-10"
##  [11] "2017-10-12" "2017-10-16" "2017-10-19" "2017-10-26" "2017-10-30"
##  [16] "2017-10-29" "2018-01-08" "2018-02-02" "2018-02-09" "2018-02-22"
##  [21] "2018-03-16" "2018-03-30" "2018-04-02" "2018-04-10" "2018-04-20"
##  [26] "2018-04-25" "2018-04-26" "2018-04-27" "2018-05-02" "2018-05-08"
##  [31] "2018-06-29" "2018-07-30" "2018-08-02" "2018-08-03" "2018-08-27"
##  [36] "2018-08-29" "2018-09-07" "2018-09-11" "2018-09-19" "2018-09-20"
##  [41] "2018-10-30" "2018-11-02" "2018-11-05" "2018-11-13" "2018-12-12"
##  [46] "2018-12-13" "2018-12-19" "2018-12-20" "2019-01-02" "2019-01-09"
##  [51] "2019-01-15" "2019-01-25" "2019-03-21" "2019-04-01" "2019-04-15"
##  [56] "2019-04-23" "2019-04-25" "2019-04-26" "2019-04-29" "2019-05-28"
##  [61] "2019-05-29" "2019-06-11" "2019-06-20" "2019-06-28" "2019-07-01"
##  [66] "2019-07-02" "2019-07-10" "2019-08-01" "2019-08-02" "2019-08-06"
##  [71] "2019-08-07" "2019-08-13" "2019-09-04" "2019-09-09" "2019-09-11"
##  [76] "2019-09-25" "2019-10-17" "2019-10-18" "2019-10-22" "2019-12-17"
##  [81] "2019-12-27" "2020-01-08" "2020-02-11" "2020-02-12" "2020-03-09"
##  [86] "2020-03-12" "2020-04-03" "2020-04-27" "2020-05-11" "2020-05-14"
##  [91] "2020-05-19" "2020-05-29" "2020-06-11" "2020-06-26" "2020-07-02"
##  [96] "2020-07-10" "2020-07-29" "2020-08-03" "2020-08-04" "2020-08-05"
## [101] "2020-08-17" "2020-08-24" "2020-08-26" "2020-08-31" "2020-09-03"
## [106] "2020-09-04" "2020-09-08" "2020-09-09" "2020-09-10" "2020-09-14"
## [111] "2020-09-23" "2020-09-24" "2020-10-02" "2020-10-30" "2020-11-05"
## [116] "2020-11-18" "2020-11-25" "2020-12-02" "2020-12-03" "2020-12-07"
## [121] "2020-12-09" "2020-12-14" "2021-01-04" "2020-10-27" "2021-01-12"
## [126] "2021-01-19" "2021-01-20" "2021-01-27" "2021-01-28" "2021-02-08"
## [131] "2021-02-11" "2021-02-19" "2021-03-02" "2021-03-04" "2021-03-10"
## [136] "2021-03-18" "2021-03-22" "2021-03-23" "2021-03-24" "2021-03-30"
## [141] "2021-04-06" "2021-04-08" "2021-04-27" "2021-05-04" "2021-05-05"
## [146] "2021-05-18" "2021-06-14" "2021-06-16" "2021-06-21" "2021-07-15"
## [151] "2021-07-16" "2021-07-27" "2021-07-30" "2021-08-03" "2021-08-09"
## [156] "2021-04-26" "2021-08-18" "2021-08-26" "2021-08-27" "2021-09-13"
## [161] "2021-09-23" "2021-09-24" "2021-10-05" "2021-10-06" "2021-10-15"
## [166] "2021-10-18" "2021-10-19" "2021-11-24" "2022-01-04" "2022-01-20"
## [171] "2022-02-15" "2022-02-22" "2022-02-28" "2022-03-01" "2022-03-16"
## [176] "2022-03-29" "2022-04-04" "2022-04-06" "2022-04-19" "2022-04-26"
## [181] "2022-05-17" "2022-06-15" "2022-06-29" "2022-07-08" "2022-07-15"
## [186] "2022-07-22" "2022-08-16" "2022-08-23" "2022-10-03" "2022-10-17"
## [191] "2022-10-24" "2022-10-31" "2022-12-13" "2022-12-16" "2023-01-04"
## [196] "2023-01-13" "2023-01-20" "2023-01-30" "2023-02-08" "2023-02-14"
## [201] "2023-03-13" "2023-03-21" "2023-03-29" "2023-04-04" "2023-04-11"
## [206] "2023-04-12" "2023-04-13" "2023-04-24" "2023-05-15" "2023-05-17"
## [211] "2023-06-01" "2023-06-20" "2023-07-03" "2023-07-05" "2023-07-18"
## [216] "2023-07-21" "2023-08-02" "2023-08-22" "2023-08-28" "2023-09-18"
## [221] "2023-09-21" "2023-09-26" "2023-09-29" "2023-10-03" "2023-10-06"
## [226] "2023-10-13" "2023-10-24" "2023-11-14" "2023-12-13" "2024-01-11"
## [231] "2024-01-12" "2024-01-16" "2024-02-02" "2023-10-20" "2024-02-07"
## [236] "2024-02-12" "2024-02-15" "2024-02-22" "2024-02-26" "2024-03-05"
## [241] "2024-03-07" "2024-03-08" "2024-04-02" "2024-04-08" "2024-04-11"
## [246] "2024-04-19" "2024-04-29" "2024-05-28" "2024-06-11" "2024-08-01"
## [251] "2024-08-22" "2024-08-27" "2024-09-13" "2024-09-23" "2024-10-03"
## [256] "2024-10-24" "2024-11-13" "2024-12-13" "2024-12-19" "2025-02-19"
## [261] "2025-02-28" "2025-03-06" "2025-03-17" "2025-03-24" "2025-04-03"
## [266] "2025-04-10" "2025-04-11" "2025-04-12" "2025-06-23" "2025-07-01"
## [271] "2025-07-17" "2025-09-22" "2025-10-07" "2025-10-29"
```

Set the dates like this:

```
snapshotDate(ah) <- pd[1]
```

# 4 Creating an ExperimentHub Package or Converting to an ExperimentHub Package

Please see *[HubPub](https://bioconductor.org/packages/3.22/HubPub)* Vignette “CreateAHubPackage”.

```
vignette("CreateAHubPackage", package="HubPub")
```

# 5 Troubleshooting

Please see *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* vignette “TroubleshootingTheHubs”.

```
vignette("TroubleshootingTheHubs", package="AnnotationHub")
```

# 6 Accessing Behind A Proxy

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

# 7 Other configuration options for resource downloading

As mentioned previously, There is no global option like `httr::set_config` to
set configuration options when using httr2. A `config` argument may be passed to
`[[` and `cache` functions. This argument is a R list object that will be passed
to `httr2::req_options`. The names of the items should be valid curl options as
defined in `curl::curl_options`.

```
ssl_opts <- list(verbose = 1L,ssl_verifypeer = 0L, ssl_verifyhost = 0L)
```

# 8 Group Hub/Cache Access

The situation may occur where a hub is desired to be shared across multiple
users on a system. This presents permissions errors. To allow access to
multiple users create a group that the users belong to and that the underlying
hub cache belongs too. Permissions of potentially two files need to be altered depending
on what you would like individuals to be able to accomplish with the hub. A
read-only hub will require manual manipulatios of the file
BiocFileCache.sqlite.LOCK so that the group permissions are `g+rw`. To allow
users to download files to the shared hub, both the
BiocFileCache.sqlite.LOCK file and the BiocFileCache.sqlite file will need group
permissions to `g+rw`. Please google how to create a user group for your system
of interest. To find the location of the hub cache to be able to change the group
and file permissions, you may run the following in R `eh = ExperimentHub(); hubCache(eh)`. For quick reference in linux you will use `chown currentuser:newgroup` to change the group and `chmod` to change the file
permissions: `chmod 660` or `chmod g+rw` should accomplish the correct
permissions.

# 9 Default Caching Location Update

As of ExperimentHub version > 1.17.2, the default caching location has
changed. The default cache is now controlled by the function `tools::R_user_dir`
instead of `rappdirs::user_cache_dir`. Users who have utilized the default
ExperimentHub location, to continue using the created cache, must move the cache and its
files to the new default location, create a system environment variable to
point to the old location, or delete and start a new cache.

## 9.1 Option 1: Move cache and files to new location

The following steps can be used to move the files to the new location:

1. Determine the old location by running the following in R
   `rappdirs::user_cache_dir(appname="ExperimentHub")`
2. Determine the new location by running the following in R
   `tools::R_user_dir("ExperimentHub", which="cache")`
3. Move the files to the new location. You can do this manually or do the
   following steps in R. Remember if you have a lot of cached files, this may take
   awhile.

```
       # make sure you have permissions on the cache/files
       # use at own risk

       moveFiles<-function(package){
       olddir <- path.expand(rappdirs::user_cache_dir(appname=package))
       newdir <- tools::R_user_dir(package, which="cache")
       dir.create(path=newdir, recursive=TRUE)
       files <- list.files(olddir, full.names =TRUE)
       moveres <- vapply(files,
           FUN=function(fl){
           filename = basename(fl)
           newname = file.path(newdir, filename)
           file.rename(fl, newname)
           },
           FUN.VALUE = logical(1))
       if(all(moveres)) unlink(olddir, recursive=TRUE)
       }

       package="ExperimentHub"
       moveFiles(package)
```

## 9.2 Option 2: Create a system environment variable

A user may set the system environment variable `EXPERIMENT_HUB_CACHE` to control
the default location of the cache. Setting system environment variables can vary
depending on the operating system; we suggest using google to find appropriate
instructions per your operating system.

You will want to set the variable to the results of running the following in R:

```
path.expand(rappdirs::user_cache_dir(appname="ExperimentHub"))
```

**NOTE:** R has `Sys.setenv` however that will only set the variable for that R
session. It would not be available or recognized in future R sessions. It is
important to set the variable as a global user-wide or system-wide
environment variable so it persists in all future logins to your system.

## 9.3 Option 3: Delete the old cache

Lastly, if a user does not care about the already existing default cache, the
old location may be deleted to move forward with the new default location. This
option should be used with caution. Once deleted, old cached resources will no
longer be available and have to be re-downloaded.

One can do this manually by navigating to the location indicated in the ERROR
message as `Problematic cache:` and deleting the folder and all its content.

The following can be done to delete through R code:

**CAUTION** This will remove the old cache and all downloaded resources. All
resources will have to be re-downloaded after executing this code.

```
library(ExperimentHub)
oldcache = path.expand(rappdirs::user_cache_dir(appname="ExperimentHub"))
setExperimentHubOption("CACHE", oldcache)
eh = ExperimentHub(localHub=TRUE)

## removes old location and all resources
removeCache(eh, ask=FALSE)

## create the new default caching location
newcache = tools::R_user_dir("ExperimentHub", which="cache")
setExperimentHubOption("CACHE", newcache)
eh = ExperimentHub()
```

# 10 Session info

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
##  [1] GenomicAlignments_1.46.0    Rsamtools_2.26.0
##  [3] Biostrings_2.78.0           XVector_0.50.0
##  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [7] MatrixGenerics_1.22.0       matrixStats_1.5.0
##  [9] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [11] IRanges_2.44.0              S4Vectors_0.48.0
## [13] ExperimentHub_3.0.0         AnnotationHub_4.0.0
## [15] BiocFileCache_3.0.0         dbplyr_2.5.1
## [17] BiocGenerics_0.56.0         generics_0.1.4
## [19] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0      xfun_0.53            bslib_0.9.0
##  [4] httr2_1.2.1          lattice_0.22-7       bitops_1.0-9
##  [7] vctrs_0.6.5          tools_4.5.1          parallel_4.5.1
## [10] curl_7.0.0           tibble_3.3.0         AnnotationDbi_1.72.0
## [13] RSQLite_2.4.3        blob_1.2.4           pkgconfig_2.0.3
## [16] Matrix_1.7-4         cigarillo_1.0.0      lifecycle_1.0.4
## [19] compiler_4.5.1       codetools_0.2-20     htmltools_0.5.8.1
## [22] sass_0.4.10          yaml_2.3.10          pillar_1.11.1
## [25] crayon_1.5.3         jquerylib_0.1.4      BiocParallel_1.44.0
## [28] DelayedArray_0.36.0  cachem_1.1.0         abind_1.4-8
## [31] tidyselect_1.2.1     digest_0.6.37        dplyr_1.1.4
## [34] purrr_1.1.0          bookdown_0.45        BiocVersion_3.22.0
## [37] grid_4.5.1           fastmap_1.2.0        SparseArray_1.10.0
## [40] cli_3.6.5            magrittr_2.0.4       S4Arrays_1.10.0
## [43] withr_3.0.2          filelock_1.0.3       rappdirs_0.3.3
## [46] bit64_4.6.0-1        rmarkdown_2.30       httr_1.4.7
## [49] bit_4.6.0            png_0.1-8            memoise_2.0.1
## [52] evaluate_1.0.5       knitr_1.50           rlang_1.1.6
## [55] glue_1.8.0           DBI_1.2.3            BiocManager_1.30.26
## [58] jsonlite_2.0.0       R6_2.6.1
```
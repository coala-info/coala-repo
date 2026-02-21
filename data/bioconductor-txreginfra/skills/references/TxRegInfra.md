# TxRegInfra: support for TxRegQuery

Vincent J. Carey, stvjc at channing.harvard.edu

#### *March 08, 2019*

# Contents

* [1 Introduction](#introduction)
* [2 Managing bed file content with mongodb](#managing-bed-file-content-with-mongodb)
  + [2.1 Querying the `txregnet` database](#querying-the-txregnet-database)
    - [2.1.1 The connection](#the-connection)
    - [2.1.2 Queries and aggregation](#queries-and-aggregation)
* [3 An integrative container](#an-integrative-container)
  + [3.1 Sample metadata](#sample-metadata)
  + [3.2 Extended RaggedExperiment](#extended-raggedexperiment)
* [4 Visualizing coincidence](#visualizing-coincidence)

# 1 Introduction

TxRegQuery addresses exploration of transcriptional regulatory networks
by integrating data on eQTL, digital genomic footprinting (DGF), DnaseI
hypersensitivity binding data (DHS), and transcription
factor binding site (TFBS) data. Owing to the volume of emerging tissue-specific
data, special data modalities are used.

# 2 Managing bed file content with mongodb

## 2.1 Querying the `txregnet` database

We have a long-running server that will respond to queries.
We focus on *[mongolite](https://CRAN.R-project.org/package%3Dmongolite)* as the interface.

### 2.1.1 The connection

```
suppressPackageStartupMessages({
library(TxRegInfra)
library(mongolite)
library(Gviz)
library(EnsDb.Hsapiens.v75)
library(BiocParallel)
register(SerialParam())
})
con1 = mongo(url=URL_txregInAWS(), db="txregnet")
con1
```

```
## <Mongo collection> 'test'
##  $aggregate(pipeline = "{}", options = "{\"allowDiskUse\":true}", handler = NULL, pagesize = 1000, iterate = FALSE)
##  $count(query = "{}")
##  $disconnect(gc = TRUE)
##  $distinct(key, query = "{}")
##  $drop()
##  $export(con = stdout(), bson = FALSE, query = "{}", fields = "{}", sort = "{\"_id\":1}")
##  $find(query = "{}", fields = "{\"_id\":0}", sort = "{}", skip = 0, limit = 0, handler = NULL, pagesize = 1000)
##  $import(con, bson = FALSE)
##  $index(add = NULL, remove = NULL)
##  $info()
##  $insert(data, pagesize = 1000, stop_on_error = TRUE, ...)
##  $iterate(query = "{}", fields = "{\"_id\":0}", sort = "{}", skip = 0, limit = 0)
##  $mapreduce(map, reduce, query = "{}", sort = "{}", limit = 0, out = NULL, scope = NULL)
##  $remove(query, just_one = FALSE)
##  $rename(name, db = NULL)
##  $replace(query, update = "{}", upsert = FALSE)
##  $run(command = "{\"ping\": 1}", simplify = TRUE)
##  $update(query, update = "{\"$set\":{}}", filters = NULL, upsert = FALSE, multiple = FALSE)
```

We will write methods that work with the ‘fields’ of this object.

There is not much explicit reflectance in the mongolite API.
The following is improvised and may be fragile:

```
parent.env(con1)$orig
```

```
## $name
## [1] "test"
##
## $db
## [1] "txregnet"
##
## $url
## [1] "mongodb+srv://user:user123@txregnet-kui9i.mongodb.net/txregnet"
##
## $options
## List of 6
##  $ pem_file              : NULL
##  $ ca_file               : NULL
##  $ ca_dir                : NULL
##  $ crl_file              : NULL
##  $ allow_invalid_hostname: logi FALSE
##  $ weak_cert_validation  : logi FALSE
```

### 2.1.2 Queries and aggregation

If the `mongo`
utility is available as a system
command, we can get a list of collections in the database
as follows.

```
if (verifyHasMongoCmd()) {
  head(c1 <- listAllCollections(url=URL_txregInAWS(), db="txregnet"))
  }
```

```
## Error in system2(cmd, args = "--help", stdout = TRUE, stderr = TRUE) :
##   error in running command
```

```
## install mongodb on your system to use this function
```

Otherwise, as long as *[mongolite](https://CRAN.R-project.org/package%3Dmongolite)* is installed,
as long as we know the collection names of interest, we
can use them as noted throughout this vignette.

We can get a record from a given collection:

```
mongo(url=URL_txregInAWS(), db="txregnet",
   collection="Adipose_Subcutaneous_allpairs_v7_eQTL")$find(limit=1)
```

```
##             gene_id       variant_id tss_distance ma_samples ma_count
## 1 ENSG00000233750.3 1_772755_A_C_b37       641730        112      129
##        maf pval_nominal    slope  slope_se     qvalue chr snp_pos A1 A2
## 1 0.169291    0.0012761 -0.27686 0.0851785 0.07468878   1  772755  A  C
##   build
## 1   b37
```

Queries can be composed using JSON. We have a tool
to generate queries that employ the mongodb aggregation
method. Here we demonstrate this by computing, for each
chromosome, the count and
minimum values of the footprint statistic on CD14 cells.

```
m1 = mongo(url = URL_txregInAWS(), db = "txregnet",  collection="CD14_DS17215_hg19_FP")
newagg = makeAggregator( by="chr", vbl="stat", op="$min", opname="min")
```

The JSON layout of this aggregating query is

```
[
  {
    "$group": {
      "_id": ["$chr"],
      "count": {
        "$sum": [1]
      },
      "min": {
        "$min": ["$stat"]
      }
    }
  }
]
```

Invocation returns a data frame:

```
head(m1$aggregate(newagg))
```

```
##     _id count        min
## 1  chrY   827 0.01907390
## 2 chr18 15868 0.06107950
## 3 chr10 40267 0.00601357
## 4  chr4 32947 0.02776440
## 5  chr6 54728 0.00565057
## 6 chr17 47987 0.01242310
```

# 3 An integrative container

We need to bind the metadata and information about the mongodb.

## 3.1 Sample metadata

The following turns a very ad hoc filtering of the collection names
into a DataFrame.

```
# cd = makeColData() # works when mongo does
cd = TxRegInfra::basicColData
head(cd,2)
```

```
## DataFrame with 2 rows and 3 columns
##                                              base        type
##                                       <character> <character>
## Adipose_Subcutaneous_allpairs_v7_eQTL     Adipose        eQTL
## CD14_DS17215_hg19_FP                         CD14          FP
##                                                            mid
##                                                    <character>
## Adipose_Subcutaneous_allpairs_v7_eQTL Subcutaneous_allpairs_v7
## CD14_DS17215_hg19_FP                              DS17215_hg19
```

## 3.2 Extended RaggedExperiment

```
rme0 = RaggedMongoExpt(con1, colData=cd)
rme1 = rme0[, which(cd$type=="FP")]
```

A key method in development is subsetting the archive by genomic coordinates.

```
s1 = sbov(rme1, GRanges("chr17", IRanges(38.07e6,38.09e6)))
```

```
## ..........................................
```

```
s1
```

```
## class: RaggedExperiment
## dim: 1676 42
## assays(3): chr id stat
## rownames: NULL
## colnames(42): CD14_DS17215_hg19_FP CD19_DS17186_hg19_FP ...
##   iPS_19_11_DS15153_hg19_FP vHMEC_DS18406_hg19_FP
## colData names(3): base type mid
```

```
dim(sa <- sparseAssay(s1, 3))  # compact gives segfault
```

```
## [1] 1676   42
```

```
sa[953:956,c("fLung_DS14724_hg19_FP", "fMuscle_arm_DS17765_hg19_FP")]
```

```
##                         fLung_DS14724_hg19_FP fMuscle_arm_DS17765_hg19_FP
## chr17:38084160-38084169              0.533333                          NA
## chr17:38084924-38084952              0.890476                          NA
## chr17:38080857-38080891                    NA                     0.54902
## chr17:38081914-38081926                    NA                     0.50000
```

# 4 Visualizing coincidence

```
ormm = txmodels("ORMDL3", plot=FALSE, name="ORMDL3")
sar = strsplit(rownames(sa), ":|-")
an = as.numeric
gr = GRanges(seqnames(ormm)[1], IRanges(an(sapply(sar,"[", 2)), an(sapply(sar,"[", 3))))
gr1 = gr
gr1$score = 1-sa[,1]
gr2 = gr
gr2$score = 1-sa[,2]
sc1 = DataTrack(gr1, name="Lung FP")
sc2 = DataTrack(gr2, name="Musc/Arm FP")
plotTracks(list(GenomeAxisTrack(), sc1, sc2, ormm), showId=TRUE)
```

![](data:image/png;base64...)
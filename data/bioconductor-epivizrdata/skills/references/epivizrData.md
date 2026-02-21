# `epivizrData` Usage

Héctor Corrada Bravo

#### 2025-10-29

# Contents

* [0.0.1 Usage](#usage)

The *[epivizrData](https://bioconductor.org/packages/3.22/epivizrData)* packages includes methods supporting serving data for visualization applications of data from R/Bioconductor objects. It is primarily used to serve data from interactive R/Bioconductor sessions to the epiviz JS application <http://epiviz.github.io>. These functions have been extracted from the *[epivizr](https://bioconductor.org/packages/3.22/epivizr)* into its own package for easier use and maintenance.

It is designed to receive and send requests through WebSocket connections provided by the *[epivizrServer](https://bioconductor.org/packages/3.22/epivizrServer)*.

### 0.0.1 Usage

The general pattern to use this package is to create an `EpivizDataMgr` object using the `createMgr` function. Once the manager is created, data objects, which provide *measurements* to a visualization application can be added using the `add_measurements` method.

```
library(epivizrData)
library(GenomicRanges)

server <- epivizrServer::createServer(port=7123L)
data_mgr <- epivizrData::createMgr(server)

## add measurements from a GRanges object
gr <- GRanges("chr10", IRanges(start=1:1000, width=100), score=rnorm(1000))
data_mgr$add_measurements(gr, "example_gr", type="bp", columns="score")
```

```
## EpivizBpData object example_gr_1
## GNCList object with 1000 ranges and 1 metadata column:
##          seqnames    ranges strand |     score
##             <Rle> <IRanges>  <Rle> | <numeric>
##      [1]    chr10     1-100      * | 1.8068549
##      [2]    chr10     2-101      * | 1.2403536
##      [3]    chr10     3-102      * | 1.0134872
##      [4]    chr10     4-103      * | 0.0927176
##      [5]    chr10     5-104      * | 1.2103423
##      ...      ...       ...    ... .       ...
##    [996]    chr10  996-1095      * |  1.263098
##    [997]    chr10  997-1096      * | -1.143480
##    [998]    chr10  998-1097      * | -0.171439
##    [999]    chr10  999-1098      * | -0.422742
##   [1000]    chr10 1000-1099      * |  0.663593
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
##  columns: score
##  limits:
##      [,1]
## [1,]   -4
## [2,]    3
```

See `?epivizrData::register` for supported object types and options when adding data. For details on usage within the epiviz visualization app see the *[epivizr](https://bioconductor.org/packages/3.22/epivizr)* package vignette.
# Creating example MinION summary dataset

Mike L. Smith

#### 4 November 2025

# Contents

* [1 Introduction](#introduction)
* [2 Data processing](#data-processing)
* [References](#references)

# 1 Introduction

This document describes the steps take to produce the three `Fast5Summary` objects stored within this package. The data were original published by Ashton *et al* (Ashton et al. [2015](#ref-ashton2015minion)), which can be viewed here: <http://www.nature.com/nbt/journal/v33/n3/full/nbt.3103.html>

# 2 Data processing

First we browse to the folder we’re going to work in. All paths given in the rest of this document are relative to this location. If you’re attempting to recreate these step, this should obviously be set to a location on your computer. The raw FAST5 data occupy approximately 50GB of disk space.

```
setwd('/media/Storage/Work/MinION/')
```

The data are available from the ENA. The sets of FAST5 files are available as tar archives, which we download here:

```
download.file(url='ftp://ftp.sra.ebi.ac.uk/vol1/ERA375/ERA375987/oxfordnanopore_native/H566_30_min_inc.tar.gz',
              destfile = 'typhi.rep1.tar.gz')
download.file(url='ftp://ftp.sra.ebi.ac.uk/vol1/ERA375/ERA375685/oxfordnanopore_native/H566_ON_inc.tar.gz',
              destfile = 'typhi.rep2.tar.gz')
download.file(url='ftp://ftp.sra.ebi.ac.uk/vol1/ERA376/ERA376255/oxfordnanopore_native/raw_2_rabsch_R7.tar.gz',
              destfile = 'typhi.rep3.tar.gz')
```

The three tar files all have different internal structures, but for the most part can be treated similarly. In this case the files split into seperate directories for each channel. In addtion to the FAST5 files, they also contain a log file for each read containing the and hidden files created during compression. Since this log information is already stored withing the FAST5 file, and we aren’t interested in the hidden files, we select to extract only the files with extension ‘*.fast5*’ that don’t start with a period ‘.’. We use the argument `tar = 'internal'` as the external tar application doesn’t seem to cope with being given list of files to extract of this length.

```
files.1 <- untar('typhi.rep1.tar.gz', list = TRUE)
extract.1 <- grep(pattern = "/FMH.*\\.fast5", files.1)
untar('typhi.rep1.tar.gz', files = files.1[extract.1], tar='internal', exdir = 'typhi.rep1')
```

The second replicate contains all FAST5 files in the top level of the archive, but can be treated in the same way as before.

```
files.2 <- untar('typhi.rep2.tar.gz', list = TRUE)
extract.2 <- grep(pattern = "/FMH.*\\.fast5", files.2)
untar('typhi.rep2.tar.gz', files = files.2[extract.2], tar='internal', exdir = 'typhi.rep2')
```

The third replicate actually contains the data in triplicate. Within the archve, the FAST5 files are present both in seperate folders per channel (*data\_by\_channel*) and in one large folder (*downloads*). There is also a seperate 7zip compressed version of the downloads folder. Here we extract only the files split into individual channels.

```
untar('typhi.rep3.tar.gz', files = 'raw_2_rabsch_R7/data_by_channel/', exdir = 'typhi.rep3')
```

Having extracted the files we create three vectors containing the paths to the extracted FAST5 files for each replicate.

```
fast5.1 <- list.files(path = "typhi.rep1", pattern = "*.fast5$",
                      full.names = TRUE, recursive = TRUE)
fast5.2 <- list.files(path = "typhi.rep2", pattern = "*.fast5$",
                      full.names = TRUE, recursive = TRUE)
fast5.3 <- list.files(path = "typhi.rep3", pattern = "*.fast5$",
                      full.names = TRUE, recursive = TRUE)
```

We can load the `IONiseR` package and read the data using the function `readFast5Summary()`.

```
library(IONiseR)
s.typhi.rep1 <- readFast5Summary(files = fast5.1)
s.typhi.rep2 <- readFast5Summary(files = fast5.2)
s.typhi.rep3 <- readFast5Summary(files = fast5.3)
```

We now to some processing to make this data more closely represent those currently produced by the Metrichor basecaller. This now categories fast5 files as either PASS or FAIL, with a passing read being defined as having both strands successfully read and a mean base quality for the 2D read greater than 9. This was no part of the workflow when the data used in this package where generated. However, several of the functions in `IONiseR` make use of this information, so we use the following function to add it manually.

```
addPassFail <- function(summaryData) {
    ## calculate the mean base quality score for 2D reads
    meanBaseQuality <- alphabetScore(quality(fastq2D(summaryData))) / width(fastq2D(summaryData))
    ## any greater than 9 is a PASS, less than is FAIL
    passFail <- ifelse(meanBaseQuality > 9, yes = TRUE, no = FALSE)
    ## match the PASS/FAIL status with an id
    passFail <- data.table(baseCalled(summaryData) %>%
                   filter(full_2D == TRUE, strand== "template") %>%
                   select(id), pass = passFail)
    ## create FALSE vector for all fast5 files, including those with no 2D
    tmp <- rep(FALSE, length(summaryData))
    ## use the id field to set PASS for appropriate reads
    tmp[filter(passFail, pass==TRUE)[,id]] <- TRUE
    ## update readInfo slot with extract column
    summaryData@readInfo <- mutate(readInfo(summaryData), pass = tmp)
    return(summaryData)
}

s.typhi.rep1 <- addPassFail(s.typhi.rep1)
s.typhi.rep2 <- addPassFail(s.typhi.rep2)
s.typhi.rep3 <- addPassFail(s.typhi.rep3)
```

Finally we save the three objects to *.rda* files.

```
save(s.typhi.rep1, file = "styphi.rep1.rda")
save(s.typhi.rep2, file = "styphi.rep2.rda")
save(s.typhi.rep3, file = "styphi.rep3.rda")
```

# References

Ashton, PM, S Nair, T Dallman, S Rubino, W Rabsch, S Mwaigwisya, J Wain, and J O’Grady. 2015. “MinION Nanopore Sequencing Identifies the Position and Structure of a Bacterial Antibiotic Resistance Island.” *Nature Biotechnology* 33 (3): 296.
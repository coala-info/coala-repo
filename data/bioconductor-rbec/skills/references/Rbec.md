# Rbec: a tool for analysis of amplicon sequencing data from synthetic microbial communities

#### Pengfan Zhang

Abstract

Rbec is a tool for analysing amplicon sequencing data from synthetic communities (SynComs), where the reference sequences for each strain are already available. Rbec can accurately correct PCR and sequencing errors, identify intra-species polymorphic variation, and detect contaminations in SynCom amplicon data.

# Overview

Rbec, which is the abbreviation of reference-based error correction of amplicon sequencing data from synthetic microbial communities, is the first documented software exclusively developed for analyzing the amplicon sequencing data from SynComs. Rbec can not only output accurate microbial composition for each sample, but also predict the potential contaminants in the artificial system.

## How to use Rbec?

## 1. Characterizing microbial communities in SynComs

Rbec can be run to estimate SynCom community profiles. An example with a small test dataset from a single bacterial strain illustrates this process:

```
library(Rbec)
fq <- system.file("extdata", "test_raw_merged_reads.fastq.gz", package="Rbec")

ref <- system.file("extdata", "test_ref.fasta", package="Rbec")

Rbec(fq, ref, tempdir(), 1, 500, 33)
#> Finished finding the best reference sequences for each unique sequences.
#> 2.66997909545898
#> Finished calculating the transition and error matrices.
#> Start 1 iterations
#> 9618
#> 7
#> 0.000727802037845706
#> The model reached consistency after 1 iteration(s)
#> Warning in dir.create(outdir): '/tmp/RtmpFRER4B' already exists
```

## 2. Detecting contaminants

One of the main sources of technical variation in gnotobiotic experiments is caused by microbial contaminations occurring during the development of the experiment or already present during input SynCom preparation. One of the features of Rbec is the assessment of likely contaminated samples based the recruitment ratio of sequencing reads across samples. When analysing data with Rbec, a separate log file is provided as an output for each sample. To predict contaminated samples, a text file containing a list of all paths to the log files needs to be provided before running the following command:

```
log_path <- list.files(paste(path.package("Rbec"), "extdata/contamination_test", sep="/"), recursive=TRUE, full.names=TRUE)
log_file <- tempfile()
writeLines(log_path, log_file)
Contam_detect(log_file, tempdir())
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the Rbec package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

This command will generate a plot showing the distribution of percentages of corrected reads across the whole sample set and a log file with predicted contaminated samples are generated. As a general rule, 90% or more of reads should be corrected in clean SynCom samples.
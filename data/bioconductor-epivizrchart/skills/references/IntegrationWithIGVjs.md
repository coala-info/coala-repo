# Visualizing Files with epivizrChart

Jayaram Kancherla, Hector Corrada Bravo

#### 2025-10-29

This vignette demonstrates one of the new components added to epivizrChart, Epiviz-IGV-Track. This element uses IGV.js (<https://github.com/igvteam/igv.js>) to visualize tracks from files (local and remote).

Sample dataset to use for the vignette.

```
data(tcga_colon_blocks)
```

Lets initialize an environment element to a specific genomic location. We can add additional annotation tracks (Homo.sapiens) and a blocks track from the example datasets.

```
epiviz_env <- epivizEnv(chr="chr11", start=118000000, end=121000000)
genes_track <- epiviz_env$plot(Homo.sapiens)
```

```
## creating gene annotation (it may take a bit)
```

```
##   24 genes were dropped because they have exons located on both strands of the
##   same reference sequence or on more than one reference sequence, so cannot be
##   represented by a single genomic range.
##   Use 'single.strand.genes.only=FALSE' to get all the genes in a GRangesList
##   object, or use suppressMessages() to suppress this message.
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
blocks_track <- epiviz_env$plot(tcga_colon_blocks, datasource_name="450kMeth")
```

We will create an R/BioConductor file object for the file we would like to visualize. We currently support BedFiles, BamFiles and BigWigFiles.

```
file1 <- Rsamtools::BamFile("http://1000genomes.s3.amazonaws.com/phase3/data/HG01879/alignment/HG01879.mapped.ILLUMINA.bwa.ACB.low_coverage.20120522.bam")
file2 <- rtracklayer::BEDFile("https://s3.amazonaws.com/igv.broadinstitute.org/annotations/hg19/genes/refGene.hg19.bed.gz")
```

Finally, we will plot the file object and when we render the environment element we will now see an IGV Track on the markdown document.

Note: IGV.js has issues with the web browser embedded in R-Studio. Please open the markdown document in firefox/chrome to visualize the tracks.

```
epiviz_igv <- epiviz_env$plot(
                  file1,
                  datasource_name = "genes2",
                  chr="chr11", start=118000000, end=121000000)

epiviz_env
```
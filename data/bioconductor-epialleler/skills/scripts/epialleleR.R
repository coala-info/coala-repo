# Code example from 'epialleleR' vignette. See references/ for full tutorial.

## ----include = FALSE------------------------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  width = 100
)
options(width=100)

## ----echo=FALSE, fig.width=10, fig.height=6, out.width="100%", out.height="100%"------------------
library(epialleleR)

data.beta <- data.table::data.table(
  pattern=rep(letters[1:10], each=10),
  pos=rep(10*c(1:10), 10),
  base=rep(c('meth',rep('unmeth',10)), length.out=100)
)
val.beta <- data.table::data.table(
  pos=rep(1:10, 2),
  var=c(rep("VEF", 10), rep("beta\nvalue", 10)),
  val=c(rep(0, 10), rep(0.1, 10))
)
data.vef <- data.table::data.table(
  pattern=rep(letters[1:10], each=10),
  pos=rep(10*c(1:10), 10),
  base=c(rep('unmeth',20), rep('meth',10), rep('unmeth',70))
)
val.vef <- data.table::data.table(
  pos=rep(1:10, 2),
  var=c(rep("VEF", 10), rep("beta\nvalue", 10)),
  val=c(rep(0.1, 10), rep(0.1, 10))
)
if (require("ggplot2", quietly=TRUE)) {
  grid::grid.newpage()
  plot.data.beta <-
    ggplot(data.beta,
           aes(x=pos, y=pattern,
               group=pattern, color=factor(base))) +
      geom_line(color="grey") +
      geom_point() +
      scale_colour_grey(start=0, end=0.8) +
      theme_light() +
      theme(axis.text.x=element_blank(), axis.text.y=element_blank(), legend.position="top") +
      labs(x="genomic position", y="epiallele", title="scattered CpG methylation", color="base")
  plot.val.beta <-
    ggplot(val.beta, aes(x=pos, y=var, label=val, fill=factor(val))) +
      geom_text(size=3) +
      theme_light() +
      theme(axis.text.x=element_blank()) +
      labs(x="", y="", title=NULL)
  plot.data.vef <-
    ggplot(data.vef,
           aes(x=pos, y=pattern,
               group=pattern, color=factor(base))) +
    geom_line(color="grey") +
    geom_point() +
    scale_colour_grey(start=0, end=0.8) +
    theme_light() +
    theme(axis.text.x=element_blank(), axis.text.y=element_blank(), legend.position="top") +
    labs(x="genomic position", y="epiallele", title="epimutation", color="base")
  plot.val.vef <-
    ggplot(val.vef, aes(x=pos, y=var, label=val, fill=factor(val))) +
    geom_text(size=3) +
    theme_light() +
    theme(axis.text.x=element_blank()) +
    labs(x="", y="", title=NULL)
  top.row <- cbind(ggplotGrob(plot.data.beta), ggplotGrob(plot.data.vef))
  bot.row <- cbind(ggplotGrob(plot.val.beta), ggplotGrob(plot.val.vef))
  bot.row$heights[[9]] <- grid::unit(0.3, "null")
  grid::grid.draw(rbind(top.row, bot.row))
}

## -------------------------------------------------------------------------------------------------
bam.file <- tempfile(pattern="simulated", fileext=".bam")
simulateBam(output.bam.file=bam.file, XM=c("ZZzZZ", "zzZzz"), XG="CT")
# one can view the resulting file using `samtools view -h <bam.file>`
# or, if desired, file can be converted to SAM using `samtools view`,
# manually corrected and converted back to BAM

## -------------------------------------------------------------------------------------------------
library(epialleleR)

capture.bam <- system.file("extdata", "capture.bam", package="epialleleR")
bam.data    <- preprocessBam(capture.bam)

# Specifics of long-read alignment processing
out.bam <- tempfile(pattern="out-", fileext=".bam")
simulateBam(
  seq=c("ACGCCATYCGCGCCA"),
  Mm=c("C+m,0,2,0;G-m,0,0,0;"),
  Ml=list(as.integer(c(102,128,153,138,101,96))),
  output.bam.file=out.bam
  )
generateCytosineReport(out.bam, threshold.reads=FALSE, report.context="CX")

## -------------------------------------------------------------------------------------------------
# bwa-meth sample output
input.bam <- system.file("extdata", "test", "bwameth-se-unsort-yd.bam", package="epialleleR")

# resulting BAM with XG/XM tags
output.bam <- tempfile(pattern="output-", fileext=".bam")

# sample reference genome
genome <- preprocessGenome(system.file("extdata", "test", "reference.fasta.gz", package="epialleleR"))

# calls cytosine methylation and stores it in the output BAM
# Input BAM has 100 records of which 73 are mapped to the genome
callMethylation(input.bam, output.bam, genome)

# process this data further
# bam.data <- preprocessBam(output.bam)

## -------------------------------------------------------------------------------------------------
# data.table::data.table object for
# CpG VEF report
cg.vef.report <- generateCytosineReport(bam.data)
head(cg.vef.report[order(meth+unmeth, decreasing=TRUE)])

# CpG cytosine report
cg.report <- generateCytosineReport(bam.data, threshold.reads=FALSE)
head(cg.report[order(meth+unmeth, decreasing=TRUE)])

# CX cytosine report
cx.report <- generateCytosineReport(bam.data, threshold.reads=FALSE,
                                    report.context="CX")
head(cx.report[order(meth+unmeth, decreasing=TRUE)])

## -------------------------------------------------------------------------------------------------
# report for amplicon-based data
# matching is done by exact start or end positions plus/minus tolerance
amplicon.report <- generateAmpliconReport(
  bam=system.file("extdata", "amplicon010meth.bam", package="epialleleR"),
  bed=system.file("extdata", "amplicon.bed", package="epialleleR")
)
amplicon.report

# report for capture-based data
# matching is done by overlap
capture.report <- generateCaptureReport(
  bam=system.file("extdata", "capture.bam", package="epialleleR"),
  bed=system.file("extdata", "capture.bed", package="epialleleR")
)
head(capture.report)

# generateBedReport is a generic function for BED-guided reports
bed.report <- generateBedReport(
  bam=system.file("extdata", "capture.bam", package="epialleleR"),
  bed=system.file("extdata", "capture.bed", package="epialleleR"),
  bed.type="capture"
)
identical(capture.report, bed.report)

## -------------------------------------------------------------------------------------------------
# lMHL report can be generated using
mhl.report <- generateMhlReport(
  bam=system.file("extdata", "capture.bam", package="epialleleR")
)

## ----fig.width=10, fig.height=6, out.width="100%", out.height="100%"------------------------------
# First, let's extract base methylation information for sequencing reads
# of 1:9 mix of methylated and non-methylated control DNA
patterns <- extractPatterns(
  bam=system.file("extdata", "amplicon010meth.bam", package="epialleleR"),
  bed=as("chr17:43125200-43125600","GRanges")
)

# that many read pairs overlap genomic region of interest
nrow(patterns)

# now we can plot the most abundant them of them using default parameters
plotPatterns(patterns)

# now let's explore methylation patterns in RAD51C gene promoter using
# methylation capture data
capture.patterns <- extractPatterns(
  bam=system.file("extdata", "capture.bam", package="epialleleR"),
  bed=as("chr17:58691673-58693108", "GRanges"),
  verbose=FALSE
)

# let's plot all the patterns using discrete genomic scale
plotPatterns(capture.patterns, npatterns.per.bin=Inf,
             genomic.scale="discrete", context.size=1)

## ----fig.width=10, fig.height=6, out.width="100%", out.height="100%"------------------------------
# VCF report
vcf.report <- generateVcfReport(
  bam=system.file("extdata", "amplicon010meth.bam", package="epialleleR"),
  bed=system.file("extdata", "amplicon.bed", package="epialleleR"),
  vcf=system.file("extdata", "amplicon.vcf.gz", package="epialleleR"),
  # thresholds on alignment and base quality
  min.mapq=30, min.baseq=13,
  # when VCF seqlevels are different from BED and BAM it is possible
  # to convert them internally
  vcf.style="NCBI"
)

# NA values are shown for the C->T variants on the "+" and G->A on the "-"
# strands, because bisulfite conversion makes their counting impossible
head(vcf.report)

# let's sort the report by increasing Fisher's exact test's p-values.
# the p-values are given separately for reads that map to the "+"
head(vcf.report[order(`FEp-`, na.last=TRUE)])

# and to the "-" strand
head(vcf.report[order(`FEp+`, na.last=TRUE)])

# and finally, let's plot methylation patterns overlapping one of the most
# covered SNPs in the methylation capture test data set - rs573296191
# (chr17:61864584) in BRIP1 gene
brip1.patterns <- extractPatterns(
  bam=system.file("extdata", "capture.bam", package="epialleleR"),
  bed=as("chr17:61864583-61864585", "GRanges"),
  highlight.positions=61864584,
  verbose=FALSE
)
plotPatterns(brip1.patterns)

## ----fig.width=10, fig.height=6, out.width="100%", out.height="100%"------------------------------
# First, let's visualise eCDFs for within- and out-of-context beta values
# for all four amplicons and unmatched reads. Note that within-the-context eCDF
# of 0.5 is very close to the expected 1-VEF value (0.1) for all amplicons
# produced from this 1:9 mix of methylated and non-methylated control DNA

# let's compute eCDF
amplicon.ecdfs <- generateBedEcdf(
  bam=system.file("extdata", "amplicon010meth.bam", package="epialleleR"),
  bed=system.file("extdata", "amplicon.bed", package="epialleleR"),
  bed.rows=NULL
)

# there are 5 items in amplicon.ecdfs, let's plot all of them
par(mfrow=c(1,length(amplicon.ecdfs)))

# cycle through items
for (x in 1:length(amplicon.ecdfs)) {
  # four of them have names corresponding to genomic regions of amplicon.bed
  # fifth - NA for all the reads that don't match to any of those regions
  main <- if (is.na(names(amplicon.ecdfs[x]))) "unmatched"
          else names(amplicon.ecdfs[x])
  
  # plotting eCDF for within-the-context per-read beta values (in red)
  plot(amplicon.ecdfs[[x]]$context, col="red", verticals=TRUE, do.points=FALSE,
       xlim=c(0,1), xlab="per-read beta value", ylab="cumulative density",
       main=main)
  
  # adding eCDF for out-of-context per-read beta values (in blue)
  plot(amplicon.ecdfs[[x]]$out.of.context, add=TRUE, col="blue",
       verticals=TRUE, do.points=FALSE)
}


# Second, let's compare eCDFs for within-the-context beta values for only one
# amplicon but all three sequenced samples: pure non-methylated DNA, 1:9 mix of
# methylated and non-methylated DNA, and fully methylated DNA

# our files
bam.files <- c("amplicon000meth.bam", "amplicon010meth.bam",
               "amplicon100meth.bam")

# let's plot all of them
par(mfrow=c(1,length(bam.files)))

# cycle through items
for (f in bam.files) {
  # let's compute eCDF
  amplicon.ecdfs <- generateBedEcdf(
    bam=system.file("extdata", f, package="epialleleR"),
    bed=system.file("extdata", "amplicon.bed", package="epialleleR"),
    # only the second amplicon
    bed.rows=2, verbose=FALSE
  )
  
  # plotting eCDF for within-the-context per-read beta values (in red)
  plot(amplicon.ecdfs[[1]]$context, col="red", verticals=TRUE, do.points=FALSE,
       xlim=c(0,1), xlab="per-read beta value", ylab="cumulative density",
       main=f)
  
   # adding eCDF for out-of-context per-read beta values (in blue)
  plot(amplicon.ecdfs[[1]]$out.of.context, add=TRUE, col="blue",
       verticals=TRUE, do.points=FALSE)
}

## ----session--------------------------------------------------------------------------------------
sessionInfo()


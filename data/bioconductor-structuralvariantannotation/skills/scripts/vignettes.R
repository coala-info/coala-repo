# Code example from 'vignettes' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(#echo = TRUE,
  collapse = TRUE,
  comment = "#>")

## ----installation, eval=FALSE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     #install.packages("BiocManager")
# BiocManager::install("StructuralVariantAnnotation")
# library(StructuralVariantAnnotation)

## ----samplevariant,warning=FALSE, message=FALSE-------------------------------
suppressPackageStartupMessages(library(StructuralVariantAnnotation))
vcf <- VariantAnnotation::readVcf(system.file("extdata", "representations.vcf", package = "StructuralVariantAnnotation"))
gr <- c(breakpointRanges(vcf), breakendRanges(vcf))
gr

## ----input, warning=FALSE, message=FALSE--------------------------------------
library(StructuralVariantAnnotation)
vcf <- VariantAnnotation::readVcf(system.file("extdata", "gridss.vcf", package = "StructuralVariantAnnotation"))
gr <- breakpointRanges(vcf)

## -----------------------------------------------------------------------------
partner(gr)

## -----------------------------------------------------------------------------
colo829_vcf <- VariantAnnotation::readVcf(system.file("extdata", "COLO829T.purple.sv.ann.vcf.gz", package = "StructuralVariantAnnotation"))
colo829_bpgr <- breakpointRanges(colo829_vcf)
colo829_begr <- breakendRanges(colo829_vcf)
colo829_gr <- sort(c(colo829_begr, colo829_bpgr))
colo829_gr[seqnames(colo829_gr) == "6"]

## -----------------------------------------------------------------------------
colo828_chr6_breakpoints <- colo829_gr[seqnames(colo829_gr) == "6"]
# A call to findBreakpointOverlaps(colo828_chr6_breakpoints, colo828_chr6_breakpoints)
# will fail as there are a) single breakends, and b) breakpoints with missing partners
colo828_chr6_breakpoints <- colo828_chr6_breakpoints[hasPartner(colo828_chr6_breakpoints)]
# As expected, each call on chr6 only overlaps with itself
countBreakpointOverlaps(colo828_chr6_breakpoints, colo828_chr6_breakpoints)

## -----------------------------------------------------------------------------
colo828_chr6_breakpoints <- colo829_gr[
  seqnames(colo829_gr) == "6" |
    seqnames(partner(colo829_gr, selfPartnerSingleBreakends=TRUE)) == "6"]
# this way we keep the chr3<->chr6 breakpoint and don't create any orphans
head(colo828_chr6_breakpoints, 1)

## -----------------------------------------------------------------------------
truth_vcf <- readVcf(system.file("extdata", "na12878_chr22_Sudmunt2015.vcf", package = "StructuralVariantAnnotation"))
truth_svgr <- breakpointRanges(truth_vcf)
truth_svgr <- truth_svgr[seqnames(truth_svgr) == "chr22"]
crest_vcf <- readVcf(system.file("extdata", "na12878_chr22_crest.vcf", package = "StructuralVariantAnnotation"))
# Some SV callers don't report QUAL so we need to use a proxy
VariantAnnotation::fixed(crest_vcf)$QUAL <- info(crest_vcf)$left_softclipped_read_count + info(crest_vcf)$left_softclipped_read_count
crest_svgr <- breakpointRanges(crest_vcf)
crest_svgr$caller <- "crest"
hydra_vcf <- readVcf(system.file("extdata", "na12878_chr22_hydra.vcf", package = "StructuralVariantAnnotation"))
hydra_svgr <- breakpointRanges(hydra_vcf)
hydra_svgr$caller <- "hydra"
svgr <- c(crest_svgr, hydra_svgr)
svgr$truth_matches <- countBreakpointOverlaps(svgr, truth_svgr,
  # read pair based callers make imprecise calls.
  # A margin around the call position is required when matching with the truth set
  maxgap=100,
  # Since we added a maxgap, we also need to restrict the mismatch between the
  # size of the events. We don't want to match a 100bp deletion with a 
  # 5bp duplication. This will happen if we have a 100bp margin but don't also
  # require an approximate size match as well
  sizemargin=0.25,
  # We also don't want to match a 20bp deletion with a 20bp deletion 80bp away
  # by restricting the margin based on the size of the event, we can make sure
  # that simple events actually do overlap
  restrictMarginToSizeMultiple=0.5,
  # HYDRA makes duplicate calls and will sometimes report a variant multiple
  # times with slightly different bounds. countOnlyBest prevents these being
  # double-counted as multiple true positives.
  countOnlyBest=TRUE)

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(require(dplyr))
suppressPackageStartupMessages(require(ggplot2))
ggplot(as.data.frame(svgr) %>%
  dplyr::select(QUAL, caller, truth_matches) %>%
  dplyr::group_by(caller, QUAL) %>%
  dplyr::summarise(
    calls=dplyr::n(),
    tp=sum(truth_matches > 0)) %>%
  dplyr::group_by(caller) %>%
  dplyr::arrange(dplyr::desc(QUAL)) %>%
  dplyr::mutate(
    cum_tp=cumsum(tp),
    cum_n=cumsum(calls),
    cum_fp=cum_n - cum_tp,
    Precision=cum_tp / cum_n,
    Recall=cum_tp/length(truth_svgr))) +
  aes(x=Recall, y=Precision, colour=caller) +
  geom_point() +
  geom_line() +
  labs(title="NA12878 chr22 CREST and HYDRA\nSudmunt 2015 truth set")

## -----------------------------------------------------------------------------
colo829_truth_bpgr  <- breakpointRanges(readVcf(system.file("extdata", "truthset_somaticSVs_COLO829.vcf", package = "StructuralVariantAnnotation")))
colo829_nanosv_bpgr <- breakpointRanges(readVcf(system.file("extdata", "colo829_nanoSV_truth_overlap.vcf", package = "StructuralVariantAnnotation")), inferMissingBreakends=TRUE, ignoreUnknownSymbolicAlleles=TRUE)
findTransitiveCalls(colo829_nanosv_bpgr, colo829_truth_bpgr)

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(require(rtracklayer))
# Export to BEDPE
rtracklayer::export(breakpointgr2pairs(gr), con="example.bedpe")

# Import to BEDPE
bedpe.gr  <- pairs2breakpointgr(rtracklayer::import("example.bedpe"))


## ----add to.gr----------------------------------------------------------------
suppressPackageStartupMessages(require(ggbio))
gr.circos <- colo829_bpgr[seqnames(colo829_bpgr) %in% seqlevels(biovizBase::hg19sub)]
seqlevels(gr.circos) <- seqlevels(biovizBase::hg19sub)
mcols(gr.circos)$to.gr <- granges(partner(gr.circos))

## ----ggbio--------------------------------------------------------------------
p <- ggbio() +
	circle(gr.circos, geom="link", linked.to="to.gr") +
	circle(biovizBase::hg19sub, geom='ideo', fill='gray70') +
	circle(biovizBase::hg19sub, geom='scale', size=2) +
	circle(biovizBase::hg19sub, geom='text', aes(label=seqnames), vjust=0, size=3)
p

## -----------------------------------------------------------------------------
sessionInfo()


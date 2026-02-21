# Code example from 'Introduction' vignette. See references/ for full tutorial.

## ----optChunkDefault, include=FALSE-------------------------------------------
stopifnot(
    requireNamespace("pander")
)
library(knitr)
opts_chunk$set( # Set these first, to make them default
    message = FALSE,
    warning=FALSE,
    error=FALSE
)
optChunkDefault <- opts_chunk$get()

## ----library------------------------------------------------------------------
library(TVTB)

## ----TVTBparamConstructor-----------------------------------------------------
tparam <- TVTBparam(Genotypes(
    ref = "0|0",
    het = c("0|1", "1|0", "0|2", "2|0", "1|2", "2|1"),
    alt = c("1|1", "2|2")),
    ranges = GenomicRanges::GRangesList(
        SLC24A5 = GenomicRanges::GRanges(
            seqnames = "15",
            IRanges::IRanges(
                start = 48413170, end = 48434757)
            )
        )
    )

## ----TVTBparamShow------------------------------------------------------------
tparam

## ----TVTBparamAsScanVcfParam--------------------------------------------------
svp <- as(tparam, "ScanVcfParam")
svp

## ----importPhenotypes---------------------------------------------------------
phenoFile <- system.file(
    "extdata", "integrated_samples.txt", package = "TVTB")
phenotypes <- S4Vectors::DataFrame(
    read.table(file = phenoFile, header = TRUE, row.names = 1))

## ----TabixFile----------------------------------------------------------------
vcfFile <- system.file(
    "extdata", "chr15.phase3_integrated.vcf.gz", package = "TVTB")
tabixVcf <- Rsamtools::TabixFile(file = vcfFile)

## ----svpTVTBparam-------------------------------------------------------------
VariantAnnotation::vcfInfo(svp(tparam)) <- vep(tparam)
VariantAnnotation::vcfGeno(svp(tparam)) <- "GT"
svp(tparam)

## ----readExpandVcf, message=FALSE---------------------------------------------
# Import variants as a CollapsedVCF object
vcf <- VariantAnnotation::readVcf(
    tabixVcf, param = tparam, colData = phenotypes)
# Expand into a ExpandedVCF object (bi-allelic records)
vcf <- VariantAnnotation::expand(x = vcf, row.names = TRUE)

## ----vcfShow, echo=FALSE------------------------------------------------------
vcf

## ----addOverallFrequencies----------------------------------------------------
initialInfo <- colnames(info(vcf))
vcf <- addOverallFrequencies(vcf = vcf)
setdiff(colnames(info(vcf)), initialInfo)

## ----addFrequenciesOverall----------------------------------------------------
vcf <- addFrequencies(vcf = vcf, force = TRUE)

## ----addPhenoLevelFrequencies-------------------------------------------------
initialInfo <- colnames(info(vcf))
vcf <- addPhenoLevelFrequencies(
    vcf = vcf, pheno = "super_pop", level = "AFR")
setdiff(colnames(info(vcf)), initialInfo)

## ----addFrequenciesPhenoLevel-------------------------------------------------
initialInfo <- colnames(info(vcf))
vcf <- addFrequencies(
    vcf,
    list(super_pop = c("EUR", "SAS", "EAS", "AMR"))
)
setdiff(colnames(info(vcf)), initialInfo)

## ----addFrequenciesPhenotype--------------------------------------------------
vcf <- addFrequencies(vcf, "pop")
head(grep("^pop_[[:alpha:]]+_REF", colnames(info(vcf)), value = TRUE))

## ----filterRulesMotivation, echo=FALSE, results='asis'------------------------
motivations <- readRDS(
    system.file("misc", "motivations_rules.rds", package = "TVTB")
)
pander::pandoc.table(
    motivations,
    paste(
        "Motivation for each of the new classes extending `FilterRules`,
        to define VCF filter rules."
    ),
    style = "multiline",
    split.cells = c(15, 45),
    split.tables = c(Inf)
)

## ----FilterRules--------------------------------------------------------------
S4Vectors::FilterRules(list(
    mixed = function(x){
        VariantAnnotation::fixed(x)[,"FILTER"] == "PASS" &
            VariantAnnotation::info(x)[,"MAF"] >= 0.05
    }
))

## ----VcfFixedRules------------------------------------------------------------
fixedR <- VcfFixedRules(list(
    pass = expression(FILTER == "PASS"),
    qual = expression(QUAL > 20)
))
fixedR

## ----VcfInfoRules-------------------------------------------------------------
infoR <- VcfInfoRules(
    exprs = list(
        rare = expression(MAF < 0.01 & MAF > 0),
        common = expression(MAF > 0.05),
        mac_ge3 = expression(HET + 2*ALT >= 3)),
    active = c(TRUE, TRUE, FALSE)
)
infoR

## ----VcfVepRules--------------------------------------------------------------
vepR <- VcfVepRules(exprs = list(
    missense = expression(Consequence %in% c("missense_variant")),
    CADD_gt15 = expression(CADD_PHRED > 15)
    ))
vepR

## ----VcfFilterRules-----------------------------------------------------------
vcfRules <- VcfFilterRules(fixedR, infoR, vepR)
vcfRules

## ----deactivateFilterRules----------------------------------------------------
active(vcfRules)["CADD_gt15"] <- FALSE
active(vcfRules)

## ----evalFilterRules----------------------------------------------------------
summary(eval(expr = infoR, envir = vcf))
summary(eval(expr = vcfRules, envir = vcf))
summary(evalSeparately(expr = vcfRules, envir = vcf))

## ----plotMAFCommon------------------------------------------------------------
plotInfo(
        subsetByFilter(vcf, vcfRules["common"]), "AAF",
        range(GenomicRanges::granges(vcf)),
        EnsDb.Hsapiens.v75::EnsDb.Hsapiens.v75,
        "super_pop",
        zero.rm = FALSE
    )

## ----plotMAFrare--------------------------------------------------------------
plotInfo(
        subsetByFilter(vcf, vcfRules["missense"]), "MAF",
        range(GenomicRanges::granges(vcf)),
        EnsDb.Hsapiens.v75::EnsDb.Hsapiens.v75,
        "super_pop",
        zero.rm = TRUE
    )

## ----pairsInfo----------------------------------------------------------------
pairsInfo(subsetByFilter(vcf, vcfRules["common"]), "AAF", "super_pop")

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()


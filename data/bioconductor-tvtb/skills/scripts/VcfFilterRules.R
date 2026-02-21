# Code example from 'VcfFilterRules' vignette. See references/ for full tutorial.

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
fr <- S4Vectors::FilterRules(list(
    mixed = function(x){
        VariantAnnotation::fixed(x)[,"FILTER"] == "PASS" &
            VariantAnnotation::info(x)[,"MAF"] >= 0.05
    }
))
fr

## ----makeCollapsedVCF---------------------------------------------------------
library(TVTB)
extdata <- system.file("extdata", package = "TVTB")
vcfFile <- file.path(extdata, "chr15.phase3_integrated.vcf.gz")
tabixVcf <- Rsamtools::TabixFile(file = vcfFile)
vcf <- VariantAnnotation::readVcf(file = tabixVcf)

## ----makeExpandedVCF----------------------------------------------------------
evcf <- VariantAnnotation::expand(x = vcf, row.names = TRUE)

## ----simpleRules--------------------------------------------------------------
fixedVcf <- colnames(fixed(vcf))
fixedVcf
infoVcf <- colnames(info(vcf))
infoVcf
csq <- parseCSQToGRanges(x = evcf)
vepVcf <- colnames(mcols(csq))
vepVcf

## ----simpleFixedRules---------------------------------------------------------
fixedRules <- VcfFixedRules(exprs = list(
    pass = expression(FILTER == "PASS"),
    qual20 = expression(QUAL >= 20)
))
active(fixedRules)["qual20"] <- FALSE
summary(evalSeparately(fixedRules, vcf))

## ----addFixedRule-------------------------------------------------------------
nucleotides <- c("A", "T", "G", "C")
SNPrule <- VcfFixedRules(exprs = list(
    SNP = expression(
    as.character(REF) %in% nucleotides &
        as.character(ALT) %in% nucleotides)
))
summary(evalSeparately(SNPrule, evcf, enclos = .GlobalEnv))

## ----simpleInfoRules----------------------------------------------------------
infoRules <- VcfInfoRules(exprs = list(
    samples = expression(NS > (0.9 * ncol(evcf))),
    avgSuperPopAF = expression(
        (EAS_AF + EUR_AF + AFR_AF + AMR_AF + SAS_AF) / 5 > 0.05
    )
))
summary(evalSeparately(infoRules, evcf, enclos = .GlobalEnv))

## ----infoFunctionRule---------------------------------------------------------
AFcutoff <- 0.05
popCutoff <- 2/3
filterFUN <- function(envir){
    # info(vcf) returns a DataFrame; rowSums below requires a data.frame
    df <- as.data.frame(envir)
    # Identify fields storing allele frequency in super-populations
    popFreqCols <- grep("[[:alpha:]]{3}_AF", colnames(df))
    # Count how many super-population have an allele freq above the cutoff
    popCount <- rowSums(df[,popFreqCols] > AFcutoff)
    # Convert the cutoff ratio to a integer count
    popCutOff <- popCutoff * length(popFreqCols)
    # Identifies variants where enough super-population pass the cutoff
    testRes <- (popCount > popCutOff)
    # Return a boolean vector, required by the eval method
    return(testRes)
}
funFilter <- VcfInfoRules(exprs = list(
    commonSuperPops = filterFUN
))
summary(evalSeparately(funFilter, evcf))

## ----applyInfoFunction--------------------------------------------------------
summary(filterFUN(info(evcf)))

## ----greplFilter--------------------------------------------------------------
missenseFilter <- VcfVepRules(
    exprs = list(
        exact = expression(Consequence == "missense_variant"),
        grepl = expression(grepl("missense", Consequence))
        ),
    vep = "CSQ")
summary(evalSeparately(missenseFilter, evcf))

## ----fixedInsertionFilter-----------------------------------------------------
fixedInsertionFilter <- VcfFixedRules(exprs = list(
    isInsertion = expression(
        Biostrings::width(ALT) > Biostrings::width(REF)
    )
))
evcf_fixedIns <- subsetByFilter(evcf, fixedInsertionFilter)
as.data.frame(fixed(evcf_fixedIns)[,c("REF", "ALT")])

## ----vepInsertionFilter-------------------------------------------------------
vepInsertionFilter <- VcfVepRules(exprs = list(
    isInsertion = expression(VARIANT_CLASS == "insertion")
))
evcf_vepIns <- subsetByFilter(evcf, vepInsertionFilter)
as.data.frame(fixed(evcf_vepIns)[,c("REF", "ALT")])

## ----fixedMultiallelicFilter--------------------------------------------------
multiallelicFilter <- VcfFixedRules(exprs = list(
    multiallelic = expression(lengths(ALT) > 1)
))
summary(eval(multiallelicFilter, vcf))

## ----combineRules-------------------------------------------------------------
vignetteRules <- VcfFilterRules(
    fixedRules,
    SNPrule,
    infoRules,
    vepInsertionFilter
)
vignetteRules
active(vignetteRules)
type(vignetteRules)
summary(evalSeparately(vignetteRules, evcf, enclos = .GlobalEnv))

## ----combinedRulesDeactivated-------------------------------------------------
active(vignetteRules)["SNP"] <- FALSE
summary(evalSeparately(vignetteRules, evcf, enclos = .GlobalEnv))

## ----combineFilterVep---------------------------------------------------------
combinedFilters <- VcfFilterRules(
    vignetteRules, # VcfFilterRules
    missenseFilter # VcfVepRules
)
type(vignetteRules)
type(combinedFilters)
active(vignetteRules)
active(missenseFilter)
active(combinedFilters)

## ----combineFilterFilter------------------------------------------------------
secondVcfFilter <- VcfFilterRules(missenseFilter)
secondVcfFilter

## ----combineMultipleRules-----------------------------------------------------
manyRules <- VcfFilterRules(
    vignetteRules, # VcfFilterRules
    secondVcfFilter, # VcfFilterRules
    funFilter # VcfInfoRules
)
manyRules
active(manyRules)
type(manyRules)
summary(evalSeparately(manyRules, evcf, enclos = .GlobalEnv))

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()


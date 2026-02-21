# Code example from 'mpra' vignette. See references/ for full tutorial.

## ----dependencies, warning=FALSE, message=FALSE-------------------------------
library(mpra)

## -----------------------------------------------------------------------------
E <- 4 # Number of elements
B <- 3 # Number of barcodes
s <- 4 # Samples per tissue
nt <- 2 # Number of tissues

set.seed(434)
rna <- matrix(rpois(E*B*s*nt, lambda = 30), nrow = E*B, ncol = s*nt)
dna <- matrix(rpois(E*B*s*nt, lambda = 30), nrow = E*B, ncol = s*nt)

rn <- as.character(outer(paste0("barcode_", seq_len(B), "_"), paste0("elem_", seq_len(E)), FUN = "paste0"))
cn <- c(paste0("liver_", seq_len(s)), paste0("kidney_", seq_len(s)))

rownames(rna) <- rn
rownames(dna) <- rn
colnames(rna) <- cn
colnames(dna) <- cn

rna
dna

## -----------------------------------------------------------------------------
eid <- rep(paste0("elem_", seq_len(E)), each = B)
eid

## -----------------------------------------------------------------------------
eseq <- replicate(E, paste(sample(c("A", "T", "C", "G"), 10, replace = TRUE), collapse = ""))
eseq <- rep(eseq, each = B)
eseq

## -----------------------------------------------------------------------------
mpraset_example <- MPRASet(DNA = dna, RNA = rna, eid = eid, eseq = eseq, barcode = NULL)
mpraset_example

## -----------------------------------------------------------------------------
E <- 2 # Number of elements
B <- 3 # Number of barcodes
s <- 4 # Total number of samples
nalleles <- 2 # Number of alleles

set.seed(434)
rna <- matrix(rpois(E*B*s*nalleles, lambda = 30), nrow = E*B*nalleles, ncol = s)
dna <- matrix(rpois(E*B*s*nalleles, lambda = 30), nrow = E*B*nalleles, ncol = s)

rn <- expand.grid(barcode = seq_len(B), allele = seq_len(nalleles), elem = seq_len(E))
rn <- paste0("barcode", rn$barcode, "_elem", rn$elem, "_allele", rn$allele)
cn <- paste0("sample", seq_len(s))

rownames(rna) <- rn
rownames(dna) <- rn
colnames(rna) <- cn
colnames(dna) <- cn

rna
dna

## -----------------------------------------------------------------------------
agg_output <- lapply(seq_len(E), function(elem_id) {
    pattern1 <- paste0(paste0("elem", elem_id), "_allele1")
    bool_rna_allele1 <- grepl(pattern1, rownames(rna))
    pattern2 <- paste0(paste0("elem", elem_id), "_allele2")
    bool_rna_allele2 <- grepl(pattern2, rownames(rna))
    agg_rna <- c(
        colSums(rna[bool_rna_allele1,]),
        colSums(rna[bool_rna_allele2,])
    )
    names(agg_rna) <- paste0(rep(c("allele1", "allele2"), each = s), "_", names(agg_rna))
    bool_dna_allele1 <- grepl(pattern1, rownames(dna))
    bool_dna_allele2 <- grepl(pattern2, rownames(dna))
    agg_dna <- c(
        colSums(dna[bool_dna_allele1,]),
        colSums(dna[bool_dna_allele2,])
    )
    names(agg_dna) <- paste0(rep(c("allele1", "allele2"), each = s), "_", names(agg_dna))
    list(rna = agg_rna, dna = agg_dna)
})
agg_rna <- do.call(rbind, lapply(agg_output, "[[", "rna"))
agg_dna <- do.call(rbind, lapply(agg_output, "[[", "dna"))
eid <- paste0("elem", seq_len(E))
rownames(agg_rna) <- eid
rownames(agg_dna) <- eid
eseq <- replicate(E, paste(sample(c("A", "T", "C", "G"), 10, replace = TRUE), collapse = ""))

## -----------------------------------------------------------------------------
mpraset_example2 <- MPRASet(DNA = agg_dna, RNA = agg_rna, eid = eid, eseq = eseq, barcode = NULL)
mpraset_example2

## -----------------------------------------------------------------------------
data(mpraSetExample)

## ----fig=TRUE-----------------------------------------------------------------
design <- data.frame(intcpt = 1, episomal = grepl("MT", colnames(mpraSetExample)))
mpralm_fit <- mpralm(object = mpraSetExample, design = design, aggregate = "mean", normalize = TRUE, model_type = "indep_groups", plot = TRUE)

## -----------------------------------------------------------------------------
toptab <- topTable(mpralm_fit, coef = 2, number = Inf)
toptab6 <- head(toptab)

## ----printToptab10------------------------------------------------------------
rownames(toptab6)
rownames(toptab6) <- NULL
toptab6

## ----fig=TRUE-----------------------------------------------------------------
data(mpraSetAllelicExample)

design <- data.frame(intcpt = 1, alleleB = grepl("allele_B", colnames(mpraSetAllelicExample)))
block_vector <- rep(1:5, 2)
mpralm_allele_fit <- mpralm(object = mpraSetAllelicExample, design = design, aggregate = "none", normalize = TRUE, block = block_vector, model_type = "corr_groups", plot = TRUE)

toptab_allele <- topTable(mpralm_allele_fit, coef = 2, number = Inf)
head(toptab_allele)

## -----------------------------------------------------------------------------
design <- data.frame(intcpt = 1,
                     episomal = grepl("MT", colnames(mpraSetExample)))
efit <- mpralm(object = mpraSetExample,
               design = design,
               aggregate = "sum",
               normalize = TRUE,
               model_type = "indep_groups",
               plot = FALSE,
               endomorphic = TRUE, coef = 2)
# for ease of printing, because 'eid' are long here
rownames(efit) <- paste0("elem_", seq_len(nrow(efit)))
rowData(efit)

## -----------------------------------------------------------------------------
sdna <- assay(efit, "scaledDNA")
srna <- assay(efit, "scaledRNA")
mt <- rowMeans(log2(srna[,1:3] + 1) - log2(sdna[,1:3] + 1))
wt <- rowMeans(log2(srna[,4:6] + 1) - log2(sdna[,4:6] + 1))
raw_lfc <- mt - wt
# very similar, precision weights modify LFC from limma a bit
lm(raw_lfc ~ rowData(efit)$logFC)

## ----sessionInfo, results='asis', echo=FALSE----------------------------------
sessionInfo()


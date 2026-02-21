# Code example from 'BasicUsageOfGBScleanR' vignette. See references/ for full tutorial.

## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(fig.pos = 'H', fig.align = "center", warning = FALSE, message = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# gds <- loadGDS(x = "/path/to/your/gds", ploidy = 4) # For tetraploid
# gds <- loadGDS(x = "/path/to/your/gds", ploidy = 6) # For hexaploid

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("GBScleanR")

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("devtools", quietly = TRUE))
#     install.packages("devtools")
# devtools::install_github("tomoyukif/GBScleanR", build_vignettes = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# Stream Read Error, need 12 byte(s) but receive 0

## ----warning=FALSE, message=FALSE---------------------------------------------
library("GBScleanR")

## -----------------------------------------------------------------------------
vcf_fn <- system.file("extdata", "sample.vcf", package = "GBScleanR")
gds_fn <- tempfile("sample", fileext = ".gds")

## -----------------------------------------------------------------------------
# `force = TRUE` allow the function to over write the GDS file,
# even if a GDS file exists at `out_fn`.
gbsrVCF2GDS(vcf_fn = vcf_fn, out_fn = gds_fn, force = TRUE, verbose = FALSE)

## -----------------------------------------------------------------------------
gds <- loadGDS(gds_fn, verbose = FALSE)

## -----------------------------------------------------------------------------
# Number of samples
nsam(gds)

## -----------------------------------------------------------------------------
# Number of SNPs
nmar(gds) 

## -----------------------------------------------------------------------------
# Indices of chromosome ID of all markers
head(getChromosome(gds)) 

## -----------------------------------------------------------------------------
# Chromosome names of all markers
head(getChromosome(gds)) 

## -----------------------------------------------------------------------------
# Position (bp) of all markers
head(getPosition(gds)) 

## -----------------------------------------------------------------------------
# Reference allele of all markers
head(getAllele(gds)) 

## -----------------------------------------------------------------------------
# SNP IDs
head(getMarID(gds)) 

## -----------------------------------------------------------------------------
# sample IDs
head(getSamID(gds)) 

## -----------------------------------------------------------------------------
geno <- getGenotype(gds)

## -----------------------------------------------------------------------------
geno <- getRead(gds)

## -----------------------------------------------------------------------------
gds <- countGenotype(gds)
gds <- countRead(gds)

## ----fig.alt="Missing rate per marker and per sample."------------------------
# Histgrams of missing rate
histGBSR(gds, stats = "missing") 

## ----fig.alt="Heterozygosity per marker and per sample."----------------------
# Histgrams of heterozygosity
histGBSR(gds, stats = "het") 

## ----fig.alt="Reference allele frequency per marker and per sample."----------
# Histgrams of reference allele frequency
histGBSR(gds, stats = "raf") 

## ----fig.alt="Total read depth per marker and per sample."--------------------
# Histgrams of total read depth
histGBSR(gds, stats = "dp") 

## ----fig.alt="Reference read depth per marker and per sample."----------------
# Histgrams of allelic read depth
histGBSR(gds, stats = "ad_ref") 

## ----fig.alt="Alternative read depth per marker and per sample."--------------
# Histgrams of allelic read depth
histGBSR(gds, stats = "ad_alt") 

## ----fig.alt="Reference read per marker and per sample."----------------------
# Histgrams of reference allele frequency
histGBSR(gds, stats = "rrf") 

## ----fig.alt="Mean of reference read depth per marker and per sample."--------
# Histgrams of mean allelic read depth
histGBSR(gds, stats = "mean_ref") 

## ----fig.alt="SD of reference read depth per marker and per sample."----------
# Histgrams of standard deviation of read depth
histGBSR(gds, stats = "sd_ref") 

## ----fig.alt="SD of alternative read depth per marker and per sample."--------
# Histgrams of standard deviation of read depth
histGBSR(gds, stats = "sd_ref") 

## -----------------------------------------------------------------------------
plotGBSR(gds, stats = "missing")

## -----------------------------------------------------------------------------
plotGBSR(gds, stats = "geno")

## -----------------------------------------------------------------------------
pairsGBSR(gds, stats1 = "missing", stats2 = "dp")

## -----------------------------------------------------------------------------
# Reference genotype count per marker
head(getCountGenoRef(gds, target = "marker")) 
# Reference genotype count per sample
head(getCountGenoRef(gds, target = "sample")) 

## -----------------------------------------------------------------------------
# Heterozygote count per marker
head(getCountGenoHet(gds, target = "marker")) 
# Heterozygote count per sample
head(getCountGenoHet(gds, target = "sample")) 

## -----------------------------------------------------------------------------
# Alternative genotype count per marker
head(getCountGenoAlt(gds, target = "marker")) 
# Alternative genotype count per sample
head(getCountGenoAlt(gds, target = "sample"))

## -----------------------------------------------------------------------------
# Missing count per marker
head(getCountGenoMissing(gds, target = "marker")) 
# Missing count per sample
head(getCountGenoMissing(gds, target = "sample")) 

## -----------------------------------------------------------------------------
# Reference allele count per marker
head(getCountAlleleRef(gds, target = "marker")) 
# Reference allele count per sample
head(getCountAlleleRef(gds, target = "sample")) 

## -----------------------------------------------------------------------------
# Alternative allele count per marker
head(getCountAlleleAlt(gds, target = "marker")) 
# Alternative allele count per sample
head(getCountAlleleAlt(gds, target = "sample")) 

## -----------------------------------------------------------------------------
# Missing allele count per marker
head(getCountAlleleMissing(gds, target = "marker")) 
# Missing allele count per sample
head(getCountAlleleMissing(gds, target = "sample")) 

## -----------------------------------------------------------------------------
# Reference read count per marker
head(getCountReadRef(gds, target = "marker")) 
# Reference read count per sample
head(getCountReadRef(gds, target = "sample")) 

## -----------------------------------------------------------------------------
# Alternative read count per marker
head(getCountReadAlt(gds, target = "marker")) 
# Alternative read count per sample
head(getCountReadAlt(gds, target = "sample")) 

## -----------------------------------------------------------------------------
# Sum of reference and alternative read counts per marker
head(getCountRead(gds, target = "marker")) 
# Sum of reference and alternative read counts per sample
head(getCountRead(gds, target = "sample")) 

## -----------------------------------------------------------------------------
# Mean of reference allele read count per marker
head(getMeanReadRef(gds, target = "marker")) 
# Mean of reference allele read count per sample
head(getMeanReadRef(gds, target = "sample"))

## -----------------------------------------------------------------------------
# Mean of Alternative allele read count per marker
head(getMeanReadAlt(gds, target = "marker")) 
# Mean of Alternative allele read count per sample
head(getMeanReadAlt(gds, target = "sample")) 

## -----------------------------------------------------------------------------
# SD of reference allele read count per marker
head(getSDReadRef(gds, target = "marker")) 
# SD of reference allele read count per sample
head(getSDReadRef(gds, target = "sample")) 

## -----------------------------------------------------------------------------
# SD of Alternative allele read count per marker
head(getSDReadAlt(gds, target = "marker")) 
# SD of Alternative allele read count per sample
head(getSDReadAlt(gds, target = "sample"))

## -----------------------------------------------------------------------------
# Minor allele frequency per marker
head(getMAF(gds, target = "marker")) 
# Minor allele frequency per sample
head(getMAF(gds, target = "sample")) 

## -----------------------------------------------------------------------------
# Minor allele count per marker
head(getMAC(gds, target = "marker")) 
# Minor allele count per sample
head(getMAC(gds, target = "sample")) 

## -----------------------------------------------------------------------------
head(getCountGenoRef(gds, target = "marker", prop = TRUE))
head(getCountGenoHet(gds, target = "marker", prop = TRUE))
head(getCountGenoAlt(gds, target = "marker", prop = TRUE))
head(getCountGenoMissing(gds, target = "marker", prop = TRUE))

## -----------------------------------------------------------------------------
head(getCountAlleleRef(gds, target = "marker", prop = TRUE))
head(getCountAlleleAlt(gds, target = "marker", prop = TRUE))
head(getCountAlleleMissing(gds, target = "marker", prop = TRUE))

## -----------------------------------------------------------------------------
head(getCountReadRef(gds, target = "marker", prop = TRUE))
head(getCountReadAlt(gds, target = "marker", prop = TRUE))

## -----------------------------------------------------------------------------
gds <- setMarFilter(gds, missing = 0.2, het = c(0.1, 0.9), maf = 0.05)
gds <- setSamFilter(gds, missing = 0.8, het = c(0.25, 0.75))

## -----------------------------------------------------------------------------
gds <- setCallFilter(gds, dp_count = c(5, Inf))

## -----------------------------------------------------------------------------
# Filtering genotype calls based on total read counts
gds <- setCallFilter(gds, dp_qtile = c(0, 0.9))

# Filtering genotype calls based on reference read counts 
# and alternative read counts separately.
gds <- setCallFilter(gds, ref_qtile = c(0, 0.9), alt_qtile = c(0, 0.9))

## -----------------------------------------------------------------------------
gds <- setCallFilter(gds, dp_count = c(5, Inf))
gds <- setMarFilter(gds, missing = 0.2)

## -----------------------------------------------------------------------------
gds <- setCallFilter(gds, ref_qtile = c(0, 0.9), alt_qtile = c(0, 0.9))
invalid_mar <- getMarID(gds)[1:5]
gds <- setMarFilter(gds, id = invalid_mar)
invalid_sam <- getSamID(gds)[1:3]
gds <- setSamFilter(gds, id = invalid_sam)

## -----------------------------------------------------------------------------
# Here we select only one marker from each 150 bp stretch.
gds <- thinMarker(gds, range = 150) 

## -----------------------------------------------------------------------------
gds <- countGenotype(gds, node = "filt")
gds <- countRead(gds, node = "filt")

## -----------------------------------------------------------------------------
head(validMar(gds))
head(validSam(gds))

## -----------------------------------------------------------------------------
nmar(gds)
nmar(gds, valid = FALSE)

## -----------------------------------------------------------------------------
# Reset the filter on markers
gds <- resetMarFilter(gds) 

# Reset the filter on samples
gds <- resetSamFilter(gds) 

# Reset the filter on calls
gds <- resetCallFilter(gds) 

# Reset all filters
gds <- resetFilter(gds) 

## -----------------------------------------------------------------------------
sample_id <- getSamID(gds, valid = FALSE)
sample_id

## -----------------------------------------------------------------------------
gds <- setReplicates(gds, replicates = rep(1:51, each = 2))

## -----------------------------------------------------------------------------
rep_of_parent1 <- sample_id %in% c("Founder1", "F2_1054", "F2_1022")
rep_of_parent2 <- sample_id %in% c("Founder2", "F2_1178", "F2_1637")
sample_id[rep_of_parent1] <- "Founder1"
sample_id[rep_of_parent2] <- "Founder2"
gds <- setReplicates(gds, replicates = sample_id)

## -----------------------------------------------------------------------------
gds <- setReplicates(gds, replicates = seq_len(nsam(gds, valid = FALSE)))

## -----------------------------------------------------------------------------
p1 <- grep("Founder1", getSamID(gds, valid = FALSE), value = TRUE)
p2 <- grep("Founder2", getSamID(gds, valid = FALSE), value = TRUE)
gds <- setParents(gds, parents = c(p1, p2), mono = TRUE, bi = TRUE)

## -----------------------------------------------------------------------------
gds <- countGenotype(gds)

## -----------------------------------------------------------------------------
histGBSR(gds, stats = "missing")

## -----------------------------------------------------------------------------
histGBSR(gds, stats = "het")

## -----------------------------------------------------------------------------
histGBSR(gds, stats = "raf")

## -----------------------------------------------------------------------------
# filter out markers with reference allele frequency
# less than 5% or more than 95%.
gds <- setMarFilter(gds, maf = 0.05) 

## -----------------------------------------------------------------------------
# Filter out samples with more than 90% missing genotype calls,
# less than 5% heterozygosity, and less than 5% minor allele frequency.
gds <- setSamFilter(gds, missing = 0.9, het = c(0.05, 1), maf = 0.05)

## -----------------------------------------------------------------------------
# Filter out genotype calls supported by reads less than 2 reads.
gds <- setCallFilter(gds, dp_count = c(2, Inf))

# Filter out genotype calls supported by reads more than 100.
gds <- setCallFilter(gds, dp_count = c(0, 100))

# Filter out genotype calls based on quantile values 
# of read counts at markers in each sample.
gds <- setCallFilter(gds, ref_qtile = c(0, 0.9), alt_qtile = c(0, 0.9))

## -----------------------------------------------------------------------------
# Remove markers having more than 75% of missing genotype calls
gds <- setMarFilter(gds, missing = 0.2) 
nmar(gds)

## -----------------------------------------------------------------------------
gds <- countGenotype(gds, node = "filt")

## -----------------------------------------------------------------------------
histGBSR(gds, stats = "missing")

## -----------------------------------------------------------------------------
histGBSR(gds, stats = "het")

## -----------------------------------------------------------------------------
histGBSR(gds, stats = "raf")

## -----------------------------------------------------------------------------
plotGBSR(gds, stats = "raf")

## -----------------------------------------------------------------------------
gds <- setMarFilter(gds, maf = 0.25)
nmar(gds)

## -----------------------------------------------------------------------------
gds <- countGenotype(gds)
histGBSR(gds, stats = "missing")

## -----------------------------------------------------------------------------
histGBSR(gds, stats = "het")

## -----------------------------------------------------------------------------
histGBSR(gds, stats = "raf")

## -----------------------------------------------------------------------------
# Marker density
plotGBSR(gds, stats = "marker")

## -----------------------------------------------------------------------------
plotGBSR(gds, stats = "geno")

## -----------------------------------------------------------------------------
# For selfed F2 population
gds <- makeScheme(gds, generation = 2, crosstype = "self")

# For sibling-crossed F2 population
gds <- makeScheme(gds, generation = 2, crosstype = "sib")

# For selfed F5 population
gds <- makeScheme(gds, generation = 5, crosstype = "self")

# For F1 population
gds <- makeScheme(gds, generation = 1) # the crosstype argument will be ignored.

## ----eval=FALSE---------------------------------------------------------------
# # Do not run.
# gds <- setParents(gds,
#                   parents = c("p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8"))
# # Member IDs will be 1, 2, 3, 4, 5, 6, 7, and 8
# # for p1, p2, p3, p4, p5, p6, p7, and p8, respectively.

## -----------------------------------------------------------------------------
# As always the first step of breeding scheme would be "pairing" cross(es) of 
# parents, never be "selfing" and a "sibling" cross,
# the argument `crosstype` in initScheme() was deprecated on the update on April 6, 2023.
# gds <- initScheme(gds, crosstype = "pairing", mating = matrix(1:2, 2))
gds <- initScheme(gds, mating = rbind(1, 2))
gds <- addScheme(gds, crosstype = "selfing")

## -----------------------------------------------------------------------------
getParents(gds)

## ----eval=FALSE---------------------------------------------------------------
# # As always the first step of breeding scheme would be "pairing" cross(es) of
# # parents, never be "selfing" and a "sibling" cross,
# # the argument `crosstype` in initScheme() was deprecated on the update on April 6, 2023.
# # gds <- initScheme(gds, crosstype = "pair", mating = cbind(c(1:2), c(3:4), c(5:6), c(7:8)))
# 
# # Do not run.
# gds <- initScheme(gds, mating = cbind(c(1:2), c(3:4), c(5:6), c(7:8)))

## ----eval=FALSE---------------------------------------------------------------
# # Do not run.
# gds <- addScheme(gds, crosstype = "pair", mating = cbind(c(9:10), c(11:12)))
# 
# # Check IDs.
# showScheme(gds)

## ----eval=FALSE---------------------------------------------------------------
# # Do not run.
# gds <- addScheme(gds, crosstype = "pair", mating = cbind(c(13:14)))
# 
# #' # Check IDs.
# showScheme(gds)

## ----eval=FALSE---------------------------------------------------------------
# # Inbreeding by five times selfing.
# # Do not run.
# gds <- addScheme(gds, crosstype = "self")
# gds <- addScheme(gds, crosstype = "self")
# gds <- addScheme(gds, crosstype = "self")
# gds <- addScheme(gds, crosstype = "self")
# gds <- addScheme(gds, crosstype = "self")

## ----eval=FALSE---------------------------------------------------------------
# # Do not run.
# gds <- setParents(object = gds,
#                   parents = c("Founder1", "Founder2", "Founder3", "Founder4"))
# gds <- initScheme(object = gds,
#                   mating = cbind(c(1, 2), c(1, 3), c(1,4)))
# # The initScheme() function here automatically set 5, 6, and 7 as member ID to
# # the progenies of the above maiting (pairing) combinations, respectively.
# 
# # Then you have to assign member IDs to your samples to indicate which sample
# # belongs to which pedigree.
# gds <- assignScheme(object = gds,
#                     id = c(rep(5, 10), rep(6, 15), rep(7, 20)))

## ----eval=FALSE---------------------------------------------------------------
# # Do not run.
# # Get sample ID
# sample_id <- getSamID(object = gds)
# 
# # Initialize the id vector
# id <- integer(nsam(gds))
# 
# # Assume your samples were named with prefixes that indicate which
# # sample was derived from which combination of parents.
# id[grepl("P1xP2", sample_id)] <- 5
# id[grepl("P1xP3", sample_id)] <- 6
# id[grepl("P1xP4", sample_id)] <- 7
# gds <- assignScheme(object = gds, id = id)

## ----message=FALSE, results=FALSE---------------------------------------------
gds <- estGeno(gds, node = "filt", iter = 4)

## ----eval=FALSE---------------------------------------------------------------
# # Do nut run
# # This is an example to show the case to use "het_parents = TRUE".
# gds <- estGeno(gds, het_parent = TRUE, iter = 4)

## ----eval=FALSE---------------------------------------------------------------
# # Following codes do the same.
# 
# # Do nut run
# # These are examples to show the case to set "iter = 1" or "optim = FALSE".
# gds <- estGeno(gds, iter = 1)
# gds <- estGeno(gds, optim = FALSE)

## -----------------------------------------------------------------------------
est_geno <- getGenotype(gds, node = "cor")

## -----------------------------------------------------------------------------
parent_geno <- getGenotype(gds, node = "parents")

## -----------------------------------------------------------------------------
est_hap <- getHaplotype(gds)

## -----------------------------------------------------------------------------
out_fn <- tempfile("sample_est", fileext = ".vcf.gz")
gbsrGDS2VCF(gds, out_fn)
gbsrGDS2VCF(gds, out_fn, node = "cor")

## -----------------------------------------------------------------------------
out_fn <- tempfile("sample_est", fileext = ".csv")
gbsrGDS2CSV(gds, out_fn)
gbsrGDS2CSV(gds, out_fn, node = "cor")

## -----------------------------------------------------------------------------
out_fn <- tempfile("sample_est", fileext = ".csv")
gbsrGDS2CSV(gds, out_fn, format = "qtl")
gbsrGDS2CSV(gds, out_fn, node = "cor", format = "qtl")

## -----------------------------------------------------------------------------
gds <- reopenGDS(gds)

## -----------------------------------------------------------------------------
plotReadRatio(x = gds, coord = c(3, 4), ind = 3, node = "raw", size = 2)

## ----eval = FALSE-------------------------------------------------------------
# for(i in seq_len(nsam(gds))){
# plotReadRatio(x = gds, coord = c(3, 4), ind = i, node = "raw")
# }

## -----------------------------------------------------------------------------
plotReadRatio(x = gds, coord = c(3, 4), ind = 3, node = "filt", size = 2)

## -----------------------------------------------------------------------------
plotDosage(x = gds, coord = c(3, 4), ind = 3, node = "raw", size = 2)

## -----------------------------------------------------------------------------
plotDosage(x = gds, coord = c(3, 4), ind = 3, node = "filt", size = 2)

## -----------------------------------------------------------------------------
closeGDS(gds)

## -----------------------------------------------------------------------------
sessionInfo()


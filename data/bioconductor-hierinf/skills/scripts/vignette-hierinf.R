# Code example from 'vignette-hierinf' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
# load the package
library(hierinf)

# random number generator (for parallel computing)
RNGkind("L'Ecuyer-CMRG")

# We use a small build-in dataset for our toy example.
data(simGWAS)

# The genotype, phenotype and the control variables are saved in
# different objects.
sim.geno  <- simGWAS$x
sim.pheno <- simGWAS$y
sim.clvar <- simGWAS$clvar

## -----------------------------------------------------------------------------
# Define the second level of the tree structure.
block <- data.frame("colname" = paste0("SNP.", 1:1000),
                    "block" = rep(c("chrom 1", "chrom 2"), each = 500),
                    stringsAsFactors = FALSE)

# Cluster the SNPs
dendr <- cluster_var(x = sim.geno,
                     block = block)
                     # # the following arguments have to be specified
                     # # for parallel computation
                     # parallel = "multicore",
                     # ncpus = 2)

## ----eval=FALSE---------------------------------------------------------------
# # Store the positions of the SNPs.
# position <- data.frame("colnames" = paste0("SNP.", 1:1000),
#                        "position" = seq(from = 1, to = 1000),
#                        stringsAsFactors = FALSE)
# 
# 
# # Build the hierarchical tree based on the position
# # The argument block defines the second level of the tree structure.
# dendr.pos <- cluster_position(position = position,
#                               block = block)
#                               # # the following arguments have to be
#                               # # specified for parallel computation
#                               # parallel = "multicore",
#                               # ncpus = 2)

## -----------------------------------------------------------------------------
# Test the hierarchy using multi sample split
set.seed(1234)
result <- test_hierarchy(x = sim.geno,
                         y = sim.pheno,
                         clvar = sim.clvar,
                         # alternatively: dendr = dendr.pos
                         dendr = dendr,
                         family = "binomial")
                         # # the following arguments have to be
                         # # specified for parallel computation
                         # parallel = "multicore",
                         # ncpus = 2)

## -----------------------------------------------------------------------------
print(result, n.terms = 4)

## -----------------------------------------------------------------------------
(coln.cluster <- result$res.hierarchy[[2, "significant.cluster"]])

## -----------------------------------------------------------------------------
compute_r2(x = sim.geno, y = sim.pheno, clvar = sim.clvar,
           res.test.hierarchy = result, family = "binomial",
           colnames.cluster = coln.cluster)

## -----------------------------------------------------------------------------
# The datasets need to be stored in different elements of a list.
# Note that the order has to be the same for all the lists.
# As a simple example, we artificially split the observations of the
# toy dataset in two parts, i.e. two datasets.
set.seed(89)
ind1 <- sample(1:500, 250)
ind2 <- setdiff(1:500, ind1)
sim.geno.2dat  <- list(sim.geno[ind1, ],
                       sim.geno[ind2, ])
sim.clvar.2dat <- list(sim.clvar[ind1, ],
                       sim.clvar[ind2, ])
sim.pheno.2dat <- list(sim.pheno[ind1],
                       sim.pheno[ind2])

# Cluster the SNPs
dendr <- cluster_var(x = sim.geno.2dat,
                     block = block)
                     # # the following arguments have to be specified
                     # # for parallel computation
                     # parallel = "multicore",
                     # ncpus = 2)

# Test the hierarchy using multi sample split
set.seed(1234)
result <- test_hierarchy(x = sim.geno.2dat,
                         y = sim.pheno.2dat,
                         clvar = sim.clvar.2dat,
                         dendr = dendr,
                         family = "binomial")
                         # # the following arguments have to be
                         # # specified for parallel computation
                         # parallel = "multicore",
                         # ncpus = 2)

## -----------------------------------------------------------------------------
print(result, n.terms = 4)


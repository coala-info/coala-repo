# Use of the GADGETS method to identify multi-SNP effects in nuclear families

Michael Nodzenski1,2,3\*

1Department of Biostatistics, University of North Carolina, Chapel Hill, NC
2Graduate Partnerships Program, National Institutes of Health, Bethesda, MD
3Biostatistics and Computational Biology Branch, National Institute of Environmental Health Sciences, Research Triangle Park, NC

\*michael.nodzenski@gmail.com

#### July 15, 2021

#### Package

epistasisGA 1.12.0

# 1 Introduction

While methods for characterizing marginal relationships between individual SNPs and disease status have been well developed in high throughput genetic association studies of complex diseases, identifying joint associations between collections of genetic variants and disease remains challenging. To date, studies have overwhelmingly focused on detecting variant-disease associations on a SNP by SNP basis. Doing so allows researchers to scan millions of SNPs for evidence of association with disease, but only SNPs with large marginal disease associations can be identified, missing collections of SNPs with large joint disease associations despite small marginal associations. For many diseases, it is hypothesized that increased penetrance may result from the joint effect of variants at multiple susceptibility loci, suggesting methods focused on identifying multi-SNP associations may offer greater insight into the genetic architecture of complex diseases.

The epistasisGA package presents one such approach. In this package, we implement the GADGETS method (Nodzenski\* et al. [2022](#ref-GADGET2020)) for identifying multi-SNP disease associations in case-parent triad or affected/unaffected sibling-pair studies. Briefly, GADGETS uses a “genetic algorithm” (GA) (Holland [1975](#ref-holland)) to identify collections of risk-relevant SNPs. Genetic algorithms are a class of general purpose optimization algorithms particularly well suited to combinatorial optimization for high dimensional problems. While we use a GA in the context of population genetics, genetic algorithms were not originally developed for genetic studies and can be used to solve a broad variety of problems. In a typical genetic algorithm, optimal solutions are identified by mimicking the process of Darwinian natural selection. In the first iteration of the algorithm, or ‘generation’, a set of potential solutions, collectively known as a ‘population’ with each population component referred to as a ‘chromosome’, is sampled. Individual chromosomes are made up of finite sets of discrete elements, just as biological chromosomes are comprised of SNPs. Unlike biological chromosomes, however, GA ‘chromosomes’ are unordered sets. A user defined function then assigns a ‘fitness score’ to each chromosome, with the fitness score constructed such that better solutions have higher fitness scores. Then, the chromosomes are subjected to ‘crossing over’, where component elements of different chromosomes are exchanged, and ‘mutation’, where component elements are arbitrarily replaced, to generate a new population for the next generation. Chromosomes with higher fitness scores are preferentially selected to produce ‘offspring’, analogous to how organisms with higher fitness reproduce more effectively under natural selection. The scoring and mutation/crossing over process continues iteratively until stopping criteria have been achieved, hopefully resulting in one or more acceptable solutions to the optimization problem. To maintain population diversity and help avoid premature convergence, GADGETS implements what is known as an ‘island model’ GA (Andre and Koza [1996](#ref-island1996)), where multiple ‘island’ populations are evolved in parallel with limited ‘migration’ of chromosomes among islands permitted at pre-specified intervals of generations.

In GADGETS, the term ‘chromosome’ refers to a collection or subset of SNPs we wish to examine for evidence of a strong multi-SNP association with disease. To be clear, these SNPs need not be located on the same biological chromosome. The details of the fitness score function and crossover/mutation operations are given in (Nodzenski\* et al. [2022](#ref-GADGET2020)), but in short, the intuitive aim is to assign high scores to collections of SNPs that are jointly carried by the disease affected children (cases) much more frequently than not. For affected/unaffected sibling-pairs, we operationalize this by comparing the paired sibling genotypes. For case-parent triads, we imagine a possible sibling for each case based on the alleles that were not transmitted, which we call the ‘complement’, and we compare the frequency with which subsets of SNPs are jointly transmitted to cases versus complements. Importantly, we do not assume a single subset of risk-relevant SNPs, so GADGETS does not directly output a single optimal subset but rather a number provisionally interesting collections of SNPs. Some final processing is therefore required to carry out overall inference and to tease out the actual risk-relevant subset(s) of SNPs.

As a final note, users should be aware this method does not currently scale up to genome wide, but it does accommodate larger numbers of input SNPs than comparable methods. In our simulations, we have used up to 10,000 input SNPs, but users are encouraged to experiment with larger numbers if desired.

# 2 Basic Usage

## 2.1 Load Data

We begin our example usage of GADGETS by loading a simulated example of case-parent triad data.

```
library(epistasisGA)
data(case)
case <- as.matrix(case)
data(dad)
dad <- as.matrix(dad)
data(mom)
mom <- as.matrix(mom)
```

These data were simulated based on a case-parent triad study of children with orofacial-clefts using the method described by Shi et al. ([2018](#ref-Shi2018)) for triads consisting of mothers, fathers, and affected children. For each dataset, the rows correspond to families, and the columns correspond to SNPs. Because this is a small example just for illustration, each of these datasets includes only 100 SNPs. The SNPs in columns 51, 52, 76, and 77 are a true risk pathway (rs1731422, rs4237892, rs7985535, rs1487251), where the joint combination of variants substantially increases the penetrance compared to other genotypes.

At present, GADGETS does not support the use of genotypes imputed with uncertainty (genotype ‘dosages’), so the most likely genotype should be used for any imputed SNPs. GADGETS does, however, support missing genotypes. If a genotype is missing for a particular SNP in any family member, that genotype will be set to missing (-9) for all members of the family, and the family will be considered uninformative for that SNP.

## 2.2 Pre-process Data

The second step in the analysis pipeline is to pre-process the data. Below, we default to the assumption that SNPs located on the same biological chromosome are in linkage, but users need not make this assumption and are encouraged to more carefully tailor this argument based on individual circumstances by using instead a measure of genetic distance or, perhaps, of LD. If choosing LD, we recommend using external data for determining LD.

For the example data, the SNPs are drawn from chromosomes 10-13, with the columns sorted by chromosome and 25 SNPs per chromosome. We therefore construct the vector as follows:

```
ld.block.vec <- rep(25, 4)
```

This vector indicates that the input genetic data has 4 distinct linkage blocks, with SNPs 1-25 in the first block, 26-50 in the second block, 51-75 in the third block, and 76-100 in the fourth block. Note the ordering of the columns in the input triad data must be consistent with the specified LD structure.

Now, we can execute pre-processing:

```
pp.list <- preprocess.genetic.data(case, father.genetic.data = dad,
                                   mother.genetic.data = mom,
                                   ld.block.vec = ld.block.vec)
```

For affected/unaffected sibling study, the sibling genetic data should be supplied as the `complement.genetic.data` argument:

```
### FOR ILLUSTRATION ONLY, DO NOT TRY TO RUN THIS CHUNK ###
pp.list <- preprocess.genetic.data(affected.sibling.genotypes,
                                   complement.genetic.data = unaffected.sibling.genotypes,
                                   ld.block.vec = ld.block.vec)
```

GADGETS can also accommodate studies with a mix of triads and unaffected/affected siblings. To input this kind of data, analysts would first need to generate the ‘complement’ data for triads, as follows:

```
complement <- mom + dad - case
```

Then the unaffected sibling genotypes should be concatenated with the complement data, and, similarly, the triad case genotypes and affected sibling genotypes should be concatenated, and these genotype matrices should be entered as the `complement.genetic.data` and `case.genetic.data` arguments for `preprocess.genetic.data`:

```
### STILL JUST FOR ILLUSTRATION ###
combined.case <- rbind(case, affected.sibling.genotypes)
combined.complement <- rbind(complement, unaffected.sibling.genotypes)
pp.list <- preprocess.genetic.data(case.genetic.data = combined.case,
                                   complement.genetic.data = combined.complement,
                                   ld.block.vec = ld.block.vec)
```

Importantly, X chromosome SNPs can be used as candidates for GADGETS, but some extra attention is required. Specifically, for affected/unaffected sibling data, both siblings in each pair should be of the same biological sex. For case-parent triad data, the ‘complement’ should be assumed to be of the same sex as the case. As a consequence, analysts must input triad data containing X chromosome SNPs as `case.genetic.data` and `complement.genetic.data`, as shown above, after manually creating the complement data for these triads. To do so, autosomal SNP complements should still be created as above (mother genotype + father genotype - case genotype), but the X chromosome SNP complement genotypes should be the allele transmitted by the father to the case *and* the allele *not* transmitted by the mother to the case. Note this will result in male X chromosome SNP case and complement genotypes being coded as 0 or 1, compared to 0, 1, or 2 for females. If males and females are both contained in the analysis dataset, analysts may wish to double male X chromosome SNP allele counts (male genotype 1 re-coded as 2) because half of the X copies are typically silenced in females. This, however, is not required and analysts can decide on a SNP-by-SNP basis. Alternatively, GADGETS could be run separately for males and females, in which case doubling male X chromosome allele counts would not be necessary.

The `preprocess.genetic.data` function performs a few disparate tasks that users should note. First, it identifies the minor allele for each input SNP based on the observed frequency in the mothers and fathers (or both siblings in sibling studies). The coding is then flipped for any SNPs where the allele count corresponds to the major allele. The identities of these re-coded SNPs can be found in the output from `preprocess.genetic.data`. Afterwards, any SNPs with minor allele frequency below a given value, 0% by default (no filtering), are removed. Following SNP filtering, \(\chi^2\) statistics for univariable SNP-disease associations are computed for each SNP assuming a log-additive model using the method of conditioning on the set of transmitted and untransmitted genotypes, regardless of phase, described by Cordell and Clayton ([2002](#ref-Cordell2002)). These statistics are used in GADGETS when SNPs are sampled for mutation, with the sampling probability for a given SNP proportional to its \(\sqrt{\chi^2}\) value. Alternatively, users can manually specify a vector proportional to SNP sampling probabilities using argument `snp.sampling.probs`. This may be of interest to users who wish to incorporate prior biological or expert knowledge into the algorithm to prioritize sampling a subset of particularly interesting SNPs.

## 2.3 Run GADGETS

We now use GADGETS to identify interesting collections of SNPs that appear to be jointly risk-related using the `run.gadgets` function. The method requires a number of tuning parameters, but the function defaults are a good starting point. More information regarding these parameters can be found in the package documentation and the paper describing the method (Nodzenski\* et al. [2022](#ref-GADGET2020)). Briefly, GADGETS requires the user to pre-specify the number of SNPs that may be jointly associated with disease status. This is controlled by the `chromosome.size` argument. We recommend running the algorithm for a range of sizes, typically 2-6. For this simple example, however, we will only examine sizes 3 and 4.

Note that `run.gadgets` does not output results directly to the R session, it will instead write results to the directory specified in `results.dir`. Furthermore, as mentioned previously, GADGETS uses a technique known as an ‘island model’ to identify potentially interesting collections of SNPs. Each ‘island’ corresponds to a separately initialized population of `n.chromosomes` chromosomes, with each chromosome comprised of `chromosome.size` SNPs and each island randomly assigned to cluster of `island.cluster.size` islands. When GADGETS is run, each island’s population evolves independently for intervals of a pre-specified number of generations (controlled by argument `migration.generations`) after which the top `n.migrations` chromosomes from each island ‘migrate’ to other islands in the cluster. This continues until each island in the cluster converges or the maximum number of generations (argument `generations`) is reached. Island clusters evolve completely independently from one another and, where computational resources permit, in parallel. Results for each island (argument `n.islands`) are written separately to `results.dir`.

```
run.gadgets(pp.list, n.chromosomes = 5, chromosome.size = 3,
       results.dir = "size3_res", cluster.type = "interactive",
       registryargs = list(file.dir = "size3_reg", seed = 1300),
       n.islands = 8, island.cluster.size = 4,
       n.migrations = 2)

run.gadgets(pp.list, n.chromosomes = 5, chromosome.size = 4,
       results.dir = "size4_res", cluster.type = "interactive",
       registryargs = list(file.dir = "size4_reg", seed = 1400),
       n.islands = 8, island.cluster.size = 4,
       n.migrations = 2)
```

The population size argument, `n.chromosomes`, does not have a default, so users need to carefully consider how to specify this parameter. In general, run-times are faster with smaller populations, but decreasing the population size may increase the chance of failing to identify true risk pathways. However, this behavior is also depends on parameters `n.islands` and `island.cluster.size`. Broadly, our goal is to maximize the number of distinct subsets of SNPs we examine for evidence of association with disease while maintaining acceptable run-times. Because the package allows island clusters to evolve in parallel, we generally pay less of a run-time price for large island numbers compared to large population sizes. We therefore typically choose to run many islands in small clusters with relatively small population sizes. More concretely, in simulations involving 10,000 input SNPs, we have observed good performance using 1,000 islands in clusters of 4 with populations of 200 chromosomes per island.

The `cluster.type` and `registry.args` parameters are also important. For the above example, the “interactive” cluster type indicates that all islands run sequentially in the R session. However this is not how we anticipate `run.gadgets` will be used in most cases. Rather, we strongly recommend this function be used with high-performance computing clusters to avoid prohibitively long run-times. An example (not run) of this type of command is given below:

```
### FOR ILLUSTRATION ONLY, DO NOT TRY TO RUN THIS CHUNK ###

library(BiocParallel)
fname <- batchtoolsTemplate("slurm")
run.gadgets(pp.list, n.chromosomes = 20, chromosome.size = 3,
       results.dir = "size3_res", cluster.type = "slurm",
       registryargs = list(file.dir = "size3_reg", seed = 1300),
       cluster.template = fname,
       resources = list(chunks.as.arrayjobs = TRUE),
       n.islands = 12,
       island.cluster.size = 4)
```

The `cluster.template` must be properly calibrated to the user’s HPC cluster. Packages *[batchtools](https://CRAN.R-project.org/package%3Dbatchtools)* and *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)* both contain good documentation on how to construct these files. It is also possible to run `run.gadgets` on a single machine with multiple cores (see `run.gadgets` documentation).

Regardless of the chosen `cluster.type`, `run.gadgets` uses the functionality from package *[batchtools](https://CRAN.R-project.org/package%3Dbatchtools)* to run jobs. In the case of HPC cluster use, with a properly configured `cluster.template`, users simply need to execute `run.gadgets` from an interactive R session and the jobs will be submitted to and executed on the cluster. This approach is well described in section 4.3.2 of the vignette “Introduction to BiocParallel” from package *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)*. Depending on `cluster.type`, jobs may take minutes to hours to complete. The status of jobs can be queried using the functions in package *[batchtools](https://CRAN.R-project.org/package%3Dbatchtools)*, most commonly `getStatus`. For users of HPC clusters, commands such as ‘squeue’ can also be used. For larger numbers of submissions, users may also construct their own automated scripts for checking that jobs have successfully completed. Perhaps the most obvious indication of a job failure is the `results.dir` will not contain `n.islands` distinct sets of results. This is particularly important when running jobs on an HPC cluster, where jobs may fail relatively cryptically. In the case of job failure due to problems with cluster schedulers (jobs fail to launch, node failure, etc.), the failed jobs can be re-run using the exact same `run.gadgets` command. The function will automatically identify the island jobs that still need to be run, and submit only those. This is also true for users running jobs on personal machines, who need to stop computations before all island results are available.

Once users have confirmed `run.gadgets` has completed and run properly, the sets of results across islands should be condensed using the function `combine.islands`. Note that in addition to the results directory path, the function requires as input a data.frame indicating the RSIDs (or a placeholder name), reference, and alternate alleles for each SNP in the data passed to `preprocess.genetic.data` as well as the list output by `preprocess.genetic.data`.

```
data(snp.annotations)
size3.combined.res <- combine.islands("size3_res", snp.annotations,
                                      pp.list)
size4.combined.res <- combine.islands("size4_res", snp.annotations,
                                      pp.list)
```

Importantly, the function will write these results to the specified directory. The function condenses island results such that the rows are sorted in decreasing order according to fitness score, or, more plainly, with the most interesting SNPs appearing at the top of the dataset:

```
library(magrittr)
library(knitr)
library(kableExtra)
kable(head(size4.combined.res)) %>%
  kable_styling() %>%
  scroll_box(width = "750px")
```

| snp1 | snp2 | snp3 | snp4 | snp1.rsid | snp2.rsid | snp3.rsid | snp4.rsid | snp1.risk.allele | snp2.risk.allele | snp3.risk.allele | snp4.risk.allele | snp1.diff.vec | snp2.diff.vec | snp3.diff.vec | snp4.diff.vec | snp1.allele.copies | snp2.allele.copies | snp3.allele.copies | snp4.allele.copies | fitness.score | n.cases.risk.geno | n.comps.risk.geno | chromosome | n.islands.found |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 51 | 52 | 76 | 77 | rs1731422 | rs4237892 | rs7985535 | rs1487251 | A | C | T | T | 0.7066807 | 0.8052581 | 0.6216295 | 0.7066309 | 1+ | 1+ | 1+ | 1+ | 18.18996 | 37 | 0 | 51.52.76.77 | 8 |

In this case, we see that the SNPs corresponding to rs1731422, rs4237892, rs7985535, and rs1487251 are the top collection, or, more simply, the group of 4 SNPs identified as most likely to exhibit a joint association with disease status. Note that these are the actual SNPs simulated to exhibit a joint effect, so we have identified the true risk pathway. In real applications, we anticipate GADGETS will nominate multiple distinct SNP-sets for further follow-up study.

Perhaps the most important elements of the output are the `n.cases.risk.geno`and `n.comps.risk.geno`columns. These report the number of cases and complements/unaffected siblings with the provisional risk genotypes, as determined by GADGETS, at each locus, among families where only one of the case and complement carries the risk genotype. For true epistatic SNP-sets, many more cases should carry the risk genotypes at each locus than the complements.

A few important but subtle components of the results users should note are the `risk.allele`, `allele.copies`, `diff.vec`, `fitness.score`, and `n.islands.found` columns. For a given SNP within a chromosome, the corresponding `risk.allele` column reports the proposed risk-related nucleobase and the `allele.copies` column indicates the required number of copies for the proposed risk pathway. A ‘1+’ indicates at least one copy of the risk allele is needed, while ‘2’ indicates two copies are required. The `n.islands.found` column reports the number of distinct islands on which a specific chromosome was found. The `diff.vec` columns also may be descriptively interesting to some users. A positive value for a given SNP indicates the minor allele is positively associated with disease status, while a negative value implies the reference (‘wild type’) allele is positively associated with the disease. More generally, these values should be large in magnitude when a SNP is transmitted to cases much more often than complements. For true multi-SNP risk pathways, we expect pathway SNPs to be jointly transmitted to cases more often than compliments, therefore the magnitude of the `diff.vec` values should be large across the pathway. As such, high scoring chromosomes containing a subset of SNPs with small magnitude `diff.vec` values offer descriptive evidence that some of the chromosome’s SNPs are not jointly transmitted to the cases and suggest a smaller chromosome size may be warranted. In the case of the true risk pathway SNPs, all `diff.vec` values are positive and reasonably large, and all `allele.copies` columns are ‘1+’ indicating the risk pathway requires having at least one copy of the minor allele for all 4 SNPs.

## 2.4 Global Permutation Test

This section outlines how to run a global permutation test. This is very computationally intensive for most use cases and is best performed on a high-performance computing cluster. For the purpose of creating network plots, results can be obtained without this global test. If not running the global test, skip to the section on visualizing results.

### 2.4.1 Permute Datasets

Of course, in real studies we do not know the identity of true risk pathways. We would therefore like a way to determine whether the results from the observed data are consistent with what we expect under the global null hypothesis of no association between any input SNPs and disease status. We do so via permutation testing. Maintaining the case/complement (or case/unaffected sibling) nomenclature from above, in permuting the data, we randomly flip or do not flip the the disease status labels. We create these permuted datasets using the `permute.dataset` command. Here we generate 4 different permuted datasets. In real applications, users are advised to generate at least 100, more if computationally feasible.

```
set.seed(1400)
permute.dataset(pp.list,
                permutation.data.file.path = "perm_data",
                n.permutations = 4)
```

### 2.4.2 Re-Run GADGETS

Once we have created the permuted datasets, for each permutation, we perform exactly the same sequence of analyses shown above. Users should note this step is by far the most time consuming of the workflow and almost certainly requires access to a computing cluster. However, since this vignette provides only a very small example, we are able to run the analyses locally. We begin by pre-processing the permuted datasets:

```
preprocess.lists <- lapply(seq_len(4), function(permutation){

  case.perm.file <- file.path("perm_data", paste0("case.permute", permutation, ".rds"))
  comp.perm.file <- file.path("perm_data", paste0("complement.permute", permutation, ".rds"))
  case.perm <- readRDS(case.perm.file)
  comp.perm <- readRDS(comp.perm.file)

  preprocess.genetic.data(case.perm,
                          complement.genetic.data = comp.perm,
                          ld.block.vec = ld.block.vec)
})
```

Then, we run GADGETS on each permuted dataset for each chromosome size and condense the results:

```
#specify chromosome sizes
chrom.sizes <- 3:4

#specify a different seed for each permutation
seeds <- 4:7

#run GADGETS for each permutation and size
lapply(chrom.sizes, function(chrom.size){

  lapply(seq_len(4), function(permutation){

    perm.data.list <- preprocess.lists[[permutation]]
    seed.val <- chrom.size*seeds[permutation]
    res.dir <- paste0("perm", permutation, "_size", chrom.size, "_res")
    reg.dir <- paste0("perm", permutation, "_size", chrom.size, "_reg")
    run.gadgets(perm.data.list, n.chromosomes = 5,
           chromosome.size = chrom.size,
           results.dir = res.dir, cluster.type = "interactive",
           registryargs = list(file.dir = reg.dir, seed = seed.val),
           n.islands = 8, island.cluster.size = 4,
           n.migrations = 2)

  })

})

#condense the results
perm.res.list <- lapply(chrom.sizes, function(chrom.size){

  lapply(seq_len(4), function(permutation){

    perm.data.list <- preprocess.lists[[permutation]]
    res.dir <- paste0("perm", permutation, "_size", chrom.size, "_res")
    combine.islands(res.dir, snp.annotations, perm.data.list)

  })

})
```

### 2.4.3 Run Global Test

Now we are ready to more formally examine whether our results are consistent with what would be expected under the null hypothesis of no association between the input variants and disease status. Our first step is to run a global test across all chromosome sizes examining whether the fitness scores from the observed data are drawn from the distribution expected under the null. Briefly, for each chromosome size separately, we sum the fitness scores of the top \(k\) chromosomes for the observed data and each permuted dataset. We then rank the observed sum compared to the corresponding chromosome size specific sums for each permuted dataset. Letting \(R\_d\) denote the rank for chromosome size \(d\), with 1 denoting the rank of the smallest sum of fitness scores, and with \(N\) denoting the the number of permutes plus 1, we compute \(T\_d = -2ln((N - R\_d + 0.5)/N)\). The test is based on summing \(T\_d\) over chromosome sizes, \(T = \sum\_d{T\_d}\). We also compute this statistic for each permuted dataset and compute a permutation-based p-value using the \(N\) values for \(T\). Intuitively, this test assesses whether the top-scoring chromosomes are consistently higher than null data across chromosome sizes.

A key feature of this approach is the test does not require adjustment for multiple comparisons despite the very large number of combinations being considered by the GA. The test is implemented in function `global.test`, with \(k\) specified by argument `n.top.scores`. We generally specify `n.top.scores = 10`, but for this illustrative example, we only use 5. When GADGETS returns fewer than `n.top.scores` chromosomes for a given chromosome size for either the observed data or any permute, say \(l^\*\) chromosomes, the global test will be automatically computed using the top \(l^\*\) for that chromosome size. Note that the number of chromosomes actually used to compute the global test for each chromosome size will be stored in the `chrom.size.k` element of the `global.test` output.

```
# chromosome size 3 results

# function requires a list of vectors of
# permutation based fitness scores
chrom3.perm.fs <- lapply(perm.res.list[[1]],
                         function(x) x$fitness.score)
chrom3.list <- list(observed.data = size3.combined.res$fitness.score,
                     permutation.list = chrom3.perm.fs)

# chromosome size 4 results
chrom4.perm.fs <- lapply(perm.res.list[[2]],
                         function(x) x$fitness.score)
chrom4.list <- list(observed.data = size4.combined.res$fitness.score,
                     permutation.list = chrom4.perm.fs)

# list of results across chromosome sizes, with each list
# element corresponding to a chromosome size
final.results <- list(chrom3.list, chrom4.list)

# run global test
global.test.res <- global.test(final.results, n.top.scores = 5)

# examine how many chromosomes were used for each  chromosome size
global.test.res$chrom.size.k
```

```
## [1] 1 1
```

```
# look at the global test stat and p-value
global.test.res$obs.test.stat
```

```
## [1] 9.21034
```

```
global.test.res$pval
```

```
## [1] 0.2
```

We see the observed \(T\) for our simple example is 9.2103404 with associated permutation based p-value 0.2. Note the permutation p-values for both for the `global.test` and `epistasis.test` functions are computed as one plus the number of permutation test statistics that exceed the observed test statistic divided the number of permutations plus one (Phipson and Smyth [2010](#ref-phipson)), underscoring the need to run as many permutations as computationally possible. If we overlay the observed \(T\) on a boxplot of the permutations, we see the observed distance is a huge outlier even when taking logs:

![](data:image/png;base64...)

### 2.4.4 Post-hoc Analyses

Regardless of result, it is crucial that users are clear about what the test implies. The null hypothesis is that the observed test statistic is drawn from the null distribution, i.e., that the global patterns of transmissions to cases are not systematically different from those to the corresponding complements or unaffected siblings. In situations where we reject the null hypothesis, of course the conclusion is the observed test statistic is very different from from the null distribution. However, to best characterize results, it is incumbent on users to closely examine results beyond the global test. In particular, we would like to be able to identify the specific subsets of SNPs that are collectively related to risk.

To that end, `global.test` provides additional, chromosome size specific information that users are encouraged to examine. First, users may look at the `obs.marginal.test.stats` and `marginal.pvals` objects from the `global.test` output:

```
global.test.res$obs.marginal.test.stats
```

```
##
## 1 4.60517 4.60517
```

```
global.test.res$marginal.pvals
```

```
## [1] 0.2 0.2
```

The `obs.marginal.test.stats` object reports the fitness score sums for each chromosome size for the observed data. The `marginal.pvals` object reports a permutation p-value for each distinct chromosome size.

Second, users may also wish to examine the `max.obs.fitness` and `max.order.pvals` elements of the output:

```
global.test.res$max.obs.fitness
```

```
## [1]  2.492284 18.189961
```

```
global.test.res$max.order.pvals
```

```
## [1] 0.2 0.2
```

The `max.obs.fitness` element reports the maximum fitness score in the observed data for each chromosome size, and the `max.order.pvals` element reports the corresponding permutation p-values. Given sufficient permutations to estimate the null distribution, these p-values correspond to the test of the null hypothesis that the maximum observed fitness score for a given chromosome size is not greater than what would be expected given no SNP-disease associations. Rejecting the null implies the observed maximum fitness score exceeds what would be expected by random chance.

Finally, the function provides boxplots of the observed vs. permuted fitness scores for each element of the input results list:

```
library(grid)
grid.draw(global.test.res$boxplot.grob)
```

![](data:image/png;base64...)

Note the numbers at the top of the plots correspond to the element of the input results list. In this example, the ‘1’ corresponds to the chromosome size 3 results (the first element of the results list) and the ‘2’ corresponds to the chromosome size 4 results (the second element of the results list). Above, we see the observed fitness scores tend to be higher than the null permutes, especially for chromosome size 4.

Users should also be clear that rejecting the null hypothesis does not necessarily indicate that a collection of SNPs exhibit epistasis. Indeed, we may reject the null simply because we have identified a single SNP with a non-zero marginal disease association. To that end, we provide a permutation based procedure specifically examining evidence for epistasis among a collection of SNPs conditional on the marginal SNP-disease associations. To illustrate, in our example, we might be interested in whether the high score of the top 4 SNP chromosome was attributable to epistasis or at least one large marginal association. We can execute this test as follows:

```
top.snps <- as.vector(t(size4.combined.res[1, 1:4]))
set.seed(10)
epi.test.res <- epistasis.test(top.snps, pp.list)
epi.test.res$pval
```

```
## [1] 9.999e-05
```

The test indicates the observed fitness score is unusual under the assumption of no epistasis among loci and given the observed marginal transmissions to the disease affected children. However, caution is warranted in interpreting this ‘p-value’. The GADGETS stochastic search method identifies SNP-sets that appear to be interacting even under an independent-effects null, so the epistasis test p-value should be interpreted in an exploratory, hypothesis-generating context. If the test were applied to data independent of that used by GADGETS, the p-values could be used for valid hypothesis tests. Otherwise, Nodzenski\* et al. ([2022](#ref-GADGET2020)) referred to these ‘p-values’ instead as ‘h-values’ to emphasize the limitation. We make use of these ‘h-values’ primarily in constructing network plots of potentially interesting SNP-sets.

Users may also receive a warning when executing `epistasis.test` that says “All chromosome SNPs in linkage, returning NA for p-value”. This is generated because the procedure can only run if at least two SNPs are not in linkage, as specified in `ld.block.vec`, otherwise other methods (not provided in this package) are required.

## 2.5 Visualize Results

As a final step in the analytic pipeline, we recommend users examine network plots of the results using function `network.plot`. This may be particularly useful when trying to determine the true number of SNPs involved in multi-SNP risk pathways and to identify those SNPs. For instance, in the example above, the true risk pathway involves 4 SNPS, but we ran GADGETS for chromosome sizes of 3 and 4. For chromosome size 3, we saw that many of the top identified collections of SNPs were subsets of the true 4 SNP pathway. If we didn’t know the true pathway size was 4, a network plot might help make this clearer.

Briefly, we use our epistasis test ‘p-values’ to assign graphical scores to pairs of SNPs identified in top-scoring chromosomes, with higher scores corresponding to lower epistasis p-values (more substantial evidence for epistasis). We then aggregate those pair-scores across chromosome sizes to generate a final collection of SNP-pairs, which we display in a single network plot.

We start by computing the SNP-pair scores using `compute.graphical.scores`. This function takes as required arguments a list of data.tables containing the results from GADGETS run for different chromosome sizes and the list of pre-processed data from the function `preprocess.genetic.data`. The `compute.graphical.scores` function uses the `epistasis.test` function under the hood, so, as mentioned above, if all SNPs are in the same designated linkage block then a warning will print. Due to the way the permutation algorithm works, if a set of SNPs are on the same linkage block, they will not get a good h-value. This is because LD blocks are permuted together, so there will be no variation in the permutations. Thus, they cannot be detected as epistatic, regardless of the underlying truth. This phenomenon may also occur if many SNPs of an epistatic set lie within the same designated LD block. The user may see fit to enforce a different criterion, perhaps based on LD, or perhaps no criterion at all and let all the SNPs permute individually.

**For analysts who have run the permutation-based global test:** we recommend restricting attention to chromosomes with fitness scores higher than what we would expect for null data. Specifically, the `global.test` function output contains a vector, `max.perm.95th.pctl`, that reports the \(95^{th}\) percentile of the maximum observed fitness score across the null permutes for each chromosome size. We restrict our network plots to the chromosomes with fitness scores exceeding the corresponding null threshold for each chromosome size:

```
# vector of 95th percentile of null fitness scores max
chrom.size.thresholds <- global.test.res$max.perm.95th.pctl

# chromosome size 3 threshold
d3.t <- chrom.size.thresholds[1]

# chromosome size 4 threshold
d4.t <- chrom.size.thresholds[2]

# create results list
obs.res.list <- list(size3.combined.res[size3.combined.res$fitness.score >= d3.t, ],
                     size4.combined.res[size4.combined.res$fitness.score >= d4.t, ])
```

**For analysts who have *not* run the permutation-based global test:** we recommend restricting attention to a subset of the top scoring chromosomes for each chromosome size. We have observed good results using the top 10, but we use the top 5 in the illustrative command below:

```
obs.res.list.no.permutes <- list(size3.combined.res[1:5, ], size4.combined.res[1:5, ])
```

Once the results list has been prepared, we generate graphical scores for each SNP-pair. Since we have run the global test, we use the `obs.res.list` results below, but the steps would be exactly the same if we instead used the `obs.res.list.no.permutes` list. Note that for large numbers of top scoring chromosomes, this function may take at least 10-20 minutes to complete.

```
set.seed(10)
graphical.scores <- compute.graphical.scores(obs.res.list, pp.list)
```

Next, we input these pair scores into function `network.plot` to actually plot the data.

```
network.plot(graphical.scores, pp.list, graph.area = 200,
             node.size = 40, vertex.label.cex = 2)
```

![](data:image/png;base64...)

We see the true pathway SNPs appear prominently in this plot. Key features of the plotting approach are (1) the thickness of the SNP-to-SNP line segments is proportional to the log of the graphical score for that pair and (2) the area of each node circle is proportional to the log of the sum of the graphical scores for that SNP. Although not seen in the plot above, dashed connections indicate SNPs in high LD (pairwise \(r^2 \geq 0.1\) by default) in the unaffected siblings/complements.

This function uses the Fruchterman-Reingold force directed graph drawing algorithm, as implemented in the `qgraph` R package. If other layout algorithms are desired, users can specify `plot = FALSE` to `network.plot`, which will return an `igraph` object that can be used for more customized or interactive plotting. For instance, the `igraph` package function `tkplot` allows for interactive plotting of `igraph` objects.

In real applications, there may be too many SNPs for a network plot to fit on a single page. In those instances, we plot a subset of the top scoring pairs. For example, we could plot the top 2 scoring pairs as follows:

```
network.plot(graphical.scores, pp.list,
             n.top.scoring.pairs = 2, graph.area = 10,
             node.size = 40, vertex.label.cex = 2)
```

![](data:image/png;base64...)

As a more minor point, the SNP labels default to the RSIDs provided, as seen in the third and fourth columns of the `pair.scores` object, and the second column of `snp.scores`:

```
head(graphical.scores[["pair.scores"]])
```

```
##     SNP1  SNP2 SNP1.rsid SNP2.rsid pair.score
##    <int> <int>    <char>    <char>      <num>
## 1:    52    77 rs4237892 rs1487251   4.012097
## 2:    52    76 rs4237892 rs7985535   3.606632
## 3:    76    77 rs7985535 rs1487251   3.606632
## 4:    51    52 rs1731422 rs4237892   3.606632
## 5:    51    77 rs1731422 rs1487251   3.606632
## 6:    51    76 rs1731422 rs7985535   2.913485
```

```
head(graphical.scores[["snp.scores"]])
```

```
##      SNP      rsid snp.score
##    <int>    <char>     <num>
## 1:    52 rs4237892  4.012097
## 2:    77 rs1487251  4.012097
## 3:    51 rs1731422  3.606632
## 4:    76 rs7985535  3.606632
```

However, if users desire custom labels, they can do so by changing the corresponding values. For instance, here we label the true risk SNPs with a star and leave all others blank:

```
risk.numbers <- c(51, 52, 76, 77)
graphical.scores[[1]]$SNP1.rsid <- ifelse(graphical.scores[[1]]$SNP1 %in% risk.numbers,
                                          "*", "")
graphical.scores[[1]]$SNP2.rsid <- ifelse(graphical.scores[[1]]$SNP2 %in% risk.numbers,
                                          "*", "")
graphical.scores[[2]]$rsid <- ifelse(graphical.scores[[2]]$SNP %in% risk.numbers, "*", "")
network.plot(graphical.scores, pp.list, graph.area = 200,
             node.size = 40, vertex.label.cex = 10)
```

![](data:image/png;base64...)

# Cleanup and sessionInfo()

```
#remove all example directories
perm.reg.dirs <- as.vector(outer(paste0("perm", 1:4),
                                 paste0("_size", chrom.sizes, "_reg"),
                                 paste0))
perm.res.dirs <- as.vector(outer(paste0("perm", 1:4),
                                 paste0("_size", chrom.sizes, "_res"),
                                 paste0))
lapply(c("size3_res", "size3_reg", "size4_res", "size4_reg",
         perm.reg.dirs, perm.res.dirs,
         "perm_data"), unlink, recursive = TRUE)
```

```
#session information
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] grid      stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
## [1] ggplot2_4.0.0      kableExtra_1.4.0   knitr_1.50         magrittr_2.0.4
## [5] epistasisGA_1.12.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] mnormt_2.1.1        pbapply_1.7-4       gridExtra_2.3
##   [4] fdrtool_1.2.18      rlang_1.1.6         matrixStats_1.5.0
##   [7] compiler_4.5.1      png_0.1-8           systemfonts_1.3.1
##  [10] vctrs_0.6.5         reshape2_1.4.4      quadprog_1.5-8
##  [13] stringr_1.5.2       pkgconfig_2.0.3     crayon_1.5.3
##  [16] fastmap_1.2.0       backports_1.5.0     magick_2.9.0
##  [19] labeling_0.4.3      pbivnorm_0.6.0      rmarkdown_2.30
##  [22] tinytex_0.57        xfun_0.53           cachem_1.1.0
##  [25] jsonlite_2.0.0      progress_1.2.3      uuid_1.2-1
##  [28] BiocParallel_1.44.0 jpeg_0.1-11         psych_2.5.6
##  [31] parallel_4.5.1      lavaan_0.6-20       prettyunits_1.2.0
##  [34] cluster_2.1.8.1     R6_2.6.1            bslib_0.9.0
##  [37] stringi_1.8.7       RColorBrewer_1.1-3  rpart_4.1.24
##  [40] jquerylib_0.1.4     Rcpp_1.1.0          bookdown_0.45
##  [43] base64enc_0.1-3     Matrix_1.7-4        splines_4.5.1
##  [46] nnet_7.3-20         igraph_2.2.1        tidyselect_1.2.1
##  [49] rstudioapi_0.17.1   dichromat_2.0-0.1   abind_1.4-8
##  [52] yaml_2.3.10         codetools_0.2-20    qgraph_1.9.8
##  [55] lattice_0.22-7      tibble_3.3.0        plyr_1.8.9
##  [58] withr_3.0.2         S7_0.2.0            evaluate_1.0.5
##  [61] foreign_0.8-90      survival_3.8-3      xml2_1.4.1
##  [64] pillar_1.11.1       BiocManager_1.30.26 debugme_1.2.0
##  [67] checkmate_2.3.3     stats4_4.5.1        generics_0.1.4
##  [70] hms_1.1.4           scales_1.4.0        gtools_3.9.5
##  [73] base64url_1.4       glue_1.8.0          Hmisc_5.2-4
##  [76] tools_4.5.1         data.table_1.17.8   fs_1.6.6
##  [79] bigmemory_4.6.4     colorspace_2.1-2    nlme_3.1-168
##  [82] htmlTable_2.4.3     Formula_1.2-5       cli_3.6.5
##  [85] brew_1.0-10         rappdirs_0.3.3      textshaping_1.0.4
##  [88] bigmemory.sri_0.1.8 batchtools_0.9.18   viridisLite_0.4.2
##  [91] svglite_2.2.2       dplyr_1.1.4         corpcor_1.6.10
##  [94] glasso_1.11         gtable_0.3.6        sass_0.4.10
##  [97] digest_0.6.37       htmlwidgets_1.6.4   farver_2.1.2
## [100] htmltools_0.5.8.1   lifecycle_1.0.4
```

# References

Andre, J. H., and J. R. Koza. 1996. “Parallel Genetic Programming: A Scalable Implementation Using the Transputer Network Architecture.” In *Advances in Genetic Programming, Volume 2*, edited by P. J. Angeline and K. E. Kinnear. Cambridge: MIT Press.

Cordell, H. J., and D. G. Clayton. 2002. “A unified stepwise regression procedure for evaluating the relative effects of polymorphisms within a gene using case/control or family data: application to HLA in type 1 diabetes.” *Am J Hum Genet* 70 (1): 124–41. <https://www.ncbi.nlm.nih.gov/pmc/articles/PMC384883/>.

Holland, JH. 1975. *Adaptation in Natural and Artificial Systems*. Ann Arbor: University of Michigan Press.

Nodzenski\*, M., M. Shi\*, J. Krahn, A. S. Wise, Y. Li, L. Li, D. M. Umbach, and C. R. Weinberg. 2022. “GADGETS: A genetic algorithm for detecting epistasis using nuclear families.” *Bioinformatics* 38 (4): 1052–8.

Phipson, B., and G. K Smyth. 2010. “Permutation P-values should never be zero: calculating exact P-values when permutations are randomly drawn.” *Stat Appl Genet Mol Biol* 9 (1): Article 39. <https://pubmed.ncbi.nlm.nih.gov/21044043/>.

Shi, M., D. M. Umbach, A. S. Wise, and C. R. Weinberg. 2018. “Simulating autosomal genotypes with realistic linkage disequilibrium and a spiked-in genetic effect.” *BMC Bioinformatics* 19 (1): 2. <https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5749028/>.
# scoup: Simulate Codons with Darwinian Selection Incorporated as an Ornstein-Uhlenbeck Process

Hassan Sadiq1

1Department of Statistics and Actuarial Science, Stellenbosch University, South Africa

#### 30 October 2025

#### Abstract

Genetic simulations are an important part of molecular biology. They are
useful for assessing the efficiency and the sensitivity of models of
evolution. Despite their relevance, hardly any simulator dedicated to
sequence generation for natural selection inference analyses exist on the
Bioconductor platform. In the broader molecular evolution genre, existing
genetic simulators are yet to fully appreciate the correspondence between
the population genomic and the phylogenetic literature. `scoup` is
designed as a contribution toward filling these voids. With `scoup`, it
is possible to explore the implications of the interplay between mutation
and genetic drift on the phenomenological inferences of natural selection
obtained from phylogenetic models. The ratio of the variance of
non-synonymous to synonymous selection coefficient (vN/vS) is also
presented as a reliable selection discriminant metric. Example code of
how to use the package are presented with elaborate comments.

#### Package

scoup 1.4.0

# 1 Introduction

Statistical inference of the extent at which Darwinian natural selection had
impacted on genetic data from multiple populations commands a healthy portion
of the phylogenetic literature (Jacques et al. [2023](#ref-jacques2023)). Validation of these
codon-based models relies heavily on simulated data. A search of the entries
on the Bioconductor (Gentleman et al. [2004](#ref-bioc2004)) platform, on 29 July 2024, with keywords
`codon`, `mutation`, `selection`, `simulate` and `simulation` returned a total
of 72 unique (out of the 2300 available Software) packages. None of the
retrieved entries was dedicated to codon data simulation for natural selection
analyses. Given the ever increasing diversity natural selection inference
models that exist, there is indeed need for applicable packages on the
platform.

Population genomic studies provided the mathematical foundation upon which
phylogenetics thrived (Wright [1931](#ref-wright1931); Fisher [1922](#ref-fisher1922); Hardy [1908](#ref-hardy1908); Weinberg [1908](#ref-weinberg1908); Darwin [1859](#ref-darwin1859)). The thirst to bridge the gap between these two genres of
evolutionary biology continue to drive the invention of more complex models
of evolution (Aris-Brosou and Rodrigue [2012](#ref-brosou2012)). Consequently, there is need to develop codon
sequence simulators to match the growth. `scoup` is designed on the
basis of the mutation-selection (MutSel) framework (Halpern and Bruno [1998](#ref-halpern1998)) as a
contribution to this quest. Only a couple of existing selection-focused
simulators in the literature used the MutSel framework (Spielman and Wilke [2015](#ref-wilke2015); Arenas and Posada [2014](#ref-arenas2014)). This is most probably due to the perceived complexity of the
methodology. In `scoup`, the versatility of the Uhlenbeck and Ornstein ([1930](#ref-uhlenbeck1930))
algorithm as a framework for evolutionary analyses (Bartoszek et al. [2017](#ref-bartoszek2017)) was
used to circumvent the complexity.

In a bid to identify an appropriate quantifier that permits direct comparison
between the degree of selection signatures imposed during simulation and that
inferred, the ratio of the variance of the non-synonymous to synonymous
selection coefficients (vN/vS) was discovered to be appropriate. The vN/vS
statistic is consequently posited as a quality selection discriminant metric.
`scoup` therefore represents an important contribution to the
phylogenetic modelling literature. Example code of how to successfully use
the package is presented below.

# 2 Installation

Use the following code to install `scoup` from the Bioconductor platform.

```
if(!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("scoup")
```

# 3 Sample Code

Three primary evolutionary algorithms are available in `scoup`. These
include the frequency-dependent (Jones et al. [2017](#ref-jones2017); Ayala and Campbell [1974](#ref-ayala1974)), the
Ornstein-Uhlenbeck (OU) and the episodic algorithms. Example of `R`
(R Core Team [2024](#ref-cran2024)) code where these functions are utilised are presented.
The homogeneous (Muse and Gaut [1994](#ref-muse1994); Goldman and Yang [1994](#ref-goldman1994)) and heterogeneous (site-wise
and branch-wise) (Nielsen and Yang [1998](#ref-nielsen1998); Kosakovsky Pond and Frost [2005](#ref-kpond2005)) selection inference modelling
contexts are explored. Data quality is assessed by comparing the
maximum likelihood inferred (\(\omega\)) and the analytically calculated
(\(\mathrm{d}N/\mathrm{d}S\)) estimates to the magnitude of the imposed
selection pressure (measured by vN/vS). Template code used to analyse
the output data (to obtain \(\omega\)) with `PAML` (Álvarez-Carretero, Kapli, and Yang [2023](#ref-sandra2023); Yang [2007](#ref-yang2007))
and `FUBAR` (Murrell et al. [2013](#ref-murrell2013); Kosakovsky Pond, Frost, and Muse [2005](#ref-hyphy2005)) are presented in the Appendix. The
`R` code presented subsequently, require that the user should have already
installed the `scoup` package.

## 3.1 Ornstein-Uhlenbeck Sensitivity

```
# Make package accessible in R session
library(scoup)
```

```
## Loading required package: Matrix
```

```
# Number of extant taxa
leaves <- 8

# Number of codon sites
sSize <- 15

# Number of data replications for each parameter combination
sims <- 1

# OU reversion parameter (Theta) value
eThta <- c(0.01)

# OU asymptotic variance value
eVary <- c(0.0001)

# OU landscape shift parameters
hbrunoStat <- hbInput(c(vNvS=1, nsynVar=0.01))

# Sequence alignment size information
seqStat <- seqDetails(c(nsite=sSize, ntaxa=leaves))

# Iterate over all listed OU variance values
for(g in seq(1,length(eVary))){

    # Iterate over all listed OU reversion parameter values
    for(h in seq(1,length(eThta))){

        # Create appropriate simulation function ("ou") object
        adaptStat <- ouInput(c(eVar=eVary[g],Theta=eThta[h]))

        # Iterate over the specified number of replicates
        for(i in seq(1,sims)){

            # Execute simulation
            simData <- alignsim(adaptStat, seqStat, hbrunoStat, NULL)
        }
    }
}
# Print simulated alignment
seqCOL(simData)
```

```
## DNAStringSet object of length 8:
##     width seq                                               names
## [1]    45 TGCTCTATGCTGTGGACGAGCTCGAGAATACAGATTTCTCTATTC     S001
## [2]    45 TGCTCTATGCCGTGGACGAGCTCGAGAATACAGATTTCTCTATTC     S002
## [3]    45 TGCTTTATGCCGTGGACGAGCTCGAGAATGCAGATTTCTCTAGTC     S003
## [4]    45 TGCCTTATGCTGTGGACGAGCTCGAGAATACAAATTTCTCTAGTC     S004
## [5]    45 TGCTCTATGCCGTCGACGAGCTCAAGAATACGGATTTCTCCATTC     S005
## [6]    45 TGCTCTATGCCGTCGCCGAGCTCAAGAATACGGATTTCTCCATTC     S006
## [7]    45 TGCTCTATGCCGTCGATAAGCTCGAGAATACGGATTTCTCTATTC     S007
## [8]    45 TGCTCTATGCCGTCGGTGAGCTCGAGAATACGGATTTCTCTATTC     S008
```

As expected, the correlation coefficient estimate was approximately
\(0.9974\) when the means of the inferred (\(\omega\)) and the calculated
(\(\mathrm{d}N/\mathrm{d}S\)) selection effects were first compared. The
correlation estimation included more iterations.

## 3.2 vN/vS Sensitivity

```
# Make package accessible in R session
library(scoup)

# Number of extant taxa
xtant <- 8

# Number of codon sites
siteSize <- 15

# Number of data replications for each parameter combination
simSize <- 1

# Variance of the non-synonymous selection coefficients
nsynVary <- c(0.001)

# Ratio of the variance of the non-synonymous to synonymous coeff.
vNvSvec <- c(1)

# Sequence alignment size information
seqStat <- seqDetails(c(nsite=siteSize, ntaxa=xtant))

# Iterate over all listed coefficient variance ratios
for(a in seq(1,length(vNvSvec))){

    # Iterate over all listed non-synonymous coefficients variance
    for(b in seq(1,length(nsynVary))){

        # Create appropriate simulation function ("omega") object
        adaptData <- wInput(list(vNvS=vNvSvec[a],nsynVar=nsynVary[b]))

        # Iterate over the specified number of replicates
        for(i in seq(1,simSize)){

            # Execute simulation
            simulateSeq <- alignsim(adaptData, seqStat, NA)
        }
    }
}
# Print simulated alignment
cseq(simulateSeq)
```

```
##                                            Sequence
##  S001 CACACCTGGGAGATCGTTTCTCAACGGTCTGCCCCCATGCCCTTC
##  S002 CACACCTGGGAGATCGTTTCTCAACGGTCTGCCCCCATGCCCTTC
##  S003 CACACTTGGGAGATCGTTTCTCAACGGTCTGCCCTCATGCCCTTC
##  S004 CACACCTGGGAGATCGTTTCTCAACGGTCTGCCCTCATGCCCTTC
##  S005 CACACCTGGGAGATCGTTTCTCAACGGTCTGCCTCCATGCCCTTC
##  S006 CACACCTGGGAGATCGTTTCTCAACGGTCTGCCTCCATGCCCTTC
##  S007 CACACCTGGGAGATCGTTTCTCAACGGTCTGCCTCCATGCCCTTC
##  S008 CACACCTGGGAGATCGTTTCTCAACGGTCTGCCTCCATGCCCTTC
```

Sequences generated with the presented code (with more iterations
included) produced strongly correlated selection inferences
(correlation coefficient \(\approx 0.9923\)) when the average
\(\mathrm{d}N/\mathrm{d}S\) and the \(\omega\) values were compared.
This implementation is an example of how to execute the
frequency-dependent evolutionary technique with the package.

## 3.3 Site-wise Application

```
# Make package accessible in R session
library(scoup)

# Number of codon sites
sitesize<- 15

# Variance of non-synonymous selection coefficients
nsynVary <- 0.01

# Number of extant taxa
## Commented value was used for results presented in article
taxasize <- 8

# Sequence alignment size information
seqsEntry <- seqDetails(c(nsite=sitesize, ntaxa=taxasize))

# Create the applicable ("ou") object for simulation function
## eVar= OU asymptotic variance, Theta=OU reversion parameter
adaptEntry <- ouInput(c(eVar=0.1,Theta=1))

# Ratio of the variance of the non-synonymous to synonymous coeff.
sratio <- c(1e-06)

# Iterate over all listed coefficient variance ratios
for(a0 in seq(1,length(sratio))){

    # OU landscape shift parameters
    mValues <- hbInput(c(vNvS=sratio[a0], nsynVar=nsynVary))

    # Execute simulation
    simSeq <- alignsim(adaptEntry, seqsEntry, mValues, NA)
}
# Print simulated codon sequence
cseq(simSeq)
```

```
##                                            Sequence
##  S001 TACACGTTGGTCCTCCTAAACATTCGGGGGCAGCTCGTTCCATTT
##  S002 CTCACCTTAGTCCCCCTAGCCATTCGGGGCCAGCGCGCTCCACTT
##  S003 CACACCTTAGTTCCCATAGACATTCATAGCCGACCTACCCCACTT
##  S004 CACACCTTGGCTCCCTTAGACATTAGTGGCTGGCCTGCCCTACTT
##  S005 CTCGACCTAGTATTCTTCGACATTCGCGGCCGACCCGCTCCATCC
##  S006 CTCGCTTTAGTATACTTAGACATTCGAGGCCGACCGGCTCTAATC
##  S007 CGCGCTTTGTTCCTTTTAGACATTTGGGAACGACCCGGTCCACTC
##  S008 CGCGCTTTAATCGTCTCAGACATTTACGATCGGCCCGCTCCAATC
```

This is another example of how to call the OU shifting landscape
evolutionary approach. The results obtained yielded a pairwise
correlation coefficient estimate of approximately \(0.9988\) between
the means of \(\mathrm{d}N/\mathrm{d}S\) and \(\omega\). The correlation
coefficient estimates were approximately \(0.8123\) and \(0.8305\) when
the averages were each compared to vN/vS, respectively.

## 3.4 Branch-wise (Episodic) Test

```
# Make package accessible in R session
library(scoup)

# Number of internal nodes on the desired balanced tree
iNode <- 3

# Number of required codon sites
siteCount <- 15

# Variance of non-synonymous selection coefficients
nsnV <- 0.01

# Number of data replications for each parameter combination
nsim <- 1

# Ratio of the variance of the non-synonymous to synonymous coeff.
vNvSvec <- c(1e-06)

# Sequence alignment size information
seqsBwise <- seqDetails(c(nsite=siteCount, blength=0.10))

# Iterate over all listed coefficient variance ratios
for(h in seq(1,length(vNvSvec))){

    # Iterate over the specified number of replicates
    for(i in seq(1,nsim)){

        # Create the parameter set applicable at each internal tree node
        scInput <- rbind(vNvS=c(rep(0,iNode-1),vNvSvec[h]),
                        nsynVar=rep(nsnV,iNode))

        # Create the applicable ("discrete") object for simulation function
        adaptBranch <- discreteInput(list(p02xnodes=scInput))

        # Execute simulation
        genSeq <- alignsim(adaptBranch, seqsBwise, NULL)
    }
}
# Print simulated sequence data
seqCOL(genSeq)
```

```
## DNAStringSet object of length 8:
##     width seq                                               names
## [1]    45 GGGCTGAATCGAACACCGGCGTCCCGGCCTCCTTTGCTGAGAGGA     S001
## [2]    45 GGACAGAACCGAACACCGGCACCCCCGCCTCCTTTGCTGAACAGA     S002
## [3]    45 GGACCGAACCGGACGTCGGCATCCTCGCCTACTTTGTTGAAAGAA     S003
## [4]    45 GGACAGAATCTGACGCTGGCGCCCCCACGTCCTTTGCTGAAAGGA     S004
## [5]    45 AGACAGAATCGAACGCCAGCACCCCCGCCTCCTCCGCTGAGGGGA     S005
## [6]    45 GGACAGAATCAAAAACTGGCACCCCCGTCTCCTCTACCGAGGGGA     S006
## [7]    45 GAACAGAATCGAACATCAGAGCCCCCGCCGCCTAGGCTGAGGGTA     S007
## [8]    45 GGACTGATTCGAACGCTGAAGCCCCCGCCTCATTGGCTGTGGGAA     S008
```

The correlation coefficient between the averages of the analytical
\(\mathrm{d}N/\mathrm{d}S\) and the inferred \(\omega\) estimates was
approximately \(0.9998\), obtained from 50 independent iterations of
the code for a set of vN/vS values. The correlation coefficient
estimate was approximately \(0.6349\) for vN/vS vs \(\omega\) and \(0.6360\)
for vN/vS vs \(\mathrm{d}N/\mathrm{d}S\).

# 4 Conclusion

Reference `scoup` code are presented to facilitate use of the package.
Although not explicitly presented, it is also possible to generate data
with signatures of directional selection by setting the `aaPlus` element
of the `wInput` entry of the `alignsim` function accordingly. The
capacity of the package is expected to be extended in future versions.

# 5 Citation

A more appropriate citation will be provided for the package
after it has been accepted for publication. In the meantime, to cite
this package, use *Sadiq, H. 2024. “scoup: Simulate Codon Sequences
with Darwinian Selection Incorporated as an Ornstein-Uhlenbeck Process”.
R Package. doi:10.18129/B9.bioc.scoup.*

# 6 References

Arenas, Miguel, and David Posada. 2014. “Simulation of Genome-wide Evolution under Heterogeneous Substitution Models and Complex Multispecies Coalescent Histories.” *Molecular Biology and Evolution* 31 (5): 1295–1301.

Aris-Brosou, Stéphane, and Nicolas Rodrigue. 2012. “The Essentials of Computational Molecular Evolution.” In *Evolutionary Genomics: Statistical and Computational Methods, Volume 1*, edited by Maria Anisimova, 855:111–52. Methods in Molecular Biology, Springer Science+Business Media, LLC.

Ayala, Francisco J, and Cathryn A Campbell. 1974. “Frequency-Dependent Selection.” *Annual Review of Ecology and Systematics* 5: 115–38.

Álvarez-Carretero, Sandra, Paschalia Kapli, and Ziheng Yang. 2023. “Beginner’s Guide on the Use of PAML to Detect Positive Selection.” *Molecular Biology and Evolution* 40 (4): msad041.

Bartoszek, Krzysztof, Sylvain Glémin, Ingemar Kaj, and Martin Lascoux. 2017. “Using the Ornstein–Uhlenbeck Process to Model the Evolution of Interacting Populations.” *Journal of Theoretical Biology* 429: 35–45.

Darwin, Charles. 1859. *On the Origin of Species by Means of Natural Selection, or the Preservation of Favoured Races in the Struggle for Life*. John Murray, London, UK.

Fisher, R A. 1922. “On the Dominance Ratio.” *Proceedings of the Royal Society of Edinburgh* 42: 321–41.

Gentleman, Robert C, Vincent J Carey, Douglas M Bates, Ben Bolstad, Marcel Dettling, Sandrine Dudoit, Byron Ellis, et al. 2004. “Bioconductor: Open Software Development for Computational Biology and Bioinformatics.” *Genome Biology* 5 (10): R80.

Goldman, Nick, and Ziheng Yang. 1994. “A Codon-based Model of Nucleotide Substitution for Protein-coding DNA Sequences.” *Molecular Biology and Evolution* 11 (5): 725–36.

Halpern, Aaron L, and William J Bruno. 1998. “Evolutionary Distances for Protein-Coding Sequences: Modelling Site-Specific Residue Frequencies.” *Molecular Biology and Evolution* 15 (7): 910–17.

Hardy, Godfrey Harold. 1908. “Mendelian Proportions in a Mixed Population.” *Science* 28 (706): 49–50.

Jacques, Florian, Paulina Bolivar, Kristian Pietras, and Emma U Hammarlund. 2023. “Roadmap to the Study of Gene and Protein Phylogeny and Evolution – A Practical Guide.” *PLoS ONE* 18 (2): e0279597.

Jones, Christopher T, Noor Youssef, Edward Susko, and Joseph P Bielawski. 2017. “Shifting Balance on a Static Mutation-Selection Landscape: A Novel Scenario of Positive Selection.” *Molecular Biology and Evolution* 34 (2): 391–407.

Kosakovsky Pond, Sergei L, and Simon D W Frost. 2005. “A Genetic Algorithm Approach to Detecting Lineage-Specific Variation in Selection Pressure.” *Molecular Biology and Evolution* 22 (4): 478–85.

Kosakovsky Pond, Sergei L, Simon D W Frost, and S V Muse. 2005. “HyPhy: Hypothesis Testing Using Phylogenies.” *Bioinformatics* 29: 676–79.

Murrell, Ben, Sasha Moola, Amandla Mabona, Thomas Weighill, Daniel Sheward, Sergei L Kosakovsky Pond, and Konrad Scheffler. 2013. “FUBAR: A Fast, Unconstrained Bayesian AppRoximation for Inferring Selection.” *Molecular Biology and Evolution* 30 (5): 1196–1205.

Muse, Spencer V, and Brandon S Gaut. 1994. “A Likelihood Approach for Comparing Synonymous and Nonsynonymous Nucleotide Substitution Rates, with Application to the Chloroplast Genome.” *Molecular Biology and Evolution* 11 (5): 715–24.

Nielsen, Rasmus, and Ziheng Yang. 1998. “Likelihood Models for Detecting Positively Selected Amino Acid Sites and Applications to the HIV-1 Envelope Gene.” *Genetics* 148 (3): 929–36.

R Core Team. 2024. *R: A Language and Environment for Statistical Computing*. Vienna, Austria: R Foundation for Statistical Computing. <https://www.R-project.org/>.

Spielman, Stephanie J, and Claus O Wilke. 2015. “Pyvolve: A Flexible Python Module for Simulating Sequences along Phylogenies.” *PLoS ONE* 10 (9): e0139047.

Uhlenbeck, G E, and L S Ornstein. 1930. “On the Theory of the Brownian Motion.” *Physical Review* 36: 823–41.

Weinberg, Wilhelm. 1908. “Über den Nachweis der Vererbung beim Menschen.” *Jahreshefte Des Vereins Für Vaterländische Naturkunde in Württemberg* 64: 369–82.

Wright, Sewall. 1931. “Evolution in Mendelian Populations.” *Genetics* 16: 97–159.

Yang, Ziheng. 2007. “PAML 4: phylogenetic analysis by maximum likelihood.” *Molecular Biology and Evolution* 24 (8): 1586–91.

# Appendix

# A Appendix: Sample Data Analyses (Non-R) Code

`CODEML` script executed in `PAML` to infer
single alignment-wide \(\omega\) estimates for data sets generated from 50
independent executions of the sensitivity analyses code presented
above. The same `CODEML` script was used to analyse data (also 50
replicates) from the episodic analyses code, with the `model` entry
replaced with `2`. The `scoup` simulated sequence data and
tree are `seq.nex` and `seq.tre`, respectively.

```
    seqfile   = seq.nex
    treefile  = seq.tre
    outfile   = seq.out
    noisy     = 0
    verbose   = 0
    seqtype   = 1
    ndata     = 1
    icode     = 0
    cleandata = 0
    model     = 0
    NSsites   = 0
    CodonFreq = 3
    estFreq   = 0
    clock     = 0
    fix_omega = 0
    omega     = 1e-05
```

`FUBAR` command executed with `HyPhy`
through the terminal in MacBook. Note that `HyPhy`
was already installed on the computer. The `seq.nex` input is the
`scoup` simulated codon sequence data that is saved in the same
NEXUS file with the tree data. The NEXUS file resides in the
working directory.

```
hyphy fubar --code Universal --alignment seq.nex --tree seq.nex
```

# B Session info

The output of `sessionInfo()` from the computer where this file is generated
is provided below.

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] scoup_1.4.0      Matrix_1.7-4     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] crayon_1.5.3        cli_3.6.5           knitr_1.50
##  [4] rlang_1.1.6         xfun_0.53           generics_0.1.4
##  [7] jsonlite_2.0.0      S4Vectors_0.48.0    Biostrings_2.78.0
## [10] htmltools_0.5.8.1   stats4_4.5.1        sass_0.4.10
## [13] rmarkdown_2.30      Seqinfo_1.0.0       grid_4.5.1
## [16] evaluate_1.0.5      jquerylib_0.1.4     fastmap_1.2.0
## [19] IRanges_2.44.0      yaml_2.3.10         lifecycle_1.0.4
## [22] bookdown_0.45       BiocManager_1.30.26 compiler_4.5.1
## [25] XVector_0.50.0      lattice_0.22-7      digest_0.6.37
## [28] R6_2.6.1            bslib_0.9.0         tools_4.5.1
## [31] BiocGenerics_0.56.0 cachem_1.1.0
```
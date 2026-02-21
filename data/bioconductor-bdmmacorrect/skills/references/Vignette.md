Batch Eﬀects Correction for Microbiome Data with
Dirichlet-multinomial Regression
DAI ZHENWEI

23 Oct, 2018

1. Introduction

Metagenomic sequencing techniques enable quantitative analyses of the microbiome. However, combining
the microbial data from these experiments is challenging due to the variations between experiments. The
existing methods for correcting batch eﬀects do not consider the interactions between variables—microbial
taxa in microbial studies—and the overdispersion of the microbiome data. Therefore, they are not applicable
to microbiome data.

We develop a new method, Bayesian Dirichlet-multinomial regression meta-analysis (BDMMA), to simul-
taneously model the batch eﬀects and detect the microbial taxa associated with phenotypes. BDMMA
automatically models the dependence among microbial taxa and is robust to the high dimensionality of the
microbiome and their association sparsity.

The package BDMMAcorrect includes functions to perform meta-analysis of the metagenomic compositional
data and select taxa signiﬁcantly associated with the covariates. BDMMA is based on the following
assumptions:

1. Only a small proportion of taxa are signiﬁcantly associated with the covariates.
2. The taxonomic read counts follows a Dirichlet-Multinomial (DM) distribution.
3. The batch eﬀects are indepdent of the covariates’ eﬀects.
4. The batch information for each sample is known.

Brief introduction to the BDMMA model

Suppose the taxonomic read counts of a sample yij (the j −th sample in i−th batch) follows a DM distribution
parameterized by γij = (γij1, γij2, ..., γijG),

fDM (yij|γij) =

Γ(γij+)Γ(yij+ + 1)
Γ(yij+ + γij+)

×

G
Y

g=1

Γ(yijg + γijg)
Γ(γijg)Γ(yijg + 1)

,

where yij+ = PG
parameter γijg with,

g=1 γijg and G encodes the number of all the taxa included in the analysis. We model the

γijg = αg × exp(

P
X

p=1

Xijpβpg + δig),

where g means the g − th taxon; X = (Xijp)N ×P is the covariate matrix (N is the total number of samples and
P is the number of covariate variables); δ = (δig)I×G is the batch eﬀects matrix satisfying PI
i=1 niδig = 0 (ni
is the sample size of the i − th batch). αg and βpg encode the intercept and covariate coeﬃcient respectively.

We adopt the Bayesian approach and provide proper prior distributions for the parameters. To select the taxa
signiﬁcantly associated with the variable of interest, we impose a spike-and-slab prior on the corresponding
coeﬃcients and estimate their posterior inclusion probability (PIP). The variable selection is conducted by
thresholding PIP. In the next section, we provide an example to show the usage of functions in our package.

1

2. Analysis Example

We simulated a sample data set, named Microbiome_dat, including 80 samples and 40 taxa. The read
counts were simulated from the DM distribution according to the BDMMA model assumptions. We also
simulated a main eﬀect variable (case/control status) and a confounding variable. Microbiome_dat is a
SummarizedExperiment object and be loaded directly.

We use colData to retrieve the phenotype and batch information, and store them in col_data. Variable
main is the main eﬀect variable, confounder is the confounding variable and batch includes the batch labels
of all the samples. The read counts can be accessed with assay, which will return a matrix object.

library(BDMMAcorrect)
require(SummarizedExperiment)
data(Microbiome_dat)
### Access phenotypes information
col_data <- colData(Microbiome_dat)
pheno <- data.frame(col_data$main, col_data$confounder)
batch <- col_data[,3]
### Access taxonomy read counts
counts <- t(assay(Microbiome_dat))
### Indicate whether the phenotype variables are continuous
continuous <- mcols(col_data)[1:2,]

BDMMAcorrect provides a function to visualize the diﬀerences of the taxonomic composition across cohorts
with the principal coordinate analysis. VBatch plots the ﬁrst two principal coordinates of the corresponding
samples and the 80% conﬁdence ellipse of each batch.

figure = VBatch(Microbiome_dat = Microbiome_dat, method = "bray")
print(figure)

For a case/control study, VBatch can also visualize the batch eﬀect of the case and control samples respectively.

2

−0.2−0.10.00.10.2−0.4−0.20.00.20.4PC1PC2batch1234main_variable <- pheno[,1]
main_variable[main_variable == 0] <- "Control"
main_variable[main_variable == 1] <- "Case"
figure <- VBatch(Microbiome_dat = Microbiome_dat, main_variable = main_variable, method = "bray")
print(figure[[1]])

print(figure[[2]])

3

−0.2−0.10.00.10.2−0.4−0.20.00.2PC1PC2batch1234main_variable = CaseThen, the main function BDMMA can work directly on Microbiome_dat. BDMMAcorrect provides the freedom
to ignore the low abundant taxa. BDMMAcorrect runs a Markov chain Monte Carlo algorithm to sample from
the posterior distribution. The users can set the lengths of the burn-in period and the sampling period for
the Markov chain. In this example, the lengths of burn-in and sampling period are set to 4000.

output <- BDMMA(Microbiome_dat = Microbiome_dat, burn_in = 4000, sample_period = 4000)

## #################### Start MCMC ####################
##
## Iteration = 50
## Iteration = 100
## Iteration = 150
## Iteration = 200
## Iteration = 250
## Iteration = 300
## Iteration = 350
## Iteration = 400
## Iteration = 450
## Iteration = 500
## Iteration = 550
## Iteration = 600
## Iteration = 650
## Iteration = 700
## Iteration = 750
## Iteration = 800
## Iteration = 850
## Iteration = 900
## Iteration = 950
## Iteration = 1000
## Iteration = 1050
## Iteration = 1100

4

−0.2−0.10.00.10.2−0.20.00.20.4PC1PC2batch1234main_variable = Control## Iteration = 1150
## Iteration = 1200
## Iteration = 1250
## Iteration = 1300
## Iteration = 1350
## Iteration = 1400
## Iteration = 1450
## Iteration = 1500
## Iteration = 1550
## Iteration = 1600
## Iteration = 1650
## Iteration = 1700
## Iteration = 1750
## Iteration = 1800
## Iteration = 1850
## Iteration = 1900
## Iteration = 1950
## Iteration = 2000
## Iteration = 2050
## Iteration = 2100
## Iteration = 2150
## Iteration = 2200
## Iteration = 2250
## Iteration = 2300
## Iteration = 2350
## Iteration = 2400
## Iteration = 2450
## Iteration = 2500
## Iteration = 2550
## Iteration = 2600
## Iteration = 2650
## Iteration = 2700
## Iteration = 2750
## Iteration = 2800
## Iteration = 2850
## Iteration = 2900
## Iteration = 2950
## Iteration = 3000
## Iteration = 3050
## Iteration = 3100
## Iteration = 3150
## Iteration = 3200
## Iteration = 3250
## Iteration = 3300
## Iteration = 3350
## Iteration = 3400
## Iteration = 3450
## Iteration = 3500
## Iteration = 3550
## Iteration = 3600
## Iteration = 3650
## Iteration = 3700
## Iteration = 3750
## Iteration = 3800

5

## Iteration = 3850
## Iteration = 3900
## Iteration = 3950
## Iteration = 4000
## Iteration = 4050
## Iteration = 4100
## Iteration = 4150
## Iteration = 4200
## Iteration = 4250
## Iteration = 4300
## Iteration = 4350
## Iteration = 4400
## Iteration = 4450
## Iteration = 4500
## Iteration = 4550
## Iteration = 4600
## Iteration = 4650
## Iteration = 4700
## Iteration = 4750
## Iteration = 4800
## Iteration = 4850
## Iteration = 4900
## Iteration = 4950
## Iteration = 5000
## Iteration = 5050
## Iteration = 5100
## Iteration = 5150
## Iteration = 5200
## Iteration = 5250
## Iteration = 5300
## Iteration = 5350
## Iteration = 5400
## Iteration = 5450
## Iteration = 5500
## Iteration = 5550
## Iteration = 5600
## Iteration = 5650
## Iteration = 5700
## Iteration = 5750
## Iteration = 5800
## Iteration = 5850
## Iteration = 5900
## Iteration = 5950
## Iteration = 6000
## Iteration = 6050
## Iteration = 6100
## Iteration = 6150
## Iteration = 6200
## Iteration = 6250
## Iteration = 6300
## Iteration = 6350
## Iteration = 6400
## Iteration = 6450
## Iteration = 6500

6

## Iteration = 6550
## Iteration = 6600
## Iteration = 6650
## Iteration = 6700
## Iteration = 6750
## Iteration = 6800
## Iteration = 6850
## Iteration = 6900
## Iteration = 6950
## Iteration = 7000
## Iteration = 7050
## Iteration = 7100
## Iteration = 7150
## Iteration = 7200
## Iteration = 7250
## Iteration = 7300
## Iteration = 7350
## Iteration = 7400
## Iteration = 7450
## Iteration = 7500
## Iteration = 7550
## Iteration = 7600
## Iteration = 7650
## Iteration = 7700
## Iteration = 7750
## Iteration = 7800
## Iteration = 7850
## Iteration = 7900
## Iteration = 7950
## Iteration = 8000

print(output$selected.taxa)

## list()

head(output$parameter_summary)

X25.

mean

X2.5.

##
X97.5.
## alpha_1 9.051869 8.274439 8.755636 9.041924 9.328451 9.916576
## alpha_2 3.118461 2.702122 2.976971 3.130481 3.259602 3.507374
## alpha_3 4.656649 4.121000 4.437485 4.647892 4.855186 5.251268
## alpha_4 1.379500 1.171690 1.309797 1.383090 1.446766 1.586689
## alpha_5 2.728788 2.234571 2.598909 2.742867 2.869149 3.156137
## alpha_6 4.191189 3.693713 4.019174 4.196642 4.359535 4.659266

X50.

X75.

print(output$PIP)

## [1] 0.9160210 0.9717571

print(output$bFDR)

## [1] 0.05611097

The output includes three arguments, selected.taxa, parameter_summary and trace. The selected taxa by
thresholding PIPs and controling Bayesian false discovery rate are listed in output$selected.taxa. The
default bFDR level and the PIP thresholds are set to 0.1 and 0.5 respectively in the function. BDMMAcorrect
selects V10 and V30 as signiﬁcantly associated taxa. Users can check the mean and quantiles of parameters’

7

posterior distribution in output$parameter_summary. output$PIP shows the PIPs of the selected taxa.
Given the selected microbial taxa, output$bFDR provides the corresponding bFDR. output$trace includes
the trace of the parameters and the function trace_plot can be used to check the convergence of the Markov
chain.

figure <- trace_plot(trace = output$trace, param = c("alpha_1", "beta1_10"))
print(figure)

## [[1]]

##
## [[2]]

Prepare data for analysis

To prepare develop the data for the analysis, here, the following example shows how to pack the data into a
SummarizedExperiment object that can be used as the input of the functions.
### Simulate counts
counts <- rmultinom(100,10000,rep(0.02,50))
### Simulate covariates
main <- rbinom(100,1,0.5)
confounder <- rnorm(100,0,1)
### Simulate batches
batch <- c(rep(1,50),rep(2,50))

8

0.02.55.07.510.002000400060008000itervalueThe trace plot of parameter alpha_1−2.0−1.5−1.0−0.50.002000400060008000itervalueThe trace plot of parameter beta1_10library(SummarizedExperiment)
col_data <- DataFrame(main, confounder, batch)
mcols(col_data)$continous <- c(0L, 1L, 0L)
### pack different datasets into a SummarizedExperiment object
Microbiome_dat <- SummarizedExperiment(list(counts), colData=col_data)

9


# trinculo CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| trinculo_multinom | PASS | synthetic data: nf-core gwas genotypes with a 3-class phenotype cut from a quantitative trait; new CWL for trinculo multinom |
| trinculo_ordinal | PASS | synthetic data: nf-core gwas genotypes with a 3-class phenotype cut from a quantitative trait; new CWL for trinculo ordinal |

## trinculo_multinom

### Tool Description
Multinomial logistic regression of a categorical phenotype on genotypes.

### Metadata
- **Docker Image**: quay.io/biocontainers/trinculo:0.96--h470a237_2
- **Homepage**: https://sourceforge.net/projects/trinculo/
- **Package**: https://anaconda.org/channels/bioconda/packages/trinculo/overview
- **Validation**: PASS

### Original Help Text
```text
Running a multinomial logistic analysis

Usage:
 trinculo MODE  [--bfile GENOTYPES_PREFIX | --dosage GENOTYPES.DOSE ] [--out OUTPUT_PREFIX] --pheno PHENOTYPES.TXT --phenoname PHENOTYPE [--basepheno REF --missingpheno MISSING ] [--covar COVARIATES.TXT --normalize] [--condition SNPS.TXT] [--priors PRIORS.TXT | --defaultprior --priorsigma PRIORVAR --priorcor PRIORCOR --covarsigma PRIORVAR | --empiricalprior  ] [ --select --phenops --errormat --fullmodel --waldstats ] [ --noassoc ] [--threads n] [ --precision DIGITS ] [ --fitIter NITER --fitAbsTol ABSTOL --fitRelTol RELTOL ] [--help]

Options:

MODE	- Either multinom or ordinal for multinomial or ordinal logistic regression

--bfile FILE_PREFIX	- Genotype input in binary plink format (FILE_PREFIX.bed, FILE_PREFIX.bim and FILE_PREFIX.fam)
--dosage FILE	- Genotype input in dosage format
--out PREFIX	- The prefix used for output files [default is "trinculo"]

--pheno FILE	- Phenotype input (same format as plink)--phenoname STRING	-The phenotype in the phenotype file to analyse
--basepheno STRING	- The reference catagory to use for the multinomial analysis [defaults to first catagory encountered]
--missingpheno STRING	- The symbol to be use to indicate a missing phenotype in the phenotype file

--condition FILE	- A file containing a list of SNPs (one per line) to conditon on (i.e. include as covariates)

--covar FILE	- A file containing covariates to condition on (same format as plink)
--normalize	- Normalizes covariates to have a variance of 1 [off by default]

--priors FILE	- A prior covariance matrix on effect sizes
--defaultpriors	- Construct a prior matrix based on default values
--priorsigma VALUE	- Set the prior variance on effect sizes within a disease[default is 0.04]
--priorcor VALUE	- Set the prior correlation on effect sizes across diseases [default is 0]
--covarsigma VALUE	- Prior on the covariate effect size [Default is 1]
--empiricalprior	 - Calculate an empirical prior directly from the data
--noassoc	-do not do any association testing, just infer the prior

--select	-Do Bayesian model selection (i.e. calculate marginal likelihoods for each sharing model)
--phenops	-Do a likelihood ratio test on each phenotype individually
--waldstats	-Calculate standard errors, Z scores and Wald p-values
--errormat	-Output the variance-covariance matrix for the log odds ratio
--fullmodel	-Output all parameter estimates and the full error matrix

--threads n	Use up to n cores

--precision DIGITS	Print output to DIGITS significant figures

--fitIter NITER	Try up to NITER iterations when fitting models
--fitAbsTol ABSTOL	Terminate model fitting if results change by less than ABSTOL
--fitRelTol RELTOL	Terminate model fitting if results change by less than (RELTOL x value)

--help	- Prints this message
```

## trinculo_ordinal

### Tool Description
Ordinal (proportional odds) logistic regression of an ordered phenotype on genotypes.

### Metadata
- **Docker Image**: quay.io/biocontainers/trinculo:0.96--h470a237_2
- **Homepage**: https://sourceforge.net/projects/trinculo/
- **Package**: https://anaconda.org/channels/bioconda/packages/trinculo/overview
- **Validation**: PASS

### Original Help Text
```text
Running a ordinal (proportional odds) logistic analysis

Usage:
 trinculo MODE  [--bfile GENOTYPES_PREFIX | --dosage GENOTYPES.DOSE ] [--out OUTPUT_PREFIX] --pheno PHENOTYPES.TXT --phenoname PHENOTYPE [--basepheno REF --missingpheno MISSING ] [--covar COVARIATES.TXT --normalize] [--condition SNPS.TXT] [--priors PRIORS.TXT | --defaultprior --priorsigma PRIORVAR --priorcor PRIORCOR --covarsigma PRIORVAR | --empiricalprior  ] [ --select --phenops --errormat --fullmodel --waldstats ] [ --noassoc ] [--threads n] [ --precision DIGITS ] [ --fitIter NITER --fitAbsTol ABSTOL --fitRelTol RELTOL ] [--help]

Options:

MODE	- Either multinom or ordinal for multinomial or ordinal logistic regression

--bfile FILE_PREFIX	- Genotype input in binary plink format (FILE_PREFIX.bed, FILE_PREFIX.bim and FILE_PREFIX.fam)
--dosage FILE	- Genotype input in dosage format
--out PREFIX	- The prefix used for output files [default is "trinculo"]

--pheno FILE	- Phenotype input (same format as plink)--phenoname STRING	-The phenotype in the phenotype file to analyse
--basepheno STRING	- The reference catagory to use for the multinomial analysis [defaults to first catagory encountered]
--missingpheno STRING	- The symbol to be use to indicate a missing phenotype in the phenotype file

--condition FILE	- A file containing a list of SNPs (one per line) to conditon on (i.e. include as covariates)

--covar FILE	- A file containing covariates to condition on (same format as plink)
--normalize	- Normalizes covariates to have a variance of 1 [off by default]

--priors FILE	- A prior covariance matrix on effect sizes
--defaultpriors	- Construct a prior matrix based on default values
--priorsigma VALUE	- Set the prior variance on effect sizes within a disease[default is 0.04]
--priorcor VALUE	- Set the prior correlation on effect sizes across diseases [default is 0]
--covarsigma VALUE	- Prior on the covariate effect size [Default is 1]
--empiricalprior	 - Calculate an empirical prior directly from the data
--noassoc	-do not do any association testing, just infer the prior

--select	-Do Bayesian model selection (i.e. calculate marginal likelihoods for each sharing model)
--phenops	-Do a likelihood ratio test on each phenotype individually
--waldstats	-Calculate standard errors, Z scores and Wald p-values
--errormat	-Output the variance-covariance matrix for the log odds ratio
--fullmodel	-Output all parameter estimates and the full error matrix

--threads n	Use up to n cores

--precision DIGITS	Print output to DIGITS significant figures

--fitIter NITER	Try up to NITER iterations when fitting models
--fitAbsTol ABSTOL	Terminate model fitting if results change by less than ABSTOL
--fitRelTol RELTOL	Terminate model fitting if results change by less than (RELTOL x value)

--help	- Prints this message
```

## Metadata
- **Skill**: generated

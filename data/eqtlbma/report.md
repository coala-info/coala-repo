# eqtlbma CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| eqtlbma_eqtlbma_avg_bfs | PASS | New file; grid-averaged Bayes factors match the tool's own expected values on its simulated test set (equal grid weights). |
| eqtlbma_eqtlbma_bf | PASS | Added staging of the files named in the list files; all five outputs are identical to the tool's own expected results on its simulated test set. |
| eqtlbma_eqtlbma_hm | PASS | New file; fitted the hierarchical model on the averaged Bayes factors of the tool's simulated test set and got pi0 and configuration weights that sum to 1. |

## eqtlbma_eqtlbma_bf

### Tool Description
performs eQTL mapping in multiple subgroups via a Bayesian model.

### eqtlbma_eqtlbma_avg_bfs

### Tool Description
Averages the raw BFs over the grid, or over the grid and the configurations, and can compute posteriors.

### Metadata
- **Docker Image**: quay.io/biocontainers/eqtlbma:1.3.3--h3dbd7e7_0
- **Homepage**: https://github.com/timflutre/eqtlbma
- **Package**: https://anaconda.org/channels/bioconda/packages/eqtlbma/overview
- **Validation**: PASS

### Original Help Text
```text
`eqtlbma_avg_bfs' averages the raw BFs over the grid only,
or over both the grid and the configurations,
and it can also compute posteriors.

Usage: eqtlbma_avg_bfs [OPTIONS] ...

Options:
  -h, --help	display the help and exit
  -V, --version	output version information and exit
  -v, --verbose	verbosity level (0/default=1/2/3)
      --in	pattern to glob '_l10abfs_raw' files from 'eqtlbma_bf'
      --gwts	file with grid weights (one per line, only the value)
      --gtk	ind-ex/icies of grid weights to keep (all by default)
		e.g. '1+3+5+7+9' to keep only those with no heterogeneity
      --model	which model (default=configs/types)
      --nsubgrp	number of subgroups
      --dim	dimension of the model (nb of active configs or types)
      --cwts	file with configuration weights (one per line, name<sep>value)
		only a subset of the configs can be given, in agreement with --nsubgrp and --dim
      --tswts	file with type and subgroup weights (one per line, name<sep>value)
      --save	precise what to save (bf/post/bf+post)
		'post' requires also options --pi0 and --post
      --pi0	proba for a gene to have no eQTL in any subgroup
		if not provided, BFs will be saved instead of posterior probability
      --post	save various kinds of posterior probabilities (e.g. 'a+b')
		a: the gene has at least one eQTL
		b: the SNP is 'the' eQTL for the gene, in at least one subgroup, given that the gene has exactly one eQTL,
		assuming all cis SNPs are equally likely and a single eQTL per gene
		c: the SNP is 'an' eQTL for the gene, in at least one subgroup, given that the gene contains at least one eQTL
		and that SNPs are independent
		d: the SNP is an eQTL in subgroup s, given that it is 'the' eQTL for the gene, the configs/types being marginalized
      --gene	file with subset of gene(s) to keep (one per line)
      --snp	file with subset of snp(s) to keep (one per line)
		caution, it can change the gene-level BFs and posteriors
      --gene-snp	file with subset of gene-snp pai(s) to keep (gene<tab>snp, one per line)
		caution, it can change the gene-level BFs and posteriors
      --bestsnp	report the best SNP(s) per gene
		0: report all SNPs (default)
		1: report only the single best SNP (pick one if tie)
		2: report the best SNP(s) listed in decreasing order of their probability of being the eQTL (conditional on the gene containing an eQTL), such that the sum of these probabilities exceeds 0.95
      --bestdim	report the best config/type per SNP (and its posterior)
      --alldim	report also BF and/or posterior for all dimensions (configs or types)
		caution, the number of configurations can be big
      --out	name of the output file (gzipped)
		if --cwts is not provided, the output file will be used as input for 'eqtlbma_hm'
      --thread	number of threads (default=1)
```

## eqtlbma_eqtlbma_hm

### Tool Description
Fits the hierarchical model of eQtlBma with an EM algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/eqtlbma:1.3.3--h3dbd7e7_0
- **Homepage**: https://github.com/timflutre/eqtlbma
- **Package**: https://anaconda.org/channels/bioconda/packages/eqtlbma/overview
- **Validation**: PASS

### Original Help Text
```text
`eqtlbma_hm' fits the hierarchical model of eQtlBma with an EM algorithm.

Usage: eqtlbma_hm [OPTIONS] ...

Options:
  -h, --help	display the help and exit
  -V, --version	output version information and exit
  -v, --verbose	verbosity level (0/default=1/2/3)
      --data	input data (usually output files from eqtlbma_bf)
      --nsubgrp	number of subgroups
      --model	which model to fit (default=configs/types)
      --dim	dimension of the model (nb of active configs or types)
      --ngrid	number of grid points
      --out	output file (gzipped)
      --init	file for initialization
		3 columns: param<tab>value<tab>fixed (TRUE or FALSE)
      --rand	random initialization
      --seed	seed used with --rand, otherwise use time
      --thresh	threshold to stop the EM (default=0.05)
      --maxit	maximum number of iterations (optional)
		useful if wall-time limit (see also --init)
      --msl	maximum step length for SQUAREM
		default=1 (meaning classical EM), around 3 is a good option
      --thread	number of threads (default=1)
      --configs	subset of configurations to keep (e.g. "1|3|1-3")
      --keepgen	keep 'general' ABFs (useful for BMAlite)
      --getci	compute the confidence intervals (single thread, thus slow)
      --getbf	compute the Bayes Factors using the estimated weights
		can take some time, otherwise only the estimated weights are reported
      --pi0	fixed value for pi0 (pi0 hence won't be updated in the EM)
      --ci	file with estimates of hyperparameters to only compute confidence intervals
```

## Metadata
- **Docker Image**: quay.io/biocontainers/eqtlbma:1.3.3--h3dbd7e7_0
- **Homepage**: https://github.com/timflutre/eqtlbma
- **Package**: https://anaconda.org/channels/bioconda/packages/eqtlbma/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/eqtlbma/overview
- **Total Downloads**: 14.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/timflutre/eqtlbma
- **Stars**: N/A
### Original Help Text
```text
`eqtlbma_bf' performs eQTL mapping in multiple subgroups via a Bayesian model.

Usage: eqtlbma_bf [OPTIONS] ...

Options:
  -h, --help	display the help and exit
  -V, --version	output version information and exit
  -v, --verbose	verbosity level (0/default=1/2/3)
      --geno	file with absolute paths to genotype files
		two columns: subgroup identifier<space/tab>path to file
		add '#' at the beginning of a line to comment it
		subgroup file: can be in three formats (VCF/IMPUTE/custom)
		VCF: see specifications on 1kG website
		IMPUTE: row 1 is a header chr<del>name<del>coord<del>a1<del>a2
		 followed by >sample1_a1a1<del>sample1_a1a2<del>sample1_a2a2<del>...
		custom: genotypes as allele dose, same as for MatrixEQTL
		 and missing data can be NA or -1 (as used by vcftools --012)
      --scoord	file with the SNP coordinates
		compulsory if custom genotype format; forbidden otherwise
		should be in the BED format (delimiter: tab)
		SNPs in the genotype files without coordinate are skipped (see also --snp)
		if a tabix-indexed file is also present, it will be used
      --exp	file with absolute paths to expression level files
		two columns: subgroup identifier<space/tab>path to file
		add '#' at the beginning of a line to comment it
		subgroup file: custom format, same as for MatrixEQTL
		 row 1 for sample names, column 1 for gene names
		subgroups can have different genes
		all genes should be in the --gcoord file
      --gcoord	file with the gene coordinates
		should be in the BED format (delimiter: tab)
		genes in the exp level files without coordinates are skipped
      --anchor	gene boundary(ies) for the cis region
		default=TSS (assumed to be start in BED file)
      --cis	length of half of the cis region (radius, in bp)
		apart from the anchor(s), default=100000
      --inss	file with absolute paths to files with summary statistics
		two columns: subgroup identifier<space/tab>path to file
		add '#' at the beginning of a line to comment it
		sstats file: custom format, similar to the one from --outss (see below)
		 header should have gene, snp, n, sigmahat, betahat.geno and sebetahat.geno
		 order doesn't matter
      --out	prefix for the output files
		all output files are gzipped and have a header line
      --lik	likelihood to use
		'normal' (default)
		'poisson' or 'quasipoisson'
      --analys	analysis to perform
		'sep': separate analysis of each subgroup
		'join': joint analysis of all subgroups
      --outss	write the output file with all summary statistics
      --outw	write the output file with the ABFs averaged over the grid
		grid weights are uniformly equal
      --qnorm	quantile-normalize the exp levels to a N(0,1)
      --maf	minimum minor allele frequency (default=0.0)
      --covar	file with absolute paths to covariate files
		two columns: subgroup identifier<space/tab>path to file
		can be a single line (single subgroup)
		add '#' at the beginning of a line to comment it
		subgroup file: row 1 is a header sample<space/tab>covariate1 ...
		all sample names should be in the respective genotype and exp level files
		the covariates should be numbers, no missing value is allowed
		subgroups can have different covariates
		the order of rows is not important
      --gridL	file with a 'large' grid for prior variances in standardized effect sizes
		first column is phi^2 and second column is omega^2, no header
		this grid is used with model 1 ('general alternative') trying to capture
		 all sorts of heterogeneity
		required with --analys join
      --gridS	file with a 'small' grid of values for phi^2 and omega^2
		same format as --gridL
		required with --analyis join if --bfs is 'sin' or 'all'
      --bfs	which Bayes Factors to compute for the joint analysis
		only the Laplace-approximated BF from Wen and Stephens (AoAS 2013) is implemented
		if --outw, each BF for a given configuration is the average of the BFs over one of the grids, with equal weights
		'gen' (default): general way to capture any level of heterogeneity
		 correspond to the consistent configuration with the large grid
		 fixed-effect and maximum-heterogeneity BFs are also calculated
		'sin': compute also the BF for each singleton (subgroup-specific configuration)
		 they use the small grid (BF_BMAlite is also reported)
		'all': compute also the BFs for all configurations (costly if many subgroups)
		 all BFs use the small grid (BF_BMA is also reported)
      --error	model for the errors (if --analys join)
		'uvlr': default, errors are not correlated between subgroups (different individuals)
		'mvlr': errors can be correlated between subgroups (same individuals)
		'hybrid': errors can be correlated between pairs of subgroups (common individuals)
      --fiterr	param used when estimating the variance of the errors (if --analys join, only with 'mvlr' or 'hybrid')
		default=0.5 but can be between 0 (null model) and 1 (full model)
      --nperm	number of permutations
		default=0, otherwise 10000 is recommended
      --seed	seed for the two random number generators
		one for the permutations, another for the trick
		by default, both are initialized via microseconds from epoch
		the RNGs are re-seeded before each subgroup and before the joint analysis
		this, along with --trick 2, allows for proper comparison of separate and joint analyzes
      --trick	apply trick to speed-up permutations
		stop after the tenth permutation for which the test statistic
		 is better than or equal to the true value, and sample from
		 a uniform between 11/(nbPermsSoFar+2) and 11/(nbPermsSoFar+1)
		if '1', the permutations really stops
		if '2', all permutations are done but the test statistics are not computed
		allows to compare different test statistics on the same permutations
      --tricut	cutoff for the trick (default=10)
		stop permutations once the nb of permutations for which permTestStat is more extreme
		 than trueTestStat equals this cutoff
      --permsep	which permutation procedure for the separate analysis
		0 (default): no permutations are done for the separate analysis
		1: use the minimum P-value over SNPs and subgroups as a test statistic (keeps correlations)
		2: use the minimum P-value over SNPs but in each subgroup separately (breaks correlations)
      --pbf	which BF to use as the test statistic for the joint-analysis permutations
		'none' (default): no permutations are done for the joint analysis
		'gen': general BF (see --bfs above)
		'gen-sin': 0.5 BFgen + 0.5 BFsin (also called BF_BMAlite)
		'all': average over all configurations (also called BF_BMA)
      --maxbf	use the maximum ABF over SNPs as test statistic for permutations
		otherwise the average ABF over SNPs is used (more Bayesian)
      --thread	number of threads (default=1, parallelize over SNPs)
      --snp	file with a list of SNPs to analyze
		one SNP name per line, useful when launched in parallel
		program exits if an empty file is given
      --sbgrp	identifier of the subgroup to analyze
		useful for quick analysis and debugging
		can be 'sbgrp1+sbgrp3' for instance
      --wrtsize	number of genes which results are written at once (default=10)
		to prevent excessive memory usage
		tune it depending on the average number of cis SNPs per gene
```


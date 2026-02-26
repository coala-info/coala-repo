# eqtlbma CWL Generation Report

## eqtlbma_eqtlbma_bf

### Tool Description
performs eQTL mapping in multiple subgroups via a Bayesian model.

### Metadata
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


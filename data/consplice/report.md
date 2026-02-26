# consplice CWL Generation Report

## consplice_ml

### Tool Description
ConSplice: error: argument command: invalid choice: 'ml' (choose from 'ML', 'constraint')

### Metadata
- **Docker Image**: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
- **Homepage**: https://github.com/mikecormier/ConSplice
- **Package**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mikecormier/ConSplice
- **Stars**: N/A
### Original Help Text
```text
usage: ConSplice [-h] [-v] [--config-path CONFIG_PATH] {ML,constraint} ...
ConSplice: error: argument command: invalid choice: 'ml' (choose from 'ML', 'constraint')
```


## consplice_constraint

### Tool Description
Module to generate genic or regional
splicing constraint using patterns of
purifying selection and evidence of
alternative splicing

### Metadata
- **Docker Image**: quay.io/biocontainers/consplice:0.0.6--pyh5e36f6f_0
- **Homepage**: https://github.com/mikecormier/ConSplice
- **Package**: https://anaconda.org/channels/bioconda/packages/consplice/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ConSplice constraint [-h]
                            {sub-matrix,oe-counts,calculate-oe,select-score,agg-overlapping-reg,to-bed,score-txt,score-bed,score-vcf}
                            ...

	#######################
	# Splicing Constraint #
	#######################

	Module to generate genic or regional
	splicing constraint using patterns of
	purifying selection and evidence of
	alternative splicing

positional arguments:
  {sub-matrix,oe-counts,calculate-oe,select-score,agg-overlapping-reg,to-bed,score-txt,score-bed,score-vcf}
    sub-matrix          Build a substitution matrix using gnomAD variants and
                        SpliceAI scores
    oe-counts           Calculate Observed and Expected splicing variant
                        counts for genic or intragenic regions of genes
    calculate-oe        Calculate the O/E and Percentile constraint scores
    select-score        Select an O/E and matching Percentile score to filter
                        on and remove all other non-essential columns after
                        ConSplice scoring
    agg-overlapping-reg
                        Aggregate scores from overlapping regions where the
                        step size of a region is less than the window size of
                        the region
    to-bed              Convert the 1-based scored ConSplice txt file to a
                        0-based bed file
    score-txt           Add ConSplice scores to a tab-delimited txt variant
                        file
    score-bed           Add ConSplice scores to a bed variant file
    score-vcf           Add ConSplice scores to a vcf file

optional arguments:
  -h, --help            show this help message and exit
```


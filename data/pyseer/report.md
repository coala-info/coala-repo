# pyseer CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pyseer | PASS | fixed-effects and lineage output identical to upstream baseline, LMM within 0.1%; --wg enet crashes inside glmnet_python (numpy 2 incompatibility) |
| pyseer_annotate_hits | PASS | run with one reference only: cwltool cannot stage upstream's draft file names containing # |
| pyseer_enet_predict | Not completed | needs a fitted elastic net model; pyseer --wg enet fails in this image (glmnet_python incompatible with numpy 2), so no model could be made |
| pyseer_phandango_mapper | PASS |  |
| pyseer_scree_plot | Failed | image problem: scree_plot_pyseer forces the TkAgg backend and crashes with missing libX11.so.6, no plot is written |
| pyseer_similarity | PASS |  |
| pyseer_square_mash | PASS |  |

## pyseer

### Tool Description
SEER (doi: 10.1038/ncomms12797), reimplemented in python

### Metadata
- **Docker Image**: quay.io/biocontainers/pyseer:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/mgalardini/pyseer
- **Package**: https://anaconda.org/channels/bioconda/packages/pyseer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyseer/overview
- **Total Downloads**: 63.5K
- **Last updated**: 2025-05-22
- **GitHub**: https://github.com/mgalardini/pyseer
- **Stars**: N/A
### Original Help Text
```text
usage: pyseer [-h] --phenotypes PHENOTYPES
              [--phenotype-column PHENOTYPE_COLUMN]
              (--kmers KMERS | --vcf VCF | --pres PRES) [--burden BURDEN]
              [--distances DISTANCES | --load-m LOAD_M]
              [--similarity SIMILARITY | --load-lmm LOAD_LMM]
              [--save-m SAVE_M] [--save-lmm SAVE_LMM]
              [--mds {classic,metric,non-metric}]
              [--max-dimensions MAX_DIMENSIONS] [--no-distances]
              [--continuous] [--lmm] [--wg {enet,rf,blup}] [--lineage]
              [--lineage-clusters LINEAGE_CLUSTERS]
              [--lineage-file LINEAGE_FILE] [--sequence-reweighting]
              [--save-vars SAVE_VARS] [--load-vars LOAD_VARS]
              [--save-model SAVE_MODEL] [--save-predictions SAVE_PREDICTIONS]
              [--alpha ALPHA] [--n-folds N_FOLDS] [--min-af MIN_AF]
              [--max-af MAX_AF] [--max-missing MAX_MISSING]
              [--filter-pvalue FILTER_PVALUE] [--lrt-pvalue LRT_PVALUE]
              [--cor-filter COR_FILTER] [--covariates COVARIATES]
              [--use-covariates [USE_COVARIATES ...]] [--print-samples]
              [--print-filtered] [--output-patterns OUTPUT_PATTERNS]
              [--uncompressed] [--cpu CPU] [--block_size BLOCK_SIZE]
              [--version]

SEER (doi: 10.1038/ncomms12797), reimplemented in python

options:
  -h, --help            show this help message and exit

Phenotype:
  --phenotypes PHENOTYPES
                        Phenotypes file (whitespace separated)
  --phenotype-column PHENOTYPE_COLUMN
                        Phenotype file column to use [Default: last column]

Variants:
  --kmers KMERS         Kmers file
  --vcf VCF             VCF file. Will filter any non 'PASS' sites
  --pres PRES           Presence/absence .Rtab matrix as produced by roary and
                        piggy
  --burden BURDEN       VCF regions to group variants by for burden testing
                        (requires --vcf). Requires vcf to be indexed

Distances:
  --distances DISTANCES
                        Strains distance square matrix (fixed or lineage
                        effects)
  --load-m LOAD_M       Load an existing matrix decomposition
  --similarity SIMILARITY
                        Strains similarity square matrix (for --lmm)
  --load-lmm LOAD_LMM   Load an existing lmm cache
  --save-m SAVE_M       Prefix for saving matrix decomposition
  --save-lmm SAVE_LMM   Prefix for saving LMM cache
  --mds {classic,metric,non-metric}
                        Type of multidimensional scaling [Default: classic]
  --max-dimensions MAX_DIMENSIONS
                        Maximum number of dimensions to consider after MDS
                        [Default: 10]
  --no-distances        Allow run without a distance matrix

Association options:
  --continuous          Force continuous phenotype [Default: binary auto-
                        detect]
  --lmm                 Use random instead of fixed effects to correct for
                        population structure. Requires a similarity matrix
  --wg {enet,rf,blup}   Use a whole genome model for association and
                        prediction. Population structure correction is
                        implicit.
  --lineage             Report lineage effects
  --lineage-clusters LINEAGE_CLUSTERS
                        Custom clusters to use as lineages [Default: MDS
                        components]
  --lineage-file LINEAGE_FILE
                        File to write lineage association to [Default:
                        lineage_effects.txt]

Whole genome options:
  --sequence-reweighting
                        Use --lineage-clusters to downweight sequences.
  --save-vars SAVE_VARS
                        Prefix for saving variants
  --load-vars LOAD_VARS
                        Prefix for loading variants
  --save-model SAVE_MODEL
                        Prefix for saving model
  --save-predictions SAVE_PREDICTIONS
                        File to save predictions to in TSV format [Default: do
                        not save predictions]
  --alpha ALPHA         Set the mixing between l1 and l2 penalties [Default:
                        0.0069]
  --n-folds N_FOLDS     Number of folds cross-validation to perform [Default:
                        10]

Filtering options:
  --min-af MIN_AF       Minimum AF [Default: 0.01]
  --max-af MAX_AF       Maximum AF [Default: 0.99]
  --max-missing MAX_MISSING
                        Maximum missing (vcf/Rtab) [Default: 0.05]
  --filter-pvalue FILTER_PVALUE
                        Prefiltering t-test pvalue threshold [Default: 1]
  --lrt-pvalue LRT_PVALUE
                        Likelihood ratio test pvalue threshold [Default: 1]
  --cor-filter COR_FILTER
                        Correlation filter for elastic net (phenotype/variant
                        correlation quantile at which to start keeping
                        variants) [Default: 0.25]

Covariates:
  --covariates COVARIATES
                        User-defined covariates file (tab-delimited, with
                        header, first column contains sample names)
  --use-covariates [USE_COVARIATES ...]
                        Covariates to use. Format is "2 3q 4" (q for
                        quantitative) [Default: load covariates but don't use
                        them]

Other:
  --print-samples       Print sample lists [Default: hide samples]
  --print-filtered      Print filtered variants (i.e. fitting errors) (does
                        not apply if --wg is used) [Default: hide them]
  --output-patterns OUTPUT_PATTERNS
                        File to print patterns to, useful for finding pvalue
                        threshold (not used with --wg)
  --uncompressed        Uncompressed kmers file [Default: gzipped]
  --cpu CPU             Processes [Default: 1]
  --block_size BLOCK_SIZE
                        Number of variants per core [Default: 3000]
  --version             show program's version number and exit
```

## pyseer_square_mash

### Tool Description
Make a square matrix out of a mash stream.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyseer:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/mgalardini/pyseer
- **Package**: https://anaconda.org/channels/bioconda/packages/pyseer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: square_mash [-h] [--classic] [--version]

Make a square matrix out of a mash stream

options:
  -h, --help  show this help message and exit
  --classic   Output table in a format suitable for R_mds.pl
  --version   show program's version number and exit
```

## pyseer_similarity

### Tool Description
Calculate a similarity matrix using variant presence/absence information.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyseer:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/mgalardini/pyseer
- **Package**: https://anaconda.org/channels/bioconda/packages/pyseer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: similarity [-h] (--kmers KMERS | --vcf VCF | --pres PRES)
                  [--min-af MIN_AF] [--max-af MAX_AF]
                  [--max-missing MAX_MISSING] [--uncompressed] [--version]
                  samples

Calculate a similarity matrix using variant presence/absence information

positional arguments:
  samples               List of sample names to use

options:
  -h, --help            show this help message and exit
  --kmers KMERS         Kmers file
  --vcf VCF             VCF file. Will filter any non 'PASS' sites
  --pres PRES           Presence/absence .Rtab matrix as produced by roary and
                        piggy
  --min-af MIN_AF       Minimum AF [Default: 0.01]
  --max-af MAX_AF       Maximum AF [Default: 0.99]
  --max-missing MAX_MISSING
                        Maximum missing (vcf/Rtab) [Default: 0.05]
  --uncompressed        Uncompressed kmers file [Default: gzipped]
  --version             show program's version number and exit
```

## pyseer_scree_plot

### Tool Description
Draw a scree-plot from MDS eigenvalues.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyseer:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/mgalardini/pyseer
- **Package**: https://anaconda.org/channels/bioconda/packages/pyseer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scree_plot_pyseer [-h] [--max-dimensions MAX_DIMENSIONS]
                         [--output OUTPUT]
                         distances

Draw a scree-plot from MDS eigenvalues

positional arguments:
  distances             Strains distance square matrix

options:
  -h, --help            show this help message and exit
  --max-dimensions MAX_DIMENSIONS
                        Maximum dimensions to plot [Default: 30]
  --output OUTPUT       Plot filename [Default: scree_plot.png]
```

## pyseer_phandango_mapper

### Tool Description
Create Phandango Manhattan plot from kmer results.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyseer:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/mgalardini/pyseer
- **Package**: https://anaconda.org/channels/bioconda/packages/pyseer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phandango_mapper [-h] [--bwa BWA] [--tmp-prefix TMP_PREFIX]
                        [--use-filter-p]
                        kmers reference output

Create Phandango Manhattan plot from kmer results

positional arguments:
  kmers                 Kmers file, filtered output from SEER
  reference             Reference fasta file
  output                Output file

options:
  -h, --help            show this help message and exit
  --bwa BWA             Location of bwa executable [Default: bwa]
  --tmp-prefix TMP_PREFIX
                        Directory to store temporary files [Default: cwd]
  --use-filter-p        Plot the unadjusted p-value [Default: lrt-p-value]
```

## pyseer_annotate_hits

### Tool Description
Iteratively annotate significant kmers from SEER.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyseer:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/mgalardini/pyseer
- **Package**: https://anaconda.org/channels/bioconda/packages/pyseer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: annotate_hits [-h] [--feature-type FEATURE_TYPE] [--bwa BWA]
                     [--tmp-prefix TMP_PREFIX]
                     kmers references output

Iteratively annotate significant kmers from SEER

positional arguments:
  kmers                 Kmers file, filtered output from SEER
  references            File of reference annotations. First column fasta
                        sequence, second column gff annotation, third column
                        'ref' or 'draft'
  output                Output file

options:
  -h, --help            show this help message and exit
  --feature-type FEATURE_TYPE
                        Which feature types to consider [default=CDSs only]
  --bwa BWA             Location of bwa executable [default=bwa]
  --tmp-prefix TMP_PREFIX
                        Directory to store temporary files [default=./]
```

## pyseer_enet_predict

### Tool Description
Predict phenotypes using a fitted elastic net model.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyseer:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/mgalardini/pyseer
- **Package**: https://anaconda.org/channels/bioconda/packages/pyseer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: enet_predict_pyseer [-h] [--threshold THRESHOLD]
                           [--lineage-clusters LINEAGE_CLUSTERS]
                           [--true-values TRUE_VALUES] [--ignore-missing]
                           (--kmers KMERS | --vcf VCF | --pres PRES)
                           [--burden BURDEN] [--uncompressed]
                           [--covariates COVARIATES]
                           [--use-covariates [USE_COVARIATES ...]]
                           model samples

Predict phenotypes using a fitted elastic net model

positional arguments:
  model                 Name of fitted model pickle file (.pkl)
  samples               File with samples to predict

options:
  -h, --help            show this help message and exit
  --threshold THRESHOLD
                        Threshold to pick binary predictions
  --lineage-clusters LINEAGE_CLUSTERS
                        Custom clusters to use as lineages to report
                        stratified accuracy
  --true-values TRUE_VALUES
                        Pheno file with known phenotypes to calculate accuracy
  --ignore-missing      Treat missing values as REF/0 rather than using the
                        mean AF

Variants:
  --kmers KMERS         Kmers file
  --vcf VCF             VCF file. Will filter any non 'PASS' sites
  --pres PRES           Presence/absence .Rtab matrix as produced by roary and
                        piggy
  --burden BURDEN       VCF regions to group variants by for burden testing
                        (requires --vcf). Requires vcf to be indexed
  --uncompressed        Uncompressed kmers file [Default: gzipped]

Covariates:
  --covariates COVARIATES
                        User-defined covariates file (tab-delimited, no
                        header, first column contains sample names)
  --use-covariates [USE_COVARIATES ...]
                        Covariates to use. Format is "2 3q 4" (q for
                        quantitative) [Default: load covariates but don't use
                        them]
```

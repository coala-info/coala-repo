# peakachu CWL Generation Report

## peakachu_window

### Tool Description
peakachu window

### Metadata
- **Docker Image**: quay.io/biocontainers/peakachu:0.2.0--py38h0020b31_4
- **Homepage**: https://github.com/tbischler/PEAKachu
- **Package**: https://anaconda.org/channels/bioconda/packages/peakachu/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/peakachu/overview
- **Total Downloads**: 17.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tbischler/PEAKachu
- **Stars**: N/A
### Original Help Text
```text
usage: peakachu window [-h] -t EXP_LIBS [EXP_LIBS ...] -c CTR_LIBS
                       [CTR_LIBS ...] [-r] [-P] [-M MAX_INSERT_SIZE]
                       [-g GFF_FOLDER] [--features [FEATURES [FEATURES ...]]]
                       [--sub_features [SUB_FEATURES [SUB_FEATURES ...]]]
                       [-p MAX_PROC] [-w WINDOW_SIZE] [-l STEP_SIZE]
                       [-d {gtest,deseq}] [-n {tmm,deseq,count,manual,none}]
                       [-s [SIZE_FACTORS [SIZE_FACTORS ...]]]
                       [-m MAD_MULTIPLIER] [-f FC_CUTOFF]
                       [-H HET_P_VAL_THRESHOLD] [-R REP_PAIR_P_VAL_THRESHOLD]
                       [-Q PADJ_THRESHOLD] [-o OUTPUT_FOLDER]

optional arguments:
  -h, --help            show this help message and exit
  -t EXP_LIBS [EXP_LIBS ...], --exp_libs EXP_LIBS [EXP_LIBS ...]
  -c CTR_LIBS [CTR_LIBS ...], --ctr_libs CTR_LIBS [CTR_LIBS ...]
  -r, --pairwise_replicates
  -P, --paired_end
  -M MAX_INSERT_SIZE, --max_insert_size MAX_INSERT_SIZE
  -g GFF_FOLDER, --gff_folder GFF_FOLDER
  --features [FEATURES [FEATURES ...]]
  --sub_features [SUB_FEATURES [SUB_FEATURES ...]]
  -p MAX_PROC, --max_proc MAX_PROC
  -w WINDOW_SIZE, --window_size WINDOW_SIZE
  -l STEP_SIZE, --step_size STEP_SIZE
  -d {gtest,deseq}, --stat_test {gtest,deseq}
  -n {tmm,deseq,count,manual,none}, --norm_method {tmm,deseq,count,manual,none}
  -s [SIZE_FACTORS [SIZE_FACTORS ...]], --size_factors [SIZE_FACTORS [SIZE_FACTORS ...]]
                        Normalization factors for libraries in input order
                        (first experiment then control libraries)
  -m MAD_MULTIPLIER, --mad_multiplier MAD_MULTIPLIER
  -f FC_CUTOFF, --fc_cutoff FC_CUTOFF
  -H HET_P_VAL_THRESHOLD, --het_p_val_threshold HET_P_VAL_THRESHOLD
  -R REP_PAIR_P_VAL_THRESHOLD, --rep_pair_p_val_threshold REP_PAIR_P_VAL_THRESHOLD
  -Q PADJ_THRESHOLD, --padj_threshold PADJ_THRESHOLD
  -o OUTPUT_FOLDER, --output_folder OUTPUT_FOLDER
```


## peakachu_experiment

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/peakachu:0.2.0--py38h0020b31_4
- **Homepage**: https://github.com/tbischler/PEAKachu
- **Package**: https://anaconda.org/channels/bioconda/packages/peakachu/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: peakachu [-h] [--version] {window,adaptive,coverage,consensus_peak} ...
peakachu: error: invalid choice: 'experiment' (choose from 'window', 'adaptive', 'coverage', 'consensus_peak')
```


## peakachu_adaptive

### Tool Description
Adaptive peak calling for ChIP-seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/peakachu:0.2.0--py38h0020b31_4
- **Homepage**: https://github.com/tbischler/PEAKachu
- **Package**: https://anaconda.org/channels/bioconda/packages/peakachu/overview
- **Validation**: PASS

### Original Help Text
```text
usage: peakachu adaptive [-h] -t EXP_LIBS [EXP_LIBS ...]
                         [-c [CTR_LIBS [CTR_LIBS ...]]] [-r] [-P]
                         [-M MAX_INSERT_SIZE] [-g GFF_FOLDER]
                         [--features [FEATURES [FEATURES ...]]]
                         [--sub_features [SUB_FEATURES [SUB_FEATURES ...]]]
                         [-p MAX_PROC] [-b BLOCKBUSTER_PATH]
                         [-C MIN_CLUSTER_EXPR_FRAC] [-O MIN_BLOCK_OVERLAP]
                         [-B MIN_MAX_BLOCK_EXPR_FRAC] [-n {deseq,manual,none}]
                         [-s [SIZE_FACTORS [SIZE_FACTORS ...]]]
                         [-m MAD_MULTIPLIER] [-f FC_CUTOFF]
                         [-Q PADJ_THRESHOLD] [-o OUTPUT_FOLDER]

optional arguments:
  -h, --help            show this help message and exit
  -t EXP_LIBS [EXP_LIBS ...], --exp_libs EXP_LIBS [EXP_LIBS ...]
  -c [CTR_LIBS [CTR_LIBS ...]], --ctr_libs [CTR_LIBS [CTR_LIBS ...]]
  -r, --pairwise_replicates
  -P, --paired_end
  -M MAX_INSERT_SIZE, --max_insert_size MAX_INSERT_SIZE
  -g GFF_FOLDER, --gff_folder GFF_FOLDER
  --features [FEATURES [FEATURES ...]]
  --sub_features [SUB_FEATURES [SUB_FEATURES ...]]
  -p MAX_PROC, --max_proc MAX_PROC
  -b BLOCKBUSTER_PATH, --blockbuster_path BLOCKBUSTER_PATH
                        Location of blockbuster executable. Per default
                        required to be on the $PATH.
  -C MIN_CLUSTER_EXPR_FRAC, --min_cluster_expr_frac MIN_CLUSTER_EXPR_FRAC
                        Minimum fraction of the blockbuster cluster expression
                        that a maximum block needs to have for further
                        consideration
  -O MIN_BLOCK_OVERLAP, --min_block_overlap MIN_BLOCK_OVERLAP
                        Minimum fraction of the width of the current maximum
                        block that has to overlap with a subblock to consider
                        it for peak merging
  -B MIN_MAX_BLOCK_EXPR_FRAC, --min_max_block_expr_frac MIN_MAX_BLOCK_EXPR_FRAC
                        Minimum fraction of the expression of the current
                        maximum block that a subblock needs to have to
                        consider it for peak merging
  -n {deseq,manual,none}, --norm_method {deseq,manual,none}
  -s [SIZE_FACTORS [SIZE_FACTORS ...]], --size_factors [SIZE_FACTORS [SIZE_FACTORS ...]]
                        Normalization factors for libraries in input order
                        (first experiment then control libraries)
  -m MAD_MULTIPLIER, --mad_multiplier MAD_MULTIPLIER
  -f FC_CUTOFF, --fc_cutoff FC_CUTOFF
  -Q PADJ_THRESHOLD, --padj_threshold PADJ_THRESHOLD
  -o OUTPUT_FOLDER, --output_folder OUTPUT_FOLDER
```


## peakachu_based

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/peakachu:0.2.0--py38h0020b31_4
- **Homepage**: https://github.com/tbischler/PEAKachu
- **Package**: https://anaconda.org/channels/bioconda/packages/peakachu/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: peakachu [-h] [--version] {window,adaptive,coverage,consensus_peak} ...
peakachu: error: invalid choice: 'based' (choose from 'window', 'adaptive', 'coverage', 'consensus_peak')
```


## peakachu_comparison

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/peakachu:0.2.0--py38h0020b31_4
- **Homepage**: https://github.com/tbischler/PEAKachu
- **Package**: https://anaconda.org/channels/bioconda/packages/peakachu/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: peakachu [-h] [--version] {window,adaptive,coverage,consensus_peak} ...
peakachu: error: invalid choice: 'comparison' (choose from 'window', 'adaptive', 'coverage', 'consensus_peak')
```


## peakachu_coverage

### Tool Description
Calculate coverage for a project folder.

### Metadata
- **Docker Image**: quay.io/biocontainers/peakachu:0.2.0--py38h0020b31_4
- **Homepage**: https://github.com/tbischler/PEAKachu
- **Package**: https://anaconda.org/channels/bioconda/packages/peakachu/overview
- **Validation**: PASS

### Original Help Text
```text
usage: peakachu coverage [-h] [-p MAX_PROC] project_folder

positional arguments:
  project_folder

optional arguments:
  -h, --help            show this help message and exit
  -p MAX_PROC, --max_proc MAX_PROC
```


## peakachu_for

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/peakachu:0.2.0--py38h0020b31_4
- **Homepage**: https://github.com/tbischler/PEAKachu
- **Package**: https://anaconda.org/channels/bioconda/packages/peakachu/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: peakachu [-h] [--version] {window,adaptive,coverage,consensus_peak} ...
peakachu: error: invalid choice: 'for' (choose from 'window', 'adaptive', 'coverage', 'consensus_peak')
```


## peakachu_consensus_peak

### Tool Description
Length of the region around peak centers for plotting consensus peaks

### Metadata
- **Docker Image**: quay.io/biocontainers/peakachu:0.2.0--py38h0020b31_4
- **Homepage**: https://github.com/tbischler/PEAKachu
- **Package**: https://anaconda.org/channels/bioconda/packages/peakachu/overview
- **Validation**: PASS

### Original Help Text
```text
usage: peakachu consensus_peak [-h] [-l CONSENSUS_LENGTH] project_folder

positional arguments:
  project_folder

optional arguments:
  -h, --help            show this help message and exit
  -l CONSENSUS_LENGTH, --consensus_length CONSENSUS_LENGTH
                        Length of the region around peak centers for plotting
                        consensus peaks
```


## peakachu_on

### Tool Description
peakachu: error: invalid choice: 'on' (choose from 'window', 'adaptive', 'coverage', 'consensus_peak')

### Metadata
- **Docker Image**: quay.io/biocontainers/peakachu:0.2.0--py38h0020b31_4
- **Homepage**: https://github.com/tbischler/PEAKachu
- **Package**: https://anaconda.org/channels/bioconda/packages/peakachu/overview
- **Validation**: PASS

### Original Help Text
```text
usage: peakachu [-h] [--version] {window,adaptive,coverage,consensus_peak} ...
peakachu: error: invalid choice: 'on' (choose from 'window', 'adaptive', 'coverage', 'consensus_peak')
```


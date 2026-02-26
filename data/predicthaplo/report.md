# predicthaplo CWL Generation Report

## predicthaplo

### Tool Description
This software aims at reconstructing haplotypes from next-generation sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/predicthaplo:2.1.4--h9b88814_6
- **Homepage**: https://github.com/cbg-ethz/PredictHaplo
- **Package**: https://anaconda.org/channels/bioconda/packages/predicthaplo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/predicthaplo/overview
- **Total Downloads**: 5.2K
- **Last updated**: 2025-09-02
- **GitHub**: https://github.com/cbg-ethz/PredictHaplo
- **Stars**: N/A
### Original Help Text
```text
Usage: predicthaplo [OPTIONS]

  This software aims at reconstructing haplotypes from next-generation sequencing data.

Options:
  --sam FILE                        Filename of the aligned reads (sam format).
  --reference FILE                  Filename of reference sequence (FASTA).
  --prefix STR                      Prefix of output files.
  --visualization_level INT         do_visualize (1 = true, 0 = false).
  --have_true_haplotypes INT        have_true_haplotypes (1 = true, 0 = false).
  --true_haplotypes FILE            Filename of the true haplotypes (MSA in FASTA format) (fill in any dummy filename if there is no "true" haplotypes).
  --do_local_Analysis INT           do_local_analysis (1 = true, 0 = false) (must be 1 in the first run).
  --max_reads_in_window INT         ...
  --entropy_threshold FLOAT         ...
  --reconstruction_start INT        ...
  --reconstruction_stop INT         ...
  --min_mapping_qual INT            ...
  --min_readlength INT              ...
  --max_gap_fraction FLOAT          Relative to alignment length.
  --min_align_score_fraction FLOAT  Relative to read length.
  --alpha_MN_local FLOAT            Prior parameter for multinomial tables over the nucleotides.
  --min_overlap_factor FLOAT        Reads must have an overlap with the local reconstruction window of at least this factor times the window size.
  --local_window_size_factor FLOAT  Size of  local reconstruction window relative to the median of the read lengths.
  --cluster_number INT              Max number of clusters (in the truncated Dirichlet process).
  --nSample INT                     MCMC iterations.
  --include_deletions INT           Include deletions (0 = no, 1 = yes).
  --help                            Show this message and exit.
```


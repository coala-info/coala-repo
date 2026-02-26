# viloca CWL Generation Report

## viloca_run

### Tool Description
Run VILOCA

### Metadata
- **Docker Image**: quay.io/biocontainers/viloca:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/cbg-ethz/VILOCA
- **Package**: https://anaconda.org/channels/bioconda/packages/viloca/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/viloca/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-07-25
- **GitHub**: https://github.com/cbg-ethz/VILOCA
- **Stars**: N/A
### Original Help Text
```text
usage: viloca <subcommand> [options] run [-h] [-v] -b BAM [BAM ...] -f REF
                                         [-a FLOAT] [-r chrm:start-stop]
                                         [-R INT] [-x INT] [-S FLOAT] [-I]
                                         [-p FLOAT]
                                         [-of {csv,vcf} [{csv,vcf} ...]]
                                         [-c INT] [-w INT]
                                         [--win_min_ext FLOAT] [-s INT] [-k]
                                         [-t INT] [-z INSERT_FILE]
                                         [--n_max_haplotypes INT]
                                         [--conv_thres FLOAT]
                                         [--n_mfa_starts INT]
                                         [--mode {shorah,learn_error_params,use_quality_scores}]
                                         [--non-unique_modus]
                                         [--extended_window_mode]
                                         [--exclude_non_var_pos_threshold FLOAT]
                                         [--reuse_files] [--record_history]
                                         [--min_windows_coverage INT]
                                         [--NO-strand_bias_filter]

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -a FLOAT, --alpha FLOAT
                        alpha
  -r chrm:start-stop, --region chrm:start-stop
                        region in format 'chr:start-stop', e.g.
                        'chrm:1000-3000'
  -R INT, --seed INT    set seed for reproducible results
  -x INT, --maxcov INT  approximate max read coverage per position allowed
  -S FLOAT, --sigma FLOAT
                        sigma value to use when calling SNVs
  -I, --ignore_indels   ignore SNVs adjacent to insertions/deletions (legacy
                        behaviour of 'fil', ignore this option if you don't
                        understand)
  -p FLOAT, --threshold FLOAT
                        pos threshold when calling variants from support files
  -of {csv,vcf} [{csv,vcf} ...], --out_format {csv,vcf} [{csv,vcf} ...]
                        output format of called SNVs
  -c INT, --win_coverage INT
                        coverage threshold. Omit windows with low coverage
  -w INT, --windowsize INT
                        window size
  --win_min_ext FLOAT   win_min_ext: Minimum percentage of bases to overlap
                        between reference and read to be considered in a
                        window. The rest (i.e. non-overlapping part) will be
                        filled with Ns.
  -s INT, --winshifts INT
                        number of window shifts
  -k, --keep_files      keep all intermediate files
  -t INT, --threads INT
                        limit maximum number of parallel threads (0: CPUs
                        count-1, n: limit to n)
  -z INSERT_FILE, --insert-file INSERT_FILE
                        path to an (optional) insert file (primer tiling
                        strategy)
  --n_max_haplotypes INT
                        Guess of maximal guess of haplotypes. If VILOCA
                        returns the maximal number of haplotypes then this
                        number was choosen to little and needs to be
                        increased.
  --conv_thres FLOAT    convergence threshold for inference.
  --n_mfa_starts INT    Number of starts for inference type
                        mean_field_approximation.
  --mode {shorah,learn_error_params,use_quality_scores}
                        Mode in which to run VILOCA: shorah,
                        learn_error_params, use_quality_scores, ShoRAH refers
                        to the method from https://github.com/cbg-ethz/shorah.
  --non-unique_modus    For inference: Make read set unique with read weights.
                        Cannot be used with --mode shorah.
  --extended_window_mode
                        Runs b2w in extended window mode where fake
                        inserations are placed into reference and read.
  --exclude_non_var_pos_threshold FLOAT
                        Runs exclude non-variable positions mode. Set
                        percentage threshold for exclusion.
  --reuse_files         Enabling this option allows the command line tool to
                        reuse files that were generated in previous runs. When
                        set to true, the tool will check for existing output
                        files and reuse them instead of regenerating the data.
                        This can help improve performance by avoiding
                        redundant file generation processes.
  --record_history      When enabled, this option saves the history of the
                        parameter values learned during the inference process.
  --min_windows_coverage INT
                        Number of windows that need to cover a mutation to
                        have it called.
  --NO-strand_bias_filter
                        Do NOT filter out mutations that do not pass the
                        strand bias filter. The strand bias filter is only
                        recommended for paired-end Illumina reads.

required arguments:
  -b BAM [BAM ...], --bam BAM [BAM ...]
                        sorted bam format alignment file
  -f REF, --fasta REF   reference genome in fasta format
```


## viloca_snv

### Tool Description
Call SNVs from BAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/viloca:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/cbg-ethz/VILOCA
- **Package**: https://anaconda.org/channels/bioconda/packages/viloca/overview
- **Validation**: PASS

### Original Help Text
```text
usage: viloca <subcommand> [options] snv [-h] [-v] -b BAM [BAM ...] -f REF
                                         [-a FLOAT] [-r chrm:start-stop]
                                         [-R INT] [-x INT] [-S FLOAT] [-I]
                                         [-p FLOAT]
                                         [-of {csv,vcf} [{csv,vcf} ...]]
                                         [-i INT]

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -a FLOAT, --alpha FLOAT
                        alpha
  -r chrm:start-stop, --region chrm:start-stop
                        region in format 'chr:start-stop', e.g.
                        'chrm:1000-3000'
  -R INT, --seed INT    set seed for reproducible results
  -x INT, --maxcov INT  approximate max read coverage per position allowed
  -S FLOAT, --sigma FLOAT
                        sigma value to use when calling SNVs
  -I, --ignore_indels   ignore SNVs adjacent to insertions/deletions (legacy
                        behaviour of 'fil', ignore this option if you don't
                        understand)
  -p FLOAT, --threshold FLOAT
                        pos threshold when calling variants from support files
  -of {csv,vcf} [{csv,vcf} ...], --out_format {csv,vcf} [{csv,vcf} ...]
                        output format of called SNVs
  -i INT, --increment INT
                        value of increment to use when calling SNVs

required arguments:
  -b BAM [BAM ...], --bam BAM [BAM ...]
                        sorted bam format alignment file
  -f REF, --fasta REF   reference genome in fasta format
```


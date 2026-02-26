# trand CWL Generation Report

## trand

### Tool Description
Perform transcript distance, complexity and transcriptome comparison analyses.

### Metadata
- **Docker Image**: quay.io/biocontainers/trand:22.10.13--pyhdfd78af_0
- **Homepage**: https://github.com/McIntyre-Lab/TranD
- **Package**: https://anaconda.org/channels/bioconda/packages/trand/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/trand/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/McIntyre-Lab/TranD
- **Stars**: N/A
### Original Help Text
```text
usage: trand [-h] [-o OUTDIR] [-x PREFIX] [-l LOG_FILE] [--consolidate]
             [--consolPrefix CONSOL_PREFIX] [-c] [-e {pairwise,gene}] [-k]
             [-p {all,both,first,second}] [-1 NAME1] [-2 NAME2] [-n CPU_CORES]
             [-f] [-s] [-i] [-v]
             input_file [input_file ...]

Perform transcript distance, complexity and transcriptome comparison analyses.

positional arguments:
  input_file            One or two input GTF file(s).

options:
  -h, --help            show this help message and exit
  -o OUTDIR, --outdir OUTDIR
                        Output directory, created if missing. Default: current
                        directory.
  -x PREFIX, --prefix PREFIX
                        Output prefix of various output files. " Default: no
                        prefix for 1GTF, 'name1_vs_name2' for 2GTF.
  -l LOG_FILE, --logfile LOG_FILE
                        Log file name for logging processing events to file.
  --consolidate         Used with 1 GTF input file. Consolidate transcripts
                        remove 5'/3' transcript end variation in redundantly
                        spliced transcripts) with identical junctions prior to
                        complexity calculations, events and summary plotting.
                        Default: No consolidation
  --consolPrefix CONSOL_PREFIX
                        Used with 1 GTF input file. Requires '--consolidate'
                        flag. Specify the prefix to use for consolidated
                        transcript_id values. Prefix must be alphanumeric with
                        no spaces. Underscore ("_") is the only allowed
                        special character. Default: 'tr'
  -c, --complexityOnly  Used with 1 or 2 GTF input file(s). Output only
                        complexity measures. If used in presence of the '--
                        consolidate' flag, complexity is calculated on the
                        consolidated GTF(s). Default: Perform all analyses and
                        comparisons including complexity calculations
  -e {pairwise,gene}, --ea {pairwise,gene}
                        Specify type of within gene transcript comparison:
                        pairwise - Used with 1 or 2 GTF input files. Compare
                        pairs of transcripts within a gene. gene - Used iwth 1
                        GTF input file. Compare all transcripts within a gene
                        Default: pairwise
  -k, --keepir          Keep transcripts with Intron Retention(s) when
                        generating transcript events. Only used with 1 GTF
                        input file. Default: remove
  -p {all,both,first,second}, --pairs {all,both,first,second}
                        Used with 2 GTF input files. The TranD metrics can be
                        for all transcript pairs in both GTF files or for a
                        subset of transcript pairs using the following
                        options: both - Trand metrics for the minimum pairs in
                        both GTF files, first - TranD metrics for the minimum
                        pairs in the first GTF file, second - TranD metrics
                        for the minimum pairs in the second GTF file all -
                        TranD metrics for all transcript pairs in both GTF
                        files Default: both
  -1 NAME1, --name1 NAME1
                        Used with 2 GTF input files. User-specified name to be
                        used for labeling output files related to the first
                        GTF file. Name must be alphanumeric, can only include
                        "_" special character and not contain any spaces.
                        Default: d1
  -2 NAME2, --name2 NAME2
                        Used with 2 GTF input files. User-specified name to be
                        used for labeling output files related to the second
                        GTF file. Name must be alphanumeric, can only include
                        "_" special character and not contain any spaces.
                        Default: d2
  -n CPU_CORES, --cpus CPU_CORES
                        Number of CPU cores to use for parallelization.
                        Default: 1
  -f, --force           Force overwrite existing output directory and files
                        within.
  -s, --skip-plots      Skip generation of all plots.
  -i, --skip-intermediate
                        Skip intermediate file output (junction and exon
                        region/fragment files).
  -v, --verbose         Verbose output
```


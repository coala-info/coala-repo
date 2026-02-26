# clever-toolkit CWL Generation Report

## clever-toolkit_clever

### Tool Description
This tool runs the whole workflow necessary to use CLEVER.

### Metadata
- **Docker Image**: quay.io/biocontainers/clever-toolkit:2.4--h077b44d_14
- **Homepage**: https://bitbucket.org/tobiasmarschall/clever-toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/clever-toolkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clever-toolkit/overview
- **Total Downloads**: 52.2K
- **Last updated**: 2025-09-16
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: clever [options] <bam-file> <ref.fasta(.gz)> <result-directory>

This tool runs the whole workflow necessary to use CLEVER.

<bam-file>         Input BAM file. All alignments for the same read (pair) must be in
                   subsequent lines. It is highly recommended to allows multiple 
                   alignments per read to avoid spurious predictions. 
<ref.fasta(.gz)>   The reference genome in (gzipped) FASTA format. This is needed to
                   recompute alignment scores (AS tags). If your BAM file does have AS tags
                   such that 10^(AS/-10.0) can be interpreted as the probability of this
                   alignment being correct, use option -a to omit this step.
<result-directory> Directory to be created to store results in. If it already exists, abort
                   unless option -f is given.

Options:
  -h, --help            show this help message and exit
  --sorted              Input BAM file is sorted by position. Note that this
                        requires alternative alignments to be given as XA tags
                        (like produced by BWA, stampy, etc.).
  --use_xa              Interprete XA tags in input BAM file. This option
                        SHOULD be given for mappers writing XA tags like BWA
                        and stampy.
  --use_mapq            Use MAPQ value instead re-computing posteriors.
  -T THREADS            Number of threads to use (default=1).
  -f                    Delete old result and working directory first (if
                        present).
  -w WORK_DIR           Working directory (default: <result-directory>/work).
  -a                    Do not (re-)compute AS tags. If given, the argument
                        <ref.fasta(.gz)> is ignored.
  -k                    Keep working directory (default: delete directory when
                        finished).
  -r                    Take read groups into account (multi sample mode).
  -C ADD_CLEVER_PARAMS  Additional parameters to be passed to the CLEVER core
                        algorithm. Call "clever-core" without parameters for a
                        list of options.
  -P ADD_POST_PARAMS    Additional parameters for postprocessing results. Call
                        "postprocess-predictions" without parameters for a
                        list of options.
  -I                    Create a plot of internal segment size distribution
                        (=fragment size - 2x read length). Also displays the
                        estimated normal distribution (requires NumPy and
                        matplotlib).
  --chromosome=CHROMOSOME
                        Only process given chromosome (default: all).
```


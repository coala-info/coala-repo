# snpiphy CWL Generation Report

## snpiphy

### Tool Description
An automated snp phylogeny pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/snpiphy:0.5--py_0
- **Homepage**: https://github.com/bogemad/snpiphy
- **Package**: https://anaconda.org/channels/bioconda/packages/snpiphy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/snpiphy/overview
- **Total Downloads**: 18.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bogemad/snpiphy
- **Stars**: N/A
### Original Help Text
```text
usage: snpiphy [-h] -o OUTDIR -r REFERENCE [-q READS_DIR] [-l READS_LIST]
               [-c CUTOFF] [-p PREFIX] [-t THREADS] [-j] [-s] [-m]
               [-b {raxml,fasttree}] [-f] [-n] [--version] [-v]

snpiphy - An automated snp phylogeny pipeline.

required arguments:
  -o OUTDIR, --output-directory OUTDIR
                        Path to the output directory. A directory will be
                        created if one does not exist.
  -r REFERENCE, --reference REFERENCE
                        Path to the reference sequence. Only fasta format is
                        accepted currently.

input arguments - required, provide only one:
  -q READS_DIR, --input_dir READS_DIR
                        Path to a directory with your interleaved fastq
                        sequencing reads, single-end sequencing reads (use
                        with the -s option) or fasta assemblies.
  -l READS_LIST, --input_list READS_LIST
                        Path to a tab-separated file containing read paths and
                        paired status. Best used when running a combination of
                        single-end and paired-end data or if your data is
                        spread across multiple directories. Run
                        'snpiphy_generate_input_list' to generate an example
                        list.

optional arguments:
  -h, --help            show this help message and exit
  -c CUTOFF, --cov_cutoff CUTOFF
                        Percent coverage of reference sequence (0-100%) used
                        to reject a sample. Samples lower than this threshold
                        will be excluded from phylogenetic pipeline steps.
                        Defaults to 85%.
  -p PREFIX, --prefix PREFIX
                        Prefix for output files
  -t THREADS, --threads THREADS
                        Number of threads to use for multiprocessing.
  -j, --parallel        Use GNU parallel to run multiple instances of snippy
                        (can speed things up if you have multiple cores
                        available)
  -s, --single_end      fastq reads are single end instead of paired-end. Use
                        for ion torrent or non-paired end illumina data
  -m, --gamma_model     Use GTRGAMMA model instead of GTRCAT during the
                        gubbins and RAxML tree building steps.
  -b {raxml,fasttree}, --tree_builder {raxml,fasttree}
                        Algorithm used for building the phylogenetic tree
                        (default: raxml)
  -f, --force           Overwrite files in the output directories.
  -n, --no_recombination_filter
                        Don't filter potential recombination events. Use for
                        organisms that are known undergo low amounts of
                        recombination.
  --version             show program's version number and exit
  -v, --verbose         Increase verbosity on command line output (n.b.
                        verbose output is always saved to snpiphy.log in the
                        output directory).
```


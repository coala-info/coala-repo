# notramp CWL Generation Report

## notramp

### Tool Description
NoTrAmp is a Tool for read-depth normalization and trimming of reads in
amplicon-tiling approaches. It trims amplicons to their appropriate length
removing barcodes, adpaters and primers (if desired) in a single clipping step
and can be used to cap coverage of all amplicons at a chosen value.

### Metadata
- **Docker Image**: quay.io/biocontainers/notramp:1.1.9--pyh7e72e81_0
- **Homepage**: https://github.com/simakro/NoTrAmp.git
- **Package**: https://anaconda.org/channels/bioconda/packages/notramp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/notramp/overview
- **Total Downloads**: 2.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/simakro/NoTrAmp
- **Stars**: N/A
### Original Help Text
```text
usage: 
notramp (-a | -c | -t) -p PRIMERS -r READS -g REFERENCE [optional arguments]

NoTrAmp is a Tool for read-depth normalization and trimming of reads in
amplicon-tiling approaches. It trims amplicons to their appropriate length
removing barcodes, adpaters and primers (if desired) in a single clipping step
and can be used to cap coverage of all amplicons at a chosen value.

Required arguments:
  -p, --primers PRIMERS
                        Path to primer bed-file (primer-names must adhere to a
                        consistent naming scheme see readme)
  -r, --reads READS     Path to sequencing reads fasta
  -g, --reference REFERENCE
                        Path to reference (genome) fasta file. Must contain
                        only one target sequence. Multiple target sequences
                        are not currently supported.
  -a, --all             Perform read depth normalization by coverage-
                        capping/downsampling first, then clip the normalized
                        reads. (mut.excl. with -c, -t)
  -c, --cov             Perform only read-depth normalization/downsampling.
                        (mut.excl. with -a, -t)
  -t, --trim            Perform only trimming to amplicon length (excluding
                        primers by default; to include primers set --incl_prim
                        flag). (mut.excl. with -a, -c)

Optional arguments:
  -h, --help            Print help message and exit
  -o OUT_DIR            Optionally specify a directory for saving of outfiles.
                        If this argument is not given, out-files will be saved
                        in the directory where the input reads are located.
                        [default=False]
  -m MAX_COV            Provide threshold for maximum read-depth per amplicon
                        as integer value. [default=200]
  --incl_prim           Set this flag if you want to include the primer
                        sequences in the trimmed reads. By default primers are
                        removed together with all overhanging sequences like
                        barcodes and adapters.
  -s SEQ_TEC            Specify long-read sequencing technology (ont/pb).
                        [default=ont]
  -n NAME_SCHEME        Provide path to json-file containing a naming scheme
                        which is consistently used for all
                        primers.[default=artic_nCoV_scheme_v5.3.2]
  --set_min_len SET_MIN_LEN
                        Set a minimum required length for alignments of reads
                        to amplicons. If this is not set the min_len will be
                        0.8*shortest_amp_len. When using reads that are
                        shorter than amplicon sizes use this argument to
                        adjust. For long reads this option is usually not
                        required.
  --set_max_len SET_MAX_LEN
                        Set a maximum allowed length for alignments of reads
                        to amplicon. If this is not set the max_len will be
                        1.2*longest_amp_len. The default setting normally
                        doesn't need to be changed.
  --set_margins MARGINS
                        Set length of tolerance margins for sorting of
                        mappings to amplicons. [default=5]
  --figures [FIGURES]   Set to generate figures of input and output
                        read_counts. Available for --all and --cov modes. You
                        can optionally provide a value to draw a red helper
                        line in the output read plot, showing a threshold,
                        e.g. min. required reads. [default=False;
                        default_threshold=20]
  --fastq               Set this flag to request output in fastq format. By
                        default output is in fasta format. Has no effect if
                        input file is fasta.
  --split               Set this flag to request output of capped, untrimmed
                        reads split to amplicon specific files (can be a lot).
  --selftest            Run a selftest of NoTrAmp using included test-data.
                        Overrides all other arguments and parameters. Useful
                        for checking how NoTrAmp runs in your environment.
  -v, --version         Print version and exit
```


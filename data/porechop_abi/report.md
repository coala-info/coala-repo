# porechop_abi CWL Generation Report

## porechop_abi

### Tool Description
Ab Initio version of Porechop. A tool for finding adapters in Oxford Nanopore reads, trimming them from the ends and splitting reads with internal adapters

### Metadata
- **Docker Image**: quay.io/biocontainers/porechop_abi:0.5.1--py310h275bdba_0
- **Homepage**: https://github.com/bonsai-team/Porechop_ABI
- **Package**: https://anaconda.org/channels/bioconda/packages/porechop_abi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/porechop_abi/overview
- **Total Downloads**: 15.9K
- **Last updated**: 2025-09-10
- **GitHub**: https://github.com/bonsai-team/Porechop_ABI
- **Stars**: N/A
### Original Help Text
```text
usage: porechop_abi [-abi] [-go] [-abc AB_INITIO_CONFIG] [-tmp TEMP_DIR]
                    [-cap CUSTOM_ADAPTERS] [-ddb] [-ws WINDOW_SIZE] [-ndc]
                    [-nr NUMBER_OF_RUN] [-cr CONSENSUS_RUN]
                    [-ec EXPORT_CONSENSUS] [-aax ALL_ABOVE_X] [-box BEST_OF_X]
                    [--export_graph EXPORT_GRAPH] -i INPUT [-o OUTPUT]
                    [--format {auto,fasta,fastq,fasta.gz,fastq.gz}]
                    [-v VERBOSITY] [-t THREADS] [-b BARCODE_DIR]
                    [--barcode_threshold BARCODE_THRESHOLD]
                    [--barcode_diff BARCODE_DIFF] [--require_two_barcodes]
                    [--untrimmed] [--discard_unassigned]
                    [--adapter_threshold ADAPTER_THRESHOLD]
                    [--check_reads CHECK_READS]
                    [--scoring_scheme SCORING_SCHEME] [--end_size END_SIZE]
                    [--min_trim_size MIN_TRIM_SIZE]
                    [--extra_end_trim EXTRA_END_TRIM]
                    [--end_threshold END_THRESHOLD] [--no_split]
                    [--discard_middle] [--middle_threshold MIDDLE_THRESHOLD]
                    [--extra_middle_trim_good_side EXTRA_MIDDLE_TRIM_GOOD_SIDE]
                    [--extra_middle_trim_bad_side EXTRA_MIDDLE_TRIM_BAD_SIDE]
                    [--min_split_read_size MIN_SPLIT_READ_SIZE] [-h]
                    [--version]

Porechop_ABI v_0.5.1: Ab Initio version of Porechop. A tool for finding
adapters in Oxford Nanopore reads, trimming them from the ends and splitting
reads with internal adapters

Ab-Initio options:
  -abi, --ab_initio       Try to infer the adapters from the read set instead
                          of just using the static database. (default: False)
  -go, --guess_adapter_only
                          Just display the inferred adapters and quit.
                          (default: False)
  -abc AB_INITIO_CONFIG, --ab_initio_config AB_INITIO_CONFIG
                          Path to a custom config file for the ab_initio phase
                          (default file in Porechop folder)
  -tmp TEMP_DIR, --temp_dir TEMP_DIR
                          Path to a writable temporary directory. Directory
                          will be created if it does not exists. Default is
                          ./tmp
  -cap CUSTOM_ADAPTERS, --custom_adapters CUSTOM_ADAPTERS
                          Path to a custom adapter text file, if you want to
                          manually submit some.
  -ddb, --discard_database
                          Ignore adapters from the Porechop database. This
                          option require either ab-initio (-abi) or a custom
                          adapter (-cap) to be set. (default: False)
  -ws WINDOW_SIZE, --window_size WINDOW_SIZE
                          Size of the smoothing window used in the drop cut
                          algorithm. (set to 1 to disable). (default: 3)
  -ndc, --no_drop_cut     Disable the drop cut step entirely (default: False)

Consensus mode options:
  -nr NUMBER_OF_RUN, --number_of_run NUMBER_OF_RUN
                          Number of time the core module must be run to
                          generate the first consensus. Each count file is
                          exported separately. Set to 1 for single run mode.
                          (default: 10)
  -cr CONSENSUS_RUN, --consensus_run CONSENSUS_RUN
                          With -nr option higher than 1, set the numberof
                          additional runs performed if no stable consensus is
                          immediatly found. (default: 20)
  -ec EXPORT_CONSENSUS, --export_consensus EXPORT_CONSENSUS
                          Path to export the intermediate adapters found in
                          consensus mode.
  -aax ALL_ABOVE_X, --all_above_x ALL_ABOVE_X
                          Only select consensus sequences if they are made
                          using at least x percent of the total adapters.
                          Default is 10%.
  -box BEST_OF_X, --best_of_x BEST_OF_X
                          Only select the best x consensus sequences from all
                          consensus found. (default: 0)

Graphs options:
  --export_graph EXPORT_GRAPH
                          Path to export the assembly graphs (.graphml
                          format), if you want to keep them

Main options:
  -i INPUT, --input INPUT
                          FASTA/FASTQ of input reads or a directory which will
                          be recursively searched for FASTQ files (required)
  -o OUTPUT, --output OUTPUT
                          Filename for FASTA or FASTQ of trimmed reads (if not
                          set, trimmed reads will be printed to stdout)
  --format {auto,fasta,fastq,fasta.gz,fastq.gz}
                          Output format for the reads - if auto, the format
                          will be chosen based on the output filename or the
                          input read format (default: auto)
  -v VERBOSITY, --verbosity VERBOSITY
                          Level of progress information: 0 = none, 1 = some, 2
                          = lots, 3 = full - output will go to stdout if reads
                          are saved to a file and stderr if reads are printed
                          to stdout (default: 1)
  -t THREADS, --threads THREADS
                          Number of threads to use for adapter alignment
                          (default: 16)

Barcode binning settings:
  Control the binning of reads based on barcodes (i.e. barcode
  demultiplexing)

  -b BARCODE_DIR, --barcode_dir BARCODE_DIR
                          Reads will be binned based on their barcode and
                          saved to separate files in this directory
                          (incompatible with --output)
  --barcode_threshold BARCODE_THRESHOLD
                          A read must have at least this percent identity to a
                          barcode to be binned (default: 75.0)
  --barcode_diff BARCODE_DIFF
                          If the difference between a read's best barcode
                          identity and its second-best barcode identity is
                          less than this value, it will not be put in a
                          barcode bin (to exclude cases which are too close to
                          call) (default: 5.0)
  --require_two_barcodes  Reads will only be put in barcode bins if they have
                          a strong match for the barcode on both their start
                          and end (default: a read can be binned with a match
                          at its start or end)
  --untrimmed             Bin reads but do not trim them (default: trim the
                          reads)
  --discard_unassigned    Discard unassigned reads (instead of creating a
                          "none" bin) (default: False)

Adapter search settings:
  Control how the program determines which adapter sets are present

  --adapter_threshold ADAPTER_THRESHOLD
                          An adapter set has to have at least this percent
                          identity to be labelled as present and trimmed off
                          (0 to 100) (default: 90.0)
  --check_reads CHECK_READS
                          This many reads will be aligned to all possible
                          adapters to determine which adapter sets are present
                          (default: 10000)
  --scoring_scheme SCORING_SCHEME
                          Comma-delimited string of alignment scores: match,
                          mismatch, gap open, gap extend (default: 3,-6,-5,-2)

End adapter settings:
  Control the trimming of adapters from read ends

  --end_size END_SIZE     The number of base pairs at each end of the read
                          which will be searched for adapter sequences
                          (default: 150)
  --min_trim_size MIN_TRIM_SIZE
                          Adapter alignments smaller than this will be ignored
                          (default: 4)
  --extra_end_trim EXTRA_END_TRIM
                          This many additional bases will be removed next to
                          adapters found at the ends of reads (default: 2)
  --end_threshold END_THRESHOLD
                          Adapters at the ends of reads must have at least
                          this percent identity to be removed (0 to 100)
                          (default: 75.0)

Middle adapter settings:
  Control the splitting of read from middle adapters

  --no_split              Skip splitting reads based on middle adapters
                          (default: split reads when an adapter is found in
                          the middle)
  --discard_middle        Reads with middle adapters will be discarded
                          (default: reads with middle adapters are split)
                          (required for reads to be used with Nanopolish, this
                          option is on by default when outputting reads into
                          barcode bins)
  --middle_threshold MIDDLE_THRESHOLD
                          Adapters in the middle of reads must have at least
                          this percent identity to be found (0 to 100)
                          (default: 90.0)
  --extra_middle_trim_good_side EXTRA_MIDDLE_TRIM_GOOD_SIDE
                          This many additional bases will be removed next to
                          middle adapters on their "good" side (default: 10)
  --extra_middle_trim_bad_side EXTRA_MIDDLE_TRIM_BAD_SIDE
                          This many additional bases will be removed next to
                          middle adapters on their "bad" side (default: 100)
  --min_split_read_size MIN_SPLIT_READ_SIZE
                          Post-split read pieces smaller than this many base
                          pairs will not be outputted (default: 1000)

Help:
  -h, --help              Show this help message and exit
  --version               Show program's version number and exit
```


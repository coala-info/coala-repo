cwlVersion: v1.2
class: CommandLineTool
baseCommand: porechop_abi
label: porechop_abi
doc: "Ab Initio version of Porechop. A tool for finding adapters in Oxford Nanopore
  reads, trimming them from the ends and splitting reads with internal adapters\n\n\
  Tool homepage: https://github.com/bonsai-team/Porechop_ABI"
inputs:
  - id: ab_initio
    type:
      - 'null'
      - boolean
    doc: Try to infer the adapters from the read set instead of just using the 
      static database.
    default: false
    inputBinding:
      position: 101
      prefix: --ab_initio
  - id: ab_initio_config
    type:
      - 'null'
      - string
    doc: Path to a custom config file for the ab_initio phase
    inputBinding:
      position: 101
      prefix: --ab_initio_config
  - id: adapter_threshold
    type:
      - 'null'
      - float
    doc: An adapter set has to have at least this percent identity to be 
      labelled as present and trimmed off (0 to 100)
    default: 90.0
    inputBinding:
      position: 101
      prefix: --adapter_threshold
  - id: all_above_x
    type:
      - 'null'
      - string
    doc: Only select consensus sequences if they are made using at least x 
      percent of the total adapters. Default is 10%.
    default: 10%
    inputBinding:
      position: 101
      prefix: --all_above_x
  - id: barcode_diff
    type:
      - 'null'
      - float
    doc: If the difference between a read's best barcode identity and its 
      second-best barcode identity is less than this value, it will not be put 
      in a barcode bin (to exclude cases which are too close to call)
    default: 5.0
    inputBinding:
      position: 101
      prefix: --barcode_diff
  - id: barcode_dir
    type:
      - 'null'
      - Directory
    doc: Reads will be binned based on their barcode and saved to separate files
      in this directory (incompatible with --output)
    inputBinding:
      position: 101
      prefix: --barcode_dir
  - id: barcode_threshold
    type:
      - 'null'
      - float
    doc: A read must have at least this percent identity to a barcode to be 
      binned
    default: 75.0
    inputBinding:
      position: 101
      prefix: --barcode_threshold
  - id: best_of_x
    type:
      - 'null'
      - int
    doc: Only select the best x consensus sequences from all consensus found.
    default: 0
    inputBinding:
      position: 101
      prefix: --best_of_x
  - id: check_reads
    type:
      - 'null'
      - int
    doc: This many reads will be aligned to all possible adapters to determine 
      which adapter sets are present
    default: 10000
    inputBinding:
      position: 101
      prefix: --check_reads
  - id: consensus_run
    type:
      - 'null'
      - int
    doc: With -nr option higher than 1, set the numberof additional runs 
      performed if no stable consensus is immediatly found.
    default: 20
    inputBinding:
      position: 101
      prefix: --consensus_run
  - id: custom_adapters
    type:
      - 'null'
      - File
    doc: Path to a custom adapter text file, if you want to manually submit 
      some.
    inputBinding:
      position: 101
      prefix: --custom_adapters
  - id: discard_database
    type:
      - 'null'
      - boolean
    doc: Ignore adapters from the Porechop database. This option require either 
      ab-initio (-abi) or a custom adapter (-cap) to be set.
    default: false
    inputBinding:
      position: 101
      prefix: --discard_database
  - id: discard_middle
    type:
      - 'null'
      - boolean
    doc: 'Reads with middle adapters will be discarded (default: reads with middle
      adapters are split) (required for reads to be used with Nanopolish, this option
      is on by default when outputting reads into barcode bins)'
    inputBinding:
      position: 101
      prefix: --discard_middle
  - id: discard_unassigned
    type:
      - 'null'
      - boolean
    doc: Discard unassigned reads (instead of creating a "none" bin)
    default: false
    inputBinding:
      position: 101
      prefix: --discard_unassigned
  - id: end_size
    type:
      - 'null'
      - int
    doc: The number of base pairs at each end of the read which will be searched
      for adapter sequences
    default: 150
    inputBinding:
      position: 101
      prefix: --end_size
  - id: end_threshold
    type:
      - 'null'
      - float
    doc: Adapters at the ends of reads must have at least this percent identity 
      to be removed (0 to 100)
    default: 75.0
    inputBinding:
      position: 101
      prefix: --end_threshold
  - id: export_consensus
    type:
      - 'null'
      - File
    doc: Path to export the intermediate adapters found in consensus mode.
    inputBinding:
      position: 101
      prefix: --export_consensus
  - id: export_graph
    type:
      - 'null'
      - File
    doc: Path to export the assembly graphs (.graphml format), if you want to 
      keep them
    inputBinding:
      position: 101
      prefix: --export_graph
  - id: extra_end_trim
    type:
      - 'null'
      - int
    doc: This many additional bases will be removed next to adapters found at 
      the ends of reads
    default: 2
    inputBinding:
      position: 101
      prefix: --extra_end_trim
  - id: extra_middle_trim_bad_side
    type:
      - 'null'
      - int
    doc: This many additional bases will be removed next to middle adapters on 
      their "bad" side
    default: 100
    inputBinding:
      position: 101
      prefix: --extra_middle_trim_bad_side
  - id: extra_middle_trim_good_side
    type:
      - 'null'
      - int
    doc: This many additional bases will be removed next to middle adapters on 
      their "good" side
    default: 10
    inputBinding:
      position: 101
      prefix: --extra_middle_trim_good_side
  - id: format
    type:
      - 'null'
      - string
    doc: Output format for the reads - if auto, the format will be chosen based 
      on the output filename or the input read format
    default: auto
    inputBinding:
      position: 101
      prefix: --format
  - id: guess_adapter_only
    type:
      - 'null'
      - boolean
    doc: Just display the inferred adapters and quit.
    default: false
    inputBinding:
      position: 101
      prefix: --guess_adapter_only
  - id: input
    type: File
    doc: FASTA/FASTQ of input reads or a directory which will be recursively 
      searched for FASTQ files (required)
    inputBinding:
      position: 101
      prefix: --input
  - id: middle_threshold
    type:
      - 'null'
      - float
    doc: Adapters in the middle of reads must have at least this percent 
      identity to be found (0 to 100)
    default: 90.0
    inputBinding:
      position: 101
      prefix: --middle_threshold
  - id: min_split_read_size
    type:
      - 'null'
      - int
    doc: Post-split read pieces smaller than this many base pairs will not be 
      outputted
    default: 1000
    inputBinding:
      position: 101
      prefix: --min_split_read_size
  - id: min_trim_size
    type:
      - 'null'
      - int
    doc: Adapter alignments smaller than this will be ignored
    default: 4
    inputBinding:
      position: 101
      prefix: --min_trim_size
  - id: no_drop_cut
    type:
      - 'null'
      - boolean
    doc: Disable the drop cut step entirely
    default: false
    inputBinding:
      position: 101
      prefix: --no_drop_cut
  - id: no_split
    type:
      - 'null'
      - boolean
    doc: 'Skip splitting reads based on middle adapters (default: split reads when
      an adapter is found in the middle)'
    inputBinding:
      position: 101
      prefix: --no_split
  - id: number_of_run
    type:
      - 'null'
      - int
    doc: Number of time the core module must be run to generate the first 
      consensus. Each count file is exported separately. Set to 1 for single run
      mode.
    default: 10
    inputBinding:
      position: 101
      prefix: --number_of_run
  - id: require_two_barcodes
    type:
      - 'null'
      - boolean
    doc: 'Reads will only be put in barcode bins if they have a strong match for the
      barcode on both their start and end (default: a read can be binned with a match
      at its start or end)'
    inputBinding:
      position: 101
      prefix: --require_two_barcodes
  - id: scoring_scheme
    type:
      - 'null'
      - string
    doc: 'Comma-delimited string of alignment scores: match, mismatch, gap open, gap
      extend'
    default: 3,-6,-5,-2
    inputBinding:
      position: 101
      prefix: --scoring_scheme
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Path to a writable temporary directory. Directory will be created if it
      does not exists.
    default: ./tmp
    inputBinding:
      position: 101
      prefix: --temp_dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for adapter alignment
    default: 16
    inputBinding:
      position: 101
      prefix: --threads
  - id: untrimmed
    type:
      - 'null'
      - boolean
    doc: 'Bin reads but do not trim them (default: trim the reads)'
    inputBinding:
      position: 101
      prefix: --untrimmed
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Level of progress information: 0 = none, 1 = some, 2 = lots, 3 = full -
      output will go to stdout if reads are saved to a file and stderr if reads are
      printed to stdout'
    default: 1
    inputBinding:
      position: 101
      prefix: --verbosity
  - id: window_size
    type:
      - 'null'
      - int
    doc: Size of the smoothing window used in the drop cut algorithm. (set to 1 
      to disable).
    default: 3
    inputBinding:
      position: 101
      prefix: --window_size
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Filename for FASTA or FASTQ of trimmed reads (if not set, trimmed reads
      will be printed to stdout)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/porechop_abi:0.5.1--py310h275bdba_0

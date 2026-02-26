cwlVersion: v1.2
class: CommandLineTool
baseCommand: porechop
label: porechop
doc: "Porechop: a tool for finding adapters in Oxford Nanopore reads, trimming them\n\
  from the ends and splitting reads with internal adapters\n\nTool homepage: https://github.com/rrwick/Porechop"
inputs:
  - id: adapter_threshold
    type:
      - 'null'
      - float
    doc: "An adapter set has to have at least this percent\nidentity to be labelled
      as present and trimmed off\n(0 to 100) (default: 90.0)"
    default: 90.0
    inputBinding:
      position: 101
      prefix: --adapter_threshold
  - id: barcode_diff
    type:
      - 'null'
      - float
    doc: "If the difference between a read's best barcode\nidentity and its second-best
      barcode identity is\nless than this value, it will not be put in a\nbarcode
      bin (to exclude cases which are too close to\ncall) (default: 5.0)"
    default: 5.0
    inputBinding:
      position: 101
      prefix: --barcode_diff
  - id: barcode_dir
    type:
      - 'null'
      - Directory
    doc: "Reads will be binned based on their barcode and\nsaved to separate files
      in this directory\n(incompatible with --output)"
    inputBinding:
      position: 101
      prefix: --barcode_dir
  - id: barcode_threshold
    type:
      - 'null'
      - float
    doc: "A read must have at least this percent identity to a\nbarcode to be binned
      (default: 75.0)"
    default: 75.0
    inputBinding:
      position: 101
      prefix: --barcode_threshold
  - id: check_reads
    type:
      - 'null'
      - int
    doc: "This many reads will be aligned to all possible\nadapters to determine which
      adapter sets are present\n(default: 10000)"
    default: 10000
    inputBinding:
      position: 101
      prefix: --check_reads
  - id: discard_middle
    type:
      - 'null'
      - boolean
    doc: "Reads with middle adapters will be discarded\n(default: reads with middle
      adapters are split)\n(required for reads to be used with Nanopolish, this\n\
      option is on by default when outputting reads into\nbarcode bins)"
    inputBinding:
      position: 101
      prefix: --discard_middle
  - id: discard_unassigned
    type:
      - 'null'
      - boolean
    doc: "Discard unassigned reads (instead of creating a\n\"none\" bin) (default:
      False)"
    default: false
    inputBinding:
      position: 101
      prefix: --discard_unassigned
  - id: end_size
    type:
      - 'null'
      - int
    doc: "The number of base pairs at each end of the read\nwhich will be searched
      for adapter sequences\n(default: 150)"
    default: 150
    inputBinding:
      position: 101
      prefix: --end_size
  - id: end_threshold
    type:
      - 'null'
      - float
    doc: "Adapters at the ends of reads must have at least\nthis percent identity
      to be removed (0 to 100)\n(default: 75.0)"
    default: 75.0
    inputBinding:
      position: 101
      prefix: --end_threshold
  - id: extra_end_trim
    type:
      - 'null'
      - int
    doc: "This many additional bases will be removed next to\nadapters found at the
      ends of reads (default: 2)"
    default: 2
    inputBinding:
      position: 101
      prefix: --extra_end_trim
  - id: extra_middle_trim_bad_side
    type:
      - 'null'
      - int
    doc: "This many additional bases will be removed next to\nmiddle adapters on their
      \"bad\" side (default: 100)"
    default: 100
    inputBinding:
      position: 101
      prefix: --extra_middle_trim_bad_side
  - id: extra_middle_trim_good_side
    type:
      - 'null'
      - int
    doc: "This many additional bases will be removed next to\nmiddle adapters on their
      \"good\" side (default: 10)"
    default: 10
    inputBinding:
      position: 101
      prefix: --extra_middle_trim_good_side
  - id: format
    type:
      - 'null'
      - string
    doc: "Output format for the reads - if auto, the format\nwill be chosen based
      on the output filename or the\ninput read format (default: auto)"
    default: auto
    inputBinding:
      position: 101
      prefix: --format
  - id: input
    type: File
    doc: "FASTA/FASTQ of input reads or a directory which will\nbe recursively searched
      for FASTQ files (required)"
    inputBinding:
      position: 101
      prefix: --input
  - id: middle_threshold
    type:
      - 'null'
      - float
    doc: "Adapters in the middle of reads must have at least\nthis percent identity
      to be found (0 to 100)\n(default: 90.0)"
    default: 90.0
    inputBinding:
      position: 101
      prefix: --middle_threshold
  - id: min_split_read_size
    type:
      - 'null'
      - int
    doc: "Post-split read pieces smaller than this many base\npairs will not be outputted
      (default: 1000)"
    default: 1000
    inputBinding:
      position: 101
      prefix: --min_split_read_size
  - id: min_trim_size
    type:
      - 'null'
      - int
    doc: "Adapter alignments smaller than this will be ignored\n(default: 4)"
    default: 4
    inputBinding:
      position: 101
      prefix: --min_trim_size
  - id: no_split
    type:
      - 'null'
      - boolean
    doc: "Skip splitting reads based on middle adapters\n(default: split reads when
      an adapter is found in\nthe middle)"
    inputBinding:
      position: 101
      prefix: --no_split
  - id: require_two_barcodes
    type:
      - 'null'
      - boolean
    doc: "Reads will only be put in barcode bins if they have\na strong match for
      the barcode on both their start\nand end (default: a read can be binned with
      a match\nat its start or end)"
    inputBinding:
      position: 101
      prefix: --require_two_barcodes
  - id: scoring_scheme
    type:
      - 'null'
      - string
    doc: "Comma-delimited string of alignment scores: match,\nmismatch, gap open,
      gap extend (default: 3,-6,-5,-2)"
    default: 3,-6,-5,-2
    inputBinding:
      position: 101
      prefix: --scoring_scheme
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use for adapter alignment\n(default: 16)"
    default: 16
    inputBinding:
      position: 101
      prefix: --threads
  - id: untrimmed
    type:
      - 'null'
      - boolean
    doc: "Bin reads but do not trim them (default: trim the\nreads)"
    inputBinding:
      position: 101
      prefix: --untrimmed
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Level of progress information: 0 = none, 1 = some, 2\n= lots, 3 = full -
      output will go to stdout if reads\nare saved to a file and stderr if reads are
      printed\nto stdout (default: 1)"
    default: 1
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: "Filename for FASTA or FASTQ of trimmed reads (if not\nset, trimmed reads
      will be printed to stdout)"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/porechop:0.2.4--py311h2a4ad6c_7

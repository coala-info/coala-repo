cwlVersion: v1.2
class: CommandLineTool
baseCommand: porechop
label: artic-porechop_porechop
doc: "Porechop: a tool for finding adapters in Oxford Nanopore reads, trimming them
  from the ends and splitting reads with internal adapters\n\nTool homepage: https://github.com/artic-network/Porechop"
inputs:
  - id: adapter_threshold
    type:
      - 'null'
      - float
    doc: 'An adapter set has to have at least this percent identity to be labelled
      as present and trimmed off (0 to 100) (default: 90.0)'
    default: 90.0
    inputBinding:
      position: 101
      prefix: --adapter_threshold
  - id: barcode_diff
    type:
      - 'null'
      - float
    doc: If the difference between a read's best barcode identity and its second-best
      barcode identity is less than this value, it will not be put in a barcode bin
    default: 5.0
    inputBinding:
      position: 101
      prefix: --barcode_diff
  - id: barcode_labels
    type:
      - 'null'
      - boolean
    doc: 'Reads will have a label added to their header with their barcode (default:
      False)'
    inputBinding:
      position: 101
      prefix: --barcode_labels
  - id: barcode_stats_csv
    type:
      - 'null'
      - boolean
    doc: 'Option to output a csv file with start/ end/ middle barcode names and percentage
      identities for each given read. (default: False)'
    inputBinding:
      position: 101
      prefix: --barcode_stats_csv
  - id: barcode_threshold
    type:
      - 'null'
      - float
    doc: 'A read must have at least this percent identity to a barcode to be binned
      (default: 75.0)'
    default: 75.0
    inputBinding:
      position: 101
      prefix: --barcode_threshold
  - id: check_reads
    type:
      - 'null'
      - int
    doc: 'This many reads will be aligned to all possible adapters to determine which
      adapter sets are present (default: 10000)'
    default: 10000
    inputBinding:
      position: 101
      prefix: --check_reads
  - id: custom_barcodes
    type:
      - 'null'
      - File
    doc: CSV file containing custom barcode sequences
    inputBinding:
      position: 101
      prefix: --custom_barcodes
  - id: discard_middle
    type:
      - 'null'
      - boolean
    doc: 'Reads with middle adapters will be discarded (default: reads with middle
      adapters are split)'
    inputBinding:
      position: 101
      prefix: --discard_middle
  - id: discard_unassigned
    type:
      - 'null'
      - boolean
    doc: 'Discard unassigned reads (instead of creating a "none" bin) (default: False)'
    inputBinding:
      position: 101
      prefix: --discard_unassigned
  - id: end_size
    type:
      - 'null'
      - int
    doc: 'The number of base pairs at each end of the read which will be searched
      for adapter sequences (default: 150)'
    default: 150
    inputBinding:
      position: 101
      prefix: --end_size
  - id: end_threshold
    type:
      - 'null'
      - float
    doc: 'Adapters at the ends of reads must have at least this percent identity to
      be removed (0 to 100) (default: 75.0)'
    default: 75.0
    inputBinding:
      position: 101
      prefix: --end_threshold
  - id: extended_labels
    type:
      - 'null'
      - boolean
    doc: Reads will have an extended label added to their header with the barcode_call
      (if any), the best start/ end barcode hit and their identities, and whether
      a barcode is found in middle of read.
    inputBinding:
      position: 101
      prefix: --extended_labels
  - id: extra_end_trim
    type:
      - 'null'
      - int
    doc: 'This many additional bases will be removed next to adapters found at the
      ends of reads (default: 2)'
    default: 2
    inputBinding:
      position: 101
      prefix: --extra_end_trim
  - id: extra_middle_trim_bad_side
    type:
      - 'null'
      - int
    doc: 'This many additional bases will be removed next to middle adapters on their
      "bad" side (default: 100)'
    default: 100
    inputBinding:
      position: 101
      prefix: --extra_middle_trim_bad_side
  - id: extra_middle_trim_good_side
    type:
      - 'null'
      - int
    doc: 'This many additional bases will be removed next to middle adapters on their
      "good" side (default: 10)'
    default: 10
    inputBinding:
      position: 101
      prefix: --extra_middle_trim_good_side
  - id: format
    type:
      - 'null'
      - string
    doc: 'Output format for the reads - if auto, the format will be chosen based on
      the output filename or the input read format (default: auto)'
    default: auto
    inputBinding:
      position: 101
      prefix: --format
  - id: input
    type: File
    doc: FASTA/FASTQ of input reads or a directory which will be recursively searched
      for FASTQ files (required)
    inputBinding:
      position: 101
      prefix: --input
  - id: limit_barcodes_to
    type:
      - 'null'
      - type: array
        items: int
    doc: Specify a list of barcodes to look for (numbers refer to native, PCR or rapid)
    inputBinding:
      position: 101
      prefix: --limit_barcodes_to
  - id: middle_threshold
    type:
      - 'null'
      - float
    doc: 'Adapters in the middle of reads must have at least this percent identity
      to be found (0 to 100) (default: 85.0)'
    default: 85.0
    inputBinding:
      position: 101
      prefix: --middle_threshold
  - id: min_split_read_size
    type:
      - 'null'
      - int
    doc: 'Post-split read pieces smaller than this many base pairs will not be outputted
      (default: 1000)'
    default: 1000
    inputBinding:
      position: 101
      prefix: --min_split_read_size
  - id: min_trim_size
    type:
      - 'null'
      - int
    doc: 'Adapter alignments smaller than this will be ignored (default: 4)'
    default: 4
    inputBinding:
      position: 101
      prefix: --min_trim_size
  - id: native_barcodes
    type:
      - 'null'
      - boolean
    doc: 'Only attempts to match the 24 native barcodes (default: False)'
    inputBinding:
      position: 101
      prefix: --native_barcodes
  - id: no_split
    type:
      - 'null'
      - boolean
    doc: 'Skip splitting reads based on middle adapters (default: split reads when
      an adapter is found in the middle)'
    inputBinding:
      position: 101
      prefix: --no_split
  - id: pcr_barcodes
    type:
      - 'null'
      - boolean
    doc: 'Only attempts to match the 96 PCR barcodes (default: False)'
    inputBinding:
      position: 101
      prefix: --pcr_barcodes
  - id: rapid_barcodes
    type:
      - 'null'
      - boolean
    doc: 'Only attempts to match the 12 rapid barcodes (default: False)'
    inputBinding:
      position: 101
      prefix: --rapid_barcodes
  - id: require_two_barcodes
    type:
      - 'null'
      - boolean
    doc: Reads will only be put in barcode bins if they have a strong match for the
      barcode on both their start and end
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
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use for adapter alignment (default: 16)'
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
    doc: 'Level of progress information: 0 = none, 1 = some, 2 = lots, 3 = full'
    default: 1
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Filename for FASTA or FASTQ of trimmed reads (if not set, trimmed reads will
      be printed to stdout)
    outputBinding:
      glob: $(inputs.output)
  - id: barcode_dir
    type:
      - 'null'
      - Directory
    doc: Reads will be binned based on their barcode and saved to separate files in
      this directory (incompatible with --output)
    outputBinding:
      glob: $(inputs.barcode_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artic-porechop:3.2pre1--py36hc9558a2_0

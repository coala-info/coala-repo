cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - calitas
  - AlignToReference
label: calitas_AlignToReference
doc: "Performs glocal alignment of query sequence to a window on the reference. Input
  should be a tab-delimited file with the following columns (with headers):\n\n  *
  id: the ID of the query sequence; optional - if not present the sequence itself
  is used\n  * query: the query sequence to be aligned\n  * chrom: the chromosome
  to align to\n  * position: the center of the window to align the query to\n\nThe
  query sequence may be a mixture of upper and lower case sequence. The lower case
  sequence (generally used for the\nPAM sequence) is scored differently than upper-case
  sequence, with higher match and mismatch values, to make mismatches\nin lower-case
  regions less common.\n\nIf all three of '--max-guide-diffs', '--max-pam-mismatches'
  and '--max-overlap' are specified then all alignments that\nmeet the given criteria
  for a query will be emitted. If none of the three parameters are provided, the single
  best\nalignment of each query will be reported. If some but not all three parameters
  are specified then an error will be\ngenerated.\n\nThe '--window-size' parameter
  can be used to control the size of the window (centered on the position given for
  each\nquery) that the queries will be aligned to. E.g. if a window size of 60bp
  is given, the target sequence is position +/- \n30bp. If '--window-size' is not
  given, it will be defaulted to 2 * length(query) for each query.\n\nTool homepage:
  https://github.com/editasmedicine/calitas"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    inputBinding:
      position: 101
      prefix: --async-io
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    inputBinding:
      position: 101
      prefix: --compression
  - id: genome_gap_net_cost
    type:
      - 'null'
      - int
    doc: Net cost of a 1bp gap in the genome.
    inputBinding:
      position: 101
      prefix: --genome-gap-net-cost
  - id: guide_gap_net_cost
    type:
      - 'null'
      - int
    doc: Net cost of a 1bp gap in the guide.
    inputBinding:
      position: 101
      prefix: --guide-gap-net-cost
  - id: guide_mismatch_net_cost
    type:
      - 'null'
      - int
    doc: Net cost of going from a match to a mismatch in the guide.
    inputBinding:
      position: 101
      prefix: --guide-mismatch-net-cost
  - id: input_file
    type: File
    doc: Input file of sequence queries and approximate positions.
    inputBinding:
      position: 101
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    inputBinding:
      position: 101
      prefix: --log-level
  - id: max_gaps_between_guide_and_pam
    type:
      - 'null'
      - int
    doc: Maximum gap bases between guide and PAM
    inputBinding:
      position: 101
      prefix: --max-gaps-between-guide-and-pam
  - id: max_guide_diffs
    type:
      - 'null'
      - int
    doc: Maximum number of differences (mms+gaps) between guide and genome.
    inputBinding:
      position: 101
      prefix: --max-guide-diffs
  - id: max_overlap
    type:
      - 'null'
      - int
    doc: Maximum overlap allowed between alignments on the same strand.
    inputBinding:
      position: 101
      prefix: --max-overlap
  - id: max_pam_mismatches
    type:
      - 'null'
      - int
    doc: Maximum mismatches in the PAM.
    inputBinding:
      position: 101
      prefix: --max-pam-mismatches
  - id: max_total_diffs
    type:
      - 'null'
      - int
    doc: Maximum total diffs in alignments.
    inputBinding:
      position: 101
      prefix: --max-total-diffs
  - id: pam_mismatch_net_cost
    type:
      - 'null'
      - int
    doc: Net cost of going from a match to a mismatch in the PAM.
    inputBinding:
      position: 101
      prefix: --pam-mismatch-net-cost
  - id: ref
    type: File
    doc: Reference genome fasta, must be indexed with faidx.
    inputBinding:
      position: 101
      prefix: --ref
  - id: sam_validation_stringency
    type:
      - 'null'
      - string
    doc: 'Validation stringency for SAM/BAM reading. Options: STRICT, LENIENT, SILENT.'
    inputBinding:
      position: 101
      prefix: --sam-validation-stringency
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads to use for alignments.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory to use for temporary files.
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size to align to.
    inputBinding:
      position: 101
      prefix: --window-size
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file to write.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/calitas:1.0--hdfd78af_1

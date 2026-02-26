cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - calitas
  - PairwiseAlignSequences
label: calitas_PairwiseAlignSequences
doc: "Performs pairwise alignment of sequences. Input is a file with two sequences
  per line, separated by whitespace.\nSequences may be composed of DNA and RNA bases
  and ambiguity codes. No headers are required or expected.\n\nDesigned for performing
  glocal alignment of guides to larger sequences (i.e. global alignment of the query
  to a local\nportion of the target.)\n\nThe query sequence may be a mixture of upper
  and lower case sequence, with lower-case bases used for the PAM at one end\nof the
  sequence or the other.\n\nThe target sequences (second on each line) should be all
  upper case and will be made upper-case if they are not\nalready.\n\nTool homepage:
  https://github.com/editasmedicine/calitas"
inputs:
  - id: async_io
    type:
      - 'null'
      - boolean
    doc: Use asynchronous I/O where possible, e.g. for SAM and BAM files.
    default: false
    inputBinding:
      position: 101
      prefix: --async-io
  - id: compression
    type:
      - 'null'
      - int
    doc: Default GZIP compression level, BAM compression level.
    default: 5
    inputBinding:
      position: 101
      prefix: --compression
  - id: genome_gap_net_cost
    type:
      - 'null'
      - int
    doc: Net cost of a 1bp gap in the genomic/target sequence.
    default: -122
    inputBinding:
      position: 101
      prefix: --genome-gap-net-cost
  - id: guide_gap_net_cost
    type:
      - 'null'
      - int
    doc: Net cost of a 1bp gap in the guide.
    default: -121
    inputBinding:
      position: 101
      prefix: --guide-gap-net-cost
  - id: guide_mismatch_net_cost
    type:
      - 'null'
      - int
    doc: Net cost of going from a match to a mismatch in the guide.
    default: -120
    inputBinding:
      position: 101
      prefix: --guide-mismatch-net-cost
  - id: input_file
    type: File
    doc: Input file of sequence pairs.
    inputBinding:
      position: 101
      prefix: --input
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Minimum severity log-level to emit. Options: Debug, Info, Warning, Error,
      Fatal.'
    default: Info
    inputBinding:
      position: 101
      prefix: --log-level
  - id: max_gaps_between_guide_and_pam
    type:
      - 'null'
      - int
    doc: Maximum gap bases between guide and PAM
    default: 3
    inputBinding:
      position: 101
      prefix: --max-gaps-between-guide-and-pam
  - id: max_overlap
    type:
      - 'null'
      - int
    doc: Maximum overlap allowed between alignments on the same strand.
    default: 10
    inputBinding:
      position: 101
      prefix: --max-overlap
  - id: pam_mismatch_net_cost
    type:
      - 'null'
      - int
    doc: Net cost of going from a match to a mismatch in the PAM.
    default: -260
    inputBinding:
      position: 101
      prefix: --pam-mismatch-net-cost
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
    default: 8
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory to use for temporary files.
    default: /tmp
    inputBinding:
      position: 101
      prefix: --tmp-dir
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

cwlVersion: v1.2
class: CommandLineTool
baseCommand: lordfast
label: lordfast
doc: "lordFAST is a sensitive tool for mapping long reads with high error rates. lordFAST
  is specially designed for aligning reads from PacBio sequencing technology but provides
  the user the ability to change alignment parameters depending on the reads and application.\n\
  \nTool homepage: https://github.com/vpc-ccg/lordfast"
inputs:
  - id: anchor_count
    type:
      - 'null'
      - int
    doc: Consider anchoring positions on the long read.
    default: 1000
    inputBinding:
      position: 101
      prefix: --anchorCount
  - id: chain_alg
    type:
      - 'null'
      - string
    doc: Chaining algorithm to use. Options are "dp-n2" and "clasp".
    default: dp-n2
    inputBinding:
      position: 101
      prefix: --chainAlg
  - id: index_file
    type: File
    doc: Path to the reference genome file in FASTA format which is supposed to 
      be indexed.
    inputBinding:
      position: 101
      prefix: --index
  - id: max_ref_hit
    type:
      - 'null'
      - int
    doc: Ignore anchoring positions with more than reference hits.
    default: 1000
    inputBinding:
      position: 101
      prefix: --maxRefHit
  - id: min_anchor_len
    type:
      - 'null'
      - int
    doc: Minimum required length of anchors to be considered.
    default: 14
    inputBinding:
      position: 101
      prefix: --minAnchorLen
  - id: min_read_len
    type:
      - 'null'
      - int
    doc: Do not try to map any read shorter than bp and report them as unmapped.
    default: 1000
    inputBinding:
      position: 101
      prefix: --minReadLen
  - id: no_sam_header
    type:
      - 'null'
      - boolean
    doc: Do not print sam header in the output.
    inputBinding:
      position: 101
      prefix: --noSamHeader
  - id: num_map
    type:
      - 'null'
      - int
    doc: Perform alignment for at most candidates.
    default: 10
    inputBinding:
      position: 101
      prefix: --numMap
  - id: read_group
    type:
      - 'null'
      - string
    doc: SAM read group line in a format like '@RGID:fooSM:bar'.
    default: ''
    inputBinding:
      position: 101
      prefix: --readGroup
  - id: search_file
    type: File
    doc: Path to the reference genome file in FASTA format.
    inputBinding:
      position: 101
      prefix: --search
  - id: seq_file
    type: File
    doc: Path to the file containing read sequences in FASTA/FASTQ format.
    inputBinding:
      position: 101
      prefix: --seq
  - id: threads
    type:
      - 'null'
      - int
    doc: Use number of CPU cores. Pass 0 to use all the available cores.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to file rather than standard output.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lordfast:0.0.10--h5b5514e_3

cwlVersion: v1.2
class: CommandLineTool
baseCommand: samsum
label: samsum_stats
doc: "Calculate read coverage stats over reference sequences.\n\nTool homepage: https://github.com/hallamlab/samsum"
inputs:
  - id: alignments
    type: File
    doc: "Path to a SAM/BAM file containing the read alignments\n                \
      \        to the reference FASTA."
    inputBinding:
      position: 101
      prefix: --alignments
  - id: map_quality
    type:
      - 'null'
      - int
    doc: "The minimum mapping quality threshold for an alignment\n               \
      \         to pass."
    inputBinding:
      position: 101
      prefix: --map_quality
  - id: min_aln
    type:
      - 'null'
      - float
    doc: "The minimum percentage of a read's length that must be\n               \
      \         aligned to be included."
    inputBinding:
      position: 101
      prefix: --aln_percent
  - id: multireads
    type:
      - 'null'
      - boolean
    doc: "Flag indicating whether reads that mapped ambiguously\n                \
      \        to multiple positions (multireads) should be used in\n            \
      \            the counts."
    inputBinding:
      position: 101
      prefix: --multireads
  - id: ref_fasta
    type: File
    doc: "Path to the reference file used to generate the\n                      \
      \  SAM/BAM file."
    inputBinding:
      position: 101
      prefix: --ref_fasta
  - id: sep
    type:
      - 'null'
      - string
    doc: "Field-separator character to be used when writing the\n                \
      \        output table."
    inputBinding:
      position: 101
      prefix: --sep
  - id: seq_coverage
    type:
      - 'null'
      - float
    doc: "The minimum percentage a reference sequence must be\n                  \
      \      covered for its coverage stats to be included; they\n               \
      \         are set to zero otherwise."
    inputBinding:
      position: 101
      prefix: --seq_coverage
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Prints a more verbose runtime log
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_table
    type:
      - 'null'
      - File
    doc: Name of a file to write the alignment stats to.
    outputBinding:
      glob: $(inputs.output_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samsum:0.1.4--py39h918f1d6_7

cwlVersion: v1.2
class: CommandLineTool
baseCommand: maelstrom-core bam-collect-doc
label: maelstrom-core_bam-collect-doc
doc: "Create contigs with synthetic sequence\n\nTool homepage: https://github.com/bihealth/maelstrom-core"
inputs:
  - id: count_kind
    type:
      - 'null'
      - string
    doc: The coverage kind to count
    default: coverage
    inputBinding:
      position: 101
      prefix: --count-kind
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwriting output file
    inputBinding:
      position: 101
      prefix: --force
  - id: in
    type: File
    doc: Path to input BAM file
    inputBinding:
      position: 101
      prefix: --in
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimal MAPQ when collecting depth of coverage information
    inputBinding:
      position: 101
      prefix: --min-mapq
  - id: min_unclipped
    type:
      - 'null'
      - int
    doc: Minimal unclipped bases when collecting depth of coverage information
    inputBinding:
      position: 101
      prefix: --min-unclipped
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Less output per occurrence
    inputBinding:
      position: 101
      prefix: --quiet
  - id: reference
    type:
      - 'null'
      - File
    doc: Path to reference FASTA file
    inputBinding:
      position: 101
      prefix: --reference
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: Optional list of regions to call
    inputBinding:
      position: 101
      prefix: --regions
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: More output per occurrence
    inputBinding:
      position: 101
      prefix: --verbose
  - id: window_length
    type:
      - 'null'
      - int
    doc: The window length
    default: 1000
    inputBinding:
      position: 101
      prefix: --window-length
outputs:
  - id: out
    type: File
    doc: Path to output VCF/BCF file
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maelstrom-core:0.1.1--he3973ca_3

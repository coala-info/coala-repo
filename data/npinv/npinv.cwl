cwlVersion: v1.2
class: CommandLineTool
baseCommand: npinv
label: npinv
doc: "Read a SE bam file and get the inversion\n\nTool homepage: https://github.com/haojingshao/npInv"
inputs:
  - id: input
    type: File
    doc: file to read
    inputBinding:
      position: 101
      prefix: --input
  - id: ir_database
    type:
      - 'null'
      - File
    doc: An inverted repeat file for the reference in bed format.
    default: none
    inputBinding:
      position: 101
      prefix: --IRdatabase
  - id: max_inversion_size
    type:
      - 'null'
      - int
    doc: maximum size of an inversion.
    default: 10000
    inputBinding:
      position: 101
      prefix: --max
  - id: min_aln
    type:
      - 'null'
      - int
    doc: minimum size for Alignment & Inv.
    default: 500
    inputBinding:
      position: 101
      prefix: --minAln
  - id: min_inversion_size
    type:
      - 'null'
      - int
    doc: minimum size of an inversion.
    default: 500
    inputBinding:
      position: 101
      prefix: --min
  - id: region
    type:
      - 'null'
      - string
    doc: Specify the region for running. Such as chr9:1-1000 OR chr9 OR all
    default: all
    inputBinding:
      position: 101
      prefix: --region
  - id: threshold
    type:
      - 'null'
      - int
    doc: minimum number of supporting reads for an inversion.
    default: 3
    inputBinding:
      position: 101
      prefix: --threshold
  - id: window
    type:
      - 'null'
      - int
    doc: minimun window size (bp) to merge inversion breakpoints.
    default: 2000
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: file to write
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/npinv:1.24--py312h7e72e81_6

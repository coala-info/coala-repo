cwlVersion: v1.2
class: CommandLineTool
baseCommand: clean
label: tapestry_clean
doc: "filter and order assembly from list of contigs\n\nTool homepage: https://github.com/johnomics/tapestry"
inputs:
  - id: assembly
    type: File
    doc: filename of assembly in FASTA format
    inputBinding:
      position: 101
      prefix: --assembly
  - id: csv
    type: File
    doc: Tapestry CSV output
    inputBinding:
      position: 101
      prefix: --csv
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: filename of output contigs
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tapestry:1.0.1--pyhdfd78af_0

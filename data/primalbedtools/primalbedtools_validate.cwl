cwlVersion: v1.2
class: CommandLineTool
baseCommand: primalbedtools validate
label: primalbedtools_validate
doc: "Validate a BED file against a reference FASTA file.\n\nTool homepage: https://github.com/ChrisgKent/primalbedtools"
inputs:
  - id: bed
    type: File
    doc: Input BED file
    inputBinding:
      position: 1
  - id: fasta
    type: File
    doc: Input reference file
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primalbedtools:1.0.0--pyhdfd78af_0
stdout: primalbedtools_validate.out

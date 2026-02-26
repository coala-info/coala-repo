cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - primalbedtools
  - validate_bedfile
label: primalbedtools_validate_bedfile
doc: "Validate a BED file\n\nTool homepage: https://github.com/ChrisgKent/primalbedtools"
inputs:
  - id: bed
    type: File
    doc: Input BED file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primalbedtools:1.0.0--pyhdfd78af_0
stdout: primalbedtools_validate_bedfile.out

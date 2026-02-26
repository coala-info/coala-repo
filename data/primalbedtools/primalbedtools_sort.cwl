cwlVersion: v1.2
class: CommandLineTool
baseCommand: primalbedtools_sort
label: primalbedtools_sort
doc: "Sort a BED file\n\nTool homepage: https://github.com/ChrisgKent/primalbedtools"
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
stdout: primalbedtools_sort.out

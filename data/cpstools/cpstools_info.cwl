cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpstools_info
label: cpstools_info
doc: "Show information about a genbank file.\n\nTool homepage: https://github.com/Xwb7533/CPStools"
inputs:
  - id: input_file
    type: File
    doc: Input genbank format file
    inputBinding:
      position: 101
      prefix: --input_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
stdout: cpstools_info.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpstools LSRs
label: cpstools_LSRs
doc: "Process GenBank files for LSRs\n\nTool homepage: https://github.com/Xwb7533/CPStools"
inputs:
  - id: input_file
    type: File
    doc: GenBank format file
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
stdout: cpstools_LSRs.out

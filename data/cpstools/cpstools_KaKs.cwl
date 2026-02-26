cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpstools_KaKs
label: cpstools_KaKs
doc: "KaKs calculator\n\nTool homepage: https://github.com/Xwb7533/CPStools"
inputs:
  - id: input_reference
    type: File
    doc: Input path of reference genbank file
    inputBinding:
      position: 101
      prefix: --input_reference
  - id: mode
    type:
      - 'null'
      - string
    doc: KaKs calculator mode
    inputBinding:
      position: 101
      prefix: --mode
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
stdout: cpstools_KaKs.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda-script_split_range
label: igda-script_split_range
doc: "Splits a range into segments.\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs:
  - id: start
    type: int
    doc: The start of the range.
    inputBinding:
      position: 1
  - id: end
    type: int
    doc: The end of the range.
    inputBinding:
      position: 2
  - id: segsize
    type: int
    doc: The size of each segment.
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_split_range.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: goleft
label: goleft_depthwed
doc: "Aggregate depth.bed files from goleft depth\n\nTool homepage: https://github.com/brentp/goleft"
inputs:
  - id: beds
    type:
      type: array
      items: File
    doc: depth.bed files from goleft depth
    inputBinding:
      position: 1
  - id: size
    type:
      - 'null'
      - int
    doc: sizes of windows to aggregate to must be >= window in input files.
    inputBinding:
      position: 102
      prefix: --size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goleft:0.2.6--he881be0_1
stdout: goleft_depthwed.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yak
  - inspect
label: yak_inspect
doc: "Evaluates k-mer QV and k-mer sensitivity.\n\nTool homepage: https://github.com/lh3/yak"
inputs:
  - id: in1_yak
    type: File
    doc: Input yak file 1
    inputBinding:
      position: 1
  - id: in2_yak
    type:
      - 'null'
      - File
    doc: Input yak file 2 (optional)
    inputBinding:
      position: 2
  - id: max_count
    type:
      - 'null'
      - int
    doc: max count (effective with in2.yak)
    inputBinding:
      position: 103
      prefix: -m
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yak:0.1--hed695b0_0
stdout: yak_inspect.out

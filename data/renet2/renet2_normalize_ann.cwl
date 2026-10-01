cwlVersion: v1.2
class: CommandLineTool
baseCommand: normalize_ann.py
label: renet2_normalize_ann
doc: "normalize annotation ID\n\nTool homepage: https://github.com/sujunhao/RENET2"
inputs:
  - id: in_f
    type:
      - 'null'
      - string
    doc: input annotation None
    inputBinding:
      position: 101
      prefix: --in_f
  - id: out_f
    type:
      - 'null'
      - string
    doc: output file
    inputBinding:
      position: 101
      prefix: --out_f
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_f_out
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.out_f)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/renet2:1.2--py_0
stdout: renet2_normalize_ann.out

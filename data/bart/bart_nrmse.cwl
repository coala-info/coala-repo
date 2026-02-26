cwlVersion: v1.2
class: CommandLineTool
baseCommand: nrmse
label: bart_nrmse
doc: "Output normalized root mean square error (NRMSE), i.e. norm(input - ref) / norm(ref)\n\
  \nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: reference
    type: string
    doc: reference
    inputBinding:
      position: 1
  - id: input
    type: string
    doc: input
    inputBinding:
      position: 2
  - id: automatic_scaling
    type:
      - 'null'
      - boolean
    doc: automatic (complex) scaling
    inputBinding:
      position: 103
      prefix: -s
  - id: eps
    type:
      - 'null'
      - float
    doc: compare to eps
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_nrmse.out

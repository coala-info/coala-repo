cwlVersion: v1.2
class: CommandLineTool
baseCommand: pocsense
label: bart_pocsense
doc: "Perform POCSENSE reconstruction.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: kspace
    type: string
    doc: kspace
    inputBinding:
      position: 1
  - id: sensitivities
    type: string
    doc: sensitivities
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 3
  - id: alpha
    type:
      - 'null'
      - float
    doc: regularization parameter
    inputBinding:
      position: 104
      prefix: -r
  - id: iter
    type:
      - 'null'
      - int
    doc: max. number of iterations
    inputBinding:
      position: 104
      prefix: -i
  - id: l1_l2_regularization
    type:
      - 'null'
      - string
    doc: toggle l1-wavelet or l2 regularization
    inputBinding:
      position: 104
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_pocsense.out

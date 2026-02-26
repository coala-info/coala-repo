cwlVersion: v1.2
class: CommandLineTool
baseCommand: estvar
label: bart_estvar
doc: "Estimate the noise variance assuming white Gaussian noise.\n\nTool homepage:
  https://github.com/tomdstanton/bart"
inputs:
  - id: kspace
    type: string
    doc: kspace
    inputBinding:
      position: 1
  - id: cal_size
    type:
      - 'null'
      - type: array
        items: string
    doc: Limits the size of the calibration region.
    inputBinding:
      position: 102
      prefix: -r
  - id: ksize
    type:
      - 'null'
      - type: array
        items: string
    doc: kernel size
    inputBinding:
      position: 102
      prefix: -k
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_estvar.out

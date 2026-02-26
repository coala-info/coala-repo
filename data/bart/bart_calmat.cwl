cwlVersion: v1.2
class: CommandLineTool
baseCommand: calmat
label: bart_calmat
doc: "Compute calibration matrix.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: kspace
    type: string
    doc: kspace
    inputBinding:
      position: 1
  - id: calibration_matrix
    type: string
    doc: calibration matrix
    inputBinding:
      position: 2
  - id: cal_size
    type:
      - 'null'
      - type: array
        items: string
    doc: Limits the size of the calibration region.
    inputBinding:
      position: 103
      prefix: -r
  - id: ksize
    type:
      - 'null'
      - type: array
        items: string
    doc: kernel size
    inputBinding:
      position: 103
      prefix: -k
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_calmat.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, calmat]
requirements:
  - class: InlineJavascriptRequirement
label: bart_calmat
doc: "Compute calibration matrix.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: kspace
    type: File
    doc: kspace
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: calibration_matrix
    type: string
    doc: calibration matrix
    inputBinding:
      position: 11
  - id: cal_size
    type:
      - 'null'
      - string
    doc: Limits the size of the calibration region.
    inputBinding:
      position: 1
      prefix: -r
  - id: ksize
    type:
      - 'null'
      - string
    doc: kernel size
    inputBinding:
      position: 1
      prefix: -k
outputs:
  - id: calibration_matrix_file
    type: File
    doc: Array written as calibration_matrix.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.calibration_matrix).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1

cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, estvar]
requirements:
  - class: InlineJavascriptRequirement
label: bart_estvar
doc: "Estimate the noise variance assuming white Gaussian noise.\n\nTool homepage:
  https://github.com/mrirecon/bart"
inputs:
  - id: kspace
    type: File
    doc: kspace
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_estvar.out

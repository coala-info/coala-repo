cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, pocsense]
requirements:
  - class: InlineJavascriptRequirement
label: bart_pocsense
doc: "Perform POCSENSE reconstruction.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: kspace
    type: File
    doc: kspace
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: sensitivities
    type: File
    doc: sensitivities
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 12
  - id: alpha
    type:
      - 'null'
      - float
    doc: regularization parameter
    inputBinding:
      position: 1
      prefix: -r
  - id: iter
    type:
      - 'null'
      - int
    doc: max. number of iterations
    inputBinding:
      position: 1
      prefix: -i
  - id: l1_l2_regularization
    type:
      - 'null'
      - string
    doc: toggle l1-wavelet or l2 regularization
    inputBinding:
      position: 1
      prefix: -l
outputs:
  - id: output_file
    type: File
    doc: Array written as output.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1

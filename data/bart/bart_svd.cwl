cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, svd]
requirements:
  - class: InlineJavascriptRequirement
label: bart_svd
doc: "Compute singular-value-decomposition (SVD).\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: input
    type: File
    doc: input
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: u
    type: string
    doc: U
    inputBinding:
      position: 11
  - id: s
    type: string
    doc: S
    inputBinding:
      position: 12
  - id: vh
    type: string
    doc: VH
    inputBinding:
      position: 13
  - id: econ
    type:
      - 'null'
      - boolean
    doc: econ
    inputBinding:
      position: 1
      prefix: -e
outputs:
  - id: u_file
    type: File
    doc: Array written as u.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.u).cfl
  - id: s_file
    type: File
    doc: Array written as s.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.s).cfl
  - id: vh_file
    type: File
    doc: Array written as vh.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.vh).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1

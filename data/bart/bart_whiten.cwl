cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, whiten]
requirements:
  - class: InlineJavascriptRequirement
label: bart_whiten
doc: "Apply multi-channel noise pre-whitening on <input> using noise data <ndata>.
  Optionally output whitening matrix and noise covariance matrix\n\nTool homepage:
  https://github.com/mrirecon/bart"
inputs:
  - id: input
    type: File
    doc: Input data
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: ndata
    type: File
    doc: Noise data
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output
    type: string
    doc: Output data
    inputBinding:
      position: 12
  - id: optmat_out
    type:
      - 'null'
      - string
    doc: Optional output whitening matrix
    inputBinding:
      position: 13
  - id: covar_out
    type:
      - 'null'
      - string
    doc: Optional output noise covariance matrix
    inputBinding:
      position: 14
  - id: covar_in
    type:
      - 'null'
      - File
    doc: use external noise covariance matrix <covar_in>
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 1
      prefix: -c
      valueFrom: "$(self === null ? null : self.path.replace(/\\.cfl$/, ''))"
  - id: normalize_variance
    type:
      - 'null'
      - boolean
    doc: normalize variance to 1 using noise data <ndata>
    inputBinding:
      position: 1
      prefix: -n
  - id: optmat_in
    type:
      - 'null'
      - File
    doc: use external whitening matrix <optmat_in>
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 1
      prefix: -o
      valueFrom: "$(self === null ? null : self.path.replace(/\\.cfl$/, ''))"
outputs:
  - id: output_file
    type: File
    doc: Array written as output.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output).cfl
  - id: optmat_out_file
    type:
      - 'null'
      - File
    doc: Array written as optmat_out.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.optmat_out).cfl
  - id: covar_out_file
    type:
      - 'null'
      - File
    doc: Array written as covar_out.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.covar_out).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1

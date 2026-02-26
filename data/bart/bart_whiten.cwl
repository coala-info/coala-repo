cwlVersion: v1.2
class: CommandLineTool
baseCommand: whiten
label: bart_whiten
doc: "Apply multi-channel noise pre-whitening on <input> using noise data <ndata>.
  Optionally output whitening matrix and noise covariance matrix\n\nTool homepage:
  https://github.com/tomdstanton/bart"
inputs:
  - id: input
    type: string
    doc: Input data
    inputBinding:
      position: 1
  - id: ndata
    type: string
    doc: Noise data
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: Output data
    inputBinding:
      position: 3
  - id: optmat_out
    type:
      - 'null'
      - string
    doc: Optional output whitening matrix
    inputBinding:
      position: 4
  - id: covar_out
    type:
      - 'null'
      - string
    doc: Optional output noise covariance matrix
    inputBinding:
      position: 5
  - id: covar_in
    type:
      - 'null'
      - string
    doc: use external noise covariance matrix <covar_in>
    inputBinding:
      position: 106
      prefix: -c
  - id: normalize_variance
    type:
      - 'null'
      - boolean
    doc: normalize variance to 1 using noise data <ndata>
    inputBinding:
      position: 106
      prefix: -n
  - id: optmat_in
    type:
      - 'null'
      - string
    doc: use external whitening matrix <optmat_in>
    inputBinding:
      position: 106
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_whiten.out

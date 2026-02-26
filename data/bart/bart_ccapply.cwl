cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccapply
label: bart_ccapply
doc: "Apply coil compression forward/inverse operation.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: kspace
    type: File
    doc: Input k-space data
    inputBinding:
      position: 1
  - id: cc_matrix
    type: File
    doc: Coil compression matrix
    inputBinding:
      position: 2
  - id: proj_kspace
    type: File
    doc: Output projected k-space data
    inputBinding:
      position: 3
  - id: espirit_type
    type:
      - 'null'
      - type: array
        items: string
    doc: 'type: ESPIRiT'
    inputBinding:
      position: 104
      prefix: -E
  - id: geometric_type
    type:
      - 'null'
      - type: array
        items: string
    doc: 'type: Geometric'
    inputBinding:
      position: 104
      prefix: -G
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: apply inverse operation
    inputBinding:
      position: 104
      prefix: -u
  - id: no_fft
    type:
      - 'null'
      - boolean
    doc: don't apply FFT in readout
    inputBinding:
      position: 104
      prefix: -t
  - id: num_virtual_channels
    type:
      - 'null'
      - int
    doc: perform compression to N virtual channels
    inputBinding:
      position: 104
      prefix: -p
  - id: svd_type
    type:
      - 'null'
      - type: array
        items: string
    doc: 'type: SVD'
    inputBinding:
      position: 104
      prefix: -S
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_ccapply.out

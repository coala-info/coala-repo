cwlVersion: v1.2
class: CommandLineTool
baseCommand: cc
label: bart_cc
doc: "Performs coil compression.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: kspace
    type: string
    doc: kspace
    inputBinding:
      position: 1
  - id: coeff_or_proj_kspace
    type: string
    doc: coeff or proj_kspace
    inputBinding:
      position: 2
  - id: calibration_region_size
    type:
      - 'null'
      - type: array
        items: string
    doc: size of calibration region
    inputBinding:
      position: 103
      prefix: -r
  - id: espirit_type
    type:
      - 'null'
      - type: array
        items: string
    doc: 'type: ESPIRiT'
    inputBinding:
      position: 103
      prefix: -E
  - id: geometric_type
    type:
      - 'null'
      - type: array
        items: string
    doc: 'type: Geometric'
    inputBinding:
      position: 103
      prefix: -G
  - id: output_matrix
    type:
      - 'null'
      - boolean
    doc: output compression matrix
    inputBinding:
      position: 103
      prefix: -M
  - id: svd_type
    type:
      - 'null'
      - type: array
        items: string
    doc: 'type: SVD'
    inputBinding:
      position: 103
      prefix: -S
  - id: use_all_data
    type:
      - 'null'
      - boolean
    doc: use all data to compute coefficients
    inputBinding:
      position: 103
      prefix: -A
  - id: virtual_channels
    type:
      - 'null'
      - int
    doc: perform compression to N virtual channels
    inputBinding:
      position: 103
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
stdout: bart_cc.out

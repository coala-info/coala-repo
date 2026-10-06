cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, cc]
requirements:
  - class: InlineJavascriptRequirement
label: bart_cc
doc: "Performs coil compression.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: kspace
    type: File
    doc: kspace
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: coeff_or_proj_kspace
    type: string
    doc: coeff or proj_kspace
    inputBinding:
      position: 11
  - id: calibration_region_size
    type:
      - 'null'
      - string
    doc: size of calibration region
    inputBinding:
      position: 1
      prefix: -r
  - id: espirit_type
    type:
      - 'null'
      - boolean
    doc: 'type: ESPIRiT'
    inputBinding:
      position: 1
      prefix: -E
  - id: geometric_type
    type:
      - 'null'
      - boolean
    doc: 'type: Geometric'
    inputBinding:
      position: 1
      prefix: -G
  - id: output_matrix
    type:
      - 'null'
      - boolean
    doc: output compression matrix
    inputBinding:
      position: 1
      prefix: -M
  - id: svd_type
    type:
      - 'null'
      - boolean
    doc: 'type: SVD'
    inputBinding:
      position: 1
      prefix: -S
  - id: use_all_data
    type:
      - 'null'
      - boolean
    doc: use all data to compute coefficients
    inputBinding:
      position: 1
      prefix: -A
  - id: virtual_channels
    type:
      - 'null'
      - int
    doc: perform compression to N virtual channels
    inputBinding:
      position: 1
      prefix: -p
outputs:
  - id: coeff_or_proj_kspace_file
    type: File
    doc: Array written as coeff_or_proj_kspace.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.coeff_or_proj_kspace).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1

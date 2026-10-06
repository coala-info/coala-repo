cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, ccapply]
requirements:
  - class: InlineJavascriptRequirement
label: bart_ccapply
doc: "Apply coil compression forward/inverse operation.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: kspace
    type: File
    doc: Input k-space data
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: cc_matrix
    type: File
    doc: Coil compression matrix
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: proj_kspace
    type: string
    doc: Output projected k-space data
    inputBinding:
      position: 12
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
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: apply inverse operation
    inputBinding:
      position: 1
      prefix: -u
  - id: no_fft
    type:
      - 'null'
      - boolean
    doc: don't apply FFT in readout
    inputBinding:
      position: 1
      prefix: -t
  - id: num_virtual_channels
    type:
      - 'null'
      - int
    doc: perform compression to N virtual channels
    inputBinding:
      position: 1
      prefix: -p
  - id: svd_type
    type:
      - 'null'
      - boolean
    doc: 'type: SVD'
    inputBinding:
      position: 1
      prefix: -S
outputs:
  - id: proj_kspace_file
    type: File
    doc: Array written as proj_kspace.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.proj_kspace).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1

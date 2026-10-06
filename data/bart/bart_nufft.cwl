cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, nufft]
requirements:
  - class: InlineJavascriptRequirement
label: bart_nufft
doc: "Perform non-uniform Fast Fourier Transform.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: traj
    type: File
    doc: Trajectory file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: input
    type: File
    doc: Input data
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 12
  - id: adjoint
    type:
      - 'null'
      - boolean
    doc: adjoint
    inputBinding:
      position: 1
      prefix: -a
  - id: dft
    type:
      - 'null'
      - boolean
    doc: DFT
    inputBinding:
      position: 1
      prefix: -s
  - id: dimensions
    type:
      - 'null'
      - string
    doc: dimensions
    inputBinding:
      position: 1
      prefix: -d
  - id: gpu_inverse
    type:
      - 'null'
      - boolean
    doc: GPU (only inverse)
    inputBinding:
      position: 1
      prefix: -g
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: inverse
    inputBinding:
      position: 1
      prefix: -i
  - id: l2_regularization
    type:
      - 'null'
      - float
    doc: l2 regularization
    inputBinding:
      position: 1
      prefix: -l
  - id: no_toeplitz_embedding_inverse
    type:
      - 'null'
      - boolean
    doc: turn-off Toeplitz embedding for inverse NUFFT
    inputBinding:
      position: 1
      prefix: -r
  - id: periodic_k_space
    type:
      - 'null'
      - boolean
    doc: periodic k-space
    inputBinding:
      position: 1
      prefix: -P
  - id: preconditioning_inverse
    type:
      - 'null'
      - boolean
    doc: Preconditioning for inverse NUFFT
    inputBinding:
      position: 1
      prefix: -c
  - id: toeplitz_embedding_inverse
    type:
      - 'null'
      - boolean
    doc: Toeplitz embedding for inverse NUFFT
    inputBinding:
      position: 1
      prefix: -t
outputs:
  - id: output
    type: File
    doc: Output file
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1

cwlVersion: v1.2
class: CommandLineTool
baseCommand: nufft
label: bart_nufft
doc: "Perform non-uniform Fast Fourier Transform.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: traj
    type: string
    doc: Trajectory file
    inputBinding:
      position: 1
  - id: input
    type: string
    doc: Input data
    inputBinding:
      position: 2
  - id: adjoint
    type:
      - 'null'
      - boolean
    doc: adjoint
    inputBinding:
      position: 103
      prefix: -a
  - id: dft
    type:
      - 'null'
      - boolean
    doc: DFT
    inputBinding:
      position: 103
      prefix: -s
  - id: dimensions
    type:
      - 'null'
      - type: array
        items: string
    doc: dimensions
    inputBinding:
      position: 103
      prefix: -d
  - id: gpu_inverse
    type:
      - 'null'
      - boolean
    doc: GPU (only inverse)
    inputBinding:
      position: 103
      prefix: -g
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: inverse
    inputBinding:
      position: 103
      prefix: -i
  - id: l2_regularization
    type:
      - 'null'
      - float
    doc: l2 regularization
    inputBinding:
      position: 103
      prefix: -l
  - id: no_toeplitz_embedding_inverse
    type:
      - 'null'
      - boolean
    doc: turn-off Toeplitz embedding for inverse NUFFT
    inputBinding:
      position: 103
      prefix: -r
  - id: periodic_k_space
    type:
      - 'null'
      - boolean
    doc: periodic k-space
    inputBinding:
      position: 103
      prefix: -P
  - id: preconditioning_inverse
    type:
      - 'null'
      - boolean
    doc: Preconditioning for inverse NUFFT
    inputBinding:
      position: 103
      prefix: -c
  - id: toeplitz_embedding_inverse
    type:
      - 'null'
      - boolean
    doc: Toeplitz embedding for inverse NUFFT
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1

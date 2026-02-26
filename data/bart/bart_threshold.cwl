cwlVersion: v1.2
class: CommandLineTool
baseCommand: threshold
label: bart_threshold
doc: "Perform (soft) thresholding with parameter lambda.\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: lambda
    type: float
    doc: Parameter lambda for thresholding
    inputBinding:
      position: 1
  - id: input
    type: File
    doc: Input file
    inputBinding:
      position: 2
  - id: daubechies_wavelet_soft_thresholding
    type:
      - 'null'
      - boolean
    doc: daubechies wavelet soft-thresholding
    inputBinding:
      position: 103
      prefix: -W
  - id: divergence_free_wavelet_soft_thresholding
    type:
      - 'null'
      - boolean
    doc: divergence-free wavelet soft-thresholding
    inputBinding:
      position: 103
      prefix: -D
  - id: hard_thresholding
    type:
      - 'null'
      - boolean
    doc: hard thresholding
    inputBinding:
      position: 103
      prefix: -H
  - id: joint_soft_thresholding_bitmask
    type:
      - 'null'
      - int
    doc: joint soft-thresholding
    inputBinding:
      position: 103
      prefix: -j
  - id: locally_low_rank_block_size
    type:
      - 'null'
      - int
    doc: locally low rank block size
    inputBinding:
      position: 103
      prefix: -b
  - id: locally_low_rank_soft_thresholding
    type:
      - 'null'
      - boolean
    doc: locally low rank soft-thresholding
    inputBinding:
      position: 103
      prefix: -L
outputs:
  - id: output
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1

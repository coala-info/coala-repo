cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, threshold]
requirements:
  - class: InlineJavascriptRequirement
label: bart_threshold
doc: "Perform (soft) thresholding with parameter lambda.\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: lambda
    type: float
    doc: Parameter lambda for thresholding
    inputBinding:
      position: 10
  - id: input
    type: File
    doc: Input file
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
  - id: daubechies_wavelet_soft_thresholding
    type:
      - 'null'
      - boolean
    doc: daubechies wavelet soft-thresholding
    inputBinding:
      position: 1
      prefix: -W
  - id: divergence_free_wavelet_soft_thresholding
    type:
      - 'null'
      - boolean
    doc: divergence-free wavelet soft-thresholding
    inputBinding:
      position: 1
      prefix: -D
  - id: hard_thresholding
    type:
      - 'null'
      - boolean
    doc: hard thresholding
    inputBinding:
      position: 1
      prefix: -H
  - id: joint_soft_thresholding_bitmask
    type:
      - 'null'
      - int
    doc: joint soft-thresholding
    inputBinding:
      position: 1
      prefix: -j
  - id: locally_low_rank_block_size
    type:
      - 'null'
      - int
    doc: locally low rank block size
    inputBinding:
      position: 1
      prefix: -b
  - id: locally_low_rank_soft_thresholding
    type:
      - 'null'
      - boolean
    doc: locally low rank soft-thresholding
    inputBinding:
      position: 1
      prefix: -L
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

cwlVersion: v1.2
class: CommandLineTool
baseCommand: lrmatrix
label: bart_lrmatrix
doc: "Perform (multi-scale) low rank matrix completion\n\nTool homepage: https://github.com/tomdstanton/bart"
inputs:
  - id: input
    type: string
    doc: input
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 2
  - id: add_noise_scale
    type:
      - 'null'
      - boolean
    doc: add noise scale to account for Gaussian noise.
    inputBinding:
      position: 103
      prefix: -N
  - id: block_size_scaling
    type:
      - 'null'
      - int
    doc: block size scaling from one scale to the next one.
    inputBinding:
      position: 103
      prefix: -j
  - id: decomposition
    type:
      - 'null'
      - boolean
    doc: perform decomposition instead, ie fully sampled
    inputBinding:
      position: 103
      prefix: -d
  - id: locally_low_rank_block_size
    type:
      - 'null'
      - int
    doc: perform locally low rank soft thresholding with specified block size.
    inputBinding:
      position: 103
      prefix: -l
  - id: low_rank_sparse_completion
    type:
      - 'null'
      - boolean
    doc: perform low rank + sparse matrix completion.
    inputBinding:
      position: 103
      prefix: -s
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: maximum iterations.
    inputBinding:
      position: 103
      prefix: -i
  - id: multi_scale_partition
    type:
      - 'null'
      - int
    doc: which dimensions to perform multi-scale partition.
    inputBinding:
      position: 103
      prefix: -f
  - id: reshape_dimensions
    type:
      - 'null'
      - int
    doc: which dimensions are reshaped to matrix columns.
    inputBinding:
      position: 103
      prefix: -m
  - id: smallest_block_size
    type:
      - 'null'
      - int
    doc: smallest block size
    inputBinding:
      position: 103
      prefix: -k
outputs:
  - id: denoised_output
    type:
      - 'null'
      - File
    doc: summed over all non-noise scales to create a denoised output.
    outputBinding:
      glob: $(inputs.denoised_output)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1

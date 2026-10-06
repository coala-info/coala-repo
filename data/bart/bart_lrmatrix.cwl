cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, lrmatrix]
requirements:
  - class: InlineJavascriptRequirement
label: bart_lrmatrix
doc: "Perform (multi-scale) low rank matrix completion\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: input
    type: File
    doc: input
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 10
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output
    type: string
    doc: output
    inputBinding:
      position: 11
  - id: add_noise_scale
    type:
      - 'null'
      - boolean
    doc: add noise scale to account for Gaussian noise.
    inputBinding:
      position: 1
      prefix: -N
  - id: block_size_scaling
    type:
      - 'null'
      - int
    doc: block size scaling from one scale to the next one.
    inputBinding:
      position: 1
      prefix: -j
  - id: decomposition
    type:
      - 'null'
      - boolean
    doc: perform decomposition instead, ie fully sampled
    inputBinding:
      position: 1
      prefix: -d
  - id: locally_low_rank_block_size
    type:
      - 'null'
      - int
    doc: perform locally low rank soft thresholding with specified block size.
    inputBinding:
      position: 1
      prefix: -l
  - id: low_rank_sparse_completion
    type:
      - 'null'
      - boolean
    doc: perform low rank + sparse matrix completion.
    inputBinding:
      position: 1
      prefix: -s
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: maximum iterations.
    inputBinding:
      position: 1
      prefix: -i
  - id: multi_scale_partition
    type:
      - 'null'
      - int
    doc: which dimensions to perform multi-scale partition.
    inputBinding:
      position: 1
      prefix: -f
  - id: reshape_dimensions
    type:
      - 'null'
      - int
    doc: which dimensions are reshaped to matrix columns.
    inputBinding:
      position: 1
      prefix: -m
  - id: smallest_block_size
    type:
      - 'null'
      - int
    doc: smallest block size
    inputBinding:
      position: 1
      prefix: -k
  - id: denoised_output_path
    type:
      - 'null'
      - string
    doc: "out2      \tsummed over all non-noise scales to create a denoised output."
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: Array written as output.cfl/.hdr
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output).cfl
  - id: denoised_output
    type:
      - 'null'
      - File
    doc: summed over all non-noise scales to create a denoised output.
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.denoised_output_path).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1

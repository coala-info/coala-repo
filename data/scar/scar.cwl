cwlVersion: v1.2
class: CommandLineTool
baseCommand: scar
label: scar
doc: "scAR (single-cell Ambient Remover) is a deep learning model for removal of the
  ambient signals in droplet-based single cell omics\n\nTool homepage: https://github.com/Novartis/scAR"
inputs:
  - id: count_matrix
    type:
      type: array
      items: File
    doc: The file of raw count matrix, 2D array (cells x genes) or the path of a
      filtered_feature_bc_matrix.h5
    inputBinding:
      position: 1
  - id: adjust
    type:
      - 'null'
      - string
    doc: "Only used  for calculating Bayesfactors to improve performance,  \n    \
      \                                    | 'micro' -- adjust the estimated native
      counts per cell. Default.\n                                        | 'global'
      -- adjust the estimated native counts globally.\n                          \
      \              | False -- no adjustment, use the model-returned native counts."
    inputBinding:
      position: 102
      prefix: --adjust
  - id: ambient_profile
    type:
      - 'null'
      - File
    doc: The file of empty profile obtained from empty droplets, 1D array
    inputBinding:
      position: 102
      prefix: --ambient_profile
  - id: batchkey
    type:
      - 'null'
      - string
    doc: The batch key for batch correction
    inputBinding:
      position: 102
      prefix: --batchkey
  - id: batchsize
    type:
      - 'null'
      - int
    doc: Batch size for training, set a small value upon out of memory error
    inputBinding:
      position: 102
      prefix: --batchsize
  - id: batchsize_infer
    type:
      - 'null'
      - int
    doc: Batch size for inference, set a small value upon out of memory error
    inputBinding:
      position: 102
      prefix: --batchsize_infer
  - id: cachecapacity
    type:
      - 'null'
      - int
    doc: The capacity of cache for batch correction
    inputBinding:
      position: 102
      prefix: --cachecapacity
  - id: clip_to_obs
    type:
      - 'null'
      - boolean
    doc: clip the predicted native counts by observed counts,             use it
      with caution, as it may lead to overestimation of overall noise.
    inputBinding:
      position: 102
      prefix: --clip_to_obs
  - id: count_model
    type:
      - 'null'
      - string
    doc: Count model
    inputBinding:
      position: 102
      prefix: --count_model
  - id: cutoff
    type:
      - 'null'
      - float
    doc: Cutoff for Bayesfactors. See [Ly2020]_
    inputBinding:
      position: 102
      prefix: --cutoff
  - id: device
    type:
      - 'null'
      - string
    doc: Device used for training, either 'auto', 'cpu', or 'cuda'
    inputBinding:
      position: 102
      prefix: --device
  - id: epochs
    type:
      - 'null'
      - int
    doc: Training epochs
    inputBinding:
      position: 102
      prefix: --epochs
  - id: feature_type
    type:
      - 'null'
      - string
    doc: The feature types, e.g. mRNA, sgRNA, ADT, tag, CMO and ATAC
    inputBinding:
      position: 102
      prefix: --feature_type
  - id: get_native_frequencies
    type:
      - 'null'
      - int
    doc: Whether to get native frequencies, 0 or 1, by default 0, not to get 
      native frequencies
    default: 0
    inputBinding:
      position: 102
      prefix: --get_native_frequencies
  - id: hidden_layer1
    type:
      - 'null'
      - int
    doc: Number of neurons in the first layer
    inputBinding:
      position: 102
      prefix: --hidden_layer1
  - id: hidden_layer2
    type:
      - 'null'
      - int
    doc: Number of neurons in the second layer
    inputBinding:
      position: 102
      prefix: --hidden_layer2
  - id: latent_dim
    type:
      - 'null'
      - int
    doc: Dimension of latent space
    inputBinding:
      position: 102
      prefix: --latent_dim
  - id: moi
    type:
      - 'null'
      - float
    doc: Multiplicity of Infection. If assigned, it will allow optimized 
      thresholding,         which tests a series of cutoffs to find the best one
      based on distributions of infections under given moi.         See 
      [Dixit2016]_ for details. Under development.
    inputBinding:
      position: 102
      prefix: --moi
  - id: round2int
    type:
      - 'null'
      - boolean
    doc: Round the counts
    inputBinding:
      position: 102
      prefix: --round2int
  - id: save_model
    type:
      - 'null'
      - string
    doc: Save the trained model
    inputBinding:
      position: 102
      prefix: --save_model
  - id: sparsity
    type:
      - 'null'
      - float
    doc: The sparsity of expected native signals
    inputBinding:
      position: 102
      prefix: --sparsity
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Whether to print the logging messages
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scar:0.7.0--pyhdfd78af_0

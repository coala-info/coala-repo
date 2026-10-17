cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyclone-vi
  - fit
label: pyclone-vi_fit
doc: "Fit PyClone-VI model to data.\n\nTool homepage: https://github.com/Roth-Lab/pyclone-vi"
inputs:
  - id: in_file
    type: File
    doc: Path to TSV format file with copy number and allele count information
      for all samples.
    inputBinding:
      position: 1
      prefix: --in-file
  - id: out_file
    type: string
    doc: Path to where results will be written in HDF5 format.
    inputBinding:
      position: 1
      prefix: --out-file
  - id: num_clusters
    type:
      - 'null'
      - int
    doc: Number of clusters to use in variational approximation distribution.
      Default 10 (x>=2).
    inputBinding:
      position: 1
      prefix: --num-clusters
  - id: density
    type:
      - 'null'
      - string
    doc: Allele count density in the PyClone model, beta-binomial or binomial.
      Default binomial.
    inputBinding:
      position: 1
      prefix: --density
  - id: num_grid_points
    type:
      - 'null'
      - int
    doc: Number of points used to approximate CCF values. Default 100 (x>=10).
    inputBinding:
      position: 1
      prefix: --num-grid-points
  - id: num_restarts
    type:
      - 'null'
      - int
    doc: Number of random restarts of variational inference. Default 1 (x>=1).
    inputBinding:
      position: 1
      prefix: --num-restarts
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Default 1 (x>=1).
    inputBinding:
      position: 1
      prefix: --num-threads
  - id: convergence_threshold
    type:
      - 'null'
      - float
    doc: Maximum relative ELBO difference between iterations to decide on
      convergence. Default 1e-06.
    inputBinding:
      position: 1
      prefix: --convergence-threshold
  - id: max_iters
    type:
      - 'null'
      - int
    doc: Maximum number of ELBO optimization iterations. Default 10000 (x>=1).
    inputBinding:
      position: 1
      prefix: --max-iters
  - id: mix_weight_prior
    type:
      - 'null'
      - float
    doc: Parameter value of symmetric Dirichlet prior distribution on mixture
      weights. Default 1.0.
    inputBinding:
      position: 1
      prefix: --mix-weight-prior
  - id: precision
    type:
      - 'null'
      - float
    doc: Precision for Beta-Binomial density. Has no effect when using
      Binomial. Default 200.
    inputBinding:
      position: 1
      prefix: --precision
  - id: print_freq
    type:
      - 'null'
      - int
    doc: How often to print information about optimization. Default 100
      (x>=1).
    inputBinding:
      position: 1
      prefix: --print-freq
  - id: seed
    type:
      - 'null'
      - int
    doc: Set random seed so results can be reproduced. By default, a random
      seed is chosen.
    inputBinding:
      position: 1
      prefix: --seed
outputs:
  - id: fit_hdf5
    type: File
    doc: Fitted model in HDF5 format.
    outputBinding:
      glob: $(inputs.out_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyclone-vi:0.2.0--pyhdfd78af_0

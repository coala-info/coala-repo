cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnmf
  - factorize
label: cnmf_factorize
doc: "Factorize the counts matrix into gene expression programs using NMF as part
  of the cNMF pipeline.\n\nTool homepage: https://github.com/dylkot/cNMF"
inputs:
  - id: beta_loss
    type:
      - 'null'
      - string
    doc: '[prepare] Loss function for NMF (default frobenius)'
    inputBinding:
      position: 101
      prefix: --beta-loss
  - id: build_reference
    type:
      - 'null'
      - boolean
    doc: '[consensus] Generates a reference spectra for use in starCAT'
    inputBinding:
      position: 101
      prefix: --build-reference
  - id: components
    type:
      - 'null'
      - type: array
        items: int
    doc: '[prepare] Numper of components (k) for matrix factorization. Several can
      be specified with "-k 8 9 10"'
    inputBinding:
      position: 101
      prefix: --components
  - id: counts
    type:
      - 'null'
      - File
    doc: '[prepare] Input (cell x gene) counts matrix as .h5ad, .mtx, df.npz, or tab
      delimited text file'
    inputBinding:
      position: 101
      prefix: --counts
  - id: densify
    type:
      - 'null'
      - boolean
    doc: '[prepare] Treat the input data as non-sparse (default False)'
    inputBinding:
      position: 101
      prefix: --densify
  - id: genes_file
    type:
      - 'null'
      - File
    doc: '[prepare] File containing a list of genes to include, one gene per line.
      Must match column labels of counts matrix.'
    inputBinding:
      position: 101
      prefix: --genes-file
  - id: init
    type:
      - 'null'
      - string
    doc: '[prepare] Initialization algorithm for NMF (default random)'
    inputBinding:
      position: 101
      prefix: --init
  - id: local_density_threshold
    type:
      - 'null'
      - float
    doc: '[consensus] Threshold for the local density filtering. This string must
      convert to a float >0 and <=2'
    inputBinding:
      position: 101
      prefix: --local-density-threshold
  - id: local_neighborhood_size
    type:
      - 'null'
      - float
    doc: '[consensus] Fraction of the number of replicates to use as nearest neighbors
      for local density filtering'
    inputBinding:
      position: 101
      prefix: --local-neighborhood-size
  - id: max_nmf_iter
    type:
      - 'null'
      - int
    doc: '[prepare] Max number of iterations per individual NMF run (default 1000)'
    inputBinding:
      position: 101
      prefix: --max-nmf-iter
  - id: n_iter
    type:
      - 'null'
      - int
    doc: '[prepare] Number of factorization replicates'
    inputBinding:
      position: 101
      prefix: --n-iter
  - id: name
    type:
      - 'null'
      - string
    doc: '[all] Name for analysis. All output will be placed in [output-dir]/[name]/...'
    inputBinding:
      position: 101
      prefix: --name
  - id: numgenes
    type:
      - 'null'
      - int
    doc: '[prepare] Number of high variance genes to use for matrix factorization.'
    inputBinding:
      position: 101
      prefix: --numgenes
  - id: seed
    type:
      - 'null'
      - int
    doc: '[prepare] Seed for pseudorandom number generation'
    inputBinding:
      position: 101
      prefix: --seed
  - id: show_clustering
    type:
      - 'null'
      - boolean
    doc: '[consensus] Produce a clustergram figure summarizing the spectra clustering'
    inputBinding:
      position: 101
      prefix: --show-clustering
  - id: skip_completed_runs
    type:
      - 'null'
      - boolean
    doc: '[factorize] Skip previously completed runs. Must re-run prepare first to
      update completed runs'
    inputBinding:
      position: 101
      prefix: --skip-completed-runs
  - id: total_workers
    type:
      - 'null'
      - int
    doc: '[all] Total number of workers to distribute jobs to'
    inputBinding:
      position: 101
      prefix: --total-workers
  - id: tpm
    type:
      - 'null'
      - File
    doc: '[prepare] Pre-computed (cell x gene) TPM values as df.npz or tab separated
      txt file. If not provided TPM will be calculated automatically'
    inputBinding:
      position: 101
      prefix: --tpm
  - id: worker_index
    type:
      - 'null'
      - int
    doc: '[factorize] Index of current worker (the first worker should have index
      0)'
    inputBinding:
      position: 101
      prefix: --worker-index
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: '[all] Output directory. All output will be placed in [output-dir]/[name]/...'
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnmf:1.7.0--pyhdfd78af_0

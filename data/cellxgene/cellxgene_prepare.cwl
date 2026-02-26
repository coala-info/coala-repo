cwlVersion: v1.2
class: CommandLineTool
baseCommand: cellxgene prepare
label: cellxgene_prepare
doc: "Preprocess data for use with cellxgene. This tool runs a series of scanpy\n\
  routines for preparing a dataset for use with cellxgene. It loads data from\ndifferent
  formats (h5ad, loom, or a 10x directory), runs dimensionality\nreduction, computes
  nearest neighbors, computes an embedding, performs\nclustering, and saves the results.
  Includes additional options for naming\nannotations, ensuring sparsity, and plotting
  results.\n\nTool homepage: https://chanzuckerberg.github.io/cellxgene/"
inputs:
  - id: data_file
    type: File
    doc: path to data file
    inputBinding:
      position: 1
  - id: embedding
    type:
      - 'null'
      - type: array
        items: string
    doc: Embedding algorithm(s). Repeat option for multiple embeddings.
    default:
      - umap
      - tsne
    inputBinding:
      position: 102
      prefix: --embedding
  - id: make_obs_names_unique
    type:
      - 'null'
      - boolean
    doc: Ensure obs index is unique.
    default: true
    inputBinding:
      position: 102
      prefix: --make-obs-names-unique
  - id: make_var_names_unique
    type:
      - 'null'
      - boolean
    doc: Ensure var index is unique.
    default: true
    inputBinding:
      position: 102
      prefix: --make-var-names-unique
  - id: no_make_obs_names_unique
    type:
      - 'null'
      - boolean
    doc: Ensure obs index is unique.
    default: false
    inputBinding:
      position: 102
      prefix: --no-make-obs-names-unique
  - id: no_make_var_names_unique
    type:
      - 'null'
      - boolean
    doc: Ensure var index is unique.
    default: false
    inputBinding:
      position: 102
      prefix: --no-make-var-names-unique
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Allow file overwriting.
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: plotting
    type:
      - 'null'
      - boolean
    doc: Generate plots.
    inputBinding:
      position: 102
      prefix: --plotting
  - id: recipe
    type:
      - 'null'
      - string
    default: none
    inputBinding:
      position: 102
      prefix: --recipe
  - id: set_obs_names
    type:
      - 'null'
      - string
    doc: Named field to set as index for obs.
    inputBinding:
      position: 102
      prefix: --set-obs-names
  - id: set_var_names
    type:
      - 'null'
      - string
    doc: Named field to set as index for var.
    inputBinding:
      position: 102
      prefix: --set-var-names
  - id: skip_qc
    type:
      - 'null'
      - boolean
    doc: "Do not run quality control metrics. By default cellxgene runs them (saved
      to\nadata.obs and adata.var; see\nscanpy.pp.calculate_qc_metrics for details)."
    inputBinding:
      position: 102
      prefix: --skip-qc
  - id: sparse
    type:
      - 'null'
      - boolean
    doc: Force sparsity.
    inputBinding:
      position: 102
      prefix: --sparse
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Save a new file to filename.
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cellxgene:1.3.0--pyhdfd78af_0

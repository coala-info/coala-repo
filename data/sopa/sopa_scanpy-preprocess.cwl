cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sopa
  - scanpy-preprocess
label: sopa_scanpy-preprocess
doc: "Optional scanpy table preprocessing (log1p, UMAP, leiden clustering) after aggregation/annotation.\n\
  \nTool homepage: https://gustaveroussy.github.io/sopa"
inputs:
  - id: sdata_path
    type: string
    doc: Path to the SpatialData `.zarr` directory
    inputBinding:
      position: 1
  - id: check_counts
    type:
      - 'null'
      - boolean
    doc: Whether to check that adata.X contains counts
    default: true
    inputBinding:
      position: 102
      prefix: --check-counts
  - id: hvg
    type:
      - 'null'
      - boolean
    doc: Whether to compute highly variable genes before computing the UMAP and 
      clustering
    default: false
    inputBinding:
      position: 102
      prefix: --hvg
  - id: resolution
    type:
      - 'null'
      - float
    doc: Resolution parameter for the leiden clustering
    default: 1.0
    inputBinding:
      position: 102
      prefix: --resolution
  - id: table_key
    type:
      - 'null'
      - string
    doc: Key of the table in the `SpatialData` object to be preprocessed
    default: table
    inputBinding:
      position: 102
      prefix: --table-key
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sopa:2.1.11--pyhdfd78af_0
stdout: sopa_scanpy-preprocess.out

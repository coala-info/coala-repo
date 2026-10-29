cwlVersion: v1.2
class: CommandLineTool
baseCommand: [sopa, scanpy-preprocess]
label: nf-sopa_sopa_scanpy-preprocess
doc: "Optional scanpy table preprocessing (log1p, UMAP, leiden clustering) after aggregation/annotation\n\nTool homepage: https://gustaveroussy.github.io/sopa"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sdata)
        entryname: sdata.zarr
        writable: true
inputs:
  - id: sdata
    type: Directory
    doc: "Path to the SpatialData .zarr directory (copied into the work directory as sdata.zarr, updated in place)"
  - id: table_key
    type: ['null', string]
    doc: Key of the table in the SpatialData object to be preprocessed (default table)
    inputBinding:
      position: 2
      prefix: --table-key
  - id: resolution
    type: ['null', float]
    doc: Resolution parameter for the leiden clustering (default 1.0)
    inputBinding:
      position: 2
      prefix: --resolution
  - id: check_counts
    type: ['null', boolean]
    doc: Check that adata.X contains counts (default)
    inputBinding:
      position: 2
      prefix: --check-counts
  - id: no_check_counts
    type: ['null', boolean]
    doc: Do not check that adata.X contains counts
    inputBinding:
      position: 2
      prefix: --no-check-counts
  - id: hvg
    type: ['null', boolean]
    doc: Compute highly variable genes before computing the UMAP and clustering
    inputBinding:
      position: 2
      prefix: --hvg
  - id: no_hvg
    type: ['null', boolean]
    doc: Do not compute highly variable genes (default)
    inputBinding:
      position: 2
      prefix: --no-hvg
arguments:
  - position: 1
    valueFrom: sdata.zarr
outputs:
  - id: sdata_out
    type: Directory
    doc: The SpatialData .zarr directory with the preprocessed table
    outputBinding:
      glob: sdata.zarr
  - id: stdout
    type: stdout
    doc: Standard output
stdout: sopa_scanpy-preprocess.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sopa:2.1.11--pyhdfd78af_0

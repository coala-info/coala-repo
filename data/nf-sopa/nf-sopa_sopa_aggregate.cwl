cwlVersion: v1.2
class: CommandLineTool
baseCommand: [sopa, aggregate]
label: nf-sopa_sopa_aggregate
doc: "Create an anndata table containing the transcript count and/or the channel intensities per cell\n\nTool homepage: https://gustaveroussy.github.io/sopa"
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
  - id: aggregate_genes
    type: ['null', boolean]
    doc: Whether to aggregate the genes (counts) inside each cell
    inputBinding:
      position: 2
      prefix: --aggregate-genes
  - id: no_aggregate_genes
    type: ['null', boolean]
    doc: Do not aggregate the genes (counts) inside each cell
    inputBinding:
      position: 2
      prefix: --no-aggregate-genes
  - id: aggregate_channels
    type: ['null', boolean]
    doc: Whether to aggregate the channels (intensity) inside each cell (default no-aggregate-channels)
    inputBinding:
      position: 2
      prefix: --aggregate-channels
  - id: no_aggregate_channels
    type: ['null', boolean]
    doc: Do not aggregate the channels (intensity) inside each cell
    inputBinding:
      position: 2
      prefix: --no-aggregate-channels
  - id: expand_radius_ratio
    type: ['null', float]
    doc: Cells polygons will be expanded by expand_radius_ratio * mean_radius for channels averaging only. This helps better aggregate boundary stainings
    inputBinding:
      position: 2
      prefix: --expand-radius-ratio
  - id: min_transcripts
    type: ['null', int]
    doc: Cells with less transcript than this integer will be filtered (default 0)
    inputBinding:
      position: 2
      prefix: --min-transcripts
  - id: min_intensity_ratio
    type: ['null', float]
    doc: Cells whose mean channel intensity is less than min_intensity_ratio * quantile_90 will be filtered (default 0)
    inputBinding:
      position: 2
      prefix: --min-intensity-ratio
  - id: image_key
    type: ['null', string]
    doc: Optional image key of the SpatialData object. By default, considers the only one image
    inputBinding:
      position: 2
      prefix: --image-key
  - id: gene_column
    type: ['null', string]
    doc: Optional column of the transcript dataframe to be used as gene names. Inferred by default
    inputBinding:
      position: 2
      prefix: --gene-column
  - id: method_name
    type: ['null', string]
    doc: If segmentation was performed with a generic method, this is the name of the method used
    inputBinding:
      position: 2
      prefix: --method-name
arguments:
  - position: 1
    valueFrom: sdata.zarr
outputs:
  - id: sdata_out
    type: Directory
    doc: The SpatialData .zarr directory with the aggregated table
    outputBinding:
      glob: sdata.zarr
  - id: stdout
    type: stdout
    doc: Standard output
stdout: sopa_aggregate.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sopa:2.1.11--pyhdfd78af_0

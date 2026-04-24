cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sopa
  - aggregate
label: sopa_aggregate
doc: "Create an `anndata` table containing the transcript count and/or the channel
  intensities per cell\n\nTool homepage: https://gustaveroussy.github.io/sopa"
inputs:
  - id: sdata_path
    type: string
    doc: Path to the SpatialData `.zarr` directory
    inputBinding:
      position: 1
  - id: aggregate_channels
    type:
      - 'null'
      - boolean
    doc: Whether to aggregate the channels (intensity) inside each cell
    inputBinding:
      position: 102
      prefix: --aggregate-channels
  - id: aggregate_genes
    type:
      - 'null'
      - boolean
    doc: Whether to aggregate the genes (counts) inside each cell
    inputBinding:
      position: 102
      prefix: --aggregate-genes
  - id: expand_radius_ratio
    type:
      - 'null'
      - float
    doc: Cells polygons will be expanded by `expand_radius_ratio * mean_radius` 
      for channels averaging **only**. This help better aggregate boundary 
      stainings
    inputBinding:
      position: 102
      prefix: --expand-radius-ratio
  - id: gene_column
    type:
      - 'null'
      - string
    doc: Optional column of the transcript dataframe to be used as gene names. 
      Inferred by default.
    inputBinding:
      position: 102
      prefix: --gene-column
  - id: image_key
    type:
      - 'null'
      - string
    doc: Optional image key of the SpatialData object. By default, considers the
      only one image. It can be useful if another image is added later on
    inputBinding:
      position: 102
      prefix: --image-key
  - id: method_name
    type:
      - 'null'
      - string
    doc: If segmentation was performed with a generic method, this is the name 
      of the method used.
    inputBinding:
      position: 102
      prefix: --method-name
  - id: min_intensity_ratio
    type:
      - 'null'
      - float
    doc: Cells whose mean channel intensity is less than `min_intensity_ratio * 
      quantile_90` will be filtered
    inputBinding:
      position: 102
      prefix: --min-intensity-ratio
  - id: min_transcripts
    type:
      - 'null'
      - int
    doc: Cells with less transcript than this integer will be filtered
    inputBinding:
      position: 102
      prefix: --min-transcripts
  - id: no_aggregate_channels
    type:
      - 'null'
      - boolean
    doc: Whether to aggregate the channels (intensity) inside each cell
    inputBinding:
      position: 102
      prefix: --no-aggregate-channels
  - id: no_aggregate_genes
    type:
      - 'null'
      - boolean
    doc: Whether to aggregate the genes (counts) inside each cell
    inputBinding:
      position: 102
      prefix: --no-aggregate-genes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sopa:2.1.11--pyhdfd78af_0
stdout: sopa_aggregate.out

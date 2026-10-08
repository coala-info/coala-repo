cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vpt
  - run-segmentation-on-tile
label: vpt_run-segmentation-on-tile
doc: "Executes the segmentation algorithm on a specific tile of the mosaic images.
  This functionality is intended both for visualizing a preview of the segmentation
  (run only one tile), and for distributing jobs using an orchestration tool such
  as Nextflow.\n\nTool homepage: https://github.com/Vizgen/vizgen-postprocessing"
inputs:
  - id: input_segmentation_parameters
    type: File
    doc: Json file generate by --prepare-segmentation that fully specifies the 
      segmentation to run
    inputBinding:
      position: 101
      prefix: --input-segmentation-parameters
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Set flag if you want to use non empty directory and agree that files 
      can be over-written.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: tile_index
    type: int
    doc: Index of the tile to run the segmentation on
    inputBinding:
      position: 101
      prefix: --tile-index
  - id: input_images
    type:
      - 'null'
      - Directory
    doc: Directory with the mosaic tiff images named in the specification json. 
      It is staged in the working directory so that relative image paths in the 
      specification resolve.
outputs:
  - id: tile_results
    type:
      type: array
      items: File
    doc: Per-tile segmentation parquet files, written to the output path of the 
      specification, in a folder named by run_on_tile_dir.
    outputBinding:
      glob: '*/*/*.parquet'
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_images)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0
stdout: vpt_run-segmentation-on-tile.out

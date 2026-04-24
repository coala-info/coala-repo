cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vpt
  - run-segmentation
label: vpt_run-segmentation
doc: "Top-level interface for this CLI which invokes the segmentation functionality
  of the tool. It is intended for users who would like to run the program with minimal
  additional configuration. Specifically, it executes: prepare-segmentation, run-segmentation-on-tile,
  and compile-tile-segmentation.\n\nTool homepage: https://github.com/Vizgen/vizgen-postprocessing"
inputs:
  - id: input_images
    type: File
    doc: 'Input images can be specified in one of three ways: 1. The path to a directory
      of tiff files, if the files are named by the MERSCOPE convention. Example: /path/to/files/
      2. The path to a directory of tiff files including a python formatting string
      specifying the file name. The format string must specify values for "stain"
      and "z". Example: /path/to/files/image_{stain}_z{z}.tif 3. A regular expression
      matching the tiff files to be used, where the regular expression specifies values
      for "stain" and "z". Example: /path/to/files/mosaic_(?P<stain>[\w|-]+)_z(?P<z>[0-9]+).tif
      In all cases, the values for "stain" and "z" must match the stains and z indexes
      specified in the segmentation algorithm.'
    inputBinding:
      position: 101
      prefix: --input-images
  - id: input_micron_to_mosaic
    type: File
    doc: Path to the micron to mosaic pixel transformation matrix.
    inputBinding:
      position: 101
      prefix: --input-micron-to-mosaic
  - id: max_row_group_size
    type:
      - 'null'
      - int
    doc: Maximum number of rows in row groups inside output parquet files. 
      Cannot be less than 1000
    inputBinding:
      position: 101
      prefix: --max-row-group-size
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Set flag if you want to use non empty directory and agree that files 
      can be over-written.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: segmentation_algorithm
    type: File
    doc: Path to a json file that fully specifies the segmentation algorithm to 
      use, including algorithm name, any algorithm specific parameters 
      (including path to weights for new model), stains corresponding to each 
      channel in the algorithm.
    inputBinding:
      position: 101
      prefix: --segmentation-algorithm
  - id: tile_overlap
    type:
      - 'null'
      - string
    doc: Overlap between adjacent tiles.
    inputBinding:
      position: 101
      prefix: --tile-overlap
  - id: tile_size
    type:
      - 'null'
      - int
    doc: Number of pixels for the width and height of each tile. Each tile is 
      created as a square.
    inputBinding:
      position: 101
      prefix: --tile-size
outputs:
  - id: output_path
    type: Directory
    doc: Directory where the segmentation specification json file will be saved 
      as segmentation_specification.json and where the final segmentation 
      results will be saved.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0

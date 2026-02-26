cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vpt
  - prepare-segmentation
label: vpt_prepare-segmentation
doc: "Generates a segmentation specification json file to be used for cell segmentation
  tasks. The segmentation specification json includes specification for the algorithm
  to run, the paths for all images for each stain for each z index, the micron to
  mosaic pixel transformation matrix, the number of tiles, and the window coordinates
  for each tile.\n\nTool homepage: https://github.com/Vizgen/vizgen-postprocessing"
inputs:
  - id: input_images
    type: string
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
    default: 10% of tile-size
    inputBinding:
      position: 101
      prefix: --tile-overlap
  - id: tile_size
    type:
      - 'null'
      - int
    doc: Number of pixels for the width and height of each tile. Each tile is 
      created as a square.
    default: 4096
    inputBinding:
      position: 101
      prefix: --tile-size
outputs:
  - id: output_path
    type: Directory
    doc: Path where the segmentation specification json file will be saved.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vpt
  - extract-image-patch
label: vpt_extract-image-patch
doc: "Extracts a patch of specified coordinates and channels from the 16-bit mosaic
  tiff images produced by the MERSCOPE as an 8-bit RGB PNG file\n\nTool homepage:
  https://github.com/Vizgen/vizgen-postprocessing"
inputs:
  - id: blue_stain_name
    type:
      - 'null'
      - string
    doc: The name of the stain that will be used for the blue channel of the 
      patch.
    inputBinding:
      position: 101
      prefix: --blue-stain-name
  - id: center_x
    type: float
    doc: MERSCOPE Vizualizer X coordinate in micron space that will serve as the
      center of the saved PNG patch
    inputBinding:
      position: 101
      prefix: --center-x
  - id: center_y
    type: float
    doc: MERSCOPE Vizualizer Y coordinate in micron space that will serve as the
      center of the saved PNG patch
    inputBinding:
      position: 101
      prefix: --center-y
  - id: green_stain_name
    type: string
    doc: The name of the stain that will be used for the green channel of the 
      patch
    inputBinding:
      position: 101
      prefix: --green-stain-name
  - id: input_images
    type: Directory
    doc: 'Input images can be specified in one of three ways: 1. The path to a directory
      of tiff files, if the files are named by the MERSCOPE convention. Example: /path/to/files/
      2. The path to a directory of tiff files including a python formatting string
      specifying the file name. The format string must specify values for "stain"
      and "z". Example: /path/to/files/image_{stain}_z{z}.tif 3. A regular expression
      matching the tiff files to be used, where the regular expression specifies values
      for "stain" and "z". Example: /path/to/files/mosaic_(?P<stain>[\w| -]+)_z(?P<z>[0-9]+).tif
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
  - id: input_z_index
    type:
      - 'null'
      - int
    doc: The Z plane of the mosaic tiff images to use for the patch.
    inputBinding:
      position: 101
      prefix: --input-z-index
  - id: normalization
    type:
      - 'null'
      - string
    doc: The name of the normalization method that will be used on each channel 
      of the patch.
    inputBinding:
      position: 101
      prefix: --normalization
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Set flag if you want to use non empty directory and agree that files 
      can be over-written.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: red_stain_name
    type:
      - 'null'
      - string
    doc: The name of the stain that will be used for the red channel of the 
      patch.
    inputBinding:
      position: 101
      prefix: --red-stain-name
  - id: size_x
    type:
      - 'null'
      - float
    doc: Number of microns for the width of the patch.
    inputBinding:
      position: 101
      prefix: --size-x
  - id: size_y
    type:
      - 'null'
      - float
    doc: Number of microns for the height of the patch.
    inputBinding:
      position: 101
      prefix: --size-y
outputs:
  - id: output_patch
    type: File
    doc: Path to the patch PNG file, will append .png to the end if not included
      in file name.
    outputBinding:
      glob: $(inputs.output_patch)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0

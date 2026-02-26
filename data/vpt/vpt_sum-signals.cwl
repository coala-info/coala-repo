cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vpt
  - sum-signals
label: vpt_sum-signals
doc: "Uses the segmentation boundaries to find the intensity of each mosaic image
  in each Entity. Outputs both the summed intensity of the raw images and the summed
  intensity of high-pass filtered images (reduces the effect of background fluorescence).\n\
  \nTool homepage: https://github.com/Vizgen/vizgen-postprocessing"
inputs:
  - id: input_boundaries
    type: File
    doc: Path to a micron-space .parquet boundary file.
    inputBinding:
      position: 101
      prefix: --input-boundaries
  - id: input_images
    type: Directory
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
    doc: Set true if you want to use non empty directory and agree that files 
      can be overwritten.
    inputBinding:
      position: 101
      prefix: --overwrite
outputs:
  - id: output_csv
    type: File
    doc: Path to the csv file where the sum intensities will be stored.
    outputBinding:
      glob: $(inputs.output_csv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0

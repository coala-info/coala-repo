cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vpt
  - convert-to-rgb-ome
label: vpt_convert-to-rgb-ome
doc: "Converts up to three flat tiff images into a rgb OME-tiff pyramidal images.
  If a rgb channel input isn’t specified, the channel will be dark (all 0’s).\n\n\
  Tool homepage: https://github.com/Vizgen/vizgen-postprocessing"
inputs:
  - id: input_image_blue
    type:
      - 'null'
      - File
    doc: Either a path to a directory or a path to a specific file
    inputBinding:
      position: 101
      prefix: --input-image-blue
  - id: input_image_green
    type:
      - 'null'
      - File
    doc: Either a path to a directory or a path to a specific file
    inputBinding:
      position: 101
      prefix: --input-image-green
  - id: input_image_red
    type:
      - 'null'
      - File
    doc: Either a path to a directory or a path to a specific file
    inputBinding:
      position: 101
      prefix: --input-image-red
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: output_image_path
    type: string
    doc: Output or path parameter `output_image_path`
    inputBinding:
      position: 102
      prefix: --output-image
outputs:
  - id: output_image
    type: File
    doc: Either a path to a directory or a path to a specific file
    outputBinding:
      glob: $(inputs.output_image_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0

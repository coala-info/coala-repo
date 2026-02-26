cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vpt
  - convert-to-ome
label: vpt_convert-to-ome
doc: "Transforms the large 16-bit mosaic tiff images produced by the MERSCOPE into
  a OME pyramidal tiff.\n\nTool homepage: https://github.com/Vizgen/vizgen-postprocessing"
inputs:
  - id: input_image
    type: File
    doc: Either a path to a directory or a path to a specific file.
    inputBinding:
      position: 101
      prefix: --input-image
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Set flag if you want to use non empty directory and agree that files 
      can be over-written.
    inputBinding:
      position: 101
      prefix: --overwrite
outputs:
  - id: output_image
    type:
      - 'null'
      - File
    doc: Either a path to a directory or a path to a specific file.
    outputBinding:
      glob: $(inputs.output_image)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vpt:1.3.0--pyhdfd78af_0

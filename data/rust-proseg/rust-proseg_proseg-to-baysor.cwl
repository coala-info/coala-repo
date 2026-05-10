cwlVersion: v1.2
class: CommandLineTool
baseCommand: proseg-to-baysor
label: rust-proseg_proseg-to-baysor
doc: "Convert proseg output to Baysor-compatible output.\n\nTool homepage: https://github.com/dcjones/proseg"
inputs:
  - id: transcript_metadata
    type: File
    inputBinding:
      position: 1
  - id: cell_polygons
    type: File
    inputBinding:
      position: 2
  - id: output_cell_polygons_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_cell_polygons_path`
    inputBinding:
      position: 101
      prefix: --output-cell-polygons
  - id: output_transcript_metadata_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_transcript_metadata_path`
    inputBinding:
      position: 102
      prefix: --output-transcript-metadata
outputs:
  - id: output_transcript_metadata
    type:
      - 'null'
      - File
    outputBinding:
      glob: $(inputs.output_transcript_metadata_path)
  - id: output_cell_polygons
    type:
      - 'null'
      - File
    outputBinding:
      glob: $(inputs.output_cell_polygons_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-proseg:2.0.6--h4349ce8_0

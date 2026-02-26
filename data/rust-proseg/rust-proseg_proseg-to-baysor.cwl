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
outputs:
  - id: output_transcript_metadata
    type:
      - 'null'
      - File
    outputBinding:
      glob: $(inputs.output_transcript_metadata)
  - id: output_cell_polygons
    type:
      - 'null'
      - File
    outputBinding:
      glob: $(inputs.output_cell_polygons)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-proseg:2.0.6--h4349ce8_0

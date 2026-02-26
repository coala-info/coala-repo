cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools_median
label: wiggletools_median
doc: "Calculates the median of wiggle tracks.\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
inputs:
  - id: input_tracks
    type:
      type: array
      items: File
    doc: Input wiggle tracks
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10

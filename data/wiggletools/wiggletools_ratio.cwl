cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools_ratio
label: wiggletools_ratio
doc: "Calculates the ratio of two wiggle files.\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
inputs:
  - id: wiggle_file1
    type: File
    doc: The first wiggle file.
    inputBinding:
      position: 1
  - id: wiggle_file2
    type: File
    doc: The second wiggle file.
    inputBinding:
      position: 2
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress output using gzip.
    inputBinding:
      position: 103
      prefix: --compress
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name. If not specified, output to stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10

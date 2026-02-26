cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdst_matrix
label: cdst_matrix
doc: "Generate a matrix from JSON input.\n\nTool homepage: https://github.com/l1-mh/CDST"
inputs:
  - id: json_file
    type: File
    doc: Input JSON file of MD5 hash lists
    inputBinding:
      position: 101
      prefix: --json
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdst:0.2.1--pyhdfd78af_0

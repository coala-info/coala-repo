cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - lorikeet.jar
  - multi-typing
label: lorikeet_multi-type
doc: "Performs multi-typing analysis using spoligotype files.\n\nTool homepage: https://github.com/AbeelLab/lorikeet"
inputs:
  - id: file_pattern
    type:
      - 'null'
      - string
    doc: File name pattern for the input files.
    default: .*.spoligotype]
    inputBinding:
      position: 101
      prefix: --pattern
  - id: input_directory
    type:
      type: array
      items: Directory
    doc: Input directory that contains all spoligotype files. You can specify 
      multiple -i arguments
    inputBinding:
      position: 101
      prefix: --input
  - id: output_prefix
    type: string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: --output
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Search input directories recursively
    default: true
    inputBinding:
      position: 101
      prefix: --recursive
  - id: threshold
    type:
      - 'null'
      - float
    doc: Minimum threshold
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorikeet:20--hdfd78af_1
stdout: lorikeet_multi-type.out

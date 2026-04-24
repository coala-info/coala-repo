cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - lorikeet.jar
  - merge-spoligotypes
label: lorikeet_merge-spoligotypes
doc: "Merges spoligotype files from input directories.\n\nTool homepage: https://github.com/AbeelLab/lorikeet"
inputs:
  - id: file_pattern
    type:
      - 'null'
      - string
    doc: File name pattern for the input files.
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
    inputBinding:
      position: 101
      prefix: --recursive
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorikeet:20--hdfd78af_1
stdout: lorikeet_merge-spoligotypes.out

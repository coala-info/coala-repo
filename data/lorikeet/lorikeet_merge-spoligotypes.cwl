cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lorikeet
  - merge-spoligotypes
label: lorikeet_merge-spoligotypes
doc: "Merge multiple spoligotype files together in a single file.\n\nTool homepage: https://github.com/AbeelLab/lorikeet"
inputs:
  - id: input_directory
    type:
      type: array
      items: Directory
      inputBinding:
        prefix: --input
    doc: Input directory that contains all spoligotype files. You can specify multiple -i arguments
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: Output prefix
    inputBinding:
      position: 2
      prefix: --output
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Search input directories recursively [Default=true]
    inputBinding:
      position: 3
      prefix: --recursive
  - id: file_pattern
    type:
      - 'null'
      - string
    doc: File name pattern for the input files. [Default=".*.spoligotype]"
    inputBinding:
      position: 4
      prefix: --pattern
outputs:
  - id: output_prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output_prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: JAVA_TOOL_OPTIONS
        envValue: -XX:-UseContainerSupport
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorikeet:20--hdfd78af_1

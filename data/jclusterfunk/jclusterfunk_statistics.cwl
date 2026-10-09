cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jclusterfunk
  - statistics
label: jclusterfunk_statistics
doc: "Extract statistics and information from trees.\n\nTool homepage: https://github.com/snake-flu/jclusterfunk"
inputs:
  - id: input_file
    type: File
    doc: input tree file
    inputBinding:
      position: 101
      prefix: --input
  - id: stats
    type: boolean
    default: true
    doc: a list of statistics to include in the output (see docs for details)
    inputBinding:
      position: 101
      prefix: --stats
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: write analysis details to console
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_file_path
    type: string
    doc: output file
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_file
    type: File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0

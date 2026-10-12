cwlVersion: v1.2
class: CommandLineTool
baseCommand: addVariants.py
label: paragraph_addVariants.py
doc: 'Add new variants into a graph as nodes/edges.\n\nTool homepage: https://github.com/Illumina/paragraph'
inputs:
  - id: graph
    type: File
    doc: 'Input graph JSON file'
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: 'Output JSON file'
    inputBinding:
      position: 2
  - id: variants
    type:
      - 'null'
      - File
    doc: 'JSON file with variant calls to use instead of calls in input graph'
    inputBinding:
      position: 101
      prefix: --variants
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'More logging'
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: 'Output JSON file'
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paragraph:2.3--h8908b6f_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand: paragraph2dot.py
label: paragraph_paragraph2dot.py
doc: 'Convert a paragraph graph or output JSON file into a graphviz dot file.\n\nTool homepage: https://github.com/Illumina/paragraph'
inputs:
  - id: input
    type: File
    doc: 'Input paragraph JSON file'
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: 'Output dot file'
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: 'Output dot file'
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/paragraph:2.3--h8908b6f_0

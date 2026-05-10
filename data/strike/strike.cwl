cwlVersion: v1.2
class: CommandLineTool
baseCommand: strike
label: strike
doc: "v1.2\n\nTool homepage: http://www.tcoffee.org/Projects/strike/index.html"
inputs:
  - id: alignment_file
    type: File
    doc: Alignment File
    inputBinding:
      position: 101
      prefix: --alignment
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Normalizes the score
    inputBinding:
      position: 101
      prefix: --normalize
  - id: template_file
    type: File
    doc: Connection File
    inputBinding:
      position: 101
      prefix: --template_file
  - id: out_file_path
    type: string
    doc: Output or path parameter `out_file_path`
    inputBinding:
      position: 102
      prefix: --out-file
outputs:
  - id: out_file
    type: File
    doc: The file where the results will be saved
    outputBinding:
      glob: $(inputs.out_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strike:1.2--h9948957_6

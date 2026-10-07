cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cressent
  - tanglegram
label: cressent_tanglegram
doc: "Generate a tanglegram from two phylogenetic trees.\n\nTool homepage: https://github.com/ricrocha82/cressent"
inputs:
  - id: tree1
    type: File
    doc: "Path to the first tree file."
    inputBinding:
      position: 101
      prefix: --tree1
  - id: tree2
    type: File
    doc: "Path to the second tree file."
    inputBinding:
      position: 101
      prefix: --tree2
  - id: label1
    type: string
    doc: "Label for the first tree in the tanglegram."
    inputBinding:
      position: 101
      prefix: --label1
  - id: label2
    type: string
    doc: "Label for the second tree in the tanglegram."
    inputBinding:
      position: 101
      prefix: --label2
  - id: output_dir
    type: string
    doc: "Path to the output directory (created by the tool; collected as the output)"
    inputBinding:
      position: 101
      prefix: --output
  - id: name_tanglegram
    type:
      - 'null'
      - string
    doc: "Name of the tanglegram PDF file (default: tanglegram.pdf)"
    inputBinding:
      position: 101
      prefix: --name_tanglegram
  - id: width
    type:
      - 'null'
      - float
    doc: "Width of the tanglegram (default = 20)"
    inputBinding:
      position: 101
      prefix: --width
  - id: height
    type:
      - 'null'
      - float
    doc: "Height of the tanglegram (default = 11)"
    inputBinding:
      position: 101
      prefix: --height
  - id: lab_cex
    type:
      - 'null'
      - float
    doc: "cex size of the labels (default = 1.5)"
    inputBinding:
      position: 101
      prefix: --lab_cex
outputs:
  - id: output
    type: Directory
    doc: Output directory with all result files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0

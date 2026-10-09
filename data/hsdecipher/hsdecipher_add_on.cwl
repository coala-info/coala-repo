cwlVersion: v1.2
class: CommandLineTool
baseCommand: HSD_add_on.py
label: hsdecipher_add_on
doc: "Add HSDs found at a later threshold on to HSDs found at a former threshold, removing redundant candidates\n\nTool homepage: https://github.com/zx0223winner/HSDecipher"
inputs:
  - id: input_file
    type: File
    doc: your HSD file
    inputBinding:
      position: 101
      prefix: --input_file=
      separate: false
  - id: adding_file
    type: File
    doc: HSDs to be added
    inputBinding:
      position: 101
      prefix: --adding_file=
      separate: false
  - id: output_file
    type: string
    doc: output file name
    inputBinding:
      position: 102
      prefix: --output_file=
      separate: false
outputs:
  - id: result_file
    type: File
    doc: combined HSD file
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hsdecipher:1.1.2--hdfd78af_0

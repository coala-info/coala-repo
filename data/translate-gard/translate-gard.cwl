cwlVersion: v1.2
class: CommandLineTool
baseCommand: translate-gard
label: translate-gard
doc: "Translate GARD output to a different format.\n\nTool homepage: https://github.com/veg/translate-gard/"
inputs:
  - id: input_filename
    type: File
    doc: input filename (like CD2.nex.GARD.csv)
    inputBinding:
      position: 101
      prefix: -i
  - id: json_filename
    type: File
    doc: json filename (like CD2.nex.out.json
    inputBinding:
      position: 101
      prefix: -j
  - id: output_filename_path
    type: string
    doc: Output or path parameter `output_filename_path`
    inputBinding:
      position: 102
      prefix: --output-filename
outputs:
  - id: output_filename
    type: File
    doc: output filename
    outputBinding:
      glob: $(inputs.output_filename_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/translate-gard:1.0.4--0

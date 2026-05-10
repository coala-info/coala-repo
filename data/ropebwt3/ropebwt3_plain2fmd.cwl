cwlVersion: v1.2
class: CommandLineTool
baseCommand: ropebwt3_plain2fmd
label: ropebwt3_plain2fmd
doc: "Convert plain text to FM-index\n\nTool homepage: https://github.com/lh3/ropebwt3"
inputs:
  - id: input_file
    type: File
    doc: Input plain text file
    inputBinding:
      position: 1
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 101
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output FM-index file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0

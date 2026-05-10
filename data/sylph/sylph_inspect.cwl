cwlVersion: v1.2
class: CommandLineTool
baseCommand: sylph inspect
label: sylph_inspect
doc: "Inspect sketched .syldb and .sylsp files\n\nTool homepage: https://github.com/bluenote-1577/sylph"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Pre-sketched *.syldb/*.sylsp files.
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
    doc: Output to this file (YAML format).
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sylph:0.9.0--ha6fb395_0

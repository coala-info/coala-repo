cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kronos
  - make_config
label: kronos_make_config
doc: "make a template config file\n\nTool homepage: https://github.com/jtaghiyar/kronos"
inputs:
  - id: components
    type:
      type: array
      items: string
    doc: list of component names
    inputBinding:
      position: 1
  - id: output_filename_path
    type: string
    doc: Output or path parameter `output_filename_path`
    inputBinding:
      position: 101
      prefix: --output-filename
outputs:
  - id: output_filename
    type: File
    doc: a name for the resultant config file
    outputBinding:
      glob: $(inputs.output_filename_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kronos:2.3.0--py_0

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
outputs:
  - id: output_filename
    type: File
    doc: a name for the resultant config file
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kronos:2.3.0--py_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kronos
  - make_component
label: kronos_make_component
doc: "make a template component\n\nTool homepage: https://github.com/jtaghiyar/kronos"
inputs:
  - id: component_name
    type: string
    doc: a name for the component to be generated
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kronos:2.3.0--py_0
stdout: kronos_make_component.out

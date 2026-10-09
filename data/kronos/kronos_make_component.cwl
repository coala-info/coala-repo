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
  - id: component_dir
    type: Directory
    doc: The generated component template directory
    outputBinding:
      glob: $(inputs.component_name)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: kronos
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kronos:2.3.0--py_0
stdout: kronos_make_component.out

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
  - id: component_dirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Component directories (made with make_component) staged into the working directory so the components can be imported
  - id: output_filename_path
    type: string
    inputBinding:
      position: 101
      prefix: --output_filename
outputs:
  - id: output_filename
    type: File
    doc: a name for the resultant config file
    outputBinding:
      glob: $(inputs.output_filename_path)*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.component_dirs ? inputs.component_dirs : [])"
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: kronos
      - envName: PYTHONPATH
        envValue: $(runtime.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kronos:2.3.0--py_0

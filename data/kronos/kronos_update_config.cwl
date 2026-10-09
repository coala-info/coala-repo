cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kronos
  - update_config
label: kronos_update_config
doc: "update the fields of a config file based on the ones from another one\n\nTool
  homepage: https://github.com/jtaghiyar/kronos"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: paths to the config files, e.g. update_config <old_config.yaml> 
      <new_config.yaml>
    inputBinding:
      position: 1
  - id: output_filename_path
    type: string
    inputBinding:
      position: 101
      prefix: --output_filename
outputs:
  - id: output_filename
    type: File
    doc: a name for the output file
    outputBinding:
      glob: $(inputs.output_filename_path)*
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: USER
        envValue: kronos
      - envName: PYTHONPATH
        envValue: $(runtime.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kronos:2.3.0--py_0

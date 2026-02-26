cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyqi
  - make-bash-completion
label: pyqi_make-bash-completion
doc: "Construct a bash tab completion script that will search through available commands
  and options\n\nTool homepage: https://github.com/qir-alliance/pyqir"
inputs:
  - id: command_config_module
    type: string
    doc: CLI command configuration module
    inputBinding:
      position: 101
      prefix: --command-config-module
  - id: driver_name
    type: string
    doc: name of the driver script
    inputBinding:
      position: 101
      prefix: --driver-name
outputs:
  - id: output_fp
    type: File
    doc: output filepath
    outputBinding:
      glob: $(inputs.output_fp)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyqi:0.3.2--py27_1

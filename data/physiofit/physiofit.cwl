cwlVersion: v1.2
class: CommandLineTool
baseCommand: Physiofit
label: physiofit
doc: "Extracellular flux estimation software\n\nTool homepage: https://github.com/MetaSys-LISBP/PhysioFit"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Path to config file in yaml format
    inputBinding:
      position: 101
      prefix: --config
  - id: data
    type:
      - 'null'
      - File
    doc: Path to data file in tabulated format (txt or tsv)
    inputBinding:
      position: 101
      prefix: --data
  - id: debug_mode
    type:
      - 'null'
      - boolean
    doc: Activate the debug logs
    inputBinding:
      position: 101
      prefix: --debug_mode
  - id: galaxy
    type:
      - 'null'
      - boolean
    doc: Is the CLI being used on the galaxy platform
    inputBinding:
      position: 101
      prefix: --galaxy
  - id: list_models
    type:
      - 'null'
      - boolean
    doc: Return the list of models in model folder
    inputBinding:
      position: 101
      prefix: --list
  - id: model
    type:
      - 'null'
      - string
    doc: Which model should be chosen. Useful only if generating related config 
      file
    inputBinding:
      position: 101
      prefix: --model
outputs:
  - id: output_config
    type:
      - 'null'
      - File
    doc: Path to output the yaml config file
    outputBinding:
      glob: $(inputs.output_config)
  - id: output_recap
    type:
      - 'null'
      - File
    doc: Path to output the summary
    outputBinding:
      glob: $(inputs.output_recap)
  - id: output_zip
    type:
      - 'null'
      - File
    doc: Path to export zip file
    outputBinding:
      glob: $(inputs.output_zip)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physiofit:3.4.0--pyhdfd78af_0

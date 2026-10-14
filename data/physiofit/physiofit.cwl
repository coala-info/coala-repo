cwlVersion: v1.2
class: CommandLineTool
baseCommand: physiofit
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
    doc: Path to data file in tabulated format (txt or tsv). Results are
      written beside it, so it is staged writable.
    inputBinding:
      position: 101
      prefix: --data
      valueFrom: $(self.basename)
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
  - id: output_config_path
    type:
      - 'null'
      - string
    doc: Existing directory in which config_file.yml is written (use '.')
    inputBinding:
      position: 102
      prefix: --output_config
  - id: output_recap_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 103
      prefix: --output_recap
  - id: output_zip_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 104
      prefix: --output_zip
outputs:
  - id: output_config
    type:
      - 'null'
      - File
    doc: The yaml config file (config_file.yml)
    outputBinding:
      glob: $(inputs.output_config_path)/config_file.yml
  - id: output_recap
    type:
      - 'null'
      - File
    doc: Path to output the summary (galaxy mode)
    outputBinding:
      glob: $(inputs.output_recap_path)
  - id: results_dir
    type:
      - 'null'
      - Directory
    doc: Results folder (<working dir name>_res) with one sub-folder per experiment
    outputBinding:
      glob: '*_res'
  - id: output_zip
    type:
      - 'null'
      - File
    doc: Path to export zip file
    outputBinding:
      glob: $(inputs.output_zip_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.data)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physiofit:3.4.0--pyhdfd78af_0

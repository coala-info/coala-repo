cwlVersion: v1.2
class: CommandLineTool
baseCommand: saqc
label: saqc
doc: "saqc\n\nTool homepage: https://github.com/Helmholtz-UFZ/saqc"
inputs:
  - id: config_file
    type: File
    doc: Path to a configuration file. Use a '.json' extension to provide a 
      JSON-configuration. Otherwise files are treated as CSV.
    inputBinding:
      position: 101
      prefix: --config
  - id: data_file
    type: File
    doc: Path to a data file.
    inputBinding:
      position: 101
      prefix: --data
  - id: json_field
    type:
      - 'null'
      - string
    doc: Use the value from the given FIELD from the root object of a json file.
      The value must hold a array of saqc tests. If the option is not given, a 
      passed JSON config is assumed to have an array of saqc tests as root 
      element.
    inputBinding:
      position: 101
      prefix: --json-field
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set log verbosity.
    inputBinding:
      position: 101
      prefix: --log-level
  - id: nodata
    type:
      - 'null'
      - float
    doc: Set a custom nodata value.
    inputBinding:
      position: 101
      prefix: --nodata
  - id: scheme
    type:
      - 'null'
      - string
    doc: A flagging scheme to use.
    inputBinding:
      position: 101
      prefix: --scheme
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Path to a output file.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/saqc:2.6.0

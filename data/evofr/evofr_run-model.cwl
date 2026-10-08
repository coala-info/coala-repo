cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - evofr
  - run-model
label: evofr_run-model
doc: "Run an evofr model using a configuration file and optional data overrides.\n\
  \nTool homepage: https://github.com/blab/evofr"
inputs:
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Data files named in the YAML configuration (for example raw_seq_path);
      staged in the working directory so relative names in the config resolve.
  - id: cases_path
    type:
      - 'null'
      - File
    doc: Optional case data override
    inputBinding:
      position: 101
      prefix: --cases-path
  - id: config
    type: File
    doc: Path to YAML configuration file
    inputBinding:
      position: 101
      prefix: --config
  - id: pivot
    type:
      - 'null'
      - string
    doc: Optional variant pivot override
    inputBinding:
      position: 101
      prefix: --pivot
  - id: seq_path
    type:
      - 'null'
      - File
    doc: Optional sequence data override
    inputBinding:
      position: 101
      prefix: --seq-path
  - id: export_path_path
    type:
      - 'null'
      - string
    doc: Optional export directory override
    inputBinding:
      position: 102
      prefix: --export-path
outputs:
  - id: export_path
    type:
      - 'null'
      - Directory
    doc: Optional export directory override
    outputBinding:
      glob: $(inputs.export_path_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.data_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evofr:0.2.0--pyhdfd78af_0

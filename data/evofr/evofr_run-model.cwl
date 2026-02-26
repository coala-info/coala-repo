cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - evofr
  - run-model
label: evofr_run-model
doc: "Run an evofr model using a configuration file and optional data overrides.\n\
  \nTool homepage: https://github.com/blab/evofr"
inputs:
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
outputs:
  - id: export_path
    type:
      - 'null'
      - Directory
    doc: Optional export directory override
    outputBinding:
      glob: $(inputs.export_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evofr:0.2.0--pyhdfd78af_0

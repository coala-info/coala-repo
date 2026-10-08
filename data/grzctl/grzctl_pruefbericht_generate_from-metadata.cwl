cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grzctl
  - pruefbericht
  - generate
  - from-metadata
label: grzctl_pruefbericht_generate_from-metadata
doc: "Generate Prüfbericht from metadata.json\n\nTool homepage: https://github.com/BfArM-MVH/grz-tools"
inputs:
  - id: fail
    type:
      - 'null'
      - boolean
    doc: Fail an otherwise valid submission (e.g. failed internal QC)
    inputBinding:
      position: 101
      prefix: --fail
  - id: pass_flag
    type:
      - 'null'
      - boolean
    doc: Pass the submission (default)
    inputBinding:
      position: 101
      prefix: --pass
  - id: metadata_file
    type: File
    doc: Path to the submission metadata.json
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the Pruefbericht JSON)
  - id: stderr
    type: stderr
    doc: Log messages of the command
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
stdout: grzctl_pruefbericht_generate_from-metadata.json
stderr: grzctl_pruefbericht_generate_from-metadata.log

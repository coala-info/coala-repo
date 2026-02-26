cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur_measurements
label: augur_measurements
doc: "Create JSON files suitable for visualization within the measurements panel of
  Auspice.\n\nTool homepage: https://github.com/nextstrain/augur"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to run. Available subcommands: export, concat'
    inputBinding:
      position: 1
  - id: concat
    type:
      - 'null'
      - boolean
    doc: Concatenate multiple measurements JSONs into a single JSON file
    inputBinding:
      position: 102
  - id: export
    type:
      - 'null'
      - boolean
    doc: Export a measurements JSON for a single collection
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
stdout: augur_measurements.out

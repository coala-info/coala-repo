cwlVersion: v1.2
class: CommandLineTool
baseCommand: augur export
label: augur_export
doc: "Export JSON files suitable for visualization with auspice.\n\nTool homepage:
  https://github.com/nextstrain/augur"
inputs:
  - id: json_version
    type: string
    doc: Define the JSON version you want, e.g. `augur export v2`.
    inputBinding:
      position: 1
  - id: v1
    type:
      - 'null'
      - boolean
    doc: Export version 1 JSON schema (separate meta and tree JSONs) for 
      visualization with Auspice
    inputBinding:
      position: 102
  - id: v2
    type:
      - 'null'
      - boolean
    doc: Export version 2 JSON schema for visualization with Auspice
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augur:33.0.0--pyhdfd78af_0
stdout: augur_export.out

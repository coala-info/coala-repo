cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grzctl
  - list
label: grzctl_list
doc: "List resources managed by grzctl\n\nTool homepage: https://github.com/BfArM-MVH/grz-tools"
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: Path to the configuration file
    inputBinding:
      position: 101
      prefix: --config-file
  - id: hide_cleaned
    type:
      - 'null'
      - boolean
    doc: Hide cleaned submissions.
    inputBinding:
      position: 101
      prefix: --hide-cleaned
  - id: json
    type:
      - 'null'
      - boolean
    doc: Output JSON for machine-readability.
    inputBinding:
      position: 101
      prefix: --json
  - id: limit
    type:
      - 'null'
      - int
    doc: Maximum number of submissions to list
    inputBinding:
      position: 101
      prefix: --limit
  - id: show_cleaned
    type:
      - 'null'
      - boolean
    doc: Show cleaned submissions.
    inputBinding:
      position: 101
      prefix: --show-cleaned
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grzctl:1.4.0--pyhdfd78af_0
stdout: grzctl_list.out

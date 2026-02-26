cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bacpage
  - setup
label: bacpage_setup
doc: "Set up project directory for analysis.\n\nTool homepage: https://github.com/CholGen/bacpage"
inputs:
  - id: directory
    type: Directory
    doc: Location to create project directory
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Generate directory wihtout checking if it is empty.
    inputBinding:
      position: 102
      prefix: --force
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not display helpful messages during creation.
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bacpage:2025.08.21--pyhdfd78af_0
stdout: bacpage_setup.out

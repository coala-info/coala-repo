cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mehari
  - server
label: mehari_server
doc: "Server related commands\n\nTool homepage: https://github.com/bihealth/mehari"
inputs:
  - id: command
    type: string
    doc: Command to run (run, schema, help)
    inputBinding:
      position: 1
  - id: quiet
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Decrease logging verbosity
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Increase logging verbosity
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mehari:0.39.0--h13c227e_0
stdout: mehari_server.out

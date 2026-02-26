cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - viguno
  - server
label: viguno_server
doc: "Clap sub command below \"server\"\n\nTool homepage: https://github.com/bihealth/viguno"
inputs:
  - id: command
    type: string
    doc: The command to run (run, schema, help)
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
    dockerPull: quay.io/biocontainers/viguno:0.4.0--h13c227e_0
stdout: viguno_server.out

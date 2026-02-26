cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varfish-server-worker
  - strucvars
label: varfish-server-worker_strucvars
doc: "Structural variant related commands\n\nTool homepage: https://github.com/bihealth/varfish-server-worker"
inputs:
  - id: command
    type: string
    doc: Command to run (aggregate, ingest, query, txt-to-bin, help)
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
    dockerPull: quay.io/biocontainers/varfish-server-worker:0.17.3--h13c227e_0
stdout: varfish-server-worker_strucvars.out

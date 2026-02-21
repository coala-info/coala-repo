cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - annonars
  - db-utils
label: annonars_db-utils
doc: "\"db-utils\" sub commands\n\nTool homepage: https://github.com/bihealth/annona-rs"
inputs:
  - id: command
    type: string
    doc: The subcommand to execute (copy, dump-meta, or help)
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
    dockerPull: quay.io/biocontainers/annonars:0.44.1--h13c227e_0
stdout: annonars_db-utils.out

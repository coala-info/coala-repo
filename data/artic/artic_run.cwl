cwlVersion: v1.2
class: CommandLineTool
baseCommand: artic_run
label: artic_run
doc: "Run the artic pipeline\n\nTool homepage: https://github.com/artic-network/fieldbioinformatics"
inputs:
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output warnings to stderr
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artic:1.8.5--pyhdfd78af_0
stdout: artic_run.out

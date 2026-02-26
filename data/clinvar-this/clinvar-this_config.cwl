cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clinvar-this
  - config
label: clinvar-this_config
doc: "Sub command category `clinvar-this config ...`\n\nTool homepage: https://github.com/bihealth/clinvar-this"
inputs:
  - id: command
    type: string
    doc: The subcommand to run
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clinvar-this:0.18.5--pyhdfd78af_0
stdout: clinvar-this_config.out

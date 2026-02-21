cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdskit
label: cdskit
doc: "A toolkit for checking and manipulating coding sequences (CDS). Note: The provided
  help text contains only system error logs and does not list specific arguments or
  subcommands.\n\nTool homepage: https://github.com/kfuku52/cdskit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdskit:0.14.5--pyhdfd78af_0
stdout: cdskit.out

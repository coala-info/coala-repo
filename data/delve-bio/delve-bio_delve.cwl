cwlVersion: v1.2
class: CommandLineTool
baseCommand: delve
label: delve-bio_delve
doc: "Delve is a variant caller for DNA sequencing data.\n\nTool homepage: https://github.com/berndbohmeier/delve"
inputs:
  - id: command
    type: string
    doc: 'The command to run. Available commands: call, help'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/delve-bio:0.2.0--h4349ce8_0
stdout: delve-bio_delve.out

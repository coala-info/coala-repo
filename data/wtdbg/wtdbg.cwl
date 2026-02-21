cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtdbg
label: wtdbg
doc: "The provided text does not contain help information for the tool. It is a log
  of a container build failure.\n\nTool homepage: https://github.com/ruanjue/wtdbg-1.2.8"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wtdbg:2.5--h577a1d6_6
stdout: wtdbg.out

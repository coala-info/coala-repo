cwlVersion: v1.2
class: CommandLineTool
baseCommand: sbtn
label: sbt_sbtn
doc: "The provided text appears to be a container execution log rather than command-line
  help text. No arguments or usage information could be extracted.\n\nTool homepage:
  https://github.com/sbt/sbt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbt:0.13.12--1
stdout: sbt_sbtn.out

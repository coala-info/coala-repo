cwlVersion: v1.2
class: CommandLineTool
baseCommand: sbt
label: sbt
doc: "The interactive build tool (Note: The provided text is a container build log
  and does not contain CLI help information or argument definitions).\n\nTool homepage:
  https://github.com/sbt/sbt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sbt:0.13.12--1
stdout: sbt.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: scala
label: scala
doc: "The Scala programming language runner (Note: The provided text appears to be
  a container build log rather than CLI help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/binhnguyennus/awesome-scalability"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scala:2.11.8--1
stdout: scala.out

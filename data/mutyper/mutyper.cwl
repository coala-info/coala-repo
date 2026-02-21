cwlVersion: v1.2
class: CommandLineTool
baseCommand: mutyper
label: mutyper
doc: "No description available: The provided text contains a container runtime error
  rather than tool help text.\n\nTool homepage: https://github.com/harrispopgen/mutyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mutyper:1.0.2--py311haab0aaa_2
stdout: mutyper.out

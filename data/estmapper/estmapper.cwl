cwlVersion: v1.2
class: CommandLineTool
baseCommand: estmapper
label: estmapper
doc: "A tool for mapping ESTs to a genome (Note: The provided help text contains only
  system error messages and does not list command-line arguments).\n\nTool homepage:
  https://github.com/estmapper/1234"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/estmapper:2008--py311pl5321hd8d945a_7
stdout: estmapper.out

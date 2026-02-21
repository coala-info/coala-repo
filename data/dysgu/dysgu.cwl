cwlVersion: v1.2
class: CommandLineTool
baseCommand: dysgu
label: dysgu
doc: "A tool for structural variant calling (Note: The provided help text contains
  only container runtime error messages and no usage information).\n\nTool homepage:
  https://github.com/kcleal/dysgu"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dysgu:1.8.7--py311h8ddd9a4_0
stdout: dysgu.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: tajimas_d
label: tajimas_d
doc: "A tool for calculating Tajima's D (Note: The provided help text contains only
  system error logs and no usage information).\n\nTool homepage: https://github.com/not-a-feature/tajimas_d"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tajimas_d:2.0.4--pyhdfd78af_0
stdout: tajimas_d.out

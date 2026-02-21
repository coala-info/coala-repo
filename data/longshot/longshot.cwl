cwlVersion: v1.2
class: CommandLineTool
baseCommand: longshot
label: longshot
doc: "Longshot is a variant caller for long-read sequencing data. (Note: The provided
  help text contains only system error messages and no usage information; arguments
  could not be extracted from the input.)\n\nTool homepage: https://github.com/pjedge/longshot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longshot:1.0.0--h8dc4d9d_3
stdout: longshot.out

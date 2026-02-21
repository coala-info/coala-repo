cwlVersion: v1.2
class: CommandLineTool
baseCommand: icount
label: icount
doc: "iCount: protein-RNA interaction analysis (Note: The provided text is a container
  execution error and does not contain help information).\n\nTool homepage: https://github.com/tomazc/iCount"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/icount:2.0.0--py36h24bf2e0_0
stdout: icount.out

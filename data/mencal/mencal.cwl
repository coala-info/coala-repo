cwlVersion: v1.2
class: CommandLineTool
baseCommand: mencal
label: mencal
doc: "A menstrual calendar for the command line (Note: The provided text contained
  system error messages rather than help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/abemiyuu/mencal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mencal:v3.0-4-deb_cv1
stdout: mencal.out

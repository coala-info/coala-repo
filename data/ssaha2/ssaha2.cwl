cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssaha2
label: ssaha2
doc: "The provided text does not contain help information for ssaha2; it contains
  a system error log regarding a failed container build process.\n\nTool homepage:
  https://github.com/ssaha2/Training"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ssaha2:v2.5.5_cv3
stdout: ssaha2.out

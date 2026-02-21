cwlVersion: v1.2
class: CommandLineTool
baseCommand: potrace
label: potrace
doc: "The provided text does not contain help information for potrace; it is a log
  of a failed container build/fetch operation.\n\nTool homepage: https://github.com/kilobtye/potrace"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/potrace:1.11--hed695b0_2
stdout: potrace.out

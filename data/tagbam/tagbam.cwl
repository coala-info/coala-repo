cwlVersion: v1.2
class: CommandLineTool
baseCommand: tagbam
label: tagbam
doc: "The provided text does not contain help information or usage instructions for
  the tool; it contains container runtime error logs.\n\nTool homepage: https://github.com/fellen31/tagbam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tagbam:0.1.0--h3ab6199_0
stdout: tagbam.out

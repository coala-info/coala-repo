cwlVersion: v1.2
class: CommandLineTool
baseCommand: metalign
label: metalign
doc: "Metagenomic alignment tool (Note: The provided text contains container execution
  error logs rather than help documentation).\n\nTool homepage: https://github.com/nlapier2/Metalign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metalign:0.12.5--pyh864c0ab_1
stdout: metalign.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_refine
label: relion_relion_refine
doc: "The provided text contains container environment logs and a fatal error message
  rather than the command-line help documentation for relion_refine. As a result,
  no arguments could be extracted.\n\nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_refine.out

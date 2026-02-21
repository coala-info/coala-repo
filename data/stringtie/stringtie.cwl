cwlVersion: v1.2
class: CommandLineTool
baseCommand: stringtie
label: stringtie
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime error logs.\n\nTool homepage: https://ccb.jhu.edu/software/stringtie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stringtie:3.0.3--h29c0135_0
stdout: stringtie.out

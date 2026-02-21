cwlVersion: v1.2
class: CommandLineTool
baseCommand: probalign
label: probalign
doc: "Probalign is a tool for multiple sequence alignment. (Note: The provided text
  appears to be a container build error log rather than help text, so no arguments
  could be extracted.)\n\nTool homepage: https://github.com/ProbAlign/ProbAlign"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/probalign:v1.4-8-deb_cv1
stdout: probalign.out

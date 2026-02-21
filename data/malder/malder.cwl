cwlVersion: v1.2
class: CommandLineTool
baseCommand: malder
label: malder
doc: "MALDER (Multiple ALDER) is a tool for dating multiple admixture events using
  linkage disequilibrium.\n\nTool homepage: https://github.com/joepickrell/malder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/malder:1.0.1e83d4e--he3c7034_8
stdout: malder.out

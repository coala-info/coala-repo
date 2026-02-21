cwlVersion: v1.2
class: CommandLineTool
baseCommand: promod3
label: promod3
doc: "ProMod3 is a protein homology modeling framework.\n\nTool homepage: https://openstructure.org/promod3/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/promod3:3.6.0--py311he264feb_0
stdout: promod3.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: sibeliaz
label: sibeliaz
doc: "SIBELIAZ (Synteny Identification by Expansion of Local Alignment Seeds) is a
  tool for finding syntenic blocks in multiple whole-genome sequences.\n\nTool homepage:
  https://github.com/medvedevgroup/SibeliaZ"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sibeliaz:1.2.7--h9948957_0
stdout: sibeliaz.out

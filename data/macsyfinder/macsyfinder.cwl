cwlVersion: v1.2
class: CommandLineTool
baseCommand: macsyfinder
label: macsyfinder
doc: "MacSyFinder is a tool to model and detect macromolecular systems (e.g., secretion
  systems, pili, etc.) in genomic data.\n\nTool homepage: https://github.com/gem-pasteur/macsyfinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macsyfinder:2.1.6--pyhdfd78af_0
stdout: macsyfinder.out

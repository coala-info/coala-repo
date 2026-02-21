cwlVersion: v1.2
class: CommandLineTool
baseCommand: openduck
label: openduck
doc: "OpenDuck is a tool for performing Dynamic Undocking (DUck) simulations to investigate
  the binding stability of protein-ligand complexes.\n\nTool homepage: https://github.com/galaxycomputationalchemistry/duck"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/openduck:0.1.2--py_0
stdout: openduck.out

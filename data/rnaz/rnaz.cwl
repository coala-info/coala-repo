cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnaz
label: rnaz
doc: "RNAz is a tool for predicting structurally conserved and thermodynamically stable
  RNA secondary structures. (Note: The provided text contains container runtime errors
  and does not include the actual help documentation for the tool).\n\nTool homepage:
  https://www.tbi.univie.ac.at/~wash/RNAz/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaz:2.1.1--pl5321h503566f_8
stdout: rnaz.out

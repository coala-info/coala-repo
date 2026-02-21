cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepsig
label: deepsig
doc: "DeepSig: deep learning method for signal peptide prediction (Note: The provided
  text contains container runtime errors rather than tool help documentation).\n\n
  Tool homepage: https://github.com/BolognaBiocomp/deepsig"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepsig:1.2.5--pyhca03a8a_1
stdout: deepsig.out

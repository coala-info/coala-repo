cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepsig.py
label: deepsig_deepsig.py
doc: "DeepSig: prediction of signal peptides in proteins. (Note: The provided help
  text contains only system error messages regarding container execution and does
  not list command-line arguments.)\n\nTool homepage: https://github.com/BolognaBiocomp/deepsig"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepsig:1.2.5--pyhca03a8a_1
stdout: deepsig_deepsig.py.out

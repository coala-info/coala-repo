cwlVersion: v1.2
class: CommandLineTool
baseCommand: sanntis_sanntis_container.py
label: sanntis_sanntis_container.py
doc: "Synteny-aware neural network for tool-integrated sequence annotation (Sanntis)\n
  \nTool homepage: https://github.com/Finn-Lab/SanntiS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sanntis:0.9.4.1--pyhdfd78af_0
stdout: sanntis_sanntis_container.py.out

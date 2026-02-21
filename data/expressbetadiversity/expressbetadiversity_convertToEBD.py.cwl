cwlVersion: v1.2
class: CommandLineTool
baseCommand: expressbetadiversity_convertToEBD.py
label: expressbetadiversity_convertToEBD.py
doc: "A tool to convert data to EBD (Express Beta Diversity) format.\n\nTool homepage:
  https://github.com/dparks1134/ExpressBetaDiversity"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expressbetadiversity:1.0.10--h9f5acd7_3
stdout: expressbetadiversity_convertToEBD.py.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: sanntis
label: sanntis
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/Finn-Lab/SanntiS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sanntis:0.9.4.1--pyhdfd78af_0
stdout: sanntis.out

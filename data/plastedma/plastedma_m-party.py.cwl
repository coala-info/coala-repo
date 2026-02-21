cwlVersion: v1.2
class: CommandLineTool
baseCommand: plastedma_m-party.py
label: plastedma_m-party.py
doc: "The provided text is a container build error log and does not contain help information
  for the tool.\n\nTool homepage: https://github.com/ozefreitas/PlastEDMA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plastedma:0.2.1--hdfd78af_0
stdout: plastedma_m-party.py.out

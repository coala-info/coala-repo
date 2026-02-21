cwlVersion: v1.2
class: CommandLineTool
baseCommand: rodeo
label: rodeo
doc: "RODEO (Robust Omics Data Evaluation and Optimization) - Note: The provided text
  was a system error log and did not contain help documentation or argument definitions.\n
  \nTool homepage: http://ripp.rodeo/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rodeo:2.3.3--hdfd78af_1
stdout: rodeo.out

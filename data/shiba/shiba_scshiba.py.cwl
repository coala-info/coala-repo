cwlVersion: v1.2
class: CommandLineTool
baseCommand: shiba_scshiba.py
label: shiba_scshiba.py
doc: "No description available: The provided text contains system error logs rather
  than help documentation.\n\nTool homepage: https://github.com/Sika-Zheng-Lab/Shiba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shiba:0.8.1--py312hdfd78af_0
stdout: shiba_scshiba.py.out

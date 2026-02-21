cwlVersion: v1.2
class: CommandLineTool
baseCommand: addeam-cluster.py
label: addeam_addeam-cluster.py
doc: "The provided text does not contain help information for the tool, but rather
  system error logs related to a container build failure (no space left on device).\n
  \nTool homepage: https://github.com/LouisPwr/AdDeam"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/addeam:1.0.0--py313h1510ab2_0
stdout: addeam_addeam-cluster.py.out

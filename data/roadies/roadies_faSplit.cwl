cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - roadies
  - faSplit
label: roadies_faSplit
doc: "The provided text does not contain help information for the tool, but appears
  to be a container runtime error log. No arguments could be extracted.\n\nTool homepage:
  https://github.com/TurakhiaLab/ROADIES"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/roadies:0.1.10--py39pl5321h5ca1c30_0
stdout: roadies_faSplit.out

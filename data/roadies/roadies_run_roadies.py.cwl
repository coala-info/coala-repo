cwlVersion: v1.2
class: CommandLineTool
baseCommand: roadies_run_roadies.py
label: roadies_run_roadies.py
doc: "The provided text appears to be a container execution log or error message rather
  than CLI help text. No arguments could be extracted from the input.\n\nTool homepage:
  https://github.com/TurakhiaLab/ROADIES"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/roadies:0.1.10--py39pl5321h5ca1c30_0
stdout: roadies_run_roadies.py.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: roadies_reroot.py
label: roadies_reroot.py
doc: "The provided text does not contain help information or a description for roadies_reroot.py;
  it contains container engine log messages and a fatal error regarding an OCI image
  build.\n\nTool homepage: https://github.com/TurakhiaLab/ROADIES"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/roadies:0.1.10--py39pl5321h5ca1c30_0
stdout: roadies_reroot.py.out

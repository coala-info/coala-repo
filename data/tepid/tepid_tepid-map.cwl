cwlVersion: v1.2
class: CommandLineTool
baseCommand: tepid-map
label: tepid_tepid-map
doc: "TEPID (Transposable Element Polymorphism Identification De novo) mapping tool.
  (Note: The provided text contains container environment logs and a fatal error message
  rather than the tool's help documentation, so no arguments could be extracted.)\n
  \nTool homepage: https://github.com/ListerLab/TEPID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tepid:0.10--py_0
stdout: tepid_tepid-map.out

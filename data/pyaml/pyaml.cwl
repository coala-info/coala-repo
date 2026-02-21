cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyaml
label: pyaml
doc: "PyYAML-based module to produce pretty and readable YAML-serialized data.\n\n
  Tool homepage: https://github.com/superna9999/pyamlboot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyaml:15.8.2--py35_0
stdout: pyaml.out

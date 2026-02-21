cwlVersion: v1.2
class: CommandLineTool
baseCommand: ruamel.yaml
label: ruamel.yaml
doc: "The provided text does not contain help documentation for ruamel.yaml; it is
  a log of a failed container build process. ruamel.yaml is a YAML parser/emitter
  library for Python.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ruamel.yaml:0.12.13--py35_0
stdout: ruamel.yaml.out

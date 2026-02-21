cwlVersion: v1.2
class: CommandLineTool
baseCommand: el_gato
label: el_gato
doc: "The provided text does not contain help documentation or usage instructions;
  it consists of system log messages and a fatal error regarding container image conversion
  and disk space.\n\nTool homepage: https://github.com/appliedbinf/el_gato"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/elastic-blast:1.5.0--pyhdfd78af_0
stdout: el_gato.out

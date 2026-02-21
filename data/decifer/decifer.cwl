cwlVersion: v1.2
class: CommandLineTool
baseCommand: decifer
label: decifer
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding container image
  conversion and disk space.\n\nTool homepage: https://github.com/raphael-group/decifer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/decifer:2.1.4--py312hf731ba3_4
stdout: decifer.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: decoupler
label: decoupler
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding container image
  building.\n\nTool homepage: https://github.com/saezlab/decoupler-py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/decoupler:1.5.0--pyhdfd78af_0
stdout: decoupler.out

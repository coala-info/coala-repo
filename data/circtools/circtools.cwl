cwlVersion: v1.2
class: CommandLineTool
baseCommand: circtools
label: circtools
doc: "A modular framework for circular RNA analysis.\n\nTool homepage: https://github.com/dieterich-lab/circtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circtools:2.0.3--pyhdfd78af_0
stdout: circtools.out

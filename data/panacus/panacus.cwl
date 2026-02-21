cwlVersion: v1.2
class: CommandLineTool
baseCommand: panacus
label: panacus
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/marschall-lab/panacus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panacus:0.4.1--hc1c3326_0
stdout: panacus.out

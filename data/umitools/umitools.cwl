cwlVersion: v1.2
class: CommandLineTool
baseCommand: umitools
label: umitools
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build process.\n\nTool homepage: https://github.com/weng-lab/umitools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umitools:0.3.4--py36_0
stdout: umitools.out

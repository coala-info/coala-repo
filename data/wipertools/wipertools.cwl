cwlVersion: v1.2
class: CommandLineTool
baseCommand: wipertools
label: wipertools
doc: "The provided text does not contain help information or a description of the
  tool; it appears to be a log of a failed container build/fetch process.\n\nTool
  homepage: https://github.com/mazzalab/fastqwiper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wipertools:1.1.5--pyhdfd78af_0
stdout: wipertools.out

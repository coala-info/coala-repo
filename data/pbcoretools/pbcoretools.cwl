cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbcoretools
label: pbcoretools
doc: "The provided text does not contain help information as the executable was not
  found in the environment.\n\nTool homepage: https://github.com/mpkocher/pbcoretools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbcoretools:0.8.1--py_1
stdout: pbcoretools.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: svtools
label: svtools
doc: "A suite of tools to manipulate and analyze structural variant calls in VCF format.\n
  \nTool homepage: https://github.com/hall-lab/svtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
stdout: svtools.out

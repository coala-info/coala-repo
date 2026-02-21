cwlVersion: v1.2
class: CommandLineTool
baseCommand: deeptoolsintervals
label: deeptoolsintervals
doc: "The provided text does not contain help information as it reflects a container
  execution error (no space left on device). No arguments could be parsed.\n\nTool
  homepage: https://github.com/deeptools/deeptools_intervals"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deeptoolsintervals:0.1.9--py312ha9c1134_11
stdout: deeptoolsintervals.out

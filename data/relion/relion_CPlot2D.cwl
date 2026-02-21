cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_CPlot2D
label: relion_CPlot2D
doc: "A tool from the RELION suite. (Note: The provided input text is a container
  execution error log and does not contain help documentation or argument definitions.)\n
  \nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_CPlot2D.out

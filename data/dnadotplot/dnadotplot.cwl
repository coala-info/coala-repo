cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnadotplot
label: dnadotplot
doc: "A tool for generating DNA dot plots. (Note: The provided text contains system
  error messages and does not include usage instructions or argument definitions.)\n
  \nTool homepage: https://github.com/quadram-institute-bioscience/dnadotplot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnadotplot:0.1.4--hc1c3326_0
stdout: dnadotplot.out

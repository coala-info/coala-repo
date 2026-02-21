cwlVersion: v1.2
class: CommandLineTool
baseCommand: hsdecipher_HSD_heatmap.py
label: hsdecipher_HSD_heatmap.py
doc: "A tool for generating HSD heatmaps. (Note: The provided text is a system error
  log regarding container image conversion and does not contain usage instructions
  or argument definitions.)\n\nTool homepage: https://github.com/zx0223winner/HSDecipher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hsdecipher:1.1.2--hdfd78af_0
stdout: hsdecipher_HSD_heatmap.py.out

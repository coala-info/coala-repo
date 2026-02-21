cwlVersion: v1.2
class: CommandLineTool
baseCommand: shiba2sashimi
label: shiba2sashimi
doc: "A tool for converting SHIBA (Splicing Heterogeneity Inference Based on Alignments)
  output to sashimi plots. (Note: The provided text is a system error log regarding
  a failed container build and does not contain usage instructions or argument definitions.)\n
  \nTool homepage: https://github.com/Sika-Zheng-Lab/shiba2sashimi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shiba2sashimi:0.1.7--pyh7e72e81_0
stdout: shiba2sashimi.out

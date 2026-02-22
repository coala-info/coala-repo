cwlVersion: v1.2
class: CommandLineTool
baseCommand: crispector
label: crispector
doc: "CRISPECTOR is a tool for the analysis of genome editing experiments, specifically
  designed to accurately evaluate translocation and off-target activity from NGS data.\n\
  \nTool homepage: https://github.com/YakhiniGroup/crispector"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crispector:1.0.7--pyhdfd78af_0
stdout: crispector.out

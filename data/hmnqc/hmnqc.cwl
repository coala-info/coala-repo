cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmnqc
label: hmnqc
doc: "A tool for quality control (QC) analysis, typically used in bioinformatics pipelines.\n
  \nTool homepage: https://github.com/guillaume-gricourt/HmnQc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnqc:0.5.1--pyhdfd78af_0
stdout: hmnqc.out

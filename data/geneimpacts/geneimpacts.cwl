cwlVersion: v1.2
class: CommandLineTool
baseCommand: geneimpacts
label: geneimpacts
doc: "A tool for assessing the impact of genetic variants.\n\nTool homepage: https://github.com/brentp/geneimpacts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/geneimpacts:0.3.7--py36_0
stdout: geneimpacts.out

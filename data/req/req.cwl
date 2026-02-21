cwlVersion: v1.2
class: CommandLineTool
baseCommand: req
label: req
doc: "\nTool homepage: https://research.pasteur.fr/fr/tool/r%CE%B5q-assessing-branch-supports-o%C6%92-a-distance-based-phylogenetic-tree-with-the-rate-o%C6%92-elementary-quartets/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/req:v1.3.190304ac--1
stdout: req.out

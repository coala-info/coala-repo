cwlVersion: v1.2
class: CommandLineTool
baseCommand: scalpel
label: scalpel
doc: "Scalpel is a software package for detecting and characterizing insertions and
  deletions (indels) in next-generation sequencing data.\n\nTool homepage: http://scalpel.sourceforge.net/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scalpel:0.5.4--pl5321h4ced824_9
stdout: scalpel.out

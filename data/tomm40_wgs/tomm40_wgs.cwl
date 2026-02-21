cwlVersion: v1.2
class: CommandLineTool
baseCommand: tomm40_wgs
label: tomm40_wgs
doc: "A tool for TOMM40 WGS (Whole Genome Sequencing) analysis. Note: The provided
  help text contains container build errors and does not list specific command-line
  arguments.\n\nTool homepage: https://github.com/RushAlz/TOMM40_WGS/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tomm40_wgs:1.0.1--hdfd78af_0
stdout: tomm40_wgs.out

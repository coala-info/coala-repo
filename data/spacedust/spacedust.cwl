cwlVersion: v1.2
class: CommandLineTool
baseCommand: spacedust
label: spacedust
doc: "Space-efficient k-mer counting and sequence analysis tool.\n\nTool homepage:
  https://github.com/soedinglab/spacedust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spacedust:2.e56c505--hd6d6fdc_0
stdout: spacedust.out

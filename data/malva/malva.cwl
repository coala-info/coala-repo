cwlVersion: v1.2
class: CommandLineTool
baseCommand: malva
label: malva
doc: "MALVA (Mapping-free ALlele VAriant analyzer) is a tool for genotyping known
  variants from NGS data.\n\nTool homepage: https://algolab.github.io/malva/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/malva:2.0.0--h7071971_4
stdout: malva.out

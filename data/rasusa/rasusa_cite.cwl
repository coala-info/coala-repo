cwlVersion: v1.2
class: CommandLineTool
baseCommand: rasusa_cite
label: rasusa_cite
doc: "Rasusa: Randomly subsample sequencing reads to a specified coverage\n\nTool
  homepage: https://github.com/mbhall88/rasusa"
inputs:
  - id: article
    type: string
    doc: BibTeX entry for the article
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rasusa:3.0.0--h54198d6_0
stdout: rasusa_cite.out

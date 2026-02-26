cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gdi
  - analysis
label: genomics-data-index_gdi analysis
doc: "Perform analysis on genomic data.\n\nTool homepage: https://github.com/apetkau/genomics-data-index"
inputs:
  - id: genomes
    type:
      - 'null'
      - type: array
        items: string
    doc: Genomes to analyze
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomics-data-index:0.9.2--pyhdfd78af_0
stdout: genomics-data-index_gdi analysis.out

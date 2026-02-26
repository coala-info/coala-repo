cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - progenomes
  - view
label: progenomes_view
doc: "View datasets within the Progenomes database.\n\nTool homepage: https://github.com/BigDataBiology/progenomes-cli"
inputs:
  - id: dataset
    type: string
    doc: 'Dataset to view. Available options: Highly important strains, Excluded genomes,
      ANI representatives, ANI clustering, Functional annotations for representative
      genomes.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/progenomes:0.3.0--pyhdfd78af_0
stdout: progenomes_view.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - galru
  - galru_species
label: galru_galru_species
doc: "Genetic Analysis of Lineage and Relationship Uncertainty - galru_species subcommand\n
  \nTool homepage: https://github.com/quadram-institute-bioscience/galru"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galru:1.0.0--py_0
stdout: galru_galru_species.out

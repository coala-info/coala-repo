cwlVersion: v1.2
class: CommandLineTool
baseCommand: plant_tribes_gene_family_phylogeny_builder
label: plant_tribes_gene_family_phylogeny_builder
doc: "A tool for building gene family phylogenies within the PlantTribes framework.\n
  \nTool homepage: https://github.com/dePamphilis/PlantTribes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_gene_family_phylogeny_builder:1.0.4--0
stdout: plant_tribes_gene_family_phylogeny_builder.out

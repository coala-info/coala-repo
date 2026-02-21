cwlVersion: v1.2
class: CommandLineTool
baseCommand: GeneFamilyAligner
label: plant_tribes_gene_family_phylogeny_builder_GeneFamilyAligner
doc: "A tool from the PlantTribes suite for building gene family phylogenies and alignments.\n
  \nTool homepage: https://github.com/dePamphilis/PlantTribes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_gene_family_phylogeny_builder:1.0.4--0
stdout: plant_tribes_gene_family_phylogeny_builder_GeneFamilyAligner.out

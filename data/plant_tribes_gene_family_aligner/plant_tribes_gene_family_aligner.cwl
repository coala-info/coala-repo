cwlVersion: v1.2
class: CommandLineTool
baseCommand: plant_tribes_gene_family_aligner
label: plant_tribes_gene_family_aligner
doc: "PlantTribes GeneFamilyAligner (Note: The provided text contains system error
  logs regarding a container build failure and does not contain help documentation
  or argument definitions).\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_gene_family_phylogeny_builder:1.0.4--0
stdout: plant_tribes_gene_family_aligner.out

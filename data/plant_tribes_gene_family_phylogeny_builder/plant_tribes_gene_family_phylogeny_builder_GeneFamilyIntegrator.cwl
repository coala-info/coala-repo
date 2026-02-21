cwlVersion: v1.2
class: CommandLineTool
baseCommand: GeneFamilyIntegrator
label: plant_tribes_gene_family_phylogeny_builder_GeneFamilyIntegrator
doc: "A tool within the PlantTribes gene family phylogeny builder suite. Note: The
  provided help text contains only system error messages regarding a failed container
  build and does not list specific command-line arguments.\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_gene_family_phylogeny_builder:1.0.4--0
stdout: plant_tribes_gene_family_phylogeny_builder_GeneFamilyIntegrator.out

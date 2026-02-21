cwlVersion: v1.2
class: CommandLineTool
baseCommand: GeneFamilyClassifier
label: plant_tribes_gene_family_phylogeny_builder_GeneFamilyClassifier
doc: "A tool for gene family classification within the PlantTribes gene family phylogeny
  builder suite. (Note: The provided input text consists of system error logs regarding
  a container build failure and does not contain the standard help documentation or
  argument definitions.)\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_gene_family_phylogeny_builder:1.0.4--0
stdout: plant_tribes_gene_family_phylogeny_builder_GeneFamilyClassifier.out

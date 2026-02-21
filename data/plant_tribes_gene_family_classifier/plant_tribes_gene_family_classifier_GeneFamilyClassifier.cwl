cwlVersion: v1.2
class: CommandLineTool
baseCommand: GeneFamilyClassifier
label: plant_tribes_gene_family_classifier_GeneFamilyClassifier
doc: "PlantTribes GeneFamilyClassifier (Note: The provided text contains only system
  error logs and no help documentation. No arguments could be extracted.)\n\nTool
  homepage: https://github.com/dePamphilis/PlantTribes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_gene_family_phylogeny_builder:1.0.4--0
stdout: plant_tribes_gene_family_classifier_GeneFamilyClassifier.out

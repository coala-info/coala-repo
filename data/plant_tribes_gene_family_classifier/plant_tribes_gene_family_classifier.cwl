cwlVersion: v1.2
class: CommandLineTool
baseCommand: plant_tribes_gene_family_classifier
label: plant_tribes_gene_family_classifier
doc: "The provided text does not contain help information or a description for the
  tool. It appears to be a system error log related to a container build failure (No
  space left on device).\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_gene_family_phylogeny_builder:1.0.4--0
stdout: plant_tribes_gene_family_classifier.out

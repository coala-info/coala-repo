cwlVersion: v1.2
class: CommandLineTool
baseCommand: plant_tribes_gene_family_classifier_md5sum
label: plant_tribes_gene_family_classifier_md5sum
doc: "The provided text does not contain help information for the tool; it is a system
  error log indicating a failure to build a container image due to insufficient disk
  space.\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_gene_family_phylogeny_builder:1.0.4--0
stdout: plant_tribes_gene_family_classifier_md5sum.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: plant_tribes_assembly_post_processor
label: plant_tribes_assembly_post_processor
doc: "Post-processor for PlantTribes assembly. Note: The provided help text appears
  to be a system error log regarding a failed container build and does not contain
  usage information or argument definitions.\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_gene_family_phylogeny_builder:1.0.4--0
stdout: plant_tribes_assembly_post_processor.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: AssemblyPostProcesser
label: plant_tribes_assembly_post_processor_AssemblyPostProcesser
doc: "A tool for post-processing assembly data within the PlantTribes toolkit.\n\n
  Tool homepage: https://github.com/dePamphilis/PlantTribes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_gene_family_phylogeny_builder:1.0.4--0
stdout: plant_tribes_assembly_post_processor_AssemblyPostProcesser.out

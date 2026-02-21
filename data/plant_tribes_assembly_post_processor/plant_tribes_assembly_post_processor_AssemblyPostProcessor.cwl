cwlVersion: v1.2
class: CommandLineTool
baseCommand: AssemblyPostProcessor
label: plant_tribes_assembly_post_processor_AssemblyPostProcessor
doc: "The provided text does not contain help documentation for the tool, but appears
  to be a system error log from a container runtime (Apptainer/Singularity) indicating
  a 'No space left on device' failure during image fetching.\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_gene_family_phylogeny_builder:1.0.4--0
stdout: plant_tribes_assembly_post_processor_AssemblyPostProcessor.out

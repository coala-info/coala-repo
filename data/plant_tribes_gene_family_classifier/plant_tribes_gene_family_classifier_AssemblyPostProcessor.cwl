cwlVersion: v1.2
class: CommandLineTool
baseCommand: AssemblyPostProcessor
label: plant_tribes_gene_family_classifier_AssemblyPostProcessor
doc: "A tool for post-processing gene family classifier assemblies within the PlantTribes
  suite. Note: The provided input text contains system error logs rather than help
  documentation, so no arguments could be extracted.\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_gene_family_phylogeny_builder:1.0.4--0
stdout: plant_tribes_gene_family_classifier_AssemblyPostProcessor.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: GeneFamilyPhylogenyBuilder
label: plant_tribes_gene_family_phylogeny_builder_GeneFamilyPhylogenyBuilder
doc: "The provided text is an error log from a container build process and does not
  contain the help text or usage information for the tool. As a result, no arguments
  could be extracted.\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_gene_family_phylogeny_builder:1.0.4--0
stdout: plant_tribes_gene_family_phylogeny_builder_GeneFamilyPhylogenyBuilder.out

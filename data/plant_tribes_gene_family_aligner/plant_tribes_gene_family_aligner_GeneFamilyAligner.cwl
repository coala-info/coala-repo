cwlVersion: v1.2
class: CommandLineTool
baseCommand: GeneFamilyAligner
label: plant_tribes_gene_family_aligner_GeneFamilyAligner
doc: "A tool for aligning gene families (Note: The provided help text contains only
  system error logs and no argument definitions).\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_gene_family_phylogeny_builder:1.0.4--0
stdout: plant_tribes_gene_family_aligner_GeneFamilyAligner.out

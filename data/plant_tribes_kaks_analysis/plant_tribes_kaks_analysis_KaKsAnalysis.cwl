cwlVersion: v1.2
class: CommandLineTool
baseCommand: KaKsAnalysis
label: plant_tribes_kaks_analysis_KaKsAnalysis
doc: "A tool for Ka/Ks analysis within the PlantTribes pipeline. Note: The provided
  help text contains only system error logs regarding a failed container build and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/dePamphilis/PlantTribes"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plant_tribes_gene_family_phylogeny_builder:1.0.4--0
stdout: plant_tribes_kaks_analysis_KaKsAnalysis.out

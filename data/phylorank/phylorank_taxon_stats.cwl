cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylorank
  - taxon_stats
label: phylorank_taxon_stats
doc: "Calculate taxon statistics based on a taxonomy file.\n\nTool homepage: https://github.com/dparks1134/PhyloRank"
inputs:
  - id: taxonomy_file
    type: File
    doc: Input taxonomy file
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: Output file for taxon statistics
    inputBinding:
      position: 2
outputs:
  - id: out_output_file
    type: File
    doc: Output file for taxon statistics
    outputBinding:
      glob: '$(inputs.output_file)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0

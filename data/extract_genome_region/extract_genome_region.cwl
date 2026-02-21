cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract_genome_region
label: extract_genome_region
doc: "Extract specific regions from a genome file.\n\nTool homepage: https://github.com/xguse/extract-genome-region"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/extract_genome_region:0.0.3--py36_0
stdout: extract_genome_region.out

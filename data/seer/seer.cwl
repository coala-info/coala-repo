cwlVersion: v1.2
class: CommandLineTool
baseCommand: seer
label: seer
doc: "Sequence Element Enrichment Analysis (seer) - a tool for genome-wide association
  studies (GWAS) on pangenomes.\n\nTool homepage: https://github.com/johnlees/seer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seer:v1.1.4-2b2-deb_cv1
stdout: seer.out

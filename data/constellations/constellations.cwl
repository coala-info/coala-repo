cwlVersion: v1.2
class: CommandLineTool
baseCommand: constellations
label: constellations
doc: "A tool for identifying constellations of mutations in viral genomes (typically
  used for SARS-CoV-2 variant surveillance).\n\nTool homepage: https://github.com/cov-lineages/constellations"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/constellations:0.1.12--pyh7cba7a3_0
stdout: constellations.out

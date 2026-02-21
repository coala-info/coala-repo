cwlVersion: v1.2
class: CommandLineTool
baseCommand: fgwas
label: fgwas
doc: "Functional Genome-Wide Association Studies (fgwas) - A tool for integrating
  functional genomic annotations with GWAS data.\n\nTool homepage: https://github.com/joepickrell/fgwas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgwas:0.3.6--ha172671_9
stdout: fgwas.out

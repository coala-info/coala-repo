cwlVersion: v1.2
class: CommandLineTool
baseCommand: metawatt
label: metawatt
doc: "Metawatt is a tool for phylogenetic profiling and binning of metagenomic contigs.\n
  \nTool homepage: https://github.com/edhelas/metawatt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawatt:3.5.3--boost1.64_0
stdout: metawatt.out

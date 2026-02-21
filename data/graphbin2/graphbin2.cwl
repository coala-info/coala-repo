cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphbin2
label: graphbin2
doc: "GraphBin2: Refined Binning of Metagenomic Contigs Using Assembly Graphs\n\n
  Tool homepage: https://github.com/metagentools/GraphBin2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphbin2:1.3.3--pyh7e72e81_0
stdout: graphbin2.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: gblocks
label: gblocks
doc: "A tool for selection of conserved blocks from multiple alignments for phylogenetic
  analysis.\n\nTool homepage: http://molevol.cmima.csic.es/castresana/Gblocks.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gblocks:0.91b--0
stdout: gblocks.out

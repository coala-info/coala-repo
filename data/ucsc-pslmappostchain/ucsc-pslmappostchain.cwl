cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslMapPostChain
label: ucsc-pslmappostchain
doc: "Post-chaining of PSL alignments after mapping. This tool is part of the UCSC
  Genome Browser utilities.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslmappostchain:482--h0b57e2e_0
stdout: ucsc-pslmappostchain.out

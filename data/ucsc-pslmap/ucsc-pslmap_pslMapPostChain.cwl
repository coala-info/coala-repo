cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pslMapPostChain
label: ucsc-pslmap_pslMapPostChain
doc: "Post-chaining of PSL alignments after mapping. (Note: The provided help text
  contains a fatal error and does not list usage instructions.)\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslmap:482--h0b57e2e_0
stdout: ucsc-pslmap_pslMapPostChain.out

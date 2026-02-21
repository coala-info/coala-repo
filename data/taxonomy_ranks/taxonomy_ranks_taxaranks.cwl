cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxonomy
  - ranks
  - taxaranks
label: taxonomy_ranks_taxaranks
doc: "A tool for processing taxonomy ranks. (Note: The provided text contains container
  build logs and error messages rather than the tool's help documentation; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/linzhi2013/taxonomy_ranks"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxonomy:0.10.2--py310h9e6395a_0
stdout: taxonomy_ranks_taxaranks.out

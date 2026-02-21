cwlVersion: v1.2
class: CommandLineTool
baseCommand: sam2lca
label: sam2lca
doc: "A tool for taxonomic profiling of SAM/BAM files using the Lowest Common Ancestor
  (LCA) algorithm.\n\nTool homepage: https://github.com/maxibor/sam2lca"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sam2lca:1.1.4--pyhdfd78af_0
stdout: sam2lca.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: sspace_basic
label: sspace_basic
doc: "SSPACE (Scaffolding Pre-Assembled Contigs after Enrichment) is a tool for extending
  and scaffolding pre-assembled contigs using paired-end or mate-pair data.\n\nTool
  homepage: https://github.com/nsoranzo/sspace_basic"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sspace:v2.1.1dfsg-4-deb_cv1
stdout: sspace_basic.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: cobra-meta
label: cobra-meta
doc: "COBRA (Contig Overlap Based Re-Assembly) is a tool for metagenomic binning and
  assembly improvement.\n\nTool homepage: https://github.com/linxingchen/cobra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cobra-meta:1.2.3--pyhdfd78af_0
stdout: cobra-meta.out

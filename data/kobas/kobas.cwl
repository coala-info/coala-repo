cwlVersion: v1.2
class: CommandLineTool
baseCommand: kobas
label: kobas
doc: "KOBAS (KEGG Orthology Based Annotation System) is a tool for gene/protein functional
  annotation and pathway enrichment analysis. Note: The provided text contains system
  error messages regarding a container runtime failure and does not list specific
  command-line arguments.\n\nTool homepage: http://kobas.cbi.pku.edu.cn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kobas:3.0.3--py27r3.4.1_0
stdout: kobas.out

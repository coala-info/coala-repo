cwlVersion: v1.2
class: CommandLineTool
baseCommand: kobas-annotate
label: kobas_kobas-annotate
doc: "KOBAS (KEGG Orthology Based Annotation System) annotation tool. Note: The provided
  help text contains only system error messages regarding container execution and
  does not list specific arguments.\n\nTool homepage: http://kobas.cbi.pku.edu.cn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kobas:3.0.3--py27r3.4.1_0
stdout: kobas_kobas-annotate.out

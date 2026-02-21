cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taseq
  - filter
label: taseq_taseq_filter
doc: "Filter TASEQ data. (Note: The provided help text contains only container execution
  logs and a fatal error, so no arguments could be extracted.)\n\nTool homepage: https://github.com/KChigira/taseq/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taseq:1.1.1--pyh7e72e81_0
stdout: taseq_taseq_filter.out

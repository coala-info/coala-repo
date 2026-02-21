cwlVersion: v1.2
class: CommandLineTool
baseCommand: hisat-3n-table
label: hisat-3n_hisat-3n-table
doc: "The provided help text contains only container execution errors and does not
  list tool functionality or arguments.\n\nTool homepage: https://github.com/fulcrumgenomics/hisat-3n"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hisat-3n:0.0.3--h503566f_0
stdout: hisat-3n_hisat-3n-table.out

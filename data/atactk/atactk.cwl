cwlVersion: v1.2
class: CommandLineTool
baseCommand: atactk
label: atactk
doc: "A toolkit for ATAC-seq data analysis. (Note: The provided input text was a container
  engine error log and did not contain help documentation for argument extraction.)\n\
  \nTool homepage: http://theparkerlab.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atactk:0.1.9--pyh3252c3a_0
stdout: atactk.out

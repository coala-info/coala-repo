cwlVersion: v1.2
class: CommandLineTool
baseCommand: ataqv
label: ataqv
doc: "QC and visualization tool for ATAC-seq data (No description or arguments found
  in the provided error log).\n\nTool homepage: https://parkerlab.github.io/ataqv/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ataqv:1.3.1--py310h50a2689_5
stdout: ataqv.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: scvis
label: scvis
doc: "A tool for dimension reduction of single-cell RNA-seq data (Note: The provided
  text is an error log and does not contain help information).\n\nTool homepage: https://bitbucket.org/jerry00/scvis-dev/commits/all"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scvis:0.1.0--scvis_0
stdout: scvis.out

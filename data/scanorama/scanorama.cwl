cwlVersion: v1.2
class: CommandLineTool
baseCommand: scanorama
label: scanorama
doc: "Scanorama is a tool for efficient integration of heterogeneous single-cell transcriptomics
  datasets. (Note: The provided text appears to be a container engine error log rather
  than CLI help text, so no arguments could be extracted.)\n\nTool homepage: https://github.com/brianhie/scanorama/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanorama:1.7.4--pyhdfd78af_0
stdout: scanorama.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: music-deconvolution
label: music-deconvolution
doc: "Multi-subject Single-cell deconvolution (MuSiC). Note: The provided text contains
  system error logs regarding container execution and does not list specific command-line
  arguments.\n\nTool homepage: https://github.com/xuranw/MuSiC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/music-deconvolution:0.1.1--r351_0
stdout: music-deconvolution.out

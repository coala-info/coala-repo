cwlVersion: v1.2
class: CommandLineTool
baseCommand: vulcan
label: vulcan
doc: "VirtUaL ChIP-seq Analysis through Networks (VULCAN) is a tool for the analysis
  of ChIP-seq data.\n\nTool homepage: https://gitlab.com/treangenlab/vulcan"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vulcan:1.0.3--hdfd78af_0
stdout: vulcan.out

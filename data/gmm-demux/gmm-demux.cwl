cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmm-demux
label: gmm-demux
doc: "The provided text does not contain help information or a description of the
  tool. It contains container execution logs and a fatal error message regarding disk
  space.\n\nTool homepage: https://github.com/CHPGenetics/GMM-demux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmm-demux:0.2.2.3--pyh7e72e81_1
stdout: gmm-demux.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicexplorer
label: hicexplorer
doc: "HiCExplorer is a set of tools for the analysis of Hi-C data. (Note: The provided
  text contains container runtime error messages rather than tool help text, so no
  arguments could be extracted.)\n\nTool homepage: https://github.com/deeptools/HiCExplorer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicexplorer:3.7.6--pyhdfd78af_0
stdout: hicexplorer.out

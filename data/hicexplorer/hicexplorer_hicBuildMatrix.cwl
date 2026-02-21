cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicBuildMatrix
label: hicexplorer_hicBuildMatrix
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build or pull the container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/deeptools/HiCExplorer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicexplorer:3.7.6--pyhdfd78af_0
stdout: hicexplorer_hicBuildMatrix.out

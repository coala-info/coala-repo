cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicBuildMatrixMicroC
label: hicexplorer_hicBuildMatrixMicroC
doc: "The provided text does not contain help information for the tool, but rather
  a system error message regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/deeptools/HiCExplorer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicexplorer:3.7.6--pyhdfd78af_0
stdout: hicexplorer_hicBuildMatrixMicroC.out

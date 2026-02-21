cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hicConvertFormat
label: hicexplorer_hicConvertFormat
doc: "The provided text does not contain help information for the tool. It contains
  container runtime error messages regarding disk space.\n\nTool homepage: https://github.com/deeptools/HiCExplorer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicexplorer:3.7.6--pyhdfd78af_0
stdout: hicexplorer_hicConvertFormat.out

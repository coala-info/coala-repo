cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vtools
  - gcoverage
label: vtools_vtools-gcoverage
doc: "The provided text does not contain help information; it is a container runtime
  error log indicating a failure to fetch or build the image.\n\nTool homepage: https://github.com/LUMC/vtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vtools:1.1.0--py311h93dcfea_7
stdout: vtools_vtools-gcoverage.out

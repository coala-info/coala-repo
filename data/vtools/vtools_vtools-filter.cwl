cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vtools
  - filter
label: vtools_vtools-filter
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build or fetch operation.\n\nTool homepage: https://github.com/LUMC/vtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vtools:1.1.0--py311h93dcfea_7
stdout: vtools_vtools-filter.out

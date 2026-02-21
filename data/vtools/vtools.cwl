cwlVersion: v1.2
class: CommandLineTool
baseCommand: vtools
label: vtools
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container build process.\n\nTool homepage: https://github.com/LUMC/vtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vtools:1.1.0--py311h93dcfea_7
stdout: vtools.out

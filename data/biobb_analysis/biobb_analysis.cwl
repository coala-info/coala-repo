cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_analysis
label: biobb_analysis
doc: "The provided text does not contain help information or documentation for the
  tool. It is a log of a failed container build process due to insufficient disk space.\n
  \nTool homepage: https://github.com/bioexcel/biobb_md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_analysis:5.2.0--pyhdfd78af_0
stdout: biobb_analysis.out

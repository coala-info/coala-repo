cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_md_grompp
label: biobb_md_grompp
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a system error log indicating a failure to build or extract
  a container image due to lack of disk space.\n\nTool homepage: https://github.com/bioexcel/biobb_md"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_md:3.7.2--pyhdfd78af_0
stdout: biobb_md_grompp.out

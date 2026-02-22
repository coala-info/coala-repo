cwlVersion: v1.2
class: CommandLineTool
baseCommand: contatester
label: contatester
doc: "The provided text does not contain help information or usage instructions. It
  consists of system error messages related to a lack of disk space during a Singularity
  container build process.\n\nTool homepage: https://github.com/CNRGH/contatester"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/contatester:1.0.0--py311r44he3b539c_4
stdout: contatester.out

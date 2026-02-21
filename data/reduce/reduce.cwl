cwlVersion: v1.2
class: CommandLineTool
baseCommand: reduce
label: reduce
doc: "The provided text does not contain help information or usage instructions for
  the tool 'reduce'. It appears to be an error log from a container build process.\n
  \nTool homepage: https://github.com/rlabduke/reduce"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reduce:4.15--py39h2de1943_4
stdout: reduce.out

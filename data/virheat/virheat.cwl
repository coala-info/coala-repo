cwlVersion: v1.2
class: CommandLineTool
baseCommand: virheat
label: virheat
doc: "The provided text contains error logs from a container build process and does
  not include the tool's help documentation or usage instructions. As a result, no
  arguments could be extracted.\n\nTool homepage: https://github.com/jonas-fuchs/virHEAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virheat:0.7.6--pyhdfd78af_0
stdout: virheat.out

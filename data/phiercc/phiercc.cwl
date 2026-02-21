cwlVersion: v1.2
class: CommandLineTool
baseCommand: phiercc
label: phiercc
doc: "The provided text does not contain help information for the tool 'phiercc';
  it contains error logs from a container build process. No arguments or descriptions
  could be extracted.\n\nTool homepage: https://github.com/zheminzhou/pHierCC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phiercc:1.24--pyhdfd78af_0
stdout: phiercc.out

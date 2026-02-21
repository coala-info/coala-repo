cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grz-cli
  - compress
label: grz-cli_compress
doc: "The provided text does not contain help information or usage instructions; it
  contains system log messages and a fatal error regarding disk space during a container
  build. No arguments could be extracted.\n\nTool homepage: https://pypi.org/project/grz-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grz-cli:1.5.1--pyhdfd78af_0
stdout: grz-cli_compress.out

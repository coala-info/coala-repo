cwlVersion: v1.2
class: CommandLineTool
baseCommand: irida-uploader
label: irida-uploader
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it contains container runtime log messages and a fatal error
  regarding disk space.\n\nTool homepage: https://github.com/phac-nml/irida-uploader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irida-uploader:0.9.5--pyhdfd78af_0
stdout: irida-uploader.out

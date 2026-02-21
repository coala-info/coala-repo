cwlVersion: v1.2
class: CommandLineTool
baseCommand: imctools
label: imctools
doc: "The provided text is an error log from a container runtime and does not contain
  help information or usage instructions for imctools. As a result, no arguments could
  be extracted.\n\nTool homepage: https://github.com/BodenmillerGroup/imctools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/imctools:2.1.8--pyhdfd78af_0
stdout: imctools.out

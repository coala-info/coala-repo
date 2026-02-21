cwlVersion: v1.2
class: CommandLineTool
baseCommand: opencontactcli
label: opencontactcli
doc: "The provided text contains error messages from a container runtime environment
  and does not include the help documentation or usage instructions for opencontactcli.
  As a result, no arguments could be extracted.\n\nTool homepage: https://github.com/galaxyproteomics/OpenContact/tree/master"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/opencontactcli:1.1--ha0a0a0d_0
stdout: opencontactcli.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: whoami
label: coreutils_whoami
doc: "Print the user name associated with the current effective user ID. Same as id
  -un.\n\nTool homepage: https://github.com/uutils/coreutils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coreutils:9.5
stdout: coreutils_whoami.out

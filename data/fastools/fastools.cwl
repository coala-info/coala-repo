cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastools
label: fastools
doc: "The provided text does not contain help information for fastools; it contains
  container runtime error messages indicating a failure to pull or build the image
  due to insufficient disk space.\n\nTool homepage: https://git.lumc.nl/j.f.j.laros/fastools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0
stdout: fastools.out

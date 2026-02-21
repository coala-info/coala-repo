cwlVersion: v1.2
class: CommandLineTool
baseCommand: insert-size-dist
label: clever-toolkit_insert-size-dist
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error message regarding a container build failure (no space
  left on device).\n\nTool homepage: https://bitbucket.org/tobiasmarschall/clever-toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clever-toolkit:2.4--h077b44d_14
stdout: clever-toolkit_insert-size-dist.out

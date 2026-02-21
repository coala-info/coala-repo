cwlVersion: v1.2
class: CommandLineTool
baseCommand: align_trim
label: align_trim
doc: "The provided text does not contain help information or usage instructions for
  the tool; it is a log of a container build failure (no space left on device).\n\n
  Tool homepage: https://github.com/artic-network/align_trim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alignlib-lite:0.3--py312h9c9b0c2_9
stdout: align_trim.out

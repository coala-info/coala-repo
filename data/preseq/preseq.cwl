cwlVersion: v1.2
class: CommandLineTool
baseCommand: preseq
label: preseq
doc: "The provided text is a container runtime error log and does not contain help
  information, usage instructions, or argument definitions for the preseq tool.\n\n
  Tool homepage: https://github.com/smithlabcode/preseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/preseq:3.2.0--hdcf5f25_6
stdout: preseq.out

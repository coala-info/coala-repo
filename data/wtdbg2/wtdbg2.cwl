cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtdbg2
label: wtdbg2
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help text or usage information for wtdbg2. As a result,
  no arguments could be extracted.\n\nTool homepage: https://github.com/ruanjue/wtdbg2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wtdbg2:2.0--h470a237_0
stdout: wtdbg2.out

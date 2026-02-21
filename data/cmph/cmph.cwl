cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmph
label: cmph
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain the help documentation or usage instructions for the cmph tool.\n
  \nTool homepage: https://github.com/zvelo/cmph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmph:2.0--h7b50bb2_7
stdout: cmph.out

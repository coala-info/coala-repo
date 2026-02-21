cwlVersion: v1.2
class: CommandLineTool
baseCommand: subread
label: subread
doc: "The provided text does not contain help information or usage instructions for
  the subread tool. It appears to be a log of a failed container build process (Apptainer/Singularity).\n
  \nTool homepage: https://subread.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
stdout: subread.out

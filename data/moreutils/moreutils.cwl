cwlVersion: v1.2
class: CommandLineTool
baseCommand: moreutils
label: moreutils
doc: "The provided text is a system error log from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or usage instructions for the tool.\n\n
  Tool homepage: https://github.com/madx/moreutils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moreutils:0.5.7--1
stdout: moreutils.out

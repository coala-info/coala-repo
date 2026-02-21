cwlVersion: v1.2
class: CommandLineTool
baseCommand: gap
label: gap
doc: "The provided text is a system error message from a container runtime (Apptainer/Singularity)
  and does not contain help documentation or argument definitions for the 'gap' tool.\n
  \nTool homepage: https://github.com/MacGapProject/MacGap1"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gap:4.8.10--0
stdout: gap.out

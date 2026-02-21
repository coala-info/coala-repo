cwlVersion: v1.2
class: CommandLineTool
baseCommand: gap
label: gap_macgap
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build a SIF image due to insufficient disk space.\n\nTool
  homepage: https://github.com/MacGapProject/MacGap1"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gap:4.8.10--0
stdout: gap_macgap.out

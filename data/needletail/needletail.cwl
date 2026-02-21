cwlVersion: v1.2
class: CommandLineTool
baseCommand: needletail
label: needletail
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/onecodex/needletail"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/needletail:0.7.1--py311hb6b3792_0
stdout: needletail.out

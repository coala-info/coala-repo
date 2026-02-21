cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isoseq3
label: isoseq3_isoseq
doc: "The provided text does not contain help information for the tool. It contains
  a fatal error message from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/PacificBiosciences/IsoSeq3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
stdout: isoseq3_isoseq.out

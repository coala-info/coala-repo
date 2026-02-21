cwlVersion: v1.2
class: CommandLineTool
baseCommand: randomFQ
label: ea-utils_randomFQ
doc: "The provided text does not contain help information for the tool. It contains
  a fatal error message from a container runtime (Apptainer/Singularity) indicating
  a failure to build the SIF image due to lack of disk space.\n\nTool homepage: https://expressionanalysis.github.io/ea-utils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ea-utils:1.1.2.779--h9dd4a16_0
stdout: ea-utils_randomFQ.out

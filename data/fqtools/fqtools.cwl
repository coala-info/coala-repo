cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqtools
label: fqtools
doc: "The provided text does not contain help documentation for fqtools. It contains
  a fatal error message from a container runtime (Apptainer/Singularity) indicating
  a failure to build the SIF image due to insufficient disk space ('no space left
  on device').\n\nTool homepage: https://github.com/alastair-droop/fqtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fqtools:2.0--h577a1d6_15
stdout: fqtools.out

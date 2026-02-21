cwlVersion: v1.2
class: CommandLineTool
baseCommand: emboss
label: emboss
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull or build the EMBOSS container image due to insufficient disk space.\n\n
  Tool homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emboss:6.6.0--h0f19ade_14
stdout: emboss.out

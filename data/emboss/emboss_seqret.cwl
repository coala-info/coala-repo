cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqret
label: emboss_seqret
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  pull the EMBOSS image due to lack of disk space.\n\nTool homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emboss:6.6.0--h0f19ade_14
stdout: emboss_seqret.out

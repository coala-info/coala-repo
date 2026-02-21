cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextclade
label: nextclade2
doc: "The provided text does not contain help information for nextclade2; it contains
  error messages regarding a container runtime (Apptainer/Singularity) failing to
  build an image due to lack of disk space.\n\nTool homepage: https://github.com/nextstrain/nextclade"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextclade2:2.14.0--h9ee0642_2
stdout: nextclade2.out

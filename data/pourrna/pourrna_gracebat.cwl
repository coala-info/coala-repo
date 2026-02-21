cwlVersion: v1.2
class: CommandLineTool
baseCommand: pourrna_gracebat
label: pourrna_gracebat
doc: "The provided text does not contain help documentation for the tool. It consists
  of container runtime (Apptainer/Singularity) log messages indicating a failure to
  fetch or build the OCI image.\n\nTool homepage: https://github.com/ViennaRNA/pourRNA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pourrna:1.2.0--h4ac6f70_4
stdout: pourrna_gracebat.out

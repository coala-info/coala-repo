cwlVersion: v1.2
class: CommandLineTool
baseCommand: gembs
label: gembs_GEM3
doc: "The provided text does not contain help documentation for the tool. It contains
  error messages from a container runtime (Singularity/Apptainer) indicating a failure
  to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/heathsc/gemBS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gembs:3.5.5_IHEC--py39h6859054_8
stdout: gembs_GEM3.out

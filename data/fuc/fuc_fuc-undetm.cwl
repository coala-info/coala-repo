cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - undetm
label: fuc_fuc-undetm
doc: "The provided text does not contain help information for the tool; it contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  build an image due to insufficient disk space.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_fuc-undetm.out

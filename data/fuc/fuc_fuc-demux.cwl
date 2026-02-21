cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - demux
label: fuc_fuc-demux
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  build a SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_fuc-demux.out

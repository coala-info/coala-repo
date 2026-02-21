cwlVersion: v1.2
class: CommandLineTool
baseCommand: dligand2
label: dligand2_dligand2.gnu
doc: "The provided text does not contain help documentation for the tool. It contains
  container runtime error messages (Singularity/Apptainer) indicating a failure to
  pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/sysu-yanglab/DLIGAND2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dligand2:0.1.0--h9948957_5
stdout: dligand2_dligand2.gnu.out

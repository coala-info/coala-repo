cwlVersion: v1.2
class: CommandLineTool
baseCommand: espresso_ESPRESSO_C.pl
label: espresso_ESPRESSO_C.pl
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the image due to insufficient disk space.\n\nTool homepage: https://github.com/Xinglab/espresso"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/espresso:1.6.0--pl5321h5ca1c30_1
stdout: espresso_ESPRESSO_C.pl.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_gromacs_tpr_convert
label: biobb_gromacs_tpr_convert
doc: "The provided text does not contain help information for the tool. It is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the image due to lack of disk space ('no space left on device').\n\nTool homepage:
  https://github.com/bioexcel/biobb_gromacs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
stdout: biobb_gromacs_tpr_convert.out

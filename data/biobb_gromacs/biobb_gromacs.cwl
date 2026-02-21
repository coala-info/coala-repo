cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_gromacs
label: biobb_gromacs
doc: "The provided text does not contain help information or documentation for the
  tool. It appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build or extract the container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/bioexcel/biobb_gromacs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_gromacs:5.2.0--pyhdfd78af_0
stdout: biobb_gromacs.out

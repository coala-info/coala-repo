cwlVersion: v1.2
class: CommandLineTool
baseCommand: transannot
label: transannot
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build or extract the container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/soedinglab/transannot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transannot:4.0.0--pl5321hd6d6fdc_2
stdout: transannot.out

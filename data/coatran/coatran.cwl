cwlVersion: v1.2
class: CommandLineTool
baseCommand: coatran
label: coatran
doc: "The provided text does not contain help information for the tool 'coatran'.
  It contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to pull the container image due to lack of disk space.\n\nTool homepage:
  https://github.com/niemasd/CoaTran"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coatran:0.0.4--h503566f_1
stdout: coatran.out

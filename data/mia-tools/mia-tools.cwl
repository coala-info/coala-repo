cwlVersion: v1.2
class: CommandLineTool
baseCommand: mia-tools
label: mia-tools
doc: "The provided text does not contain help information for mia-tools; it is an
  error log from a container runtime (Apptainer/Singularity) indicating a failure
  to pull or build the container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/MIA-iEEG/mia"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mia-tools:v2.4.6-4-deb_cv1
stdout: mia-tools.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: scipy
label: scipy
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log related to a container runtime (Singularity/Apptainer)
  failing to pull a Docker image due to insufficient disk space.\n\nTool homepage:
  https://github.com/scipy/scipy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scipy:1.1.0
stdout: scipy.out

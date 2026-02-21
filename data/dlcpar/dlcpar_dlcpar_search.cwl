cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dlcpar_search
label: dlcpar_dlcpar_search
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failing to pull
  a Docker image due to insufficient disk space.\n\nTool homepage: https://github.com/wutron/dlcpar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dlcpar:1.0--py27_0
stdout: dlcpar_dlcpar_search.out

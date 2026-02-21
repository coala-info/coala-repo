cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhg
label: mhg
doc: "The provided text does not contain help information for the tool 'mhg'. It contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to pull or build the container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/NakhlehLab/Maximal-Homologous-Groups"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhg:1.1.0--hdfd78af_0
stdout: mhg.out

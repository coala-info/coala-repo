cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermikit
label: fermikit
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failure.\n
  \nTool homepage: https://github.com/lh3/fermikit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermikit:0.14.dev1--pl5321h86e5fe9_2
stdout: fermikit.out

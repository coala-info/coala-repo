cwlVersion: v1.2
class: CommandLineTool
baseCommand: tabulate
label: tabulate
doc: "The provided text does not contain help information for the 'tabulate' command;
  it is an error log from a container runtime (Apptainer/Singularity) failing to fetch
  a Docker image.\n\nTool homepage: https://github.com/astanin/python-tabulate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tabulate:0.7.5--py36_0
stdout: tabulate.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: rmath4
label: rmath4
doc: "The provided text does not contain help information for the tool. It consists
  of log messages and a fatal error from a container runtime (Apptainer/Singularity)
  attempting to fetch a Docker image.\n\nTool homepage: https://github.com/alex-wave/Rmath-python"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rmath4:4.3.1--py39hbcbf7aa_2
stdout: rmath4.out

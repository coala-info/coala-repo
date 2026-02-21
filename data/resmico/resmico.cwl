cwlVersion: v1.2
class: CommandLineTool
baseCommand: resmico
label: resmico
doc: "The provided text does not contain help information for the tool 'resmico'.
  It contains log messages and a fatal error from a container runtime (Apptainer/Singularity)
  attempting to fetch a Docker image.\n\nTool homepage: https://github.com/leylabmpi/ResMiCo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/resmico:1.2.2--py310h6cc9453_1
stdout: resmico.out

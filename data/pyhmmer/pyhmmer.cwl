cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyhmmer
label: pyhmmer
doc: "The provided text does not contain help information for pyhmmer; it is an error
  log from a container runtime (Apptainer/Singularity) failing to fetch or build the
  pyhmmer image.\n\nTool homepage: https://github.com/althonos/pyhmmer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyhmmer:0.12.0--py313h366bbf7_0
stdout: pyhmmer.out

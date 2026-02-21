cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyskani
label: pyskani
doc: "The provided text does not contain help information for pyskani; it is an error
  log from a container runtime (Apptainer/Singularity) failing to fetch the tool's
  image.\n\nTool homepage: https://github.com/althonos/pyskani/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyskani:0.2.0--py311h5e00ca1_0
stdout: pyskani.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyopal
label: pyopal
doc: "The provided text does not contain help information or usage instructions for
  pyopal; it contains error logs from a container runtime (Singularity/Apptainer)
  failing to pull the image.\n\nTool homepage: https://github.com/althonos/pyopal"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyopal:0.7.3--py312h9c9b0c2_0
stdout: pyopal.out

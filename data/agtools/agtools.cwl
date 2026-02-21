cwlVersion: v1.2
class: CommandLineTool
baseCommand: agtools
label: agtools
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: https://github.com/Vini2/agtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agtools:1.0.2--py313hdfd78af_0
stdout: agtools.out

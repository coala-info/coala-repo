cwlVersion: v1.2
class: CommandLineTool
baseCommand: spectrassembler
label: spectrassembler
doc: "The provided text does not contain help information or usage instructions for
  spectrassembler; it contains error logs from a container runtime (Apptainer/Singularity)
  attempting to fetch the tool's image.\n\nTool homepage: https://github.com/antrec/spectrassembler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spectrassembler:0.0.1a1--py27_1
stdout: spectrassembler.out

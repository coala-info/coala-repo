cwlVersion: v1.2
class: CommandLineTool
baseCommand: blastbesties
label: blastbesties
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error messages related to a Singularity/Docker container
  execution failure (no space left on device).\n\nTool homepage: https://github.com/Adamtaranto/blast-besties"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blastbesties:1.2.0--pyhdfd78af_0
stdout: blastbesties.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: pdbxyz
label: tinker_pdbxyz
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container image retrieval (Apptainer/Singularity).\n\nTool
  homepage: https://dasher.wustl.edu/tinker/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_pdbxyz.out

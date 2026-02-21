cwlVersion: v1.2
class: CommandLineTool
baseCommand: sam2pairwise
label: sam2pairwise
doc: "The provided text does not contain help information for sam2pairwise. It appears
  to be a container runtime error log from Apptainer/Singularity.\n\nTool homepage:
  https://github.com/mlafave/sam2pairwise"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sam2pairwise:1.0.0--h9948957_1
stdout: sam2pairwise.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: distree
label: distree
doc: "The provided text is an error log from a container runtime (Apptainer/Singularity)
  and does not contain help information or usage instructions for the tool.\n\nTool
  homepage: https://github.com/PathoGenOmics-Lab/distree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/distree:1.0.0--h4349ce8_0
stdout: distree.out

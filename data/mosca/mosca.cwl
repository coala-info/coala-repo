cwlVersion: v1.2
class: CommandLineTool
baseCommand: mosca
label: mosca
doc: "MOSCA (Metagenomics and Oxygen-Sensing Cluster Analysis) - Note: The provided
  text is an error log from a container runtime and does not contain help information
  or argument definitions.\n\nTool homepage: https://github.com/iquasere/MOSCA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mosca:2.3.0--hdfd78af_0
stdout: mosca.out

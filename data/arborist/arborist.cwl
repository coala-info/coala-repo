cwlVersion: v1.2
class: CommandLineTool
baseCommand: arborist
label: arborist
doc: "The provided text does not contain help information or usage instructions for
  the tool 'arborist'. It contains error logs related to a container runtime (Apptainer/Singularity)
  failure during image extraction.\n\nTool homepage: https://github.com/VanLoo-lab/Arborist"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arborist:1.0.0--pyhdfd78af_0
stdout: arborist.out

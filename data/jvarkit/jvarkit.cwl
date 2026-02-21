cwlVersion: v1.2
class: CommandLineTool
baseCommand: jvarkit
label: jvarkit
doc: "The provided text does not contain help information for the tool. It contains
  error messages from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/lindenb/jvarkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jvarkit:2024.08.25--hdfd78af_2
stdout: jvarkit.out

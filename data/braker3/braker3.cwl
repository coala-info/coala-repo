cwlVersion: v1.2
class: CommandLineTool
baseCommand: braker3
label: braker3
doc: "The provided text does not contain help information or a description of the
  tool; it contains error messages related to a container runtime (Singularity/Apptainer)
  failing to pull the braker3 image due to insufficient disk space.\n\nTool homepage:
  https://github.com/Gaius-Augustus/BRAKER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/braker3:3.0.8--hdfd78af_0
stdout: braker3.out

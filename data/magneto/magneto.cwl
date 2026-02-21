cwlVersion: v1.2
class: CommandLineTool
baseCommand: magneto
label: magneto
doc: "The provided text does not contain help information for the tool 'magneto'.
  It contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build or pull the container image due to lack of disk space.\n\nTool
  homepage: https://gitlab.univ-nantes.fr/bird_pipeline_registry/magneto"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magneto:1.5.1--pyhdfd78af_0
stdout: magneto.out

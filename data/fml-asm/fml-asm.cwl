cwlVersion: v1.2
class: CommandLineTool
baseCommand: fml-asm
label: fml-asm
doc: "The provided text does not contain help information for fml-asm; it contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to pull the image due to lack of disk space.\n\nTool homepage: https://github.com/HurriKane/skyfactory-2.4-faults"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fml-asm:v0.1-5-deb_cv1
stdout: fml-asm.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: e-mem
label: e-mem
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failing to build
  the image due to insufficient disk space.\n\nTool homepage: https://github.com/EverMind-AI/EverMemOS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/e-mem:v1.0.1-2-deb_cv1
stdout: e-mem.out

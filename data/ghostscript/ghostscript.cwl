cwlVersion: v1.2
class: CommandLineTool
baseCommand: ghostscript
label: ghostscript
doc: "The provided text does not contain help information for Ghostscript; it contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the container image due to insufficient disk space.\n\nTool homepage: https://github.com/duc-nt/RCE-0-day-for-GhostScript-9.50"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ghostscript:9.18--1
stdout: ghostscript.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: libcifpp
label: libcifpp
doc: "The provided text does not contain help information for libcifpp; it contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to pull the container image due to insufficient disk space.\n\nTool homepage: https://github.com/PDB-REDO/libcifpp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libcifpp:9.0.6--hddb1751_1
stdout: libcifpp.out

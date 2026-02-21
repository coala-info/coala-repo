cwlVersion: v1.2
class: CommandLineTool
baseCommand: jemalloc
label: jemalloc
doc: "The provided text does not contain help information for the tool; it contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/jemalloc/jemalloc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jemalloc:4.5.0--0
stdout: jemalloc.out

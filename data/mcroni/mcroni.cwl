cwlVersion: v1.2
class: CommandLineTool
baseCommand: mcroni
label: mcroni
doc: "The provided text does not contain help information for mcroni; it contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to build the container due to lack of disk space.\n\nTool homepage: https://github.com/liampshaw/mcroni"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcroni:1.0.4--pyh5e36f6f_0
stdout: mcroni.out

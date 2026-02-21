cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamsurgeon
label: bamsurgeon
doc: "The provided text does not contain help information for bamsurgeon; it contains
  error logs from a container runtime (Apptainer/Singularity) indicating a failure
  to extract the tool's image due to lack of disk space.\n\nTool homepage: https://github.com/adamewing/bamsurgeon"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamsurgeon:1.4.1--pyhdfd78af_0
stdout: bamsurgeon.out

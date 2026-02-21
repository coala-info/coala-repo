cwlVersion: v1.2
class: CommandLineTool
baseCommand: sourcetracker
label: sourcetracker
doc: "The provided text does not contain help information for sourcetracker; it contains
  error logs from a container runtime (Apptainer/Singularity) failing to fetch the
  tool's image.\n\nTool homepage: http://www.biota.com"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sourcetracker:2.0.1--pyh24bf2e0_0
stdout: sourcetracker.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: multigps
label: multigps
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to insufficient disk space.\n\nTool homepage: https://github.com/shaunmahony/multigps-archive"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multigps:0.74--r3.3.1_0
stdout: multigps.out

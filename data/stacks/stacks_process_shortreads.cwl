cwlVersion: v1.2
class: CommandLineTool
baseCommand: process_shortreads
label: stacks_process_shortreads
doc: "The provided text does not contain help information for the tool. It consists
  of container runtime (Apptainer/Singularity) error logs indicating a failure to
  fetch or build the OCI image.\n\nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_process_shortreads.out

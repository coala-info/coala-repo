cwlVersion: v1.2
class: CommandLineTool
baseCommand: stacks-web_process_radtags
label: stacks-web_process_radtags
doc: "The provided text does not contain help information or usage instructions. It
  consists of system logs and a fatal error message from a container runtime (Apptainer/Singularity)
  indicating a failure to fetch or build the OCI image.\n\nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/stacks-web:v2.2dfsg-1-deb_cv1
stdout: stacks-web_process_radtags.out

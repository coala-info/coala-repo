cwlVersion: v1.2
class: CommandLineTool
baseCommand: process_shortreads
label: stacks-web_process_shortreads
doc: "The provided text does not contain help information; it contains container runtime
  error logs regarding the failure to fetch or build the OCI image.\n\nTool homepage:
  https://catchenlab.life.illinois.edu/stacks/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/stacks-web:v2.2dfsg-1-deb_cv1
stdout: stacks-web_process_shortreads.out

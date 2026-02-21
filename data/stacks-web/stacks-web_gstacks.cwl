cwlVersion: v1.2
class: CommandLineTool
baseCommand: gstacks
label: stacks-web_gstacks
doc: "The provided text does not contain help information. It appears to be a container
  execution error log from a failed attempt to fetch or build the OCI image.\n\nTool
  homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/stacks-web:v2.2dfsg-1-deb_cv1
stdout: stacks-web_gstacks.out

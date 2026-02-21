cwlVersion: v1.2
class: CommandLineTool
baseCommand: stacks-web
label: stacks-web
doc: "The provided text contains container runtime logs and a fatal error message
  rather than tool help text. No command-line arguments or descriptions could be extracted.\n
  \nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/stacks-web:v2.2dfsg-1-deb_cv1
stdout: stacks-web.out

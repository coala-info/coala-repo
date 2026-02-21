cwlVersion: v1.2
class: CommandLineTool
baseCommand: gnumed-server
label: gnumed-server
doc: "GNUmed server (Note: The provided text is a container runtime error log and
  does not contain help information or argument definitions.)\n\nTool homepage: https://github.com/aur-archive/gnumed-server"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gnumed-server:v22.5-1-deb_cv1
stdout: gnumed-server.out

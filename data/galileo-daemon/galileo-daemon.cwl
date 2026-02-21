cwlVersion: v1.2
class: CommandLineTool
baseCommand: galileo-daemon
label: galileo-daemon
doc: "Galileo daemon (Note: The provided text contains container runtime error logs
  and does not list specific command-line arguments or usage instructions).\n\nTool
  homepage: https://github.com/pc-coholic/galileo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/galileo-daemon:v0.5.1-6-deb_cv1
stdout: galileo-daemon.out

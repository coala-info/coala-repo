cwlVersion: v1.2
class: CommandLineTool
baseCommand: sshash
label: sshash
doc: "The provided text does not contain help information or usage instructions; it
  consists of system logs and a fatal error message regarding a container build failure.\n
  \nTool homepage: https://github.com/jermp/sshash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sshash:5.0.0--haf24da9_0
stdout: sshash.out

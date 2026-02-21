cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-minion-backend-sqlite
label: perl-minion-backend-sqlite
doc: "A SQLite backend for the Minion job queue. (Note: The provided text is a system
  error log indicating a failure to pull the container image due to insufficient disk
  space, and does not contain CLI help documentation.)\n\nTool homepage: https://github.com/Grinnz/Minion-Backend-SQLite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-minion-backend-sqlite:5.0.7--pl5321hdfd78af_0
stdout: perl-minion-backend-sqlite.out

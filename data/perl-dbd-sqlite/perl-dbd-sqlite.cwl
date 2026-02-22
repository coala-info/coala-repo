cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-dbd-sqlite
label: perl-dbd-sqlite
doc: "The provided text does not contain help information or usage instructions; it
  consists of system error logs regarding a failed container build due to insufficient
  disk space.\n\nTool homepage: https://metacpan.org/pod/DBD::SQLite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-dbd-sqlite:1.78--pl5321h6709bd3_0
stdout: perl-dbd-sqlite.out

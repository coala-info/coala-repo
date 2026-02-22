cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-mojo-sqlite
label: perl-mojo-sqlite
doc: "The provided text does not contain help information or a description of the
  tool. It contains system error messages related to a Singularity/OCI container build
  failure (no space left on device).\n\nTool homepage: https://github.com/Grinnz/Mojo-SQLite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-mojo-sqlite:3.009--pl5321hdfd78af_0
stdout: perl-mojo-sqlite.out

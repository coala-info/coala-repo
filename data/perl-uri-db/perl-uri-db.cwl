cwlVersion: v1.2
class: CommandLineTool
baseCommand: uri-db
label: perl-uri-db
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error messages related to a failed container build
  (Singularity/OCI) due to insufficient disk space.\n\nTool homepage: https://search.cpan.org/dist/URI-db/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-uri-db:0.23--pl5321hdfd78af_0
stdout: perl-uri-db.out

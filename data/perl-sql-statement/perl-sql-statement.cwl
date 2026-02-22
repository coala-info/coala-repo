cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sql-statement
label: perl-sql-statement
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull a Docker image due to insufficient disk space.\n\nTool homepage:
  https://metacpan.org/release/SQL-Statement"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sql-statement:1.414--pl5321hdfd78af_0
stdout: perl-sql-statement.out

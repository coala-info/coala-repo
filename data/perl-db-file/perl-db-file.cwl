cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-db-file
label: perl-db-file
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of error logs related to a container image build failure (Singularity/OCI
  conversion) due to insufficient disk space.\n\nTool homepage: https://metacpan.org/pod/Set::IntervalTree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-db-file:1.855--pl5321h779adbc_1
stdout: perl-db-file.out

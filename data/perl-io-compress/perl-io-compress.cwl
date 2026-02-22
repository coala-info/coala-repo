cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-compress
label: perl-io-compress
doc: "The provided text does not contain help information or usage instructions; it
  is a system error log indicating a failure to build or pull a Singularity container
  due to insufficient disk space.\n\nTool homepage: https://metacpan.org/pod/IO::Compress"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-io-compress:2.216--pl5321h503566f_0
stdout: perl-io-compress.out

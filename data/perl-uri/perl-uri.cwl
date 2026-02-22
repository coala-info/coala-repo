cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-uri
label: perl-uri
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log indicating a failure to build or pull
  a Singularity container due to insufficient disk space.\n\nTool homepage: https://github.com/libwww-perl/URI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-uri:5.12--pl5321hdfd78af_0
stdout: perl-uri.out

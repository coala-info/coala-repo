cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-util
label: perl-file-util
doc: "The provided text does not contain help information or usage instructions. It
  consists of system error messages related to a failed container image build due
  to insufficient disk space.\n\nTool homepage: https://github.com/tommybutler/file-util/wiki"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-util:4.201720--pl5321hdfd78af_0
stdout: perl-file-util.out

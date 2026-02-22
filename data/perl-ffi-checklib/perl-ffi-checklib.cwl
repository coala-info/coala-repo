cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-ffi-checklib
label: perl-ffi-checklib
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system error messages related to disk space and container
  image conversion.\n\nTool homepage: https://metacpan.org/pod/FFI::CheckLib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-ffi-checklib:0.31--pl5321hdfd78af_0
stdout: perl-ffi-checklib.out

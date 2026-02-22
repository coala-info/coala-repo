cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-next
label: perl-file-next
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error messages related to a container runtime failure
  (no space left on device).\n\nTool homepage: http://metacpan.org/pod/File::Next"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-next:1.18--pl5321hdfd78af_0
stdout: perl-file-next.out

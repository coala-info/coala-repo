cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-ipc-cmd
label: perl-ipc-cmd
doc: "The provided text does not contain help documentation for the tool. It consists
  of system error messages related to a Singularity/Docker container execution failure
  (no space left on device). perl-ipc-cmd is typically a Perl module (IPC::Cmd) used
  for finding and running system commands.\n\nTool homepage: http://metacpan.org/pod/IPC::Cmd"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-ipc-cmd:1.04--pl5321hdfd78af_1
stdout: perl-ipc-cmd.out

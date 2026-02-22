cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-ipc-run
label: perl-ipc-run
doc: "The provided text does not contain help information for the tool. It consists
  of system error messages related to a Singularity/Docker image pull failure (no
  space left on device).\n\nTool homepage: https://metacpan.org/pod/IPC::Run"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-ipc-run:20250809.0--pl5321hdfd78af_0
stdout: perl-ipc-run.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-ipc-run3
label: perl-ipc-run3
doc: "The provided text does not contain help information for the tool. It contains
  system error messages (WARNING, INFO, FATAL) related to a failed Singularity/Apptainer
  container build due to insufficient disk space.\n\nTool homepage: http://metacpan.org/pod/IPC::Run3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-ipc-run3:0.049--pl5321hdfd78af_0
stdout: perl-ipc-run3.out

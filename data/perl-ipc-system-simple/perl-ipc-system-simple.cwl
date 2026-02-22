cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-ipc-system-simple
label: perl-ipc-system-simple
doc: "The provided text is a system error log indicating a failure to pull or build
  a container image due to insufficient disk space ('no space left on device'), rather
  than command-line help text. Consequently, no arguments or tool descriptions could
  be extracted.\n\nTool homepage: http://metacpan.org/pod/IPC::System::Simple"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-ipc-system-simple:1.30--pl5321hdfd78af_0
stdout: perl-ipc-system-simple.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-http-daemon
label: perl-http-daemon
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system error messages related to a container runtime (Singularity/Apptainer)
  failing to pull an image due to insufficient disk space.\n\nTool homepage: http://metacpan.org/pod/HTTP-Daemon"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-http-daemon:6.16--pl5321hdfd78af_0
stdout: perl-http-daemon.out

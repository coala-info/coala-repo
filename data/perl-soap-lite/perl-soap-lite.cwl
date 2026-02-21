cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-soap-lite
label: perl-soap-lite
doc: "The provided text does not contain help information or usage instructions for
  perl-soap-lite. It appears to be an error log from a container runtime (Apptainer/Singularity)
  attempting to fetch a Docker image.\n\nTool homepage: http://metacpan.org/pod/SOAP-Lite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-soap-lite:1.27--pl5321hdfd78af_0
stdout: perl-soap-lite.out

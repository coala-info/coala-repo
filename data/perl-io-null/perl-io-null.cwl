cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-null
label: perl-io-null
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error messages related to a Singularity/Apptainer
  container build failure ('no space left on device'). IO::Null is a Perl module that
  provides a null filehandle.\n\nTool homepage: http://metacpan.org/pod/IO::Null"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-io-null:1.01--pl5321hdfd78af_2
stdout: perl-io-null.out

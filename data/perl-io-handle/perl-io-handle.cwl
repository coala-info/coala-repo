cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-handle
label: perl-io-handle
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a Singularity/Apptainer container build process indicating
  a 'no space left on device' failure.\n\nTool homepage: http://metacpan.org/pod/IO::Handle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-io-handle:1.42--pl5321hdfd78af_2
stdout: perl-io-handle.out

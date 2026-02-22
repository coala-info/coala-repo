cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-dbm-deep
label: perl-dbm-deep
doc: "A multi-level storage engine for Perl. (Note: The provided text contains system
  error messages regarding disk space and container image conversion rather than command-line
  help documentation.)\n\nTool homepage: http://metacpan.org/pod/DBM-Deep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-dbm-deep:2.0019--pl5321hdfd78af_0
stdout: perl-dbm-deep.out

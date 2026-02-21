cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-extutils-helpers
label: perl-extutils-helpers
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is an error log indicating that the executable 'perl-extutils-helpers'
  was not found in the system PATH during an Apptainer/Singularity execution.\n\n
  Tool homepage: http://metacpan.org/pod/ExtUtils::Helpers"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-extutils-helpers:0.026--pl526_0
stdout: perl-extutils-helpers.out

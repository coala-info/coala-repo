cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-mldbm
label: perl-mldbm
doc: "The provided text does not contain help information as the executable was not
  found in the environment. MLDBM (Multi-Level Data Base Manager) is typically a Perl
  module used to store multi-level hash structures in single-level tied hashes.\n\n
  Tool homepage: https://github.com/pld-linux/perl-MLDBM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-mldbm:2.05--pl526_1
stdout: perl-mldbm.out

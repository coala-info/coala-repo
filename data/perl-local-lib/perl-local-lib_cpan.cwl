cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cpan
label: perl-local-lib_cpan
doc: "CPAN.pm is used to query, download, build, and install Perl modules from CPAN
  sites. This specific instance appears to be configuring a local::lib environment
  for managing Perl dependencies without root privileges.\n\nTool homepage: http://metacpan.org/pod/local::lib"
inputs:
  - id: modules
    type:
      - 'null'
      - type: array
        items: string
    doc: One or more Perl modules to install or query
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-local-lib:2.000029--pl5321hdfd78af_0
stdout: perl-local-lib_cpan.out

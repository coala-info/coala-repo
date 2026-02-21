cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-www-mechanize
label: perl-www-mechanize
doc: "The provided text is a system error log from an Apptainer/Singularity build
  process and does not contain help text or command-line arguments for the tool 'perl-www-mechanize'.\n
  \nTool homepage: https://metacpan.org/pod/WWW::Mechanize"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-www-mechanize:2.20--pl5321hdfd78af_0
stdout: perl-www-mechanize.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-homedir
label: perl-file-homedir
doc: "A Perl utility for locating the home directory of users on various operating
  systems.\n\nTool homepage: https://metacpan.org/release/File-HomeDir"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-homedir:1.004--pl526_2
stdout: perl-file-homedir.out

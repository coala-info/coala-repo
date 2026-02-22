cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-slurper
label: perl-file-slurper
doc: "A simple, sane and efficient Perl module to slurp a file (read/write entire
  files). Note: The provided text appears to be a system error log regarding a container
  build failure rather than CLI help text; therefore, no arguments could be extracted.\n\
  \nTool homepage: http://metacpan.org/pod/File-Slurper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-slurper:0.014--pl5321hdfd78af_0
stdout: perl-file-slurper.out

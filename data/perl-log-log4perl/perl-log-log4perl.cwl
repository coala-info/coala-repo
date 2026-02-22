cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-log-log4perl
label: perl-log-log4perl
doc: "Log::Log4perl is a Perl port of the log4j logging library. Note: The provided
  text appears to be a system error log regarding a container build failure and does
  not contain command-line usage information or arguments.\n\nTool homepage: http://metacpan.org/pod/Log::Log4perl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-log-log4perl:1.55--pl5321hdfd78af_0
stdout: perl-log-log4perl.out

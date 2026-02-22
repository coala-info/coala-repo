cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-module-load
label: perl-module-load
doc: "A tool for loading Perl modules (Note: The provided text contains system error
  messages rather than command-line help documentation, so no arguments could be extracted).\n\
  \nTool homepage: http://metacpan.org/pod/Module::Load"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-module-load:0.34--pl5321hdfd78af_0
stdout: perl-module-load.out

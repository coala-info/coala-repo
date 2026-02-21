cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-module-loaded
label: perl-module-loaded
doc: "A tool to check if a Perl module is loaded or available. (Note: The provided
  text contained system logs and an error message rather than help text; no arguments
  could be extracted.)\n\nTool homepage: http://metacpan.org/pod/Module::Loaded"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-module-loaded:0.08--pl526_0
stdout: perl-module-loaded.out

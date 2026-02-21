cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-probe-perl
label: perl-probe-perl
doc: "The tool 'perl-probe-perl' could not be executed, and no help text was provided
  in the input. The provided text contains system logs indicating a fatal error where
  the executable was not found in the PATH.\n\nTool homepage: http://metacpan.org/pod/Probe::Perl"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-probe-perl:0.03--pl526_0
stdout: perl-probe-perl.out

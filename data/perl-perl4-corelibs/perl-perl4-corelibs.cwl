cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-perl4-corelibs
label: perl-perl4-corelibs
doc: "Legacy Perl 4 libraries. Note: The provided text is an error log indicating
  the executable was not found, and does not contain usage information or argument
  definitions.\n\nTool homepage: http://metacpan.org/pod/Perl4-CoreLibs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-perl4-corelibs:0.004--pl5.22.0_0
stdout: perl-perl4-corelibs.out

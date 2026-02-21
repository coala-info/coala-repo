cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sub-name
label: perl-sub-name
doc: "A tool related to the Perl Sub::Name module, used for renaming subroutines.
  (Note: The provided help text contains only container execution logs and indicates
  the executable was not found, so no specific arguments could be extracted.)\n\n
  Tool homepage: https://github.com/gfx/Perl-Sub-Name"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sub-name:0.21--pl5.22.0_0
stdout: perl-sub-name.out

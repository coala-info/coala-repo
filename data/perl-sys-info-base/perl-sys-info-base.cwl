cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-sys-info-base
label: perl-sys-info-base
doc: "The provided text does not contain help documentation or usage instructions;
  it is an error log indicating that the executable 'perl-sys-info-base' was not found
  in the system PATH.\n\nTool homepage: http://metacpan.org/pod/Sys::Info::Base"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sys-info-base:0.7807--pl526_0
stdout: perl-sys-info-base.out

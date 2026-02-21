cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-module-runtime
label: perl-module-runtime
doc: "Perl module runtime (Note: The provided text is an error log indicating the
  executable was not found and does not contain help documentation).\n\nTool homepage:
  http://metacpan.org/pod/Module-Runtime"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-module-runtime:0.016--pl526_0
stdout: perl-module-runtime.out

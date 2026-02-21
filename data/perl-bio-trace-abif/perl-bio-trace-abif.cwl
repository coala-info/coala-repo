cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-trace-abif
label: perl-bio-trace-abif
doc: "The provided text is an error log indicating that the executable 'perl-bio-trace-abif'
  was not found in the system PATH. No help text or usage information was available
  to parse arguments.\n\nTool homepage: https://metacpan.org/pod/Bio::Trace::ABIF"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-trace-abif:1.06--pl526_0
stdout: perl-bio-trace-abif.out

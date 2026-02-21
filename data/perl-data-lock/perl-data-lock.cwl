cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-data-lock
label: perl-data-lock
doc: "The provided text is an error log indicating that the executable 'perl-data-lock'
  was not found in the system path; no help text or usage information was available
  to parse.\n\nTool homepage: http://metacpan.org/pod/Data::Lock"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-data-lock:1.03--pl526_0
stdout: perl-data-lock.out

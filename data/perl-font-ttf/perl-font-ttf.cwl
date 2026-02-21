cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-font-ttf
label: perl-font-ttf
doc: "The provided text is an error log indicating that the executable 'perl-font-ttf'
  was not found in the system path. No help text or usage information was available
  to parse arguments.\n\nTool homepage: http://metacpan.org/pod/Font-TTF"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-font-ttf:1.06--pl526_0
stdout: perl-font-ttf.out

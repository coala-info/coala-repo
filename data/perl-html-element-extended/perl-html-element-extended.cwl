cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-html-element-extended
label: perl-html-element-extended
doc: "The provided text is an error log indicating that the executable 'perl-html-element-extended'
  was not found in the system PATH. No help text or usage information was available
  to parse arguments.\n\nTool homepage: https://github.com/pld-linux/perl-HTML-Element-Extended"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-html-element-extended:1.18--pl526_1
stdout: perl-html-element-extended.out

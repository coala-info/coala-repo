cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-html-tree
label: perl-html-tree
doc: "The provided text is an error log indicating that the executable 'perl-html-tree'
  was not found in the system path. No help text or usage information was available
  to parse.\n\nTool homepage: http://metacpan.org/pod/HTML::Tree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-html-tree:5.07--pl526_0
stdout: perl-html-tree.out

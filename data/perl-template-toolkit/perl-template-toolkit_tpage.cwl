cwlVersion: v1.2
class: CommandLineTool
baseCommand: tpage
label: perl-template-toolkit_tpage
doc: "A command-line interface to the Template Toolkit, used to process template files.\n
  \nTool homepage: https://metacpan.org/pod/Template::Toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-template-toolkit:3.102--pl5321h7b50bb2_1
stdout: perl-template-toolkit_tpage.out

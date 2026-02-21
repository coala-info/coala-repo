cwlVersion: v1.2
class: CommandLineTool
baseCommand: ttree
label: perl-template-toolkit_ttree
doc: "The ttree script is used to process entire directory trees of templates. It
  is part of the Perl Template Toolkit.\n\nTool homepage: https://metacpan.org/pod/Template::Toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-template-toolkit:3.102--pl5321h7b50bb2_1
stdout: perl-template-toolkit_ttree.out

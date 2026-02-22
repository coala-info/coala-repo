cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-obogaf-parser
label: perl-obogaf-parser
doc: "A tool for parsing OBO (Open Biomedical Ontologies) and GAF (Gene Association
  File) formats.\n\nTool homepage: http://metacpan.org/pod/obogaf::parser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-obogaf-parser:1.373--pl5321hdfd78af_2
stdout: perl-obogaf-parser.out

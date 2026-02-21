cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xml-semanticdiff
label: perl-xml-semanticdiff
doc: "A tool for comparing XML documents semantically. (Note: The provided help text
  indicates a fatal error where the executable was not found, so specific arguments
  could not be parsed from the input.)\n\nTool homepage: http://metacpan.org/pod/XML-SemanticDiff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-semanticdiff:1.0007--pl526_0
stdout: perl-xml-semanticdiff.out

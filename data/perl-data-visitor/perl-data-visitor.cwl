cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-data-visitor
label: perl-data-visitor
doc: "A tool for visiting and transforming Perl data structures. (Note: The provided
  help text indicates a fatal error and does not contain usage information or argument
  definitions.)\n\nTool homepage: http://metacpan.org/release/Data-Visitor"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-data-visitor:0.30--0
stdout: perl-data-visitor.out

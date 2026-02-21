cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xml-namespacesupport
label: perl-xml-namespacesupport
doc: "The provided text does not contain help documentation as the executable was
  not found in the environment. perl-xml-namespacesupport is typically a Perl module
  (XML::NamespaceSupport) used for supporting XML namespaces.\n\nTool homepage: https://github.com/perigrin/xml-namespacesupport"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-namespacesupport:1.12--pl526_0
stdout: perl-xml-namespacesupport.out

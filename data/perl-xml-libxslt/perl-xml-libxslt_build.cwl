cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xml-libxslt_build
label: perl-xml-libxslt_build
doc: "The provided text is a log of a failed container build process for perl-xml-libxslt
  (due to 'no space left on device') rather than command-line help text. As a result,
  no arguments or options could be extracted.\n\nTool homepage: https://metacpan.org/pod/XML::LibXSLT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-libxslt:2.003000--pl5321h7b50bb2_2
stdout: perl-xml-libxslt_build.out

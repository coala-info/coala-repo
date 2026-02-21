cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xml-dom-xpath
label: perl-xml-dom-xpath
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log from a container build process (Apptainer/Singularity) that failed
  due to insufficient disk space.\n\nTool homepage: https://github.com/gooselinux/perl-XML-DOM-XPath"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-dom-xpath:0.14--pl526_1
stdout: perl-xml-dom-xpath.out

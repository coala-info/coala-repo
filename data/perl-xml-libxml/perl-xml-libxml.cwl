cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-xml-libxml
label: perl-xml-libxml
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be an error log from a container build process (Apptainer/Singularity)
  indicating a 'no space left on device' failure while fetching a Docker image.\n\n
  Tool homepage: https://bitbucket.org/shlomif/perl-xml-libxml"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-libxml:2.0210--pl5321hd2ab53c_1
stdout: perl-xml-libxml.out

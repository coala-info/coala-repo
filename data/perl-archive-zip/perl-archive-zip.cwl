cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-archive-zip
label: perl-archive-zip
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of error logs related to a Singularity/Apptainer container
  build failure due to insufficient disk space.\n\nTool homepage: http://metacpan.org/pod/Archive::Zip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-archive-zip:1.68--pl5321hdfd78af_0
stdout: perl-archive-zip.out

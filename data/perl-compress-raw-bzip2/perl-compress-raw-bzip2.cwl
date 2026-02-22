cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-compress-raw-bzip2
label: perl-compress-raw-bzip2
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is an error log indicating a failure to build or run a Singularity/Apptainer
  container due to insufficient disk space ('no space left on device').\n\nTool homepage:
  http://metacpan.org/pod/Compress::Raw::Bzip2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-compress-raw-bzip2:2.201--pl5321h87f3376_1
stdout: perl-compress-raw-bzip2.out

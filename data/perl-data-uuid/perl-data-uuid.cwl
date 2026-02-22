cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-data-uuid
label: perl-data-uuid
doc: "The provided text is an error log from a Singularity/Apptainer environment indicating
  a failure to pull or build a container image due to insufficient disk space. It
  does not contain CLI help information or usage instructions for the perl-data-uuid
  tool.\n\nTool homepage: https://metacpan.org/pod/Data::UUID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-data-uuid:1.227--pl5321h9948957_1
stdout: perl-data-uuid.out

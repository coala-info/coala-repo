cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-io-pager
label: perl-io-pager
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log related to a container runtime (Singularity/Apptainer)
  failing due to insufficient disk space.\n\nTool homepage: http://metacpan.org/pod/IO-Pager"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-io-pager:2.10--pl5321hdfd78af_1
stdout: perl-io-pager.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-timedate
label: perl-timedate
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log from a Singularity/Apptainer container execution failure
  due to insufficient disk space.\n\nTool homepage: http://metacpan.org/pod/TimeDate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-timedate:2.33--pl5321hdfd78af_2
stdout: perl-timedate.out

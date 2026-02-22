cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-http-date
label: perl-http-date
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of error messages from a container runtime (Singularity/Apptainer)
  indicating a failure to pull or build the container image due to insufficient disk
  space ('no space left on device').\n\nTool homepage: http://metacpan.org/pod/HTTP::Date"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-http-date:6.06--pl5321hdfd78af_0
stdout: perl-http-date.out

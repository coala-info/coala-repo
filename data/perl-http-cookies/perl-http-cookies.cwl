cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-http-cookies
label: perl-http-cookies
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log related to a failed Singularity/Apptainer container build
  due to insufficient disk space.\n\nTool homepage: https://github.com/libwww-perl/http-cookies"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-http-cookies:6.11--pl5321hdfd78af_0
stdout: perl-http-cookies.out

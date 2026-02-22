cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-cgi
label: perl-cgi
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of error messages from a container runtime (Singularity/Apptainer)
  indicating a failure to pull or convert a Docker image due to lack of disk space.\n\
  \nTool homepage: https://metacpan.org/pod/distribution/CGI/lib/CGI.pod"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-cgi:4.71--pl5321h7b50bb2_0
stdout: perl-cgi.out

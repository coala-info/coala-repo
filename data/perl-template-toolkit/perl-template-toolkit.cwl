cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-template-toolkit
label: perl-template-toolkit
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build or extract the container image due to insufficient disk space.\n
  \nTool homepage: https://metacpan.org/pod/Template::Toolkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-template-toolkit:3.102--pl5321h7b50bb2_1
stdout: perl-template-toolkit.out

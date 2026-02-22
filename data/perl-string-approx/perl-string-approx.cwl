cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-string-approx
label: perl-string-approx
doc: "The provided text does not contain help documentation for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to pull or build the image due to insufficient disk space ('no space left on device').\n\
  \nTool homepage: https://github.com/pld-linux/perl-String-Approx"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-string-approx:3.27--pl5321h7b50bb2_6
stdout: perl-string-approx.out

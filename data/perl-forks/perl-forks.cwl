cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-forks
label: perl-forks
doc: "The provided text does not contain help documentation or usage instructions.
  It consists of error messages from a container runtime (Singularity/Apptainer) indicating
  a failure to build or pull the container image due to insufficient disk space ('no
  space left on device').\n\nTool homepage: https://github.com/swati1024/torrents"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-forks:0.36--pl5321h7b50bb2_10
stdout: perl-forks.out

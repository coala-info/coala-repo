cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-sharedir
label: perl-file-sharedir
doc: "The provided text does not contain help information or documentation for the
  tool; it consists of system error messages related to a container runtime (Singularity/Apptainer)
  failing due to lack of disk space.\n\nTool homepage: https://metacpan.org/release/File-ShareDir"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-file-sharedir:1.118--pl5321hdfd78af_0
stdout: perl-file-sharedir.out

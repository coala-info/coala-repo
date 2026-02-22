cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-file-copy-recursive
label: perl-file-copy-recursive
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Singularity/Apptainer) failing
  to pull an image due to lack of disk space.\n\nTool homepage: https://metacpan.org/pod/File::Copy::Recursive"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-file-copy-recursive:0.45--pl5321h7b50bb2_5
stdout: perl-file-copy-recursive.out

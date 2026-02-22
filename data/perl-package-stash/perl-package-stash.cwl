cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-package-stash
label: perl-package-stash
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  and does not contain help information or command-line arguments for the tool 'perl-package-stash'.\n\
  \nTool homepage: http://metacpan.org/release/Package-Stash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-package-stash:0.40--pl5321h87f3376_1
stdout: perl-package-stash.out

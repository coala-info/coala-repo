cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-package-stash-xs
label: perl-package-stash-xs
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system error messages related to a failed container build
  (Singularity/Apptainer) due to insufficient disk space.\n\nTool homepage: http://metacpan.org/release/Package-Stash-XS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-package-stash-xs:0.29--pl5321h87f3376_1
stdout: perl-package-stash-xs.out

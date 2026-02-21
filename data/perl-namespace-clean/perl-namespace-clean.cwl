cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-namespace-clean
label: perl-namespace-clean
doc: "The provided text does not contain help documentation. It is an error log indicating
  that the executable 'perl-namespace-clean' was not found in the system PATH during
  an Apptainer/Singularity build process.\n\nTool homepage: https://github.com/gfx/Perl-namespace-clean-xs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-namespace-clean:0.27--pl5.22.0_0
stdout: perl-namespace-clean.out

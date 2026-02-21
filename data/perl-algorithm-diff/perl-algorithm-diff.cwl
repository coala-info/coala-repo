cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-algorithm-diff
label: perl-algorithm-diff
doc: "The provided text does not contain help documentation. It is an error log indicating
  that the executable 'perl-algorithm-diff' was not found in the system PATH during
  an Apptainer/Singularity execution attempt.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-algorithm-diff:1.1903--0
stdout: perl-algorithm-diff.out

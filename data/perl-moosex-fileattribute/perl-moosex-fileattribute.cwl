cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-moosex-fileattribute
label: perl-moosex-fileattribute
doc: "The provided text does not contain help information; it is an error log indicating
  that the executable was not found in the system PATH during an Apptainer/Singularity
  build process.\n\nTool homepage: https://github.com/moose/MooseX-FileAttribute"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-moosex-fileattribute:0.03--pl526_0
stdout: perl-moosex-fileattribute.out

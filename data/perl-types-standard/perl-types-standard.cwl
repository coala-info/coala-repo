cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-types-standard
label: perl-types-standard
doc: "The provided text does not contain help information for the tool. It appears
  to be an error log indicating that the executable 'perl-types-standard' was not
  found in the system PATH during an Apptainer/Singularity build process.\n\nTool
  homepage: http://search.cpan.org/~tobyink/Type-Tiny-1.002001/lib/Types/Standard.pm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-types-standard:1.002001--pl526_1
stdout: perl-types-standard.out

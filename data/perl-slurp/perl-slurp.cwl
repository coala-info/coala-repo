cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-slurp
label: perl-slurp
doc: "The provided text does not contain help documentation for 'perl-slurp'. It consists
  of Apptainer/Singularity environment logs and a fatal error indicating that the
  executable was not found in the system path.\n\nTool homepage: http://metacpan.org/pod/Slurp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-slurp:0.4--pl526_0
stdout: perl-slurp.out

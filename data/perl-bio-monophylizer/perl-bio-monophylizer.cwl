cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio-monophylizer.pl
label: perl-bio-monophylizer
doc: "The provided text does not contain help information for the tool. It is a log
  of a failed Apptainer/Singularity image build process due to insufficient disk space.
  No command-line arguments or tool descriptions could be extracted from this input.\n
  \nTool homepage: https://metacpan.org/pod/Bio::Monophylizer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-monophylizer:1.0.0--hdfd78af_0
stdout: perl-bio-monophylizer.out

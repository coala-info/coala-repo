cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-searchio-hmmer_hmmpfam
label: perl-bio-searchio-hmmer_hmmpfam
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to an Apptainer/Singularity image build failure (No
  space left on device).\n\nTool homepage: https://metacpan.org/release/Bio-SearchIO-hmmer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-searchio-hmmer:1.7.3--pl5321hdfd78af_0
stdout: perl-bio-searchio-hmmer_hmmpfam.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-rna-barriers
label: perl-bio-rna-barriers
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system error messages related to container image extraction
  and disk space issues.\n\nTool homepage: https://metacpan.org/pod/Bio::RNA::Barriers"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-bio-rna-barriers:0.03--pl5321hdfd78af_0
stdout: perl-bio-rna-barriers.out

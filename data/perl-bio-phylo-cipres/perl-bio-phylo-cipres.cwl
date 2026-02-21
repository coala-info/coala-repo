cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-phylo-cipres
label: perl-bio-phylo-cipres
doc: "A tool from the Bio::Phylo package for CIPRES integration. Note: The provided
  text is a system error log regarding a container build failure and does not contain
  usage instructions or argument definitions.\n\nTool homepage: http://metacpan.org/pod/Bio::Phylo::CIPRES"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-phylo-cipres:v0.2.1--pl5321hdfd78af_2
stdout: perl-bio-phylo-cipres.out

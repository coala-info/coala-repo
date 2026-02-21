cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-tools-phylo-paml
label: perl-bio-tools-phylo-paml
doc: "BioPerl tools for PAML (Phylogenetic Analysis by Maximum Likelihood). Note:
  The provided text is an error log from a failed container build process and does
  not contain the actual help text or usage instructions for the tool.\n\nTool homepage:
  https://metacpan.org/release/Bio-Tools-Phylo-PAML"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-tools-phylo-paml:1.7.3--pl526_0
stdout: perl-bio-tools-phylo-paml.out

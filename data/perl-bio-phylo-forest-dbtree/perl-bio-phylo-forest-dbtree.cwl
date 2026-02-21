cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio-phylo-forest-dbtree
label: perl-bio-phylo-forest-dbtree
doc: "A tool from the Bio::Phylo library for managing phylogenetic forest data in
  a database structure. (Note: The provided input text was a system error log regarding
  container extraction and did not contain help documentation or argument definitions.)\n
  \nTool homepage: http://biophylo.blogspot.com/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-phylo-forest-dbtree:0.58--pl5321hdfd78af_2
stdout: perl-bio-phylo-forest-dbtree.out

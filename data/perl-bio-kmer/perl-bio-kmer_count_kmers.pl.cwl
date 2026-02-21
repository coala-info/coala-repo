cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-kmer_count_kmers.pl
label: perl-bio-kmer_count_kmers.pl
doc: "Count kmers using the Bio::Kmer Perl module. (Note: The provided text contained
  system error messages regarding container extraction and did not include the tool's
  help documentation.)\n\nTool homepage: https://metacpan.org/pod/Bio::Kmer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-kmer:0.55--pl5321h031d066_0
stdout: perl-bio-kmer_count_kmers.pl.out

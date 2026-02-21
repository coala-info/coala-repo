cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-asn1-entrezgene
label: perl-bio-asn1-entrezgene
doc: "Regular expression-based Perl Parser for NCBI Entrez Gene ASN.1 definition.
  (Note: The provided input text is an error log indicating the executable was not
  found; no help text was available to parse arguments.)\n\nTool homepage: http://search.cpan.org/dist/Bio-ASN1-EntrezGene"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-asn1-entrezgene:1.73--pl526_0
stdout: perl-bio-asn1-entrezgene.out

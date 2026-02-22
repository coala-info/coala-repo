cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-rna-barmap
label: perl-bio-rna-barmap
doc: "A tool for mapping RNA secondary structures (Note: The provided input text contained
  system error messages regarding disk space and container image retrieval rather
  than the tool's help documentation).\n\nTool homepage: https://metacpan.org/pod/Bio::RNA::BarMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-rna-barmap:0.04--pl5321hdfd78af_0
stdout: perl-bio-rna-barmap.out

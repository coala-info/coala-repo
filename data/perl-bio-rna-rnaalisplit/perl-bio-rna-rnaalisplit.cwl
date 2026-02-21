cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnaalisplit
label: perl-bio-rna-rnaalisplit
doc: "The provided text does not contain help information for the tool. It is a log
  of a failed container build process due to insufficient disk space.\n\nTool homepage:
  http://metacpan.org/pod/Bio::RNA::RNAaliSplit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-rna-rnaalisplit:0.11--pl5321hdfd78af_0
stdout: perl-bio-rna-rnaalisplit.out

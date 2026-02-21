cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-bio-viennangs_kallisto_quant_merge.pl
label: perl-bio-viennangs_kallisto_quant_merge.pl
doc: "The provided text does not contain help information for the tool. It consists
  of system error messages related to a container build failure (no space left on
  device).\n\nTool homepage: http://metacpan.org/pod/Bio::ViennaNGS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-bio-viennangs:v0.19.2--pl526_5
stdout: perl-bio-viennangs_kallisto_quant_merge.pl.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-pcap_bwa_mem.pl
label: perl-pcap_bwa_mem.pl
doc: "No description available: The provided text contains system error logs regarding
  a container build failure ('no space left on device') rather than the help documentation
  for the tool.\n\nTool homepage: https://github.com/ICGC-TCGA-PanCancer/PCAP-core"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
stdout: perl-pcap_bwa_mem.pl.out

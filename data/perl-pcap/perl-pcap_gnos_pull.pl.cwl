cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-pcap_gnos_pull.pl
label: perl-pcap_gnos_pull.pl
doc: "A tool for pulling data from GNOS (Global Network of Biomedical Data Storage),
  typically used in genomic data analysis workflows.\n\nTool homepage: https://github.com/ICGC-TCGA-PanCancer/PCAP-core"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
stdout: perl-pcap_gnos_pull.pl.out

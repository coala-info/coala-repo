cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-pcap
label: perl-pcap
doc: "The provided text does not contain help information or usage instructions for
  perl-pcap; it is an error log from a container build process indicating a 'no space
  left on device' failure.\n\nTool homepage: https://github.com/ICGC-TCGA-PanCancer/PCAP-core"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
stdout: perl-pcap.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: monitor.pl
label: perl-pcap_monitor.pl
doc: "Run a command and report wall time, CPU time and peak memory of all its processes\n\nTool homepage: https://github.com/ICGC-TCGA-PanCancer/PCAP-core"
inputs:
  - id: command
    type:
      type: array
      items: string
    doc: "Command and arguments to run and monitor"
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
stdout: perl-pcap_monitor.pl.out

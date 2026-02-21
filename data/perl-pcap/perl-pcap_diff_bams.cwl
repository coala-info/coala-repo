cwlVersion: v1.2
class: CommandLineTool
baseCommand: diff_bams
label: perl-pcap_diff_bams
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build process (Apptainer/Singularity) due to insufficient
  disk space.\n\nTool homepage: https://github.com/ICGC-TCGA-PanCancer/PCAP-core"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
stdout: perl-pcap_diff_bams.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: diff_bams.pl
label: perl-pcap_diff_bams.pl
doc: "Compare two BAM/CRAM files by their @SQ headers and the order and content of the reads\n\nTool homepage: https://github.com/ICGC-TCGA-PanCancer/PCAP-core"
inputs:
  - id: bam_a
    type: File
    doc: "The first BAM|CRAM file"
    inputBinding:
      position: 101
      prefix: -bam_a
  - id: bam_b
    type: File
    doc: "The second BAM|CRAM file (different to bam_a)"
    inputBinding:
      position: 101
      prefix: -bam_b
  - id: ref
    type:
      - 'null'
      - File
    secondaryFiles:
      - '.fai'
    doc: "Required for CRAM: genome.fa with co-located fai"
    inputBinding:
      position: 101
      prefix: -ref
  - id: count
    type:
      - 'null'
      - boolean
    doc: "Count flag differences"
    inputBinding:
      position: 101
      prefix: -count
  - id: skipz
    type:
      - 'null'
      - boolean
    doc: "Don't include reads with MAPQ=0 in comparison"
    inputBinding:
      position: 101
      prefix: -skipz
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
stdout: perl-pcap_diff_bams.pl.out

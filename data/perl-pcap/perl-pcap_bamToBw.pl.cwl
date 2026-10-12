cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamToBw.pl
label: perl-pcap_bamToBw.pl
doc: "Convert a BAM/CRAM file to per chromosome BigWig files and a merged BigWig\n\nTool homepage: https://github.com/ICGC-TCGA-PanCancer/PCAP-core"
inputs:
  - id: bam
    type: File
    secondaryFiles:
      - '.bai?'
    doc: "BAM/CRAM file to be processed"
    inputBinding:
      position: 101
      prefix: -bam
  - id: outdir
    type: string
    doc: "Folder to output result to"
    inputBinding:
      position: 101
      prefix: -outdir
  - id: reference
    type: File
    secondaryFiles:
      - '.fai'
    doc: "Path to genome.fa (the .fai next to it is used)"
    inputBinding:
      position: 101
      prefix: -reference
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use [1]"
    inputBinding:
      position: 101
      prefix: -threads
  - id: filter
    type:
      - 'null'
      - int
    doc: "Ignore reads with the filter flags"
    inputBinding:
      position: 101
      prefix: -filter
  - id: process
    type:
      - 'null'
      - string
    doc: "Only process this step then exit (bamToBw or generateBw), optionally set -index"
    inputBinding:
      position: 101
      prefix: -process
  - id: index
    type:
      - 'null'
      - int
    doc: "Optionally restrict -process to single job"
    inputBinding:
      position: 101
      prefix: -index
  - id: jobs
    type:
      - 'null'
      - boolean
    doc: "For a parallel step report the number of jobs required"
    inputBinding:
      position: 101
      prefix: -jobs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: outdir_out
    type:
      - 'null'
      - Directory
    doc: "Output folder with the BigWig files"
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
stdout: perl-pcap_bamToBw.pl.out

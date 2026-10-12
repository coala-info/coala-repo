cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwa_aln.pl
label: perl-pcap_bwa_aln.pl
doc: "Align reads with BWA aln/sampe using the PCAP pipeline, sort to BAM and mark duplicates\n\nTool homepage: https://github.com/ICGC-TCGA-PanCancer/PCAP-core"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input FASTQ, BAM or CRAM files (full file names)"
    inputBinding:
      position: 200
  - id: outdir
    type: string
    doc: "Folder to output result to"
    inputBinding:
      position: 103
      prefix: -outdir
  - id: reference
    type: File
    secondaryFiles:
      - '.fai'
      - '.amb'
      - '.ann'
      - '.bwt'
      - '.pac'
      - '.sa'
    doc: "Path to reference genome file *.fa[.gz] with its BWA index"
    inputBinding:
      position: 101
      prefix: -reference
  - id: sample
    type: string
    doc: "Sample name to be applied to output file"
    inputBinding:
      position: 101
      prefix: -sample
  - id: threads
    type: int
    doc: "Number of threads to use [1]"
    inputBinding:
      position: 101
      prefix: -threads
  - id: process
    type:
      - 'null'
      - string
    doc: "Only process this step then exit (bam2fq, aln, sampe or mark), optionally set -index"
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: outdir_out
    type: Directory
    doc: "Output folder with the BAM, index, md5 and metrics"
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
stdout: perl-pcap_bwa_aln.pl.out

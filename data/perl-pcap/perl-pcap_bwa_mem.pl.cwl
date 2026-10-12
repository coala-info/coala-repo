cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwa_mem.pl
label: perl-pcap_bwa_mem.pl
doc: "Align reads with BWA-MEM using the PCAP pipeline: mapping, sorting and BAM/CRAM output with support for duplicate marking and CRAM conversion\n\nTool homepage: https://github.com/ICGC-TCGA-PanCancer/PCAP-core"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input BAM, CRAM or FASTQ files (full file names)"
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
  - id: fragment
    type:
      - 'null'
      - int
    doc: "Split input into fragments of X million repairs [10]"
    inputBinding:
      position: 101
      prefix: -fragment
  - id: nomarkdup
    type:
      - 'null'
      - boolean
    doc: "Don't mark duplicates"
    inputBinding:
      position: 101
      prefix: -nomarkdup
  - id: cram
    type:
      - 'null'
      - boolean
    doc: "Output cram, see -scramble"
    inputBinding:
      position: 101
      prefix: -cram
  - id: scramble
    type:
      - 'null'
      - string
    doc: "Single quoted string of parameters to pass to Scramble when -cram is used"
    inputBinding:
      position: 101
      prefix: -scramble
  - id: bwa
    type:
      - 'null'
      - string
    doc: "Single quoted string of additional parameters to pass to BWA"
    inputBinding:
      position: 101
      prefix: -bwa
  - id: map_threads
    type:
      - 'null'
      - int
    doc: "Number of cores applied to each parallel BWA job when -threads exceeds this value and -index is not in use [6]"
    inputBinding:
      position: 101
      prefix: -map_threads
  - id: process
    type:
      - 'null'
      - string
    doc: "Only process this step then exit (bwamem, mark or stats), optionally set -index"
    inputBinding:
      position: 101
      prefix: -process
  - id: index
    type:
      - 'null'
      - int
    doc: "Optionally restrict -process to single job (bwamem: 1..lane_count)"
    inputBinding:
      position: 101
      prefix: -index
  - id: bwa_pl
    type:
      - 'null'
      - File
    doc: "Path to libtcmalloc_minimal.so to make BWA run about 8% quicker"
    inputBinding:
      position: 101
      prefix: -bwa_pl
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
    type: Directory
    doc: "Output folder with the BAM/CRAM, index, md5 and metrics"
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
stdout: perl-pcap_bwa_mem.pl.out

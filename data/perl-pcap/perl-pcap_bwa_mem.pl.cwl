cwlVersion: v1.2
class: CommandLineTool
baseCommand: bwa_mem.pl
label: perl-pcap_bwa_mem.pl
doc: "BWA MEM alignment wrapper for processing BAM, CRAM, or FASTQ files, including
  support for duplicate marking and CRAM conversion.\n\nTool homepage: https://github.com/ICGC-TCGA-PanCancer/PCAP-core"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input file(s) (BAM, CRAM, or FASTQ)
    inputBinding:
      position: 1
  - id: bwa
    type:
      - 'null'
      - string
    doc: Single quoted string of additional parameters to pass to BWA
    inputBinding:
      position: 102
      prefix: -bwa
  - id: bwa_pl
    type:
      - 'null'
      - File
    doc: Path to 'gperftools/lib/libtcmalloc_minimal.so' for performance 
      improvement.
    inputBinding:
      position: 102
      prefix: -bwa_pl
  - id: cram
    type:
      - 'null'
      - boolean
    doc: Output cram, see '-sc'
    inputBinding:
      position: 102
      prefix: -cram
  - id: fragment
    type:
      - 'null'
      - int
    doc: Split input into fragments of X million repairs
    inputBinding:
      position: 102
      prefix: -fragment
  - id: index
    type:
      - 'null'
      - int
    doc: Optionally restrict '-p' to single job (e.g., 1..<lane_count> for 
      bwamem)
    inputBinding:
      position: 102
      prefix: -index
  - id: jobs
    type:
      - 'null'
      - boolean
    doc: For a parallel step report the number of jobs required
    inputBinding:
      position: 102
      prefix: -jobs
  - id: man
    type:
      - 'null'
      - boolean
    doc: Full documentation.
    inputBinding:
      position: 102
      prefix: -man
  - id: map_threads
    type:
      - 'null'
      - int
    doc: Number of cores applied to each parallel BWA job when '-t' exceeds this
      value and '-i' is not in use
    inputBinding:
      position: 102
      prefix: -map_threads
  - id: nomarkdup
    type:
      - 'null'
      - boolean
    doc: Don't mark duplicates
    inputBinding:
      position: 102
      prefix: -nomarkdup
  - id: process
    type:
      - 'null'
      - string
    doc: Only process this step then exit (bwamem, mark, or stats)
    inputBinding:
      position: 102
      prefix: -process
  - id: reference
    type: File
    doc: Path to reference genome file *.fa[.gz]
    inputBinding:
      position: 102
      prefix: -reference
  - id: sample
    type: string
    doc: Sample name to be applied to output file.
    inputBinding:
      position: 102
      prefix: -sample
  - id: scramble
    type:
      - 'null'
      - string
    doc: Single quoted string of parameters to pass to Scramble when '-c' used
    inputBinding:
      position: 102
      prefix: -scramble
  - id: threads
    type: int
    doc: Number of threads to use.
    inputBinding:
      position: 102
      prefix: -threads
outputs:
  - id: outdir
    type: Directory
    doc: Folder to output result to.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0

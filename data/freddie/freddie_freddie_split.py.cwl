cwlVersion: v1.2
class: CommandLineTool
baseCommand: freddie_split.py
label: freddie_freddie_split.py
doc: "Extract alignment information from BAM/SAM file and splits reads into distinct
  transcriptional intervals\n\nTool homepage: https://github.com/vpc-ccg/freddie"
inputs:
  - id: reads
    type:
      type: array
      items: File
    doc: Space separated paths to reads in FASTQ or FASTA format used to extract
      polyA tail information. If the file ends with .gz, it will be read using 
      gzip
    inputBinding:
      position: 1
  - id: bam
    type: File
    doc: Path to sorted and indexed BAM file of reads. Assumes splice aligner is
      used to the genome. Prefers deSALT
    inputBinding:
      position: 102
      prefix: --bam
  - id: consider_nonspliced
    type:
      - 'null'
      - boolean
    doc: Consider reads with no splicing
    inputBinding:
      position: 102
      prefix: --consider-nonspliced
  - id: contig_min_size
    type:
      - 'null'
      - int
    doc: 'Minimum contig size. Any contig with less size will not be processes. Default:
      1,000,000'
    inputBinding:
      position: 102
      prefix: --contig-min-size
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: 'Path to output directory. Default: freddie_split/'
    inputBinding:
      position: 102
      prefix: --outdir
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads. Max # of threads used is # of contigs. Default: 1'
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freddie:0.4--hdfd78af_0
stdout: freddie_freddie_split.py.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: viralrecall
label: viralrecall
doc: "A command-line tool for predicting NCLDV-like regions in genomic data\n\nTool
  homepage: https://github.com/abdealijivaji/ViralRecall_3.0"
inputs:
  - id: cpus
    type:
      - 'null'
      - string
    doc: number of cores to use in batch mode
    inputBinding:
      position: 101
      prefix: --cpus
  - id: database
    type: Directory
    doc: Database directory name, e.g. ~/hmm (download the database using 
      viralrecall_database)
    inputBinding:
      position: 101
      prefix: --database
  - id: evalue
    type:
      - 'null'
      - float
    doc: e-value that is passed to pyHmmer for hmmsearch
    inputBinding:
      position: 101
      prefix: --evalue
  - id: input
    type: File
    doc: Input Fasta file or directory of fasta files (ending in .fna, .fasta, 
      or .fa)
    inputBinding:
      position: 101
      prefix: --input
  - id: minhit
    type:
      - 'null'
      - int
    doc: minimum number of unique viral hits that each viral region must have to
      be reported
    inputBinding:
      position: 101
      prefix: --minhit
  - id: minscore
    type:
      - 'null'
      - int
    doc: minimum score of viral regions to report, with higher values indicating
      higher confidence
    inputBinding:
      position: 101
      prefix: --minscore
  - id: minsize
    type:
      - 'null'
      - string
    doc: minimum length of viral regions to report, in kilobases
    inputBinding:
      position: 101
      prefix: --minsize
  - id: outdir
    type: Directory
    doc: Output directory name
    inputBinding:
      position: 101
      prefix: --outdir
  - id: window
    type:
      - 'null'
      - string
    doc: sliding window size to use for detecting viral regions
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viralrecall:3.0.2--pyhdfd78af_0
stdout: viralrecall.out

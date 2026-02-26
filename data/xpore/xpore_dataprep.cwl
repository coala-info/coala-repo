cwlVersion: v1.2
class: CommandLineTool
baseCommand: xpore_dataprep
label: xpore_dataprep
doc: "Prepares data for xpore analysis.\n\nTool homepage: https://github.com/GoekeLab/xpore"
inputs:
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: number of lines from nanopolish eventalign.txt for processing.
    inputBinding:
      position: 101
      prefix: --chunk_size
  - id: eventalign
    type: File
    doc: eventalign filepath, the output from nanopolish.
    inputBinding:
      position: 101
      prefix: --eventalign
  - id: genome
    type:
      - 'null'
      - boolean
    doc: to run on Genomic coordinates. Without this argument, the program will 
      run on transcriptomic coordinates
    inputBinding:
      position: 101
      prefix: --genome
  - id: gtf_or_gff
    type:
      - 'null'
      - File
    doc: GTF or GFF file path.
    inputBinding:
      position: 101
      prefix: --gtf_or_gff
  - id: n_processes
    type:
      - 'null'
      - int
    doc: number of processes to run.
    inputBinding:
      position: 101
      prefix: --n_processes
  - id: out_dir
    type: Directory
    doc: output directory.
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: readcount_max
    type:
      - 'null'
      - int
    doc: maximum read counts per gene.
    inputBinding:
      position: 101
      prefix: --readcount_max
  - id: readcount_min
    type:
      - 'null'
      - int
    doc: minimum read counts per gene.
    inputBinding:
      position: 101
      prefix: --readcount_min
  - id: resume
    type:
      - 'null'
      - boolean
    doc: with this argument, the program will resume from the previous run.
    inputBinding:
      position: 101
      prefix: --resume
  - id: skip_eventalign_indexing
    type:
      - 'null'
      - boolean
    doc: skip indexing the eventalign nanopolish output.
    inputBinding:
      position: 101
      prefix: --skip_eventalign_indexing
  - id: transcript_fasta
    type:
      - 'null'
      - File
    doc: transcript FASTA path.
    inputBinding:
      position: 101
      prefix: --transcript_fasta
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xpore:2.1--pyh5e36f6f_0
stdout: xpore_dataprep.out

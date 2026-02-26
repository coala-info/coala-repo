cwlVersion: v1.2
class: CommandLineTool
baseCommand: starseqr.py
label: starseqr_starseqr.py
doc: "STAR-SEQR Parameters:\n\nTool homepage: https://github.com/ExpressionAnalysis/STAR-SEQR"
inputs:
  - id: as_type
    type:
      - 'null'
      - string
    doc: assembler to use
    inputBinding:
      position: 101
      prefix: --as_type
  - id: bed_file
    type:
      - 'null'
      - File
    doc: Bed file to subset analysis
    inputBinding:
      position: 101
      prefix: --bed_file
  - id: fasta
    type: File
    doc: indexed fasta (.fa)
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fastq1
    type: File
    doc: fastq.gz 1(.gz)
    inputBinding:
      position: 101
      prefix: --fastq1
  - id: fastq2
    type: File
    doc: fastq.gz 2(.gz)
    inputBinding:
      position: 101
      prefix: --fastq2
  - id: gtf
    type: File
    doc: gtf file. (.gtf)
    inputBinding:
      position: 101
      prefix: --gtf
  - id: keep_dups
    type:
      - 'null'
      - boolean
    doc: keep read duplicates. Use for PCR data or with molecular tags
    inputBinding:
      position: 101
      prefix: --keep_dups
  - id: keep_gene_dups
    type:
      - 'null'
      - boolean
    doc: allow internal gene duplications to be considered
    inputBinding:
      position: 101
      prefix: --keep_gene_dups
  - id: keep_mito
    type:
      - 'null'
      - boolean
    doc: allow RNA fusions to contain at least one breakpoint from Mitochondria
    inputBinding:
      position: 101
      prefix: --keep_mito
  - id: library
    type:
      - 'null'
      - string
    doc: salmon library type(A, ISF, ISR, etc)
    inputBinding:
      position: 101
      prefix: --library
  - id: mode
    type:
      - 'null'
      - int
    doc: STAR alignment mode. 0=More-specific, 1=More-Sensitive
    inputBinding:
      position: 101
      prefix: --mode
  - id: prefix
    type: string
    doc: prefix to name files. Can be string or /path/to/string
    inputBinding:
      position: 101
      prefix: --prefix
  - id: star_bam
    type:
      - 'null'
      - File
    doc: Aligned.sortedByCoord.out.bam file produced by STAR. Must contain 
      chimeric reads with ch tag.
    inputBinding:
      position: 101
      prefix: --star_bam
  - id: star_index
    type:
      - 'null'
      - Directory
    doc: path to STAR index folder
    inputBinding:
      position: 101
      prefix: --star_index
  - id: star_jxns
    type:
      - 'null'
      - File
    doc: chimeric junctions file produced by STAR
    inputBinding:
      position: 101
      prefix: --star_jxns
  - id: star_sam
    type:
      - 'null'
      - File
    doc: Chimeric.out.sam file produced by STAR. Either use this or -sb
    inputBinding:
      position: 101
      prefix: --star_sam
  - id: subset_type
    type:
      - 'null'
      - string
    doc: allow fusions to pass with either one breakend in bed file or require 
      both. Must use -b.
    inputBinding:
      position: 101
      prefix: --subset_type
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for STAR and STAR-SEQR. 4-12 recommended.
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: verbose level... repeat up to three times.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/starseqr:0.6.7--py36h7eb728f_0
stdout: starseqr_starseqr.py.out

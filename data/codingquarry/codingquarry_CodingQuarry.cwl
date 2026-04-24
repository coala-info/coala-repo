cwlVersion: v1.2
class: CommandLineTool
baseCommand: CodingQuarry
label: codingquarry_CodingQuarry
doc: "CodingQuarry is a tool for gene prediction in fungal genomes using transcriptomic
  data (RNA-seq).\n\nTool homepage: https://sourceforge.net/p/codingquarry/"
inputs:
  - id: aligned_est_data
    type:
      - 'null'
      - File
    doc: gff3 file of aligned EST data
    inputBinding:
      position: 101
      prefix: -e
  - id: aligned_transcripts
    type:
      - 'null'
      - File
    doc: gff3 file of aligned transcripts (recommended)
    inputBinding:
      position: 101
      prefix: -t
  - id: genome_sequence
    type: File
    doc: file name of genome sequence
    inputBinding:
      position: 101
      prefix: -f
  - id: hard_mask_soft_masked
    type:
      - 'null'
      - boolean
    doc: do not predict genes in soft-masked regions (that is, hard-mask these 
      regions)
    inputBinding:
      position: 101
      prefix: -h
  - id: high_confidence_genes
    type:
      - 'null'
      - File
    doc: gff3 of high confidence genes that can be used for training
    inputBinding:
      position: 101
      prefix: -a
  - id: species_name
    type:
      - 'null'
      - string
    doc: species name, providing pre-trained parameters exist
    inputBinding:
      position: 101
      prefix: -s
  - id: stop_after_stage1
    type:
      - 'null'
      - boolean
    doc: stop after stage 1 (see manual)
    inputBinding:
      position: 101
      prefix: -i
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -p
  - id: unstranded_rnaseq
    type:
      - 'null'
      - boolean
    doc: specify this when using un-stranded RNA-seq. By default, CodingQuarry 
      expects stranded RNA-seq
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/codingquarry:2.0--py311he264feb_11
stdout: codingquarry_CodingQuarry.out

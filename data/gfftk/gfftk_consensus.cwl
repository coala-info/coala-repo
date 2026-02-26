cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfftk_consensus
label: gfftk_consensus
doc: "EvidenceModeler-like tool to generate consensus gene predictions. All gene models
  are loaded and sorted into loci based on genomic location, in each locus the gene
  models are scored based on: 1) overlap with protein/transcript evidence 2) AED score
  in relation to all models at that locus 3) user supplied source weights 4) de novo
  source weights estimated from evidence overlaps 5) for each locus the gene model
  with highest score is retained.\n\nTool homepage: https://github.com/nextgenusfs/gfftk"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: write/keep intermediate files
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: fasta
    type: File
    doc: genome in FASTA format
    inputBinding:
      position: 101
      prefix: --fasta
  - id: genes
    type:
      type: array
      items: File
    doc: 'gene model predictions in GFF3 format [accepts multiple files: space separated]'
    inputBinding:
      position: 101
      prefix: --genes
  - id: logfile
    type:
      - 'null'
      - boolean
    doc: write logs to file
    inputBinding:
      position: 101
      prefix: --logfile
  - id: max_exon
    type:
      - 'null'
      - int
    doc: maximum exon length
    default: -1
    inputBinding:
      position: 101
      prefix: --max-exon
  - id: max_intron
    type:
      - 'null'
      - int
    doc: maximum intron length
    default: -1
    inputBinding:
      position: 101
      prefix: --max-intron
  - id: min_exon
    type:
      - 'null'
      - int
    doc: minimum exon length
    default: 3
    inputBinding:
      position: 101
      prefix: --min-exon
  - id: min_intron
    type:
      - 'null'
      - int
    doc: minimum intron length
    default: 10
    inputBinding:
      position: 101
      prefix: --min-intron
  - id: minscore
    type:
      - 'null'
      - string
    doc: 'minimum score to retain gene model (default: auto)'
    inputBinding:
      position: 101
      prefix: --minscore
  - id: num_processes
    type:
      - 'null'
      - int
    doc: 'number of processes to use for parallel execution (default: number of CPU
      cores)'
    inputBinding:
      position: 101
      prefix: --num-processes
  - id: proteins
    type:
      - 'null'
      - type: array
        items: File
    doc: 'protein alignments in GFF3 format [accepts multiple files: space separated]'
    default: []
    inputBinding:
      position: 101
      prefix: --proteins
  - id: repeat_overlap
    type:
      - 'null'
      - int
    doc: percent gene model overlap with repeats to remove
    default: 90
    inputBinding:
      position: 101
      prefix: --repeat-overlap
  - id: repeats
    type:
      - 'null'
      - File
    doc: repeat alignments in BED or GFF3 format
    inputBinding:
      position: 101
      prefix: --repeats
  - id: silent
    type:
      - 'null'
      - boolean
    doc: do not write anything to terminal/stderr
    default: false
    inputBinding:
      position: 101
      prefix: --silent
  - id: transcripts
    type:
      - 'null'
      - type: array
        items: File
    doc: 'transcripts alignments in GFF3 format [accepts multiple files: space separated]'
    default: []
    inputBinding:
      position: 101
      prefix: --transcripts
  - id: weights
    type:
      - 'null'
      - type: array
        items: string
    doc: 'user supplied source weights [accepts multiple: space separated source:weight]'
    default: []
    inputBinding:
      position: 101
      prefix: --weights
outputs:
  - id: out
    type: File
    doc: output in GFF3 format
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfftk:26.2.12--pyh1f0d9b5_0

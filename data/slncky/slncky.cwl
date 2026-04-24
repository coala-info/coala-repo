cwlVersion: v1.2
class: CommandLineTool
baseCommand: slncky
label: slncky
doc: "sLNCky: a lncRNA discovery software for lncRNA annotation and ortholog discovery.\n\
  \nTool homepage: https://github.com/slncky/slncky"
inputs:
  - id: bedfile
    type: File
    doc: bed12 file of transcripts
    inputBinding:
      position: 1
  - id: assembly
    type: string
    doc: assembly
    inputBinding:
      position: 2
  - id: out_prefix
    type: string
    doc: out_prefix
    inputBinding:
      position: 3
  - id: bedtools
    type:
      - 'null'
      - File
    doc: path to bedtools
    inputBinding:
      position: 104
      prefix: --bedtools
  - id: config
    type:
      - 'null'
      - File
    doc: path to assembly.config file. default uses config file in same 
      directory as slncky
    inputBinding:
      position: 104
      prefix: --config
  - id: gap_extend
    type:
      - 'null'
      - string
    inputBinding:
      position: 104
      prefix: --gap_extend
  - id: gap_open
    type:
      - 'null'
      - string
    inputBinding:
      position: 104
      prefix: --gap_open
  - id: lastz
    type:
      - 'null'
      - File
    doc: path to lastz
    inputBinding:
      position: 104
      prefix: --lastz
  - id: liftover
    type:
      - 'null'
      - File
    doc: path to liftOver
    inputBinding:
      position: 104
      prefix: --liftover
  - id: min_cluster
    type:
      - 'null'
      - int
    doc: min size of duplication clusters to remove. default=2
    inputBinding:
      position: 104
      prefix: --min_cluster
  - id: min_coding
    type:
      - 'null'
      - string
    doc: min exonic identity to filter out transcript that aligns to orthologous
      coding gene. default is set by learning coding alignment distribution from
      data
    inputBinding:
      position: 104
      prefix: --min_coding
  - id: min_noncoding
    type:
      - 'null'
      - float
    doc: min exonic identity to filter out transcript that aligns to orthologous
      noncoding gene. default=0
    inputBinding:
      position: 104
      prefix: --min_noncoding
  - id: min_overlap
    type:
      - 'null'
      - float
    doc: remove any transcript that overlap annotated coding gene > 
      min_overlap%. default = 0%
    inputBinding:
      position: 104
      prefix: --min_overlap
  - id: minmatch
    type:
      - 'null'
      - float
    doc: minMatch parameter for liftover. default=0.1
    inputBinding:
      position: 104
      prefix: --minMatch
  - id: no_bg
    type:
      - 'null'
      - boolean
    doc: flag if you don't want to compare lnc-to-ortholog alignments to a 
      background. This flag may be useful if you want to do a 'quick-and-dirty' 
      run of the ortholog search.
    inputBinding:
      position: 104
      prefix: --no_bg
  - id: no_coding
    type:
      - 'null'
      - boolean
    doc: flag if you don't want to align to orthologous coding
    inputBinding:
      position: 104
      prefix: --no_coding
  - id: no_collapse
    type:
      - 'null'
      - boolean
    doc: flag if you don't want to collapse isoforms
    inputBinding:
      position: 104
      prefix: --no_collapse
  - id: no_dup
    type:
      - 'null'
      - boolean
    doc: flag if don't want to align to duplicates
    inputBinding:
      position: 104
      prefix: --no_dup
  - id: no_filter
    type:
      - 'null'
      - boolean
    doc: flag if you don't want lncs to be filtered before searching for 
      ortholog
    inputBinding:
      position: 104
      prefix: --no_filter
  - id: no_orf
    type:
      - 'null'
      - boolean
    doc: flag if you don't want to search for orfs
    inputBinding:
      position: 104
      prefix: --no_orf
  - id: no_orth_search
    type:
      - 'null'
      - boolean
    doc: flag if you only want to filter lncs but don't want to search for 
      orthologs
    inputBinding:
      position: 104
      prefix: --no_orth_search
  - id: no_overlap
    type:
      - 'null'
      - boolean
    doc: flag if you don't want to overlap with coding
    inputBinding:
      position: 104
      prefix: --no_overlap
  - id: no_self
    type:
      - 'null'
      - boolean
    doc: flag if you don't want to self-align for duplicates
    inputBinding:
      position: 104
      prefix: --no_self
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: forces overwrite of out_prefix.bed
    inputBinding:
      position: 104
      prefix: --overwrite
  - id: pad
    type:
      - 'null'
      - int
    doc: '# of basepairs to search up- and down-stream when lifting over lnc to ortholog'
    inputBinding:
      position: 104
      prefix: --pad
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads. default = 5
    inputBinding:
      position: 104
      prefix: --threads
  - id: web
    type:
      - 'null'
      - boolean
    doc: flag for if you want slncky to create a website visualizing results
    inputBinding:
      position: 104
      prefix: --web
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slncky:1.0.4--1
stdout: slncky.out

cwlVersion: v1.2
class: CommandLineTool
baseCommand: swipe
label: swipe
doc: "SWIPE 2.1.1 [Dec 14 2024 05:52:37]\n\nReference: T. Rognes (2011) Faster Smith-Waterman
  database searches\nwith inter-sequence SIMD parallelisation, BMC Bioinformatics,
  12:221.\n\nTool homepage: http://dna.uio.no/swipe"
inputs:
  - id: database
    type: File
    doc: sequence database base name (required)
    inputBinding:
      position: 101
      prefix: --db
  - id: db_gencode
    type:
      - 'null'
      - int
    doc: database genetic code [1-23] (1)
    inputBinding:
      position: 101
      prefix: --db_gencode
  - id: dbsize
    type:
      - 'null'
      - int
    doc: set effective database size (0)
    inputBinding:
      position: 101
      prefix: --dbsize
  - id: dump
    type:
      - 'null'
      - int
    doc: dump database [0-2=no,yes,split headers] (0)
    inputBinding:
      position: 101
      prefix: --dump
  - id: evalue
    type:
      - 'null'
      - float
    doc: maximum expect value of sequences to show (10.0)
    inputBinding:
      position: 101
      prefix: --evalue
  - id: gapextend
    type:
      - 'null'
      - int
    doc: gap extension penalty (1)
    inputBinding:
      position: 101
      prefix: --gapextend
  - id: gapopen
    type:
      - 'null'
      - int
    doc: gap open penalty (11)
    inputBinding:
      position: 101
      prefix: --gapopen
  - id: matrix
    type:
      - 'null'
      - string
    doc: score matrix name or filename (BLOSUM62)
    inputBinding:
      position: 101
      prefix: --matrix
  - id: max_score
    type:
      - 'null'
      - string
    doc: maximum score of sequences to show (inf.)
    inputBinding:
      position: 101
      prefix: --max_score
  - id: min_score
    type:
      - 'null'
      - int
    doc: minimum score of sequences to show (1)
    inputBinding:
      position: 101
      prefix: --min_score
  - id: minevalue
    type:
      - 'null'
      - float
    doc: minimum expect value of sequences to show (0.0)
    inputBinding:
      position: 101
      prefix: --minevalue
  - id: num_alignments
    type:
      - 'null'
      - int
    doc: sequence alignments to show (100)
    inputBinding:
      position: 101
      prefix: --num_alignments
  - id: num_descriptions
    type:
      - 'null'
      - int
    doc: sequence descriptions to show (250)
    inputBinding:
      position: 101
      prefix: --num_descriptions
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of threads to use [1-256] (1)
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: outfmt
    type:
      - 'null'
      - int
    doc: output format [0,7-9=plain,xml,tsv,tsv+] (0)
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: penalty
    type:
      - 'null'
      - int
    doc: penalty for nucleotide mismatch (-3)
    inputBinding:
      position: 101
      prefix: --penalty
  - id: query
    type:
      - 'null'
      - File
    doc: query sequence filename (stdin)
    inputBinding:
      position: 101
      prefix: --query
  - id: query_gencode
    type:
      - 'null'
      - int
    doc: query genetic code [1-23] (1)
    inputBinding:
      position: 101
      prefix: --query_gencode
  - id: reward
    type:
      - 'null'
      - int
    doc: reward for nucleotide match (1)
    inputBinding:
      position: 101
      prefix: --reward
  - id: show_gis
    type:
      - 'null'
      - boolean
    doc: show gi numbers in results (no)
    inputBinding:
      position: 101
      prefix: --show_gis
  - id: show_taxid
    type:
      - 'null'
      - boolean
    doc: show taxid etc in results (no)
    inputBinding:
      position: 101
      prefix: --show_taxid
  - id: strand
    type:
      - 'null'
      - string
    doc: query strands to search [1-3] (3)
    inputBinding:
      position: 101
      prefix: --strand
  - id: symtype
    type:
      - 'null'
      - string
    doc: symbol type/translation [0-4] (1)
    inputBinding:
      position: 101
      prefix: --symtype
  - id: taxidlist
    type:
      - 'null'
      - File
    doc: taxid list filename (none)
    inputBinding:
      position: 101
      prefix: --taxidlist
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file (stdout)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/swipe:2.1.1--hf1d56f0_5

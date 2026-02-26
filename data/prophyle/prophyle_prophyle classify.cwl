cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - prophyle
  - classify
label: prophyle_prophyle classify
doc: "Classify reads using a prophyle index.\n\nTool homepage: https://github.com/karel-brinda/prophyle"
inputs:
  - id: index_dir
    type: Directory
    doc: index directory
    inputBinding:
      position: 1
  - id: reads1_fq
    type: File
    doc: first file with reads in FASTA/FASTQ (- for standard input)
    inputBinding:
      position: 2
  - id: reads2_fq
    type:
      - 'null'
      - File
    doc: second file with reads in FASTA/FASTQ
    inputBinding:
      position: 3
  - id: advanced_config
    type:
      - 'null'
      - type: array
        items: string
    doc: advanced configuration (a JSON dictionary)
    inputBinding:
      position: 104
      prefix: -c
  - id: annotate_assignments
    type:
      - 'null'
      - boolean
    doc: annotate assignments (using tax. information from NHX)
    inputBinding:
      position: 104
      prefix: -A
  - id: force_restarted_search
    type:
      - 'null'
      - boolean
    doc: force restarted search mode
    inputBinding:
      position: 104
      prefix: -K
  - id: incorporate_seq_qual
    type:
      - 'null'
      - boolean
    doc: incorporate sequences and qualities into SAM records
    inputBinding:
      position: 104
      prefix: -P
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length
    default: detect automatically from the index
    inputBinding:
      position: 104
      prefix: -k
  - id: log_file
    type:
      - 'null'
      - string
    doc: log file
    inputBinding:
      position: 104
      prefix: -l
  - id: measure
    type:
      - 'null'
      - string
    doc: 'measure: h1=hit count, c1=coverage, h2=norm.hit count, c2=norm.coverage'
    default: h1
    inputBinding:
      position: 104
      prefix: -m
  - id: mimic_kraken
    type:
      - 'null'
      - boolean
    doc: mimic Kraken (equivalent to "-m h1 -f kraken -L -X")
    inputBinding:
      position: 104
      prefix: -M
  - id: output_format
    type:
      - 'null'
      - string
    doc: output format
    default: sam
    inputBinding:
      position: 104
      prefix: -f
  - id: replace_assignments_by_lca
    type:
      - 'null'
      - boolean
    doc: replace read assignments by their LCA
    inputBinding:
      position: 104
      prefix: -L
  - id: replace_kmer_matches_by_lca
    type:
      - 'null'
      - boolean
    doc: replace k-mer matches by their LCA
    inputBinding:
      position: 104
      prefix: -X
  - id: use_cpp_impl
    type:
      - 'null'
      - boolean
    doc: use C++ impl. of the assignment algorithm (experimental)
    inputBinding:
      position: 104
      prefix: -C
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophyle:0.3.3.2--py39h746d604_3
stdout: prophyle_prophyle classify.out

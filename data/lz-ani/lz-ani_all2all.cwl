cwlVersion: v1.2
class: CommandLineTool
baseCommand: lz-ani
label: lz-ani_all2all
doc: "Tool for rapid determination of similarities among sets of DNA sequences\n\n\
  Tool homepage: https://github.com/refresh-bio/lz-ani"
inputs:
  - id: mode
    type: string
    doc: Mode to run the tool (e.g., all2all)
    inputBinding:
      position: 1
  - id: am
    type:
      - 'null'
      - int
    doc: max. no. of mismatches in approx. window
    default: 7
    inputBinding:
      position: 102
      prefix: --am
  - id: ar
    type:
      - 'null'
      - int
    doc: min. length of run ending approx. extension
    default: 3
    inputBinding:
      position: 102
      prefix: --ar
  - id: aw
    type:
      - 'null'
      - int
    doc: approx. window length
    default: 15
    inputBinding:
      position: 102
      prefix: --aw
  - id: flt_kmerdb
    type:
      - 'null'
      - type: array
        items: string
    doc: filtering file (kmer-db output) and threshold
    inputBinding:
      position: 102
      prefix: --flt-kmerdb
  - id: in_dir
    type:
      - 'null'
      - Directory
    doc: directory with FASTA files
    inputBinding:
      position: 102
      prefix: --in-dir
  - id: in_fasta
    type:
      - 'null'
      - File
    doc: FASTA file (for multisample-fasta mode)
    inputBinding:
      position: 102
      prefix: --in-fasta
  - id: in_txt
    type:
      - 'null'
      - File
    doc: text file with FASTA file names
    inputBinding:
      position: 102
      prefix: --in-txt
  - id: mal
    type:
      - 'null'
      - int
    doc: min. anchor length
    default: 11
    inputBinding:
      position: 102
      prefix: --mal
  - id: mqd
    type:
      - 'null'
      - int
    doc: max. dist. between approx. matches in query
    default: 40
    inputBinding:
      position: 102
      prefix: --mqd
  - id: mrd
    type:
      - 'null'
      - int
    doc: max. dist. between approx. matches in reference
    default: 40
    inputBinding:
      position: 102
      prefix: --mrd
  - id: msl
    type:
      - 'null'
      - int
    doc: min. seed length
    default: 7
    inputBinding:
      position: 102
      prefix: --msl
  - id: multisample_fasta
    type:
      - 'null'
      - boolean
    doc: multi sample FASTA input
    default: true
    inputBinding:
      position: 102
      prefix: --multisample-fasta
  - id: out_filter
    type:
      - 'null'
      - type: array
        items: string
    doc: Store only results with <par> (tani, gani, ani, cov) at least <float>
    inputBinding:
      position: 102
      prefix: --out-filter
  - id: out_format
    type:
      - 'null'
      - string
    doc: Comma-separated list of values for output format
    default: standard
    inputBinding:
      position: 102
      prefix: --out-format
  - id: out_in_percent
    type:
      - 'null'
      - boolean
    doc: output in percent
    default: false
    inputBinding:
      position: 102
      prefix: --out-in-percent
  - id: out_type
    type:
      - 'null'
      - string
    doc: 'Output type: tsv or single-txt'
    inputBinding:
      position: 102
      prefix: --out-type
  - id: reg
    type:
      - 'null'
      - int
    doc: min. considered region length
    default: 35
    inputBinding:
      position: 102
      prefix: --reg
  - id: threads
    type:
      - 'null'
      - int
    doc: no of threads; 0 means auto-detect
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbosity level
    default: 1
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.out)
  - id: out_ids
    type:
      - 'null'
      - File
    doc: output file name for ids file (optional)
    outputBinding:
      glob: $(inputs.out_ids)
  - id: out_alignment
    type:
      - 'null'
      - File
    doc: output file name for ids file (optional)
    outputBinding:
      glob: $(inputs.out_alignment)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lz-ani:1.2.3--h9ee0642_0

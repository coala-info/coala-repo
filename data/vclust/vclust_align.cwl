cwlVersion: v1.2
class: CommandLineTool
baseCommand: vclust_align
label: vclust_align
doc: "Align genome pairs\n\nTool homepage: https://github.com/refresh-bio/vclust"
inputs:
  - id: am
    type:
      - 'null'
      - int
    doc: Max. no. of mismatches in approx. window
    default: 7
    inputBinding:
      position: 101
      prefix: --am
  - id: ar
    type:
      - 'null'
      - int
    doc: Min. length of run ending approx. extension
    default: 3
    inputBinding:
      position: 101
      prefix: --ar
  - id: aw
    type:
      - 'null'
      - int
    doc: Approx. window length
    default: 15
    inputBinding:
      position: 101
      prefix: --aw
  - id: filter_file
    type:
      - 'null'
      - File
    doc: Path to filter file (output of prefilter)
    inputBinding:
      position: 101
      prefix: --filter
  - id: filter_threshold
    type:
      - 'null'
      - float
    doc: Align genome pairs above the threshold (0-1)
    default: 0
    inputBinding:
      position: 101
      prefix: --filter-threshold
  - id: input_file
    type: File
    doc: Input FASTA file or directory of files (gzipped or uncompressed)
    inputBinding:
      position: 101
      prefix: --in
  - id: mal
    type:
      - 'null'
      - int
    doc: Min. anchor length
    default: 11
    inputBinding:
      position: 101
      prefix: --mal
  - id: mqd
    type:
      - 'null'
      - int
    doc: Max. dist. between approx. matches in query
    default: 40
    inputBinding:
      position: 101
      prefix: --mqd
  - id: mrd
    type:
      - 'null'
      - int
    doc: Max. dist. between approx. matches in reference
    default: 40
    inputBinding:
      position: 101
      prefix: --mrd
  - id: msl
    type:
      - 'null'
      - int
    doc: Min. seed length
    default: 7
    inputBinding:
      position: 101
      prefix: --msl
  - id: out_ani
    type:
      - 'null'
      - float
    doc: Min. ANI to output (0-1)
    default: 0
    inputBinding:
      position: 101
      prefix: --out-ani
  - id: out_gani
    type:
      - 'null'
      - float
    doc: Min. gANI to output (0-1)
    default: 0
    inputBinding:
      position: 101
      prefix: --out-gani
  - id: out_qcov
    type:
      - 'null'
      - float
    doc: Min. query coverage (aligned fraction) to output (0-1)
    default: 0
    inputBinding:
      position: 101
      prefix: --out-qcov
  - id: out_rcov
    type:
      - 'null'
      - float
    doc: Min. reference coverage (aligned fraction) to output (0-1)
    default: 0
    inputBinding:
      position: 101
      prefix: --out-rcov
  - id: out_tani
    type:
      - 'null'
      - float
    doc: Min. tANI to output (0-1)
    default: 0
    inputBinding:
      position: 101
      prefix: --out-tani
  - id: outfmt
    type:
      - 'null'
      - string
    doc: Output format
    default: standard
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: reg
    type:
      - 'null'
      - int
    doc: Min. considered region length
    default: 35
    inputBinding:
      position: 101
      prefix: --reg
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbosity_level
    type:
      - 'null'
      - int
    doc: Verbosity level
    default: 1
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: Output filename
    outputBinding:
      glob: $(inputs.output_file)
  - id: out_aln
    type:
      - 'null'
      - File
    doc: Write alignments to the tsv <file>
    outputBinding:
      glob: $(inputs.out_aln)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vclust:1.3.1--py311he264feb_1

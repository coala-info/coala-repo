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
    inputBinding:
      position: 101
      prefix: --am
  - id: ar
    type:
      - 'null'
      - int
    doc: Min. length of run ending approx. extension
    inputBinding:
      position: 101
      prefix: --ar
  - id: aw
    type:
      - 'null'
      - int
    doc: Approx. window length
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
    inputBinding:
      position: 101
      prefix: --mal
  - id: mqd
    type:
      - 'null'
      - int
    doc: Max. dist. between approx. matches in query
    inputBinding:
      position: 101
      prefix: --mqd
  - id: mrd
    type:
      - 'null'
      - int
    doc: Max. dist. between approx. matches in reference
    inputBinding:
      position: 101
      prefix: --mrd
  - id: msl
    type:
      - 'null'
      - int
    doc: Min. seed length
    inputBinding:
      position: 101
      prefix: --msl
  - id: out_ani
    type:
      - 'null'
      - float
    doc: Min. ANI to output (0-1)
    inputBinding:
      position: 101
      prefix: --out-ani
  - id: out_gani
    type:
      - 'null'
      - float
    doc: Min. gANI to output (0-1)
    inputBinding:
      position: 101
      prefix: --out-gani
  - id: out_qcov
    type:
      - 'null'
      - float
    doc: Min. query coverage (aligned fraction) to output (0-1)
    inputBinding:
      position: 101
      prefix: --out-qcov
  - id: out_rcov
    type:
      - 'null'
      - float
    doc: Min. reference coverage (aligned fraction) to output (0-1)
    inputBinding:
      position: 101
      prefix: --out-rcov
  - id: out_tani
    type:
      - 'null'
      - float
    doc: Min. tANI to output (0-1)
    inputBinding:
      position: 101
      prefix: --out-tani
  - id: outfmt
    type:
      - 'null'
      - string
    doc: Output format
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: reg
    type:
      - 'null'
      - int
    doc: Min. considered region length
    inputBinding:
      position: 101
      prefix: --reg
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbosity_level
    type:
      - 'null'
      - int
    doc: Verbosity level
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

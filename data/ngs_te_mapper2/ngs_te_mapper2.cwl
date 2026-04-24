cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngs_te_mapper2
label: ngs_te_mapper2
doc: "Script to detect non-reference TEs from single end short read data\n\nTool homepage:
  https://github.com/bergmanlab/ngs_te_mapper2"
inputs:
  - id: annotation
    type:
      - 'null'
      - File
    doc: reference TE annotation in GFF3 format (must have 'Target' attribute in
      the 9th column)
    inputBinding:
      position: 101
      prefix: --annotation
  - id: gap_max
    type:
      - 'null'
      - int
    doc: maximum gap size
    inputBinding:
      position: 101
      prefix: --gap_max
  - id: keep_files
    type:
      - 'null'
      - boolean
    doc: 'If provided then all intermediate files will be kept (default: remove intermediate
      files)'
    inputBinding:
      position: 101
      prefix: --keep_files
  - id: library
    type: File
    doc: TE concensus sequence
    inputBinding:
      position: 101
      prefix: --library
  - id: mapper
    type:
      - 'null'
      - string
    doc: read alignment program
    inputBinding:
      position: 101
      prefix: --mapper
  - id: min_af
    type:
      - 'null'
      - float
    doc: minimum allele frequency
    inputBinding:
      position: 101
      prefix: --min_af
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: minimum mapping quality of alignment
    inputBinding:
      position: 101
      prefix: --min_mapq
  - id: out
    type:
      - 'null'
      - Directory
    doc: output dir
    inputBinding:
      position: 101
      prefix: --out
  - id: prefix
    type:
      - 'null'
      - string
    doc: output prefix
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reads
    type: File
    doc: raw reads in fastq or fastq.gz format, separated by comma
    inputBinding:
      position: 101
      prefix: --reads
  - id: reference
    type: File
    doc: reference genome
    inputBinding:
      position: 101
      prefix: --reference
  - id: thread
    type:
      - 'null'
      - int
    doc: thread
    inputBinding:
      position: 101
      prefix: --thread
  - id: tsd_max
    type:
      - 'null'
      - int
    doc: maximum TSD size
    inputBinding:
      position: 101
      prefix: --tsd_max
  - id: window
    type:
      - 'null'
      - int
    doc: merge window for identifying TE clusters
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs_te_mapper2:1.0.2--pyhdfd78af_1
stdout: ngs_te_mapper2.out

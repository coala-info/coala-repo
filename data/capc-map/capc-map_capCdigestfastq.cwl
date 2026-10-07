cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capCdigestfastq
label: capc-map_capCdigestfastq
doc: "Digest paired fastq reads in silico at a restriction enzyme site and write the fragments to one fastq file.\n\nTool homepage: https://capc-map.readthedocs.io/"
inputs:
  - id: first_fq
    type: File
    doc: "is the first of the pair of fastq files (uncompressed)"
    inputBinding:
      position: 1
      prefix: '-1'
  - id: second_fq
    type: File
    doc: "is the second of the pair of fastq files (uncompressed)"
    inputBinding:
      position: 1
      prefix: '-2'
  - id: output_fq
    type: string
    doc: "is the name of the output fastq file"
    inputBinding:
      position: 1
      prefix: -o
  - id: enzyme_seq
    type: string
    doc: "is the sequence of the restriction enzyme; must be characters ACGT only"
    inputBinding:
      position: 1
      prefix: -e
  - id: cut_position
    type: int
    doc: "is the bp position within SEQ where the cut will occur (first base is 1; Xth base will be the start of the right hand fragment)"
    inputBinding:
      position: 1
      prefix: -p
  - id: long
    type:
      - 'null'
      - boolean
    doc: "option switches on 'long' mode, where only the longest of the restriction fragments in each of the pairs is kept"
    inputBinding:
      position: 1
      prefix: --long
outputs:
  - id: digested_fastq
    type: File
    doc: "fastq file of digested read fragments"
    outputBinding:
      glob: $(inputs.output_fq)
  - id: digest_log
    type: File
    doc: "digestion log file"
    outputBinding:
      glob: digestlog_$(inputs.output_fq).log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capc-map:1.1.3--py36h8619c78_0

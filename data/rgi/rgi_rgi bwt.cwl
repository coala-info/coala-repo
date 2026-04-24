cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rgi
  - bwt
label: rgi_rgi bwt
doc: "Aligns metagenomic reads to CARD and wildCARD reference using kma, bowtie2 or
  bwa and provide reports.\n\nTool homepage: https://card.mcmaster.ca"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: select read aligner (default=kma)
    inputBinding:
      position: 101
      prefix: --aligner
  - id: clean
    type:
      - 'null'
      - boolean
    doc: removes temporary files (default=False)
    inputBinding:
      position: 101
      prefix: --clean
  - id: coverage
    type:
      - 'null'
      - string
    doc: filter reads based on coverage of reference sequence
    inputBinding:
      position: 101
      prefix: --coverage
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debug mode (default=False)
    inputBinding:
      position: 101
      prefix: --debug
  - id: include_baits
    type:
      - 'null'
      - boolean
    doc: include baits (default=False)
    inputBinding:
      position: 101
      prefix: --include_baits
  - id: include_other_models
    type:
      - 'null'
      - boolean
    doc: include protein variant, rRNA variant, knockout, and protein 
      overexpression models (default=False)
    inputBinding:
      position: 101
      prefix: --include_other_models
  - id: include_wildcard
    type:
      - 'null'
      - boolean
    doc: include wildcard (default=False)
    inputBinding:
      position: 101
      prefix: --include_wildcard
  - id: local
    type:
      - 'null'
      - boolean
    doc: 'use local database (default: uses database in executable directory)'
    inputBinding:
      position: 101
      prefix: --local
  - id: mapped
    type:
      - 'null'
      - boolean
    doc: filter reads based on mapped reads (default=False)
    inputBinding:
      position: 101
      prefix: --mapped
  - id: mapq
    type:
      - 'null'
      - boolean
    doc: filter reads based on MAPQ score (default=False)
    inputBinding:
      position: 101
      prefix: --mapq
  - id: read_one
    type: File
    doc: raw read one (qc and trimmed)
    inputBinding:
      position: 101
      prefix: --read_one
  - id: read_two
    type:
      - 'null'
      - File
    doc: raw read two (qc and trimmed)
    inputBinding:
      position: 101
      prefix: --read_two
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads (CPUs) to use (default=20)
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: name of output filename(s)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0

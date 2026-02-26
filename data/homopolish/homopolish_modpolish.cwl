cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - homopolish
  - modpolish
label: homopolish_modpolish
doc: "A tool for polishing genome assemblies using mash sketches and local databases.\n\
  \nTool homepage: https://github.com/ythuang0522/homopolish"
inputs:
  - id: ani
    type:
      - 'null'
      - int
    doc: Ani identity
    default: 99
    inputBinding:
      position: 101
      prefix: --ani
  - id: bam
    type:
      - 'null'
      - File
    doc: bam file
    inputBinding:
      position: 101
      prefix: --bam
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Keep the information .
    inputBinding:
      position: 101
      prefix: --debug
  - id: distance
    type:
      - 'null'
      - int
    doc: Difference of structure (counted by ani).
    default: 5
    inputBinding:
      position: 101
      prefix: --distance
  - id: fasta
    type: File
    doc: fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fastq
    type:
      - 'null'
      - File
    doc: fastq file
    inputBinding:
      position: 101
      prefix: --fastq
  - id: local_db_path
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Path to your local DB
    inputBinding:
      position: 101
      prefix: --local_DB_path
  - id: pattern
    type:
      - 'null'
      - string
    doc: special pattern
    inputBinding:
      position: 101
      prefix: --pattern
  - id: sketch_path
    type: File
    doc: Path to a mash sketch file.
    inputBinding:
      position: 101
      prefix: --sketch_path
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: OUTPUT_DIR
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homopolish:0.4.2--pyhdfd78af_0

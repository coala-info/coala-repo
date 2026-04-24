cwlVersion: v1.2
class: CommandLineTool
baseCommand: tb-profiler spoligotype
label: tb-profiler_spoligotype
doc: "Spoligotyping analysis for TBProfiler\n\nTool homepage: https://github.com/jodyphelan/TBProfiler"
inputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: BAM file. Make sure it has been generated using the H37Rv genome 
      (GCA_000195955.2)
    inputBinding:
      position: 101
      prefix: --bam
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Add CSV output
    inputBinding:
      position: 101
      prefix: --csv
  - id: db
    type:
      - 'null'
      - string
    doc: Mutation panel name
    inputBinding:
      position: 101
      prefix: --db
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: Database directory
    inputBinding:
      position: 101
      prefix: --db_dir
  - id: dir
    type:
      - 'null'
      - Directory
    doc: Storage directory
    inputBinding:
      position: 101
      prefix: --dir
  - id: docx
    type:
      - 'null'
      - boolean
    doc: Add docx output. This requires docxtpl to be installed
    inputBinding:
      position: 101
      prefix: --docx
  - id: external_db
    type:
      - 'null'
      - File
    doc: Path to db files prefix (overrides "--db" parameter)
    inputBinding:
      position: 101
      prefix: --external-db
  - id: fasta
    type:
      - 'null'
      - File
    doc: Fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: kmer_counter
    type:
      - 'null'
      - string
    doc: Kmer counter
    inputBinding:
      position: 101
      prefix: --kmer_counter
  - id: logging
    type:
      - 'null'
      - string
    doc: Logging level
    inputBinding:
      position: 101
      prefix: --logging
  - id: platform
    type:
      - 'null'
      - string
    doc: NGS Platform used to generate data
    inputBinding:
      position: 101
      prefix: --platform
  - id: prefix
    type:
      - 'null'
      - string
    doc: Sample prefix
    inputBinding:
      position: 101
      prefix: --prefix
  - id: ram
    type:
      - 'null'
      - int
    doc: Maximum memory to use in Gb
    inputBinding:
      position: 101
      prefix: --ram
  - id: read1
    type:
      - 'null'
      - File
    doc: First read file
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - File
    doc: Second read file
    inputBinding:
      position: 101
      prefix: --read2
  - id: temp
    type:
      - 'null'
      - Directory
    doc: Temp firectory to process all files
    inputBinding:
      position: 101
      prefix: --temp
  - id: text_template
    type:
      - 'null'
      - string
    doc: Jinja2 formatted template for output
    inputBinding:
      position: 101
      prefix: --text_template
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: txt
    type:
      - 'null'
      - boolean
    doc: Add text output
    inputBinding:
      position: 101
      prefix: --txt
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
stdout: tb-profiler_spoligotype.out

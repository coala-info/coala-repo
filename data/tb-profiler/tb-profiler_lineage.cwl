cwlVersion: v1.2
class: CommandLineTool
baseCommand: tb-profiler lineage
label: tb-profiler_lineage
doc: "Lineage profiling for Mycobacterium tuberculosis\n\nTool homepage: https://github.com/jodyphelan/TBProfiler"
inputs:
  - id: bam
    type: File
    doc: BAM file. Make sure it has been generated using the H37Rv genome 
      (GCA_000195955.2)
    inputBinding:
      position: 101
      prefix: --bam
  - id: barcode_snps
    type:
      - 'null'
      - File
    doc: Dump barcoding mutations to a file
    inputBinding:
      position: 101
      prefix: --barcode_snps
  - id: caller
    type:
      - 'null'
      - string
    doc: Variant caller
    inputBinding:
      position: 101
      prefix: --caller
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
  - id: external_db
    type:
      - 'null'
      - string
    doc: Path to db files prefix (overrides "--db" parameter)
    inputBinding:
      position: 101
      prefix: --external_db
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
  - id: spoligotype
    type:
      - 'null'
      - boolean
    doc: Perform in-silico spoligotyping
    inputBinding:
      position: 101
      prefix: --spoligotype
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
stdout: tb-profiler_lineage.out

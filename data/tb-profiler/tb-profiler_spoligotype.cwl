cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tb-profiler
  - spoligotype
label: tb-profiler_spoligotype
doc: "In-silico spoligotyping of a TB sample\n\nTool homepage: https://github.com/jodyphelan/TBProfiler"
inputs:
  - id: read1
    type:
      - 'null'
      - File
    doc: 'First read file'
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - File
    doc: 'Second read file'
    inputBinding:
      position: 101
      prefix: --read2
  - id: bam
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .bai
        required: false
    doc: 'BAM file. Make sure it has been generated using the H37Rv genome (GCA_000195955.2)'
    inputBinding:
      position: 101
      prefix: --bam
  - id: fasta
    type:
      - 'null'
      - File
    doc: 'Fasta file'
    inputBinding:
      position: 101
      prefix: --fasta
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Sample prefix (default: tbprofiler)'
    inputBinding:
      position: 101
      prefix: --prefix
  - id: txt
    type:
      - 'null'
      - boolean
    doc: 'Add text output'
    inputBinding:
      position: 101
      prefix: --txt
  - id: csv
    type:
      - 'null'
      - boolean
    doc: 'Add CSV output'
    inputBinding:
      position: 101
      prefix: --csv
  - id: docx
    type:
      - 'null'
      - boolean
    doc: 'Add docx output'
    inputBinding:
      position: 101
      prefix: --docx
  - id: text_template
    type:
      - 'null'
      - File
    doc: 'Jinja2 formatted template for output'
    inputBinding:
      position: 101
      prefix: --text_template
  - id: kmer_counter
    type:
      - 'null'
      - string
    doc: 'Kmer counter: FastK, kmc or dsk (default: FastK)'
    inputBinding:
      position: 101
      prefix: --kmer_counter
  - id: platform
    type:
      - 'null'
      - string
    doc: 'NGS platform used to generate data: illumina, nanopore or pacbio (default: illumina)'
    inputBinding:
      position: 101
      prefix: --platform
  - id: db
    type:
      - 'null'
      - string
    doc: 'Mutation panel name (default: tbdb)'
    inputBinding:
      position: 101
      prefix: --db
  - id: external_db
    type:
      - 'null'
      - string
    doc: 'Path to db files prefix (overrides the db option)'
    inputBinding:
      position: 101
      prefix: --external_db
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Threads to use (default: 1)'
    inputBinding:
      position: 101
      prefix: --threads
  - id: ram
    type:
      - 'null'
      - int
    doc: 'Maximum memory to use in Gb (default: 2)'
    inputBinding:
      position: 101
      prefix: --ram
  - id: dir
    type:
      - 'null'
      - string
    doc: 'Storage directory for results (default: current directory)'
    inputBinding:
      position: 101
      prefix: --dir
  - id: temp
    type:
      - 'null'
      - string
    doc: 'Temp directory to process all files (default: .)'
    inputBinding:
      position: 101
      prefix: --temp
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: 'Database directory (default: bundled database in the image)'
    inputBinding:
      position: 101
      prefix: --db_dir
  - id: logging
    type:
      - 'null'
      - string
    doc: 'Logging level: DEBUG, INFO, WARNING, ERROR or CRITICAL (default: INFO)'
    inputBinding:
      position: 101
      prefix: --logging
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: result_files
    type:
      type: array
      items: File
    doc: 'Spoligotype result files'
    outputBinding:
      glob: $((inputs.dir || '.') + '/results/' + (inputs.prefix || 'tbprofiler') + '.spoligotype.*')
  - id: results_dir
    type:
      - 'null'
      - Directory
    doc: 'Results directory'
    outputBinding:
      glob: $((inputs.dir || '.') + '/results')
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.bam)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
stdout: tb-profiler_spoligotype.out

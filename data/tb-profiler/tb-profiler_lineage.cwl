cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tb-profiler
  - lineage
label: tb-profiler_lineage
doc: "Profile only the lineage of a TB sample from a BAM file\n\nTool homepage: https://github.com/jodyphelan/TBProfiler"
inputs:
  - id: bam
    type: File
    secondaryFiles:
      - pattern: .bai
        required: false
    doc: 'BAM file. Make sure it has been generated using the H37Rv genome (GCA_000195955.2)'
    inputBinding:
      position: 101
      prefix: --bam
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'Sample prefix (default: tbprofiler)'
    inputBinding:
      position: 101
      prefix: --prefix
  - id: barcode_snps
    type:
      - 'null'
      - string
    doc: 'Dump barcoding mutations to a file'
    inputBinding:
      position: 101
      prefix: --barcode_snps
  - id: caller
    type:
      - 'null'
      - string
    doc: 'Variant caller: bcftools, freebayes or gatk (default: freebayes)'
    inputBinding:
      position: 101
      prefix: --caller
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
  - id: spoligotype
    type:
      - 'null'
      - boolean
    doc: 'Perform in-silico spoligotyping'
    inputBinding:
      position: 101
      prefix: --spoligotype
  - id: external_db
    type:
      - 'null'
      - string
    doc: 'Path to db files prefix (overrides the db option)'
    inputBinding:
      position: 101
      prefix: --external_db
  - id: text_template
    type:
      - 'null'
      - File
    doc: 'Jinja2 formatted template for output'
    inputBinding:
      position: 101
      prefix: --text_template
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Threads to use (default: 1)'
    inputBinding:
      position: 101
      prefix: --threads
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
  - id: barcode_snps_file
    type:
      - 'null'
      - File
    doc: 'Dumped barcoding mutations'
    outputBinding:
      glob: $(inputs.barcode_snps)
  - id: lineage_json
    type:
      - 'null'
      - File
    doc: 'Lineage result in JSON format'
    outputBinding:
      glob: $((inputs.dir || '.') + '/results/' + (inputs.prefix || 'tbprofiler') + '.lineage.json')
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
stdout: tb-profiler_lineage.out

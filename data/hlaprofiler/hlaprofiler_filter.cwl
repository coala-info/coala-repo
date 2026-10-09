cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - HLAProfiler.pl
  - filter
label: hlaprofiler_filter
doc: "Filter paired fastq reads into HLA genes using an HLA database.\n\nTool homepage: https://github.com/ExpressionAnalysis/HLAProfiler"
inputs:
  - id: fastq1
    type: File
    doc: 'Read 1 fastq'
    inputBinding:
      position: 1
      prefix: -fastq1
  - id: fastq2
    type: File
    doc: 'Read 2 fastq'
    inputBinding:
      position: 1
      prefix: -fastq2
  - id: output_dir
    type: string
    doc: 'Output directory (created in the working directory)'
    inputBinding:
      position: 1
      prefix: -output_dir
  - id: database_dir
    type:
      - 'null'
      - Directory
    doc: 'Location of the database directory (default: ".")'
    inputBinding:
      position: 1
      prefix: -database_dir
  - id: database_name
    type:
      - 'null'
      - string
    doc: 'Name of the HLA database (default: hla)'
    inputBinding:
      position: 1
      prefix: -database_name
  - id: kraken_path
    type:
      - 'null'
      - string
    default: /usr/local/share/kraken-ea-0.10.5ea.3-1
    doc: 'Base directory of the kraken installation (the bioconda image keeps it in /usr/local/share/kraken-ea-0.10.5ea.3-1)'
    inputBinding:
      position: 1
      prefix: -kraken_path
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use for processing (default: 1)'
    inputBinding:
      position: 1
      prefix: -threads
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory of the module
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_dir)
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hlaprofiler:1.0.5--0

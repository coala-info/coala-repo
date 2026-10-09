cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - HLAProfiler.pl
  - create_profiles
label: hlaprofiler_create_profiles
doc: "Simulate reads from the HLA reference and create k-mer profiles for HLAProfiler predict.\n\nTool homepage: https://github.com/ExpressionAnalysis/HLAProfiler"
inputs:
  - id: reference
    type: File
    secondaryFiles:
      - pattern: ^.allele_map.txt
        required: false
    doc: 'Location of the HLA reference fasta file'
    inputBinding:
      position: 1
      prefix: -reference
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
    doc: 'Location of the database parent directory (default: ".")'
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
  - id: num_reads
    type:
      - 'null'
      - int
    doc: 'Number of reads to simulate per reference allele (default: 500000)'
    inputBinding:
      position: 1
      prefix: -num_reads
  - id: read_length
    type:
      - 'null'
      - int
    doc: 'Length of the simulated reads, same as the k-mer length in the profile (default: 50)'
    inputBinding:
      position: 1
      prefix: -read_length
  - id: filter_reads
    type:
      - 'null'
      - int
    doc: 'Filter reads using the HLA database, 0 or 1 (default: 1)'
    inputBinding:
      position: 1
      prefix: -filter_reads
  - id: intermediate_files
    type:
      - 'null'
      - boolean
    doc: 'Keep intermediate files'
    inputBinding:
      position: 1
      prefix: -intermediate_files
  - id: max_insert
    type:
      - 'null'
      - int
    doc: 'Maximum size of insert (default: 1000)'
    inputBinding:
      position: 1
      prefix: -max_insert
  - id: scale
    type:
      - 'null'
      - float
    doc: 'Scale of pareto distribution to determine insert size (default: 80)'
    inputBinding:
      position: 1
      prefix: -scale
  - id: shape
    type:
      - 'null'
      - float
    doc: 'Shape of pareto distribution to determine insert size (default: 0.7)'
    inputBinding:
      position: 1
      prefix: -shape
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Seed of random number generator for simulation (default: 1234)'
    inputBinding:
      position: 1
      prefix: -seed
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

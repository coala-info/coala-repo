cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - HLAProfiler.pl
  - predict
label: hlaprofiler_predict
doc: "Predict the HLA type of paired-end NGS reads with a prebuilt HLAProfiler database.\n\nTool homepage: https://github.com/ExpressionAnalysis/HLAProfiler"
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
  - id: database_name
    type: string
    doc: 'Name of the HLA database'
    inputBinding:
      position: 1
      prefix: -database_name
  - id: database_dir
    type: Directory
    doc: 'Parent directory of the database (the help calls the option -directory_dir, but the program only accepts -database_dir)'
    inputBinding:
      position: 1
      prefix: -database_dir
  - id: reference
    type: File
    secondaryFiles:
      - pattern: ^.allele_map.txt
        required: false
    doc: 'Reference fasta used to create the database; the allele map file (same name with .allele_map.txt) must sit beside it'
    inputBinding:
      position: 1
      prefix: -reference
  - id: allele_refinement
    type:
      - 'null'
      - string
    doc: 'Level to which the predicted alleles are refined based on the observed reads (refine_only, predict_only, refineAndPredict, all, none; default: all)'
    inputBinding:
      position: 1
      prefix: -allele_refinement
  - id: num_reads
    type:
      - 'null'
      - int
    doc: 'Number of reads to simulate per reference allele for k-mer profile creation (default: 500000)'
    inputBinding:
      position: 1
      prefix: -num_reads
  - id: read_length
    type:
      - 'null'
      - int
    doc: 'Length of reads simulated for the k-mer profile; same as the length of the k-mers in the profile (default: 50)'
    inputBinding:
      position: 1
      prefix: -read_length
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
  - id: intermediate_files
    type:
      - 'null'
      - boolean
    doc: 'Keep intermediate files'
    inputBinding:
      position: 1
      prefix: -intermediate_files
  - id: minimum_reads
    type:
      - 'null'
      - int
    doc: 'Minimum number of reads from a gene before attempting to call HLA types (default: 100)'
    inputBinding:
      position: 1
      prefix: -minimum_reads
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use for processing (default: 1)'
    inputBinding:
      position: 1
      prefix: -threads
  - id: output_dir
    type: string
    doc: 'Output directory (created in the working directory)'
    inputBinding:
      position: 1
      prefix: -output_dir
  - id: kraken_path
    type:
      - 'null'
      - string
    default: /usr/local/share/kraken-ea-0.10.5ea.3-1
    doc: 'Base directory of the kraken installation (the bioconda image keeps it in /usr/local/share/kraken-ea-0.10.5ea.3-1)'
    inputBinding:
      position: 1
      prefix: -kraken_path
  - id: log
    type:
      - 'null'
      - string
    default: HLAProfiler.log
    doc: 'Name of the log file (the module needs a log file name)'
    inputBinding:
      position: 1
      prefix: -log
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

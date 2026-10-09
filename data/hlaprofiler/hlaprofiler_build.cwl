cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - HLAProfiler.pl
  - build
label: hlaprofiler_build
doc: "Build the HLAProfiler reference (taxonomy, kraken database and k-mer profiles) from an HLA reference FASTA and GENCODE transcripts.\n\nTool homepage: https://github.com/ExpressionAnalysis/HLAProfiler"
inputs:
  - id: transcripts
    type: File
    doc: 'Fasta file containing transcripts (GENCODE transcripts only)'
    inputBinding:
      position: 1
      prefix: -transcripts
  - id: transcript_gtf
    type: File
    doc: 'Gtf file with the transcripts corresponding to the transcripts file'
    inputBinding:
      position: 1
      prefix: -transcript_gtf
  - id: exclusion_bed
    type: File
    doc: 'Bed file with the regions excluded from the distractome, for example the HLA region'
    inputBinding:
      position: 1
      prefix: -exclusion_bed
  - id: reference
    type: File
    doc: 'Fasta file containing the HLA reference (IPD-IMGT/HLA recommended)'
    inputBinding:
      position: 1
      prefix: -reference
  - id: cwd
    type: File
    doc: 'File containing the names of common and well-documented alleles (can be empty)'
    inputBinding:
      position: 1
      prefix: -cwd
  - id: output_dir
    type: string
    doc: 'Location of the output directory (default: ".")'
    inputBinding:
      position: 1
      prefix: -output_dir
  - id: database_name
    type:
      - 'null'
      - string
    doc: 'Name of the HLA database to be created (default: hla)'
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
  - id: k_mer
    type:
      - 'null'
      - int
    doc: 'Size of the k-mer used to create the database (default: 31)'
    inputBinding:
      position: 1
      prefix: -k_mer
  - id: minimizer
    type:
      - 'null'
      - int
    doc: 'Size of the k-mer minimizer used to create the database (default: 13)'
    inputBinding:
      position: 1
      prefix: -minimizer
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
  - id: filter_reads
    type:
      - 'null'
      - int
    doc: 'Filter reads using the HLA database when building the k-mer profile, 0 or 1 (default: 1)'
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

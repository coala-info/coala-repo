cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - HLAProfiler.pl
  - build_taxonomy
label: hlaprofiler_build_taxonomy
doc: "Build an HLA database using a reference and a custom taxonomy.\n\nTool homepage: https://github.com/ExpressionAnalysis/HLAProfiler"
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
  - id: output_dir
    type: string
    doc: 'Location of the database directory (default: ".")'
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
      - entryname: $(inputs.output_dir + "/" + (inputs.database_name || "hla"))
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hlaprofiler:1.0.5--0

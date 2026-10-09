cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - HLAProfiler.pl
  - predict_only
label: hlaprofiler_predict_only
doc: "Predict the HLA type from previously filtered and counted reads.\n\nTool homepage: https://github.com/ExpressionAnalysis/HLAProfiler"
inputs:
  - id: counts_directory
    type: Directory
    doc: 'Directory with the filtered and paired read count files'
    inputBinding:
      position: 1
      prefix: -counts_directory
  - id: reads_directory
    type: Directory
    doc: 'Directory with the filtered and paired read fastqs'
    inputBinding:
      position: 1
      prefix: -reads_directory
  - id: profile_directory
    type: Directory
    doc: 'Directory with the k-mer profile files'
    inputBinding:
      position: 1
      prefix: -profile_directory
  - id: sample_name
    type: string
    doc: 'Name of the sample; must match the prefix of the read count files'
    inputBinding:
      position: 1
      prefix: -sample_name
  - id: reference
    type: File
    secondaryFiles:
      - pattern: ^.allele_map.txt
        required: false
    doc: 'HLA reference fasta; an allele map file must sit beside it'
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
  - id: kraken_db
    type:
      - 'null'
      - Directory
    doc: 'Base directory of the kraken database'
    inputBinding:
      position: 1
      prefix: -kraken_db
  - id: kraken_path
    type:
      - 'null'
      - string
    default: /usr/local/share/kraken-ea-0.10.5ea.3-1
    doc: 'Base directory of the kraken installation (the bioconda image keeps it in /usr/local/share/kraken-ea-0.10.5ea.3-1)'
    inputBinding:
      position: 1
      prefix: -kraken_path
  - id: minimum_reads
    type:
      - 'null'
      - int
    doc: 'Minimum number of reads from a gene before attempting to call HLA types (default: 100)'
    inputBinding:
      position: 1
      prefix: -minimum_reads
  - id: output_dir
    type: string
    doc: 'Output directory (created in the working directory)'
    inputBinding:
      position: 1
      prefix: -output_dir
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

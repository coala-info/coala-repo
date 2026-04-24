cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rgi
  - main
label: rgi_rgi main
doc: "Resistance Gene Identifier - 6.0.5 - Main\n\nTool homepage: https://card.mcmaster.ca"
inputs:
  - id: alignment_tool
    type:
      - 'null'
      - string
    doc: specify alignment tool
    inputBinding:
      position: 101
      prefix: --alignment_tool
  - id: clean
    type:
      - 'null'
      - boolean
    doc: removes temporary files
    inputBinding:
      position: 101
      prefix: --clean
  - id: data
    type:
      - 'null'
      - string
    doc: specify a data-type
    inputBinding:
      position: 101
      prefix: --data
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: include_loose
    type:
      - 'null'
      - boolean
    doc: include loose hits in addition to strict and perfect hits
    inputBinding:
      position: 101
      prefix: --include_loose
  - id: include_nudge
    type:
      - 'null'
      - boolean
    doc: include hits nudged from loose to strict hits
    inputBinding:
      position: 101
      prefix: --include_nudge
  - id: input_sequence
    type: File
    doc: input file must be in either FASTA (contig and protein) or gzip format!
      e.g myFile.fasta, myFasta.fasta.gz
    inputBinding:
      position: 101
      prefix: --input_sequence
  - id: input_type
    type:
      - 'null'
      - string
    doc: specify data input type
    inputBinding:
      position: 101
      prefix: --input_type
  - id: keep
    type:
      - 'null'
      - boolean
    doc: keeps Prodigal CDS when used with --clean
    inputBinding:
      position: 101
      prefix: --keep
  - id: local
    type:
      - 'null'
      - boolean
    doc: use local database
    inputBinding:
      position: 101
      prefix: --local
  - id: low_quality
    type:
      - 'null'
      - boolean
    doc: use for short contigs to predict partial genes
    inputBinding:
      position: 101
      prefix: --low_quality
  - id: num_threads
    type:
      - 'null'
      - int
    doc: number of threads (CPUs) to use in the BLAST search
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: orf_finder
    type:
      - 'null'
      - string
    doc: specify ORF finding tool
    inputBinding:
      position: 101
      prefix: --orf_finder
  - id: split_prodigal_jobs
    type:
      - 'null'
      - boolean
    doc: run multiple prodigal jobs simultaneously for contigs in a fasta file
    inputBinding:
      position: 101
      prefix: --split_prodigal_jobs
outputs:
  - id: output_file
    type: File
    doc: output folder and base filename
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgi:6.0.5--pyh05cac1d_0

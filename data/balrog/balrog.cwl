cwlVersion: v1.2
class: CommandLineTool
baseCommand: balrog
label: balrog
doc: "Balrog is a prokaryotic gene finder based on a temporal convolutional network.
  It writes gene predictions in GFF3 format.\n\nTool homepage: https://github.com/Markusjsommer/BalrogCPP"
inputs:
  - id: input_fasta
    type: File
    doc: Path to input fasta or gzipped fasta
    inputBinding:
      position: 101
      prefix: --in
  - id: output_file_path
    type: string
    doc: Path to output annotation (GFF3)
    inputBinding:
      position: 101
      prefix: --out
  - id: temp
    type:
      - 'null'
      - string
    doc: 'Directory to store temp files (default: /tmp)'
    inputBinding:
      position: 102
      prefix: --temp
  - id: max_overlap
    type:
      - 'null'
      - int
    doc: 'Maximum allowable overlap between genes in nucleotides (default: 60)'
    inputBinding:
      position: 102
      prefix: --max-overlap
  - id: min_length
    type:
      - 'null'
      - int
    doc: 'Minimum allowable gene length in nucleotides (default: 90)'
    inputBinding:
      position: 102
      prefix: --min-length
  - id: translation_table
    type:
      - 'null'
      - int
    doc: 'Nucleotide to amino acid translation table. 11 for most bacteria/archaea,
      4 for Mycoplasma/Spiroplasma. (default: 11)'
    inputBinding:
      position: 102
      prefix: --table
  - id: max_connections
    type:
      - 'null'
      - int
    doc: 'Maximum number of forward connections in the directed acyclic graph used
      to find a set of coherent genes in each genome. (default: 50)'
    inputBinding:
      position: 102
      prefix: --max-connections
  - id: gene_batch_size
    type:
      - 'null'
      - int
    doc: 'Batch size for the temporal convolutional network used to score genes.
      (default: 128)'
    inputBinding:
      position: 102
      prefix: --gene-batch-size
  - id: tis_batch_size
    type:
      - 'null'
      - int
    doc: 'Batch size for the temporal convolutional network used to score TIS. (default:
      1024)'
    inputBinding:
      position: 102
      prefix: --TIS-batch-size
  - id: verbose
    type:
      - 'null'
      - string
    doc: 'Verbose output: true or false (default: true)'
    inputBinding:
      position: 102
      prefix: --verbose=
      separate: false
  - id: mmseqs
    type:
      - 'null'
      - string
    doc: 'Use MMseqs2 to reduce false positive rate: true or false (default: true)'
    inputBinding:
      position: 102
      prefix: --mmseqs=
      separate: false
  - id: clear_cache
    type:
      - 'null'
      - boolean
    doc: Force MMseqs2 to remake the reference database and index files
    inputBinding:
      position: 102
      prefix: --clear-cache=true
outputs:
  - id: output_file
    type: File
    doc: Gene predictions (GFF3 format)
    outputBinding:
      glob: $(inputs.output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/balrog:0.5.1--he513fc3_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxator-tk_taxator
label: taxator-tk_taxator
doc: "Specify a taxonomy mapping file for the reference sequence identifiers\n\nTool
  homepage: https://github.com/fungs/taxator-tk"
inputs:
  - id: advanced_options
    type:
      - 'null'
      - boolean
    doc: show advanced program options
    inputBinding:
      position: 101
      prefix: --advanced-options
  - id: algorithm
    type:
      - 'null'
      - string
    doc: set the algorithm that is used to predict taxonomic ids from alignments
    inputBinding:
      position: 101
      prefix: --algorithm
  - id: citation
    type:
      - 'null'
      - boolean
    doc: show citation info
    inputBinding:
      position: 101
      prefix: --citation
  - id: logfile
    type:
      - 'null'
      - File
    doc: specify name of file for logging (appending lines)
    inputBinding:
      position: 101
      prefix: --logfile
  - id: processors
    type:
      - 'null'
      - int
    doc: sets number of threads, number > 2 will heavily profit from multi-core 
      architectures, set to 0 for max. performance
    inputBinding:
      position: 101
      prefix: --processors
  - id: query_sequences
    type:
      - 'null'
      - File
    doc: query sequences FASTA
    inputBinding:
      position: 101
      prefix: --query-sequences
  - id: query_sequences_index
    type:
      - 'null'
      - File
    doc: query sequences FASTA index, for out-of-memory operation; is created if
      not existing
    inputBinding:
      position: 101
      prefix: --query-sequences-index
  - id: ref_sequences
    type:
      - 'null'
      - File
    doc: reference sequences FASTA
    inputBinding:
      position: 101
      prefix: --ref-sequences
  - id: ref_sequences_index
    type:
      - 'null'
      - File
    doc: FASTA file index, for out-of-memory operation; is created if not 
      existing
    inputBinding:
      position: 101
      prefix: --ref-sequences-index
  - id: seqid_taxid_mapping
    type:
      - 'null'
      - File
    doc: filename of seqid->taxid mapping for reference
    inputBinding:
      position: 101
      prefix: --seqid-taxid-mapping
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxator-tk:1.3.3e--0
stdout: taxator-tk_taxator.out

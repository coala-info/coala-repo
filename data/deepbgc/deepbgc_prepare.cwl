cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepbgc prepare
label: deepbgc_prepare
doc: "Prepare genomic sequence by annotating proteins and Pfam domains.\n\nTool homepage:
  https://github.com/Merck/DeepBGC"
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: Input sequence file path(s) (FASTA/GenBank)
    inputBinding:
      position: 1
  - id: debug
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --debug
  - id: limit_to_record
    type:
      - 'null'
      - type: array
        items: string
    doc: Process only specific record ID. Can be provided multiple times
    inputBinding:
      position: 102
      prefix: --limit-to-record
  - id: prodigal_meta_mode
    type: boolean
    doc: Run Prodigal in '-p meta' mode to enable detecting genes in short 
      contigs
    inputBinding:
      position: 102
      prefix: --prodigal-meta-mode
  - id: protein
    type: boolean
    doc: Accept amino-acid protein sequences as input (experimental). Will treat
      each file as a single record with multiple proteins.
    inputBinding:
      position: 102
      prefix: --protein
outputs:
  - id: output_gbk
    type:
      - 'null'
      - File
    doc: Output GenBank file path
    outputBinding:
      glob: $(inputs.output_gbk)
  - id: output_tsv
    type:
      - 'null'
      - File
    doc: Output TSV file path
    outputBinding:
      glob: $(inputs.output_tsv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepbgc:0.1.31--pyhca03a8a_0

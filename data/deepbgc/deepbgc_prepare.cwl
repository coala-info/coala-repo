cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepbgc
  - prepare
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
        inputBinding:
          prefix: --limit-to-record
    doc: Process only specific record ID. Can be provided multiple times
    inputBinding:
      position: 102
  - id: prodigal_meta_mode
    type:
      - 'null'
      - boolean
    doc: Run Prodigal in '-p meta' mode to enable detecting genes in short 
      contigs
    inputBinding:
      position: 102
      prefix: --prodigal-meta-mode
  - id: protein
    type:
      - 'null'
      - boolean
    doc: Accept amino-acid protein sequences as input (experimental). Will treat
      each file as a single record with multiple proteins.
    inputBinding:
      position: 102
      prefix: --protein
  - id: output_gbk_path
    type:
      - 'null'
      - string
    doc: Output GenBank file path
    inputBinding:
      position: 103
      prefix: --output-gbk
  - id: output_tsv_path
    type:
      - 'null'
      - string
    doc: Output TSV file path
    inputBinding:
      position: 104
      prefix: --output-tsv
  - id: downloads_dir
    type:
      - 'null'
      - Directory
    doc: DeepBGC downloads directory made by "deepbgc download" (models and Pfam 
      database); passed to the tool as the DEEPBGC_DOWNLOADS_DIR environment 
      variable
outputs:
  - id: output_gbk
    type:
      - 'null'
      - File
    doc: Output GenBank file path
    outputBinding:
      glob: $(inputs.output_gbk_path)
  - id: output_tsv
    type:
      - 'null'
      - File
    doc: Output TSV file path
    outputBinding:
      glob: $(inputs.output_tsv_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      DEEPBGC_DOWNLOADS_DIR: '$(inputs.downloads_dir ? inputs.downloads_dir.path : runtime.outdir
        + "/deepbgc_downloads")'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepbgc:0.1.31--pyhca03a8a_0

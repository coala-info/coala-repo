cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mehari
  - db
  - create
label: mehari_db_create
doc: "Construct mehari transcripts and sequence database\n\nTool homepage: https://github.com/varfish-org/mehari"
inputs:
  - id: assembly
    type: string
    doc: "Targeted genome assembly to extract transcripts for (grch37, grch38)"
    inputBinding:
      position: 1
      prefix: --assembly
  - id: transcript_source
    type: string
    doc: "Source of the transcripts: refseq, ensembl, or other"
    inputBinding:
      position: 2
      prefix: --transcript-source
  - id: cdot_version
    type: string
    doc: "Version of cdot data"
    inputBinding:
      position: 3
      prefix: --cdot-version
  - id: path_out
    type: string
    doc: "Path to output protobuf file to write to"
    inputBinding:
      position: 4
      prefix: --path-out
  - id: path_cdot_json
    type:
      - type: array
        items: File
        inputBinding:
          prefix: --path-cdot-json
    doc: "Paths to the cdot JSON transcripts to import"
    inputBinding:
      position: 5
  - id: path_seqrepo_instance
    type: Directory
    doc: "Path to the seqrepo instance directory to use"
    inputBinding:
      position: 6
      prefix: --path-seqrepo-instance
  - id: assembly_version
    type:
      - 'null'
      - string
    doc: "Version of the genome assembly, e.g. GRCh37.p13"
    inputBinding:
      position: 7
      prefix: --assembly-version
  - id: transcript_source_version
    type:
      - 'null'
      - string
    doc: "Version of the transcript source, e.g. 112 for Ensembl"
    inputBinding:
      position: 8
      prefix: --transcript-source-version
  - id: path_mane_txs_tsv
    type:
      - 'null'
      - File
    doc: "Path to TSV file for label transfer of transcripts. Columns are transcript id (without version), (unused) gene symbol, and label"
    inputBinding:
      position: 9
      prefix: --path-mane-txs-tsv
  - id: max_txs
    type:
      - 'null'
      - int
    doc: "Maximal number of transcripts to process. DEPRECATED"
    inputBinding:
      position: 10
      prefix: --max-txs
  - id: gene_symbols
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --gene-symbols
    doc: "Limit transcript database to the following HGNC symbols. Useful for building test databases"
    inputBinding:
      position: 11
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use for steps supporting parallel processing (default: 1)"
    inputBinding:
      position: 12
      prefix: --threads
  - id: compression_level
    type:
      - 'null'
      - int
    doc: "ZSTD compression level to use (default: 19)"
    inputBinding:
      position: 13
      prefix: --compression-level
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase logging verbosity"
    inputBinding:
      position: 14
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Decrease logging verbosity"
    inputBinding:
      position: 15
      prefix: --quiet
outputs:
  - id: output_db
    type:
      - 'null'
      - File
    doc: "Transcript database written by mehari"
    outputBinding:
      glob: $(inputs.path_out)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mehari:0.39.0--h13c227e_0
stdout: mehari_db_create.out

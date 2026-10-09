cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicap
label: hicap
doc: "Identify cap locus serotype and structure in a Haemophilus influenzae assembly.\n\nTool homepage: https://github.com/scwatts/hicap"
inputs:
  - id: query_fp
    type: File
    doc: Input FASTA query
    inputBinding:
      position: 101
      prefix: --query_fp
  - id: output_dir_path
    type: string
    doc: Output directory
    inputBinding:
      position: 102
      prefix: --output_dir
  - id: database_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing locus database.
    inputBinding:
      position: 103
      prefix: --database_dir
  - id: model_fp
    type:
      - 'null'
      - File
    doc: Path to prodigal model.
    inputBinding:
      position: 103
      prefix: --model_fp
  - id: full_sequence
    type:
      - 'null'
      - boolean
    doc: Write the full input sequence out to the genbank file rather than just 
      the region surrounding and including the locus
    inputBinding:
      position: 103
      prefix: --full_sequence
  - id: gene_coverage
    type:
      - 'null'
      - float
    doc: Minimum percentage coverage to consider a single gene complete.
    inputBinding:
      position: 103
      prefix: --gene_coverage
  - id: gene_identity
    type:
      - 'null'
      - float
    doc: Minimum percentage identity to consider a single gene complete.
    inputBinding:
      position: 103
      prefix: --gene_identity
  - id: broken_gene_length
    type:
      - 'null'
      - int
    doc: Minimum length to consider a broken gene.
    inputBinding:
      position: 103
      prefix: --broken_gene_length
  - id: broken_gene_identity
    type:
      - 'null'
      - float
    doc: Minimum percentage identity to consider a broken gene.
    inputBinding:
      position: 103
      prefix: --broken_gene_identity
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads to use for BLAST+.
    inputBinding:
      position: 103
      prefix: --threads
  - id: log_fp
    type:
      - 'null'
      - string
    doc: Record logging messages to file
    inputBinding:
      position: 103
      prefix: --log_fp
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debug messages
    inputBinding:
      position: 103
      prefix: --debug
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir_path)
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file written to log_fp
    outputBinding:
      glob: $(inputs.log_fp)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({class: "Directory", basename: inputs.output_dir_path, listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicap:1.0.4--pyhdfd78af_2

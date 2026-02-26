cwlVersion: v1.2
class: CommandLineTool
baseCommand: iobrpy_count2tpm
label: iobrpy_count2tpm
doc: "Convert gene counts to TPM (Transcripts Per Million)\n\nTool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: check_data
    type:
      - 'null'
      - boolean
    doc: Check and remove missing values in count matrix
    inputBinding:
      position: 101
      prefix: --check_data
  - id: effective_length_csv
    type:
      - 'null'
      - File
    doc: Optional CSV with id, eff_length, and gene_symbol columns
    inputBinding:
      position: 101
      prefix: --effLength_csv
  - id: gene_length_source
    type:
      - 'null'
      - string
    doc: Source of gene lengths
    inputBinding:
      position: 101
      prefix: --source
  - id: gene_symbol_column
    type:
      - 'null'
      - string
    doc: Column name for gene symbol in effLength CSV
    inputBinding:
      position: 101
      prefix: --gene_symbol
  - id: id_column
    type:
      - 'null'
      - string
    doc: Column name for gene ID in effLength CSV
    inputBinding:
      position: 101
      prefix: --id
  - id: id_type
    type:
      - 'null'
      - string
    doc: Gene ID type
    inputBinding:
      position: 101
      prefix: --idtype
  - id: input_count_matrix
    type: File
    doc: Path to input count matrix (CSV/TSV, genes×samples)
    inputBinding:
      position: 101
      prefix: --input
  - id: length_column
    type:
      - 'null'
      - string
    doc: Column name for gene length in effLength CSV
    inputBinding:
      position: 101
      prefix: --length
  - id: organism
    type:
      - 'null'
      - string
    doc: 'Organism: hsa or mmus'
    inputBinding:
      position: 101
      prefix: --org
  - id: remove_version
    type:
      - 'null'
      - boolean
    doc: Remove version suffix from gene IDs before processing
    inputBinding:
      position: 101
      prefix: --remove_version
outputs:
  - id: output_path
    type: File
    doc: Path to save TPM matrix
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastafunk
  - split
label: fastafunk_split
doc: "Splits sequences into fasta files based on index column or index field\n\nTool homepage: https://github.com/cov-ert/fastafunk"
inputs:
  - id: in_fasta
    type: File
    doc: "One FASTA files of sequences (else reads from stdin)"
    inputBinding:
      position: 101
      prefix: --in-fasta
  - id: in_metadata
    type: File
    doc: "One CSV of metadata"
    inputBinding:
      position: 101
      prefix: --in-metadata
  - id: index_column
    type: ['null', string]
    doc: "Column(s) in the metadata file to use to match to the sequence"
    inputBinding:
      position: 101
      prefix: --index-column
  - id: index_field
    type: string
    doc: "Field(s) in the fasta header to match the metadata (else matches column names)"
    inputBinding:
      position: 101
      prefix: --index-field
  - id: lineage
    type: ['null', {type: array, items: string}]
    doc: "Specific list of lineages to split by with others collpasing to nearest lineage."
    inputBinding:
      position: 101
      prefix: --lineage
  - id: lineage_csv
    type: ['null', File]
    doc: "CSV with lineage and outgroup columns defining the lineages to split by."
    inputBinding:
      position: 101
      prefix: --lineage-csv
  - id: aliases
    type: ['null', File]
    doc: "JSON with aliases for lettered lineages."
    inputBinding:
      position: 101
      prefix: --aliases
  - id: out_folder_path
    type: ['null', string]
    doc: "Output prefix for the FASTA files, one per lineage, named <prefix><lineage>.fasta (the help calls it a directory, but the tool only prepends this text to the file name; default ./)"
    inputBinding:
      position: 101
      prefix: --out-folder
  - id: log_file_path
    type: ['null', string]
    doc: "Log file to use (otherwise uses stdout, or stderr if out-fasta to stdout)"
    inputBinding:
      position: 101
      prefix: --log-file
  - id: verbose
    type: ['null', boolean]
    doc: "Run with high verbosity (debug level logging)"
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout_output
    type: stdout
    doc: Standard output (FASTA or table when no output file is given, and log messages).
  - id: out_folder
    type: {type: array, items: File}
    doc: "FASTA files written by split, one per lineage."
    outputBinding:
      glob: '$(inputs.out_folder_path ? inputs.out_folder_path + "*.fasta" : "*.fasta")'
  - id: log_file
    type: ['null', File]
    doc: Log file.
    outputBinding:
      glob: $(inputs.log_file_path)
requirements:
  - class: InlineJavascriptRequirement
stdout: fastafunk_split.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastafunk:0.1.2--pyh5e36f6f_0

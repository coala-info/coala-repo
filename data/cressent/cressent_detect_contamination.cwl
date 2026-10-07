cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cressent
  - detect_contamination
label: cressent_detect_contamination
doc: "Filter viral contaminants from sequence data (nucleotide or protein).\n\nTool homepage: https://github.com/ricrocha82/cressent"
inputs:
  - id: input_fasta
    type: File
    doc: "Input FASTA file"
    inputBinding:
      position: 101
      prefix: --input_fasta
  - id: db
    type: File
    doc: "Contaminant database FASTA file (staged writable: the BLAST database is built beside it)"
    inputBinding:
      position: 101
      prefix: --db
      valueFrom: $(self.basename)
  - id: output_dir
    type: string
    doc: "Path to the output directory (created by the tool; collected as the output)"
    inputBinding:
      position: 101
      prefix: --output
  - id: output_name
    type:
      - 'null'
      - string
    doc: "Base name for output files (default: clean_sequences)"
    inputBinding:
      position: 101
      prefix: --output-name
  - id: seq_type
    type:
      - 'null'
      - string
    doc: "Sequence type, nucl or prot (auto-detect if not specified)"
    inputBinding:
      position: 101
      prefix: --seq-type
  - id: evalue
    type:
      - 'null'
      - float
    doc: "BLAST E-value threshold (default: 1e-10)"
    inputBinding:
      position: 101
      prefix: --evalue
  - id: identity
    type:
      - 'null'
      - float
    doc: "Minimum percent identity to consider a match (default: 90.0)"
    inputBinding:
      position: 101
      prefix: --identity
  - id: coverage
    type:
      - 'null'
      - float
    doc: "Minimum query coverage to consider a match (default: 50.0)"
    inputBinding:
      position: 101
      prefix: --coverage
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of CPU threads for BLAST (default: 1)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: "Keep temporary BLAST output files"
    inputBinding:
      position: 101
      prefix: --keep-temp
outputs:
  - id: output
    type: Directory
    doc: Output directory with all result files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.db)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0

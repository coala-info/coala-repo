cwlVersion: v1.2
class: CommandLineTool
baseCommand: suvtk_features
label: suvtk_features
doc: "Create feature tables for sequences from an input fasta file.\n\n  This command
  processes the input sequences to predict open reading frames\n  (ORFs), aligns the
  predicted protein sequences against a specified database\n  with proteins and their
  function, and generates feature tables for\n  submission to GenBank.\n\nTool homepage:
  https://github.com/LanderDC/suvtk"
inputs:
  - id: coding_complete
    type:
      - 'null'
      - boolean
    doc: Do not predict incomplete genes (no stop codon) and only keep genomes 
      that are 'coding complete' (>50% coding capacity). [This can not be turned
      off for now]
    inputBinding:
      position: 101
      prefix: --coding-complete
  - id: database_path
    type: Directory
    doc: Path to the suvtk database folder.
    inputBinding:
      position: 101
      prefix: --database
  - id: input_file
    type: File
    doc: Input fasta file
    inputBinding:
      position: 101
      prefix: --input
  - id: separate_files
    type:
      - 'null'
      - boolean
    doc: Save feature tables into separate files
    inputBinding:
      position: 101
      prefix: --separate-files
  - id: taxonomy_file
    type:
      - 'null'
      - File
    doc: Taxonomy file to adjust sequence orientation (ssRNA- sequences will get
      3' -> 5' orientation, all others 5' -> 3').
    inputBinding:
      position: 101
      prefix: --taxonomy
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
  - id: translation_table
    type:
      - 'null'
      - string
    doc: Translation table to use. Only genetic codes from 
      https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi are allowed (1-6,
      9-16, 21-31).
    default: 1
    inputBinding:
      position: 101
      prefix: --translation-table
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/suvtk:0.1.6--pyh64700be_0

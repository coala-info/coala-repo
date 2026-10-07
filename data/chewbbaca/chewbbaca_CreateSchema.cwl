cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chewBBACA.py
  - CreateSchema
label: chewbbaca_CreateSchema
doc: "Create a schema seed.\n\nTool homepage: https://github.com/B-UMMI/chewBBACA"
inputs:
  - id: input_files
    type: Directory
    doc: "Path to the directory that contains the input FASTA files."
    inputBinding:
      position: 1
      prefix: --input-files
  - id: output_directory
    type: string
    doc: "Output directory where the process will store intermediate files and create the schema's directory."
    default: "createschema_out"
    inputBinding:
      position: 1
      prefix: --output-directory
  - id: schema_name
    type:
      - 'null'
      - string
    doc: "Name given to the schema folder. (default: schema_seed)"
    inputBinding:
      position: 1
      prefix: --schema-name
  - id: training_file
    type:
      - 'null'
      - File
    doc: "Path to the Prodigal training file used by Pyrodigal to predict genes. The translation table used to create this file overrides any value passed to --translation-table. This file is copied to the schema folder to be used for allele calling."
    inputBinding:
      position: 1
      prefix: --training-file
  - id: blast_score_ratio
    type:
      - 'null'
      - float
    doc: "BLAST Score Ratio (BSR) value. Aligned sequences with a BSR >= than the defined value are considered to be alleles of the same gene. (default: 0.6)"
    inputBinding:
      position: 1
      prefix: --blast-score-ratio
  - id: minimum_length
    type:
      - 'null'
      - int
    doc: "Minimum sequence length value. Predicted coding sequences (CDSs) shorter than this value are excluded. (default: 201)"
    inputBinding:
      position: 1
      prefix: --minimum-length
  - id: translation_table
    type:
      - 'null'
      - int
    doc: "Genetic code used to predict genes and to translate coding DNA sequences (CDSs). Ignored if a valid training file is passed to --training-file."
    inputBinding:
      position: 1
      prefix: --translation-table
  - id: size_threshold
    type:
      - 'null'
      - float
    doc: "Coding sequence (CDS) size variation threshold, added to the schema config file. (default: 0.2)"
    inputBinding:
      position: 1
      prefix: --size-threshold
  - id: cpu_cores
    type:
      - 'null'
      - int
    doc: "Number of CPU cores that will be used to run the process (chewie resets to a lower value if it is equal to or exceeds the total number of available CPU cores). (default: 1)"
    inputBinding:
      position: 1
      prefix: --cpu-cores
  - id: blast_path
    type:
      - 'null'
      - Directory
    doc: "Path to the directory that contains the BLAST executables."
    inputBinding:
      position: 1
      prefix: --blast-path
  - id: prodigal_mode
    type:
      - 'null'
      - string
    doc: "Prodigal running mode (\"single\" or \"meta\"). (default: single)"
    inputBinding:
      position: 1
      prefix: --prodigal-mode
  - id: cds_input
    type:
      - 'null'
      - boolean
    doc: "If provided, chewBBACA skips the gene prediction step and assumes the input FASTA files contain coding sequences."
    inputBinding:
      position: 1
      prefix: --cds-input
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: "If provided, intermediate files generated during process execution are not deleted at the end."
    inputBinding:
      position: 1
      prefix: --no-cleanup
outputs:
  - id: results_dir
    type: Directory
    doc: "Output directory with the schema seed."
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0

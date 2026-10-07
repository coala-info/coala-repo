cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chewBBACA.py
  - PrepExternalSchema
label: chewbbaca_PrepExternalSchema
doc: "Adapt an external schema to be used with chewBBACA.\n\nTool homepage: https://github.com/B-UMMI/chewBBACA"
inputs:
  - id: schema_directory
    type: Directory
    doc: "Path to the directory of the schema to adapt. The schema must contain one FASTA file per gene/locus."
    inputBinding:
      position: 1
      prefix: --schema-directory
  - id: output_directory
    type: string
    doc: "Path to the output directory where the adapted schema will be created."
    default: "adapted_schema"
    inputBinding:
      position: 1
      prefix: --output-directory
  - id: genes_list
    type:
      - 'null'
      - File
    doc: "Path to a file with the list of loci in the schema that the process should adapt (one per line, full paths or loci IDs)."
    inputBinding:
      position: 1
      prefix: --genes-list
  - id: training_file
    type:
      - 'null'
      - File
    doc: "Path to the Prodigal training file that will be included in the directory of the adapted schema."
    inputBinding:
      position: 1
      prefix: --training-file
  - id: blast_score_ratio
    type:
      - 'null'
      - float
    doc: "BLAST Score Ratio (BSR) value used to select representative alleles. (default: 0.6)"
    inputBinding:
      position: 1
      prefix: --blast-score-ratio
  - id: minimum_length
    type:
      - 'null'
      - int
    doc: "Minimum sequence length value stored in the schema config file. (default: 0)"
    inputBinding:
      position: 1
      prefix: --minimum-length
  - id: translation_table
    type:
      - 'null'
      - int
    doc: "Genetic code used for allele translation. Ignored if a valid training file is passed to --training-file."
    inputBinding:
      position: 1
      prefix: --translation-table
  - id: size_threshold
    type:
      - 'null'
      - float
    doc: "Allele size variation threshold value stored in the schema config file. (default: 0.2)"
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
  - id: size_filter
    type:
      - 'null'
      - boolean
    doc: "Apply the minimum length and size threshold values to filter out alleles during schema adaptation."
    inputBinding:
      position: 1
      prefix: --size-filter
outputs:
  - id: results_dir
    type: Directory
    doc: "Adapted schema directory."
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chewbbaca:3.5.1--pyhdfd78af_0

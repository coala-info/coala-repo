cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CAT_pack
  - prepare
label: cat_prepare
doc: "Construct CAT/BAT/RAT database files.\n\nTool homepage: https://github.com/MGXlab/CAT_pack"
inputs:
  - id: db_fasta
    type: File
    doc: "Path to fasta file containing all sequences."
    inputBinding:
      position: 101
      prefix: --db_fasta
  - id: names
    type: File
    doc: "Path to names.dmp"
    inputBinding:
      position: 101
      prefix: --names
  - id: nodes
    type: File
    doc: "Path to nodes.dmp"
    inputBinding:
      position: 101
      prefix: --nodes
  - id: acc2tax
    type: File
    doc: "Path to accession2taxid.txt file. Can be gzipped."
    inputBinding:
      position: 101
      prefix: --acc2tax
  - id: db_dir
    type: string
    doc: "Path to directory where CAT/BAT/RAT database files will be created."
    inputBinding:
      position: 101
      prefix: --db_dir
  - id: path_to_diamond
    type:
      - 'null'
      - string
    doc: "Path to DIAMOND binaries. Supply if CAT/BAT/RAT cannot find DIAMOND."
    inputBinding:
      position: 101
      prefix: --path_to_diamond
  - id: common_prefix
    type:
      - 'null'
      - string
    doc: "Prefix for all files to be created."
    inputBinding:
      position: 101
      prefix: --common_prefix
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Suppress verbosity."
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase verbosity."
    inputBinding:
      position: 101
      prefix: --verbose
  - id: no_log
    type:
      - 'null'
      - boolean
    doc: "Suppress log file."
    inputBinding:
      position: 101
      prefix: --no_log
  - id: nproc
    type:
      - 'null'
      - int
    doc: "Number of cores to deploy by DIAMOND (default: maximum)."
    inputBinding:
      position: 101
      prefix: --nproc
outputs:
  - id: db_dir_out
    type: Directory
    doc: "Database directory (holds db/ and tax/)"
    outputBinding:
      glob: "$(inputs.db_dir)"
  - id: database_folder
    type: Directory
    doc: "Database files (DIAMOND database, fastaid2LCAtaxid, taxids_with_multiple_offspring)"
    outputBinding:
      glob: "$(inputs.db_dir)/db"
  - id: taxonomy_folder
    type: Directory
    doc: "Taxonomy files (names.dmp, nodes.dmp)"
    outputBinding:
      glob: "$(inputs.db_dir)/tax"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cat:6.0.1--hdfd78af_1

cwlVersion: v1.2
class: CommandLineTool
baseCommand: gunc_run
label: gunc_run
doc: "Run GUNC analysis\n\nTool homepage: https://github.com/grp-bork/gunc"
inputs:
  - id: contig_taxonomy_output
    type:
      - 'null'
      - boolean
    doc: 'Output assignments for each contig. Default: False'
    default: false
    inputBinding:
      position: 101
      prefix: --contig_taxonomy_output
  - id: db_file
    type:
      - 'null'
      - File
    doc: 'DiamondDB reference file. Default: GUNC_DB envvar'
    inputBinding:
      position: 101
      prefix: --db_file
  - id: detailed_output
    type:
      - 'null'
      - boolean
    doc: 'Output scores for every taxlevel. Default: False'
    default: false
    inputBinding:
      position: 101
      prefix: --detailed_output
  - id: file_suffix
    type:
      - 'null'
      - string
    doc: Suffix of files in input_dir.
    default: .fa
    inputBinding:
      position: 101
      prefix: --file_suffix
  - id: gene_calls
    type:
      - 'null'
      - boolean
    doc: 'Input files are FASTA faa format. Default: False'
    default: false
    inputBinding:
      position: 101
      prefix: --gene_calls
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: Input dir with files in FASTA format.
    inputBinding:
      position: 101
      prefix: --input_dir
  - id: input_fasta
    type:
      - 'null'
      - File
    doc: Input file in FASTA format.
    inputBinding:
      position: 101
      prefix: --input_fasta
  - id: input_file
    type:
      - 'null'
      - File
    doc: File with paths to FASTA format files.
    inputBinding:
      position: 101
      prefix: --input_file
  - id: min_mapped_genes
    type:
      - 'null'
      - int
    doc: 'Dont calculate GUNC score if number of mapped genes is below this value.
      Default: 11'
    default: 11
    inputBinding:
      position: 101
      prefix: --min_mapped_genes
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: 'Output dir. Default: cwd'
    default: cwd
    inputBinding:
      position: 101
      prefix: --out_dir
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: 'Run with high sensitivity. Default: False'
    default: false
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: 'Directory to store temp files. Default: cwd'
    default: cwd
    inputBinding:
      position: 101
      prefix: --temp_dir
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of CPU threads. Default: 4'
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: use_species_level
    type:
      - 'null'
      - boolean
    doc: 'Allow species level to be picked as maxCSS. Default: False'
    default: false
    inputBinding:
      position: 101
      prefix: --use_species_level
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output for debugging
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gunc:1.0.6--pyhdfd78af_1
stdout: gunc_run.out

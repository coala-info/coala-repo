cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gappa
  - edit
  - multiplicity
label: gappa_edit_multiplicity
doc: "Edit the multiplicities of queries in jplace files.\n\nTool homepage: https://github.com/lczech/gappa"
inputs:
  - id: jplace_path
    type:
      type: array
      items:
        - File
        - Directory
    doc: "List of jplace files or directories to process. For directories, only files with the extension `.jplace[.gz]` are processed."
    inputBinding:
      position: 1
      prefix: --jplace-path
  - id: multiplicity_file
    type: ['null', File]
    doc: "File containing a tab-separated list of [sample name,] query name, and multiplicity. (Excludes: --fasta-path --write-multiplicity-file)"
    inputBinding:
      position: 2
      prefix: --multiplicity-file
  - id: fasta_path
    type:
      - 'null'
      - type: array
        items:
          - File
          - Directory
    doc: "List of fasta files or directories to process. For directories, only files with the extension `.(fasta|fas|fsa|fna|ffn|faa|frn)[.gz]` are processed. (Excludes: --multiplicity-file --write-multiplicity-file)"
    inputBinding:
      position: 3
      prefix: --fasta-path
  - id: keep_full_label
    type: ['null', boolean]
    doc: "If fasta files are used, keep their whole label as the name for jplace pqueries, instead of removing the abundance annotation. (Needs: --fasta-path)"
    inputBinding:
      position: 4
      prefix: --keep-full-label
  - id: write_multiplicity_file
    type: ['null', boolean]
    doc: "Do not change the existing multiplicities, but instead produce a file that lists them. (Excludes: --multiplicity-file --fasta-path)"
    inputBinding:
      position: 5
      prefix: --write-multiplicity-file
  - id: out_dir
    type: ['null', string]
    doc: "Directory to write output files to. (Default: .)"
    default: "gappa_out"
    inputBinding:
      position: 6
      prefix: --out-dir
  - id: file_prefix
    type: ['null', string]
    doc: "File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 7
      prefix: --file-prefix
  - id: file_suffix
    type: ['null', string]
    doc: "File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 8
      prefix: --file-suffix
  - id: compress
    type: ['null', boolean]
    doc: "If set, compress the output files using gzip. Output file extensions are automatically extended by `.gz`."
    inputBinding:
      position: 9
      prefix: --compress
  - id: allow_file_overwriting
    type: ['null', boolean]
    doc: "Allow to overwrite existing output files instead of aborting the command."
    inputBinding:
      position: 10
      prefix: --allow-file-overwriting
  - id: verbose
    type: ['null', boolean]
    doc: "Produce more verbose output."
    inputBinding:
      position: 11
      prefix: --verbose
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use for calculations. (Default: 10)"
    inputBinding:
      position: 12
      prefix: --threads
  - id: log_file
    type: ['null', string]
    doc: "Write all output to a log file, in addition to standard output to the terminal."
    inputBinding:
      position: 13
      prefix: --log-file
outputs:
  - id: output_dir
    type: Directory
    doc: "Output directory (--out-dir)."
    outputBinding:
      glob: "$(inputs.out_dir)"
  - id: log_file_out
    type: File?
    doc: "Log file written by --log-file."
    outputBinding:
      glob: "$(inputs.log_file)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gappa:0.9.0--h077b44d_0

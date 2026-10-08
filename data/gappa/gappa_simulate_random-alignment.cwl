cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gappa
  - simulate
  - random-alignment
label: gappa_simulate_random-alignment
doc: "Create a random alignment with a given numer of sequences of a given length.\n\nTool homepage: https://github.com/lczech/gappa"
inputs:
  - id: sequence_count
    type: int
    doc: "Number of sequences to create. (Default: 0)"
    inputBinding:
      position: 1
      prefix: --sequence-count
  - id: sequence_length
    type: int
    doc: "Length of the sequences to create. (Default: 0)"
    inputBinding:
      position: 2
      prefix: --sequence-length
  - id: characters
    type: ['null', string]
    doc: "Set of characters to use for the sequences. (Default: -ACGT)"
    inputBinding:
      position: 3
      prefix: --characters
  - id: out_dir
    type: ['null', string]
    doc: "Directory to write output files to. (Default: .)"
    default: "gappa_out"
    inputBinding:
      position: 4
      prefix: --out-dir
  - id: file_prefix
    type: ['null', string]
    doc: "File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 5
      prefix: --file-prefix
  - id: file_suffix
    type: ['null', string]
    doc: "File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 6
      prefix: --file-suffix
  - id: compress
    type: ['null', boolean]
    doc: "If set, compress the output files using gzip. Output file extensions are automatically extended by `.gz`."
    inputBinding:
      position: 7
      prefix: --compress
  - id: write_fasta
    type: ['null', boolean]
    doc: "Write sequences to a fasta file."
    inputBinding:
      position: 8
      prefix: --write-fasta
  - id: write_strict_phylip
    type: ['null', boolean]
    doc: "Write sequences to a strict phylip file. (Excludes: --write-relaxed-phylip)"
    inputBinding:
      position: 9
      prefix: --write-strict-phylip
  - id: write_relaxed_phylip
    type: ['null', boolean]
    doc: "Write sequences to a relaxed phylip file. (Excludes: --write-strict-phylip)"
    inputBinding:
      position: 10
      prefix: --write-relaxed-phylip
  - id: allow_file_overwriting
    type: ['null', boolean]
    doc: "Allow to overwrite existing output files instead of aborting the command."
    inputBinding:
      position: 11
      prefix: --allow-file-overwriting
  - id: verbose
    type: ['null', boolean]
    doc: "Produce more verbose output."
    inputBinding:
      position: 12
      prefix: --verbose
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use for calculations. (Default: 10)"
    inputBinding:
      position: 13
      prefix: --threads
  - id: log_file
    type: ['null', string]
    doc: "Write all output to a log file, in addition to standard output to the terminal."
    inputBinding:
      position: 14
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

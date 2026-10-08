cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gappa
  - prepare
  - phat
label: gappa_prepare_phat
doc: "Generate consensus sequences from a sequence database according to the PhAT method.\n\nTool homepage: https://github.com/lczech/gappa"
inputs:
  - id: taxonomy_file
    type: File
    doc: "File that lists the taxa of the database."
    inputBinding:
      position: 1
      prefix: --taxonomy-file
  - id: sequence_file
    type: File
    doc: "Fasta file containing the sequences of the database."
    inputBinding:
      position: 2
      prefix: --sequence-file
  - id: target_size
    type: int
    doc: "Target size of how many taxa to select for building consensus sequences. (Default: 0)"
    inputBinding:
      position: 3
      prefix: --target-size
  - id: sub_taxonomy
    type: ['null', string]
    doc: "If a taxopath from the taxonomy is provided, only the respective sub-taxonomy is used."
    inputBinding:
      position: 4
      prefix: --sub-taxonomy
  - id: min_subclade_size
    type: ['null', int]
    doc: "Minimal size of sub-clades. Everything below is expanded. (Default: 0)"
    inputBinding:
      position: 5
      prefix: --min-subclade-size
  - id: max_subclade_size
    type: ['null', int]
    doc: "Maximal size of a non-expanded sub-clades. Everything bigger is first expanded. (Default: 0)"
    inputBinding:
      position: 6
      prefix: --max-subclade-size
  - id: min_tax_level
    type: ['null', int]
    doc: "Minimal taxonomic level. Taxa below this level are always expanded. (Default: 0)"
    inputBinding:
      position: 7
      prefix: --min-tax-level
  - id: allow_approximation
    type: ['null', boolean]
    doc: "Allow to expand taxa that help getting closer to the --target-size, even if they are not the ones with the highest entropy."
    inputBinding:
      position: 8
      prefix: --allow-approximation
  - id: no_taxa_selection
    type: ['null', boolean]
    doc: "If set, no taxa selection using entropy is performed. Instead, all taxa on all levels/ranks are used and consensus sequences for all of them are calculated. This is useful for testing and to try out new ideas."
    inputBinding:
      position: 9
      prefix: --no-taxa-selection
  - id: consensus_method
    type:
      - 'null'
      - type: enum
        symbols: [majorities, cavener, threshold]
    doc: "Consensus method to use for combining sequences. (Default: majorities)"
    inputBinding:
      position: 10
      prefix: --consensus-method
  - id: consensus_threshold
    type: ['null', float]
    doc: "Threshold value to use with --consensus-method threshold. Has to be in [ 0.0, 1.0 ]. (Needs: --consensus-method; Default: 0.5; Range: [0 - 1])"
    inputBinding:
      position: 11
      prefix: --consensus-threshold
  - id: out_dir
    type: ['null', string]
    doc: "Directory to write output files to. (Default: .)"
    default: "gappa_out"
    inputBinding:
      position: 12
      prefix: --out-dir
  - id: file_prefix
    type: ['null', string]
    doc: "File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 13
      prefix: --file-prefix
  - id: file_suffix
    type: ['null', string]
    doc: "File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 14
      prefix: --file-suffix
  - id: write_info_files
    type: ['null', boolean]
    doc: "If set, two additional info files are written, containing the new pruned taxonomy, as well as the entropy of all clades of the original taxonomy."
    inputBinding:
      position: 15
      prefix: --write-info-files
  - id: allow_file_overwriting
    type: ['null', boolean]
    doc: "Allow to overwrite existing output files instead of aborting the command."
    inputBinding:
      position: 16
      prefix: --allow-file-overwriting
  - id: verbose
    type: ['null', boolean]
    doc: "Produce more verbose output."
    inputBinding:
      position: 17
      prefix: --verbose
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use for calculations. (Default: 10)"
    inputBinding:
      position: 18
      prefix: --threads
  - id: log_file
    type: ['null', string]
    doc: "Write all output to a log file, in addition to standard output to the terminal."
    inputBinding:
      position: 19
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

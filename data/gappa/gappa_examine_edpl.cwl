cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gappa
  - examine
  - edpl
label: gappa_examine_edpl
doc: "Calcualte the Expected Distance between Placement Locations (EDPL) for all pqueries.\n\nTool homepage: https://github.com/lczech/gappa"
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
  - id: histogram_bins
    type: ['null', int]
    doc: "Number of histogram bins for binning the EDPL values. (Default: 25)"
    inputBinding:
      position: 2
      prefix: --histogram-bins
  - id: histogram_max
    type: ['null', float]
    doc: "Maximum value to use in the histogram for binning the EDPL values. To use the maximal EDPL found in the samples, use a negative value (default). (Default: -1)"
    inputBinding:
      position: 3
      prefix: --histogram-max
  - id: no_list_file
    type: ['null', boolean]
    doc: "If set, do not write out the EDPL per pquery, but just the histogram file. As the list needs to keep all pquery names in memory (to get the correct order), the memory requirements might be too large. In that case, this option can help."
    inputBinding:
      position: 4
      prefix: --no-list-file
  - id: out_dir
    type: ['null', string]
    doc: "Directory to write output files to. (Default: .)"
    default: "gappa_out"
    inputBinding:
      position: 5
      prefix: --out-dir
  - id: file_prefix
    type: ['null', string]
    doc: "File prefix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 6
      prefix: --file-prefix
  - id: file_suffix
    type: ['null', string]
    doc: "File suffix for output files. Most gappa commands use the command name as the base name for file output. This option amends the base name, to distinguish runs with different data."
    inputBinding:
      position: 7
      prefix: --file-suffix
  - id: allow_file_overwriting
    type: ['null', boolean]
    doc: "Allow to overwrite existing output files instead of aborting the command."
    inputBinding:
      position: 8
      prefix: --allow-file-overwriting
  - id: verbose
    type: ['null', boolean]
    doc: "Produce more verbose output."
    inputBinding:
      position: 9
      prefix: --verbose
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use for calculations. (Default: 10)"
    inputBinding:
      position: 10
      prefix: --threads
  - id: log_file
    type: ['null', string]
    doc: "Write all output to a log file, in addition to standard output to the terminal."
    inputBinding:
      position: 11
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

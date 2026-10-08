cwlVersion: v1.2
class: CommandLineTool
baseCommand: rm_low_coverage_duplicated_contigs.py
label: getorganelle_rm_low_coverage_duplicated_contigs.py
doc: "Remove low-coverage contigs that duplicate higher-coverage contigs in FASTG assembly graphs, found by blastn.\n\nTool homepage: http://github.com/Kinggerm/GetOrganelle"
inputs:
  - id: assemblies
    type:
      type: array
      items: File
    doc: "Input FASTG format assembly graph files."
    inputBinding:
      position: 2
  - id: coverage_threshold
    type:
      - 'null'
      - float
    doc: "With ratio (coverage of query/coverage of subject) below which, the query would be exposed to discarded. Default: 0.12"
    inputBinding:
      position: 101
      prefix: --cov-t
  - id: length_threshold
    type:
      - 'null'
      - float
    doc: "With overlap (length of hit of query/ length of query) above which, the query would be exposed to discarded. Default: 0.9"
    inputBinding:
      position: 101
      prefix: --len-t
  - id: blur
    type:
      - 'null'
      - boolean
    doc: "Replace hit low-coverage bases with N."
    inputBinding:
      position: 101
      prefix: --blur
  - id: keep_temp
    type:
      - 'null'
      - boolean
    doc: "Keep temp blast files."
    inputBinding:
      position: 101
      prefix: --keep-temp
  - id: which_blast
    type:
      - 'null'
      - string
    doc: "Assign the path to BLAST binary files if not added to the path."
    inputBinding:
      position: 101
      prefix: --which-blast
  - id: output_dir
    type:
      - 'null'
      - string
    doc: "Output directory. Default: along with the original file"
    inputBinding:
      position: 1
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: "Threads of blastn."
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_directory
    type: Directory?
    doc: "The output directory."
    outputBinding:
      glob: "$(inputs.output_dir)"
  - id: stdout
    type: stdout
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
stdout: getorganelle_rm_low_coverage_duplicated_contigs.py.out

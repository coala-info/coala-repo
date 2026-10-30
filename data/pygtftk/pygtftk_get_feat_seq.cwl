cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - get_feat_seq
label: pygtftk_get_feat_seq
doc: "Get feature sequences (i.e. column 3) in a flexible fasta format from a GTF file.\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: inputfile
    type: File
    doc: "Path to the GTF file. Default to STDIN"
    inputBinding:
      position: 101
      prefix: --inputfile
  - id: outputfile_path
    type: string
    doc: "Output FASTA file."
    inputBinding:
      position: 102
      prefix: --outputfile
  - id: genome
    type: File
    doc: "The genome in fasta format."
    inputBinding:
      position: 101
      prefix: --genome
  - id: separator
    type: ['null', string]
    doc: "To separate info in header."
    inputBinding:
      position: 101
      prefix: --separator
  - id: label
    type: ['null', string]
    doc: "A set of key for the header that will be extracted from the transcript line."
    inputBinding:
      position: 101
      prefix: --label
  - id: feature_type
    type: ['null', string]
    doc: "The feature type (one defined in column 3)."
    inputBinding:
      position: 101
      prefix: --feature-type
  - id: no_rev_comp
    type: ['null', boolean]
    doc: "Don't reverse complement sequence corresponding to gene on minus strand."
    inputBinding:
      position: 101
      prefix: --no-rev-comp
  - id: rev_comp_to_header
    type: ['null', boolean]
    doc: "Indicate in the header whether sequence was rev-complemented."
    inputBinding:
      position: 101
      prefix: --rev-comp-to-header
  - id: unique
    type: ['null', boolean]
    doc: "Don't write redondant IDS."
    inputBinding:
      position: 101
      prefix: --unique
  - id: verbosity
    type: ['null', int]
    doc: "Set output verbosity ([0-3])."
    inputBinding:
      position: 101
      prefix: --verbosity
  - id: no_date
    type: ['null', boolean]
    doc: "Do not add date to output file names."
    inputBinding:
      position: 101
      prefix: --no-date
  - id: add_chr
    type: ['null', boolean]
    doc: "Add 'chr' to chromosome names before printing output."
    inputBinding:
      position: 101
      prefix: --add-chr
  - id: tmp_dir
    type: ['null', string]
    doc: "Keep all temporary files into this folder."
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: keep_all
    type: ['null', boolean]
    doc: "Try to keep all temporary files even if process does not terminate normally."
    inputBinding:
      position: 101
      prefix: --keep-all
  - id: logger_file
    type: ['null', string]
    doc: "Stores the arguments passed to the command into a file."
    inputBinding:
      position: 101
      prefix: --logger-file
  - id: write_message_to_file
    type: ['null', string]
    doc: "Store all message into a file."
    inputBinding:
      position: 101
      prefix: --write-message-to-file
outputs:
  - id: outputfile
    type: File
    doc: "Output FASTA file."
    outputBinding:
      glob: $(inputs.outputfile_path)
  - id: logger_file_out
    type: ['null', File]
    doc: "Stores the arguments passed to the command into a file."
    outputBinding:
      glob: $(inputs.logger_file)
  - id: write_message_to_file_out
    type: ['null', File]
    doc: "Store all message into a file."
    outputBinding:
      glob: $(inputs.write_message_to_file)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genome)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5

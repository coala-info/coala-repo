cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - closest_genes
label: pygtftk_closest_genes
doc: "Find the n closest genes for each genes.\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: inputfile
    type: File
    doc: "Path to the GTF file. Default to STDIN"
    inputBinding:
      position: 101
      prefix: --inputfile
  - id: outputfile_path
    type: string
    doc: "Output file."
    inputBinding:
      position: 102
      prefix: --outputfile
  - id: from_region_type
    type:
      - 'null'
      - type: enum
        symbols: [tss, tts, gene]
    doc: "What is region to consider for each gene."
    inputBinding:
      position: 101
      prefix: --from-region-type
  - id: nb_neighbors
    type: ['null', int]
    doc: "The size of the neighborhood."
    inputBinding:
      position: 101
      prefix: --nb-neighbors
  - id: to_region_type
    type:
      - 'null'
      - type: enum
        symbols: [tss, tts, gene]
    doc: "What is region to consider for each closest gene."
    inputBinding:
      position: 101
      prefix: --to-region-type
  - id: same_strandedness
    type: ['null', boolean]
    doc: "Require same strandedness"
    inputBinding:
      position: 101
      prefix: --same-strandedness
  - id: diff_strandedness
    type: ['null', boolean]
    doc: "Require different strandedness"
    inputBinding:
      position: 101
      prefix: --diff-strandedness
  - id: text_format
    type: ['null', boolean]
    doc: "Return a text format."
    inputBinding:
      position: 101
      prefix: --text-format
  - id: no_header
    type: ['null', boolean]
    doc: "Don't print the header line."
    inputBinding:
      position: 101
      prefix: --no-header
  - id: collapse
    type: ['null', boolean]
    doc: "Unwrap. Don't use comma. Print closest genes line by line."
    inputBinding:
      position: 101
      prefix: --collapse
  - id: identifier
    type:
      - 'null'
      - type: enum
        symbols: [gene_id, gene_name]
    doc: "The key used as gene identifier."
    inputBinding:
      position: 101
      prefix: --identifier
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
    doc: "Output file."
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5

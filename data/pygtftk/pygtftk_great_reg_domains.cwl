cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - great_reg_domains
label: pygtftk_great_reg_domains
doc: "Given a GTF and a GO term computes labeled regions using GREAT 'association rule'.\n\nTool homepage: http://github.com/dputhier/pygtftk"
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
  - id: go_id
    type: ['null', string]
    doc: "The GO ID (e.g GO:0003700). Default is to return all genes."
    inputBinding:
      position: 101
      prefix: --go-id
  - id: species
    type: ['null', string]
    doc: "The dataset/species. Use select_by_go to get the list of species"
    inputBinding:
      position: 101
      prefix: --species
  - id: upstream
    type: ['null', int]
    doc: "Extend the TSS in 5' by a given value."
    inputBinding:
      position: 101
      prefix: --upstream
  - id: downstream
    type: ['null', int]
    doc: "Extend the TSS 3' by a given value."
    inputBinding:
      position: 101
      prefix: --downstream
  - id: distal
    type: ['null', int]
    doc: "Maximum extension in one direction"
    inputBinding:
      position: 101
      prefix: --distal
  - id: chrom_info
    type:
      - File
      - string
    doc: "Tabulated two-columns file. Chromosomes as column 1, sizes as column 2"
    inputBinding:
      position: 101
      prefix: --chrom-info
  - id: mode
    type: ['null', string]
    doc: "The type of 'association rule'."
    inputBinding:
      position: 101
      prefix: --mode
  - id: http_proxy
    type: ['null', string]
    doc: "Use this http proxy (not tested/experimental)."
    inputBinding:
      position: 101
      prefix: --http-proxy
  - id: https_proxy
    type: ['null', string]
    doc: "Use this https proxy (not tested/experimental)."
    inputBinding:
      position: 101
      prefix: --https-proxy
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

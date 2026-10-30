cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - feature_size
label: pygtftk_feature_size
doc: "Get the size and limits (start/end) of features enclosed in the GTF. The feature can be of any type (as found in the 3rd column of the GTF) or 'mature_rna' to get transcript size (i.e without introns). If bed format is requested returns the limits in bed format and the size as a score. Otherwise output GTF file with 'feat_size' as a new key and size as value.\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: inputfile
    type: File
    doc: "Path to the GTF file. Default to STDIN"
    inputBinding:
      position: 101
      prefix: --inputfile
  - id: outputfile_path
    type: string
    doc: "Output file (BED)."
    inputBinding:
      position: 102
      prefix: --outputfile
  - id: ft_type
    type: ['null', string]
    doc: "A target feature (as found in the 3rd column of the GTF) or 'mature_rna' to get transcript size (without introns)."
    inputBinding:
      position: 101
      prefix: --ft-type
  - id: names
    type: ['null', string]
    doc: "The key(s) that should be used as name if bed is requested."
    inputBinding:
      position: 101
      prefix: --names
  - id: key_name
    type: ['null', string]
    doc: "Name for the new key if GTF format is requested."
    inputBinding:
      position: 101
      prefix: --key-name
  - id: separator
    type: ['null', string]
    doc: "The separator to be used for separating name elements (see -n)."
    inputBinding:
      position: 101
      prefix: --separator
  - id: bed
    type: ['null', boolean]
    doc: "Output bed format."
    inputBinding:
      position: 101
      prefix: --bed
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
    doc: "Output file (BED)."
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

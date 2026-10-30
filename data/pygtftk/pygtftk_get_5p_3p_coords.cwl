cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - get_5p_3p_coords
label: pygtftk_get_5p_3p_coords
doc: "Get the 5p or 3p coordinate for each feature (e.g TSS or TTS for a transcript).\n\nTool homepage: http://github.com/dputhier/pygtftk"
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
    doc: "The target feature (as found in the 3rd column of the GTF)."
    inputBinding:
      position: 101
      prefix: --ft-type
  - id: invert
    type: ['null', boolean]
    doc: "Get 3' coordinate."
    inputBinding:
      position: 101
      prefix: --invert
  - id: transpose
    type: ['null', int]
    doc: "Transpose coordinate in 5' (use negative value) or in 3' (use positive values)."
    inputBinding:
      position: 101
      prefix: --transpose
  - id: names
    type: ['null', string]
    doc: "The key(s) that should be used as name."
    inputBinding:
      position: 101
      prefix: --names
  - id: more_names
    type: ['null', string]
    doc: "A comma-separated list of information to be added to the 'name' column of the bed file."
    inputBinding:
      position: 101
      prefix: --more-names
  - id: separator
    type: ['null', string]
    doc: "The separator to be used for separating name elements (see -n)."
    inputBinding:
      position: 101
      prefix: --separator
  - id: explicit
    type: ['null', boolean]
    doc: "Write explicitly the name of the keys in the header."
    inputBinding:
      position: 101
      prefix: --explicit
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

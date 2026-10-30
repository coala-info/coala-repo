cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - bed_to_gtf
label: pygtftk_bed_to_gtf
doc: "Convert a bed file to a gtf. This will make the poor bed feel as if it was a big/fat gtf (but with lots of empty fields...sniff). May be helpful sometimes...\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: inputfile
    type: File
    doc: "Path to the poor BED file to would like to behave as if it was a GTF."
    inputBinding:
      position: 101
      prefix: --inputfile
  - id: outputfile_path
    type: string
    doc: "Output file."
    inputBinding:
      position: 102
      prefix: --outputfile
  - id: ft_type
    type: ['null', string]
    doc: "The type of features you are trying to mimic..."
    inputBinding:
      position: 101
      prefix: --ft-type
  - id: source
    type: ['null', string]
    doc: "The source of annotation."
    inputBinding:
      position: 101
      prefix: --source
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

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - bigwig_to_bed
label: pygtftk_bigwig_to_bed
doc: "Convert a bigwig to a BED3 format by selecting regions based on a boolean expression.\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: inputfile
    type: File
    doc: "Path to the bigwig file"
    inputBinding:
      position: 101
      prefix: --inputfile
  - id: outputfile_path
    type: ['null', string]
    doc: "The output BED file."
    inputBinding:
      position: 102
      prefix: --outputfile
  - id: chrom_list
    type:
      - 'null'
      - string[]
    doc: "The list of chromosomes of interest."
    inputBinding:
      position: 101
      prefix: --chrom-list
  - id: expression
    type: string
    doc: "A boolean expression where s is the signal (e.g; s > 0 and s < 0.5)."
    inputBinding:
      position: 101
      prefix: --expression
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
    type: ['null', File]
    doc: "The output BED file."
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
  - id: stdout_out
    type: stdout
stdout: bigwig_to_bed.bed
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5

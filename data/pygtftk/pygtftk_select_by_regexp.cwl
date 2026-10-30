cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - select_by_regexp
label: pygtftk_select_by_regexp
doc: "Select lines from a GTF file based on a regexp. The default is to try to select feature from conventional human chromosome (chr1..chr22, chrX and chrY) with --key set to chrom and --regexp set to \"^chr[0-9XY]+$\".\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: add_chr
    type:
      - 'null'
      - boolean
    doc: "Add 'chr' to chromosome names before printing output."
    inputBinding:
      position: 1
      prefix: --add-chr
  - id: inputfile
    type:
      - 'null'
      - File
    doc: "Path to the GTF file. Default to STDIN."
    inputBinding:
      position: 1
      prefix: --inputfile
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: "Not/invert match. Selected lines whose requested key do not match the regexp."
    inputBinding:
      position: 1
      prefix: --invert-match
  - id: keep_all
    type:
      - 'null'
      - boolean
    doc: "Try to keep all temporary files even if process does not terminate normally."
    inputBinding:
      position: 1
      prefix: --keep-all
  - id: key
    type:
      - 'null'
      - string
    doc: "The key name."
    inputBinding:
      position: 1
      prefix: --key
  - id: logger_file
    type:
      - 'null'
      - string
    doc: "Stores the arguments passed to the command into a file."
    inputBinding:
      position: 1
      prefix: --logger-file
  - id: no_date
    type:
      - 'null'
      - boolean
    doc: "Do not add date to output file names."
    inputBinding:
      position: 1
      prefix: --no-date
  - id: outputfile
    type: string
    default: "out.gtf"
    doc: "Output file."
    inputBinding:
      position: 1
      prefix: --outputfile
  - id: regexp
    type:
      - 'null'
      - string
    doc: "The regular expression."
    inputBinding:
      position: 1
      prefix: --regexp
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Keep all temporary files into this folder."
    inputBinding:
      position: 1
      prefix: --tmp-dir
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Set output verbosity ([0-3])."
    inputBinding:
      position: 1
      prefix: --verbosity
  - id: write_message_to_file
    type:
      - 'null'
      - string
    doc: "Store all message into a file."
    inputBinding:
      position: 1
      prefix: --write-message-to-file
outputs:
  - id: result
    type: File
    doc: "Output file."
    outputBinding:
      glob: "$(inputs.outputfile)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5

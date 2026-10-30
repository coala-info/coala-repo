cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - select_by_intron_size
label: pygtftk_select_by_intron_size
doc: "Delete transcripts containing an intron whose size is below s. By default delete transcripts containing an intron (or a sum intronic nucleotides, see -m) whose size is below s. If --invert-match is selected delete transcripts containing an intron whose size is greater or equal to s. Mono-exonic transcripts are not tested for intron size. They can be kept or deleted based on -d.\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: add_chr
    type:
      - 'null'
      - boolean
    doc: "Add 'chr' to chromosome names before printing output."
    inputBinding:
      position: 1
      prefix: --add-chr
  - id: add_intron_size
    type:
      - 'null'
      - boolean
    doc: "Add a new key containing intron_size (comma-separated in order of apppearance) or the sum of intron size (see -m)."
    inputBinding:
      position: 1
      prefix: --add-intron-size
  - id: delete_monoexonic
    type:
      - 'null'
      - boolean
    doc: "If selected, delete mono-exonic transcripts."
    inputBinding:
      position: 1
      prefix: --delete-monoexonic
  - id: inputfile
    type:
      - 'null'
      - File
    doc: "Path to the GTF file. Default to STDIN."
    inputBinding:
      position: 1
      prefix: --inputfile
  - id: intron_size
    type: int
    doc: "The minimum intron size."
    inputBinding:
      position: 1
      prefix: --intron-size
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: "Keep genes with an intron whose size is above s and delete others."
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
  - id: logger_file
    type:
      - 'null'
      - string
    doc: "Stores the arguments passed to the command into a file."
    inputBinding:
      position: 1
      prefix: --logger-file
  - id: merged
    type:
      - 'null'
      - boolean
    doc: "If selected, the sum of all intron lengths for a gene should be higher than s."
    inputBinding:
      position: 1
      prefix: --merged
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

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - shift
label: pygtftk_shift
doc: "Transpose coordinates in 3' or 5' direction. By default shift is not strand specific: a positive value shifts in 5' direction relative to the forward strand and a negative value in 3' direction. If --stranded is true, features are transposed in 5' direction relative to their associated strand. By default, features are not allowed to go outside the genome coordinates; use --allow-outside to let them disappear.\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: add_chr
    type:
      - 'null'
      - boolean
    doc: "Add 'chr' to chromosome names before printing output."
    inputBinding:
      position: 1
      prefix: --add-chr
  - id: allow_outside
    type:
      - 'null'
      - boolean
    doc: "Accept the partial or total disappearance of a feature upon shifting."
    inputBinding:
      position: 1
      prefix: --allow-outside
  - id: chrom_info
    type: File
    doc: "Tabulated two-columns file. Chromosomes as column 1 and sizes as column 2 (or a genome name such as hg38)."
    inputBinding:
      position: 1
      prefix: --chrom-info
  - id: inputfile
    type:
      - 'null'
      - File
    doc: "Path to the GTF file. Default to STDIN."
    inputBinding:
      position: 1
      prefix: --inputfile
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
  - id: shift_value
    type: int
    doc: "Shift coordinate by s nucleotides."
    inputBinding:
      position: 1
      prefix: --shift-value
  - id: stranded
    type:
      - 'null'
      - boolean
    doc: "Shift in 5' direction relative to the strand of each feature."
    inputBinding:
      position: 1
      prefix: --stranded
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

cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - mk_matrix
label: pygtftk_mk_matrix
doc: "Create a matrix storing the bigwig coverage computed from binned regions.\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: add_chr
    type:
      - 'null'
      - boolean
    doc: "Add 'chr' to chromosome names before printing output."
    inputBinding:
      position: 1
      prefix: --add-chr
  - id: bigwiglist
    type:
      type: array
      items: File
    doc: "A list of Bigwig files (last argument)."
    inputBinding:
      position: 1
      prefix: --bigwiglist
  - id: bin_around_frac
    type:
      - 'null'
      - float
    doc: "Fraction of bins used in 5' and 3' regions."
    inputBinding:
      position: 1
      prefix: --bin-around-frac
  - id: bin_nb
    type:
      - 'null'
      - int
    doc: "Split the region into w bins."
    inputBinding:
      position: 1
      prefix: --bin-nb
  - id: chrom_info
    type: File
    doc: "Tabulated file (chr as column 1, sizes as column 2.)"
    inputBinding:
      position: 1
      prefix: --chrom-info
  - id: downstream
    type:
      - 'null'
      - int
    doc: "Extend the region of interest in 3' by a given value."
    inputBinding:
      position: 1
      prefix: --downstream
  - id: ft_type
    type:
      - 'null'
      - string
    doc: "If input is a GTF, the region to analyse (promoter, tts, transcript, user_regions or single_nuc)."
    inputBinding:
      position: 1
      prefix: --ft-type
  - id: inputfile
    type:
      - 'null'
      - File
    doc: "A GTF file or bed file. A GTF if <stdin>."
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
  - id: labels
    type:
      - 'null'
      - string
    doc: "Bigwig labels (i.e short name version for plotting)."
    inputBinding:
      position: 1
      prefix: --labels
  - id: logger_file
    type:
      - 'null'
      - string
    doc: "Stores the arguments passed to the command into a file."
    inputBinding:
      position: 1
      prefix: --logger-file
  - id: nb_proc
    type:
      - 'null'
      - int
    doc: "Use this many threads to compute coverage."
    inputBinding:
      position: 1
      prefix: --nb-proc
  - id: no_date
    type:
      - 'null'
      - boolean
    doc: "Do not add date to output file names."
    inputBinding:
      position: 1
      prefix: --no-date
  - id: no_stranded
    type:
      - 'null'
      - boolean
    doc: "The bins should not be oriented relative to strand."
    inputBinding:
      position: 1
      prefix: --no-stranded
  - id: outputfile
    type: string
    default: "out_matrix"
    doc: "Output file name (.zip extension will be added)."
    inputBinding:
      position: 1
      prefix: --outputfile
  - id: pseudo_count
    type:
      - 'null'
      - float
    doc: "Pseudo-count to add to all values."
    inputBinding:
      position: 1
      prefix: --pseudo-count
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Keep all temporary files into this folder."
    inputBinding:
      position: 1
      prefix: --tmp-dir
  - id: upstream
    type:
      - 'null'
      - int
    doc: "Extend the region of interest in 5' by a given value."
    inputBinding:
      position: 1
      prefix: --upstream
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
  - id: zero_to_na
    type:
      - 'null'
      - boolean
    doc: "Use NA not zero when region is undefined in bigwig."
    inputBinding:
      position: 1
      prefix: --zero-to-na
outputs:
  - id: result
    type: File
    doc: "Zipped coverage matrix (.zip added by the tool)."
    outputBinding:
      glob: "$(inputs.outputfile).zip"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5

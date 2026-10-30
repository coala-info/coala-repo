cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - coverage
label: pygtftk_coverage
doc: "Takes a GTF as input to compute bigwig coverage in regions of interest (promoter, transcript body, intron, intron_by_tx, tts...) or a BED6 to focus on user-defined regions. If --n-highest is used the program will compute the coverage of each bigwig based on the average value of the n windows (--nb-window) with the highest coverage values.\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: bw_list
    type:
      - 'null'
      - File[]
    doc: "A list of Bigwig file (last argument)."
    inputBinding:
      position: 200
  - id: inputfile
    type: File
    doc: "The input GTF/BED file. Only GTF file if <stdin> is used."
    inputBinding:
      position: 101
      prefix: --inputfile
  - id: outputfile_path
    type: string
    doc: "Output file."
    inputBinding:
      position: 102
      prefix: --outputfile
  - id: chrom_info
    type:
      - File
      - string
    doc: "Tabulated two-columns file. Chromosomes as column 1 and sizes as column 2"
    inputBinding:
      position: 101
      prefix: --chrom-info
  - id: upstream
    type: ['null', int]
    doc: "Extend the regions in 5' by a given value (int)."
    inputBinding:
      position: 101
      prefix: --upstream
  - id: downstream
    type: ['null', int]
    doc: "Extend the regions in 3' by a given value (int)."
    inputBinding:
      position: 101
      prefix: --downstream
  - id: nb_window
    type: ['null', int]
    doc: "Split the region into w bins (see -n)."
    inputBinding:
      position: 101
      prefix: --nb-window
  - id: nb_proc
    type: ['null', int]
    doc: "Use this many threads to compute coverage."
    inputBinding:
      position: 101
      prefix: --nb-proc
  - id: ft_type
    type: ['null', string]
    doc: "Region in which coverage is to be computed (promoter, intron, intergenic, tts or any feature defined in the column 3 of the GTF)."
    inputBinding:
      position: 101
      prefix: --ft-type
  - id: labels
    type: ['null', string]
    doc: "Bigwig labels."
    inputBinding:
      position: 101
      prefix: --labels
  - id: name_column
    type: ['null', string]
    doc: "Use this ids to compute the name (4th column in bed output)."
    inputBinding:
      position: 101
      prefix: --name-column
  - id: pseudo_count
    type: ['null', float]
    doc: "A pseudo-count to add in case count is equal to 0."
    inputBinding:
      position: 101
      prefix: --pseudo-count
  - id: n_highest
    type: ['null', int]
    doc: "For each bigwig, use the n windows with higher values to compute coverage."
    inputBinding:
      position: 101
      prefix: --n-highest
  - id: matrix_out
    type: ['null', boolean]
    doc: "Matrix output format. Bigwigs as column names and features as rows."
    inputBinding:
      position: 101
      prefix: --matrix-out
  - id: zero_to_na
    type: ['null', boolean]
    doc: "Use NA not zero when region is undefined in bigwig or below window size."
    inputBinding:
      position: 101
      prefix: --zero-to-na
  - id: key_name
    type: ['null', string]
    doc: "If gtf format is requested, the name of the key."
    inputBinding:
      position: 101
      prefix: --key-name
  - id: stat
    type:
      - 'null'
      - type: enum
        symbols: [mean, sum]
    doc: "The statistics to be computed for each region."
    inputBinding:
      position: 101
      prefix: --stat
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

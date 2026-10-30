cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - overlapping
label: pygtftk_overlapping
doc: "Find transcripts whose body/TSS/TTS region extended in 5' and 3' (-u/-d) overlaps with any transcript from another gene. Strandness is not considered by default. Used --invert-match to find those that do not overlap. If --annotate-gtf is used, all lines of the input GTF file will be printed and a new key containing the list of overlapping transcripts will be added to the transcript features/lines (key will be 'overlapping_*' with * one of body/TSS/TTS). The --annotate-gtf and --invert-match arguments are mutually exclusive.\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: add_chr
    type:
      - 'null'
      - boolean
    doc: "Add 'chr' to chromosome names before printing output."
    inputBinding:
      position: 1
      prefix: --add-chr
  - id: annotate_all
    type:
      - 'null'
      - boolean
    doc: "When --annotate-gtf annotate all transcripts (default value would be '0')."
    inputBinding:
      position: 1
      prefix: --annotate-all
  - id: annotate_gtf
    type:
      - 'null'
      - boolean
    doc: "All lines of the original GTF will be printed."
    inputBinding:
      position: 1
      prefix: --annotate-gtf
  - id: bool
    type:
      - 'null'
      - boolean
    doc: "When --annotate-gtf is used use 0 or 1 as key values (instead of overlapping transcripts id)."
    inputBinding:
      position: 1
      prefix: --bool
  - id: chrom_info
    type: File
    doc: "Chromosome information. A tabulated two-columns file with chromosomes as column 1 and sizes as column 2 (or a genome name such as hg38)."
    inputBinding:
      position: 1
      prefix: --chrom-info
  - id: diff_strandedness
    type:
      - 'null'
      - boolean
    doc: "Require different strandedness."
    inputBinding:
      position: 1
      prefix: --diff-strandedness
  - id: downstream
    type:
      - 'null'
      - int
    doc: "Extend the region in 3'. Used to define the region around the TSS/TTS."
    inputBinding:
      position: 1
      prefix: --downstream
  - id: feature_type
    type:
      - 'null'
      - string
    doc: "The feature of interest (transcript, promoter or tts)."
    inputBinding:
      position: 1
      prefix: --feature-type
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
    doc: "Not/Invert match."
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
  - id: key_name
    type:
      - 'null'
      - string
    doc: "The name of the key."
    inputBinding:
      position: 1
      prefix: --key-name
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
  - id: same_strandedness
    type:
      - 'null'
      - boolean
    doc: "Require same strandedness."
    inputBinding:
      position: 1
      prefix: --same-strandedness
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
    doc: "Extend the region in 5'. Used to define the region around the TSS/TTS."
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

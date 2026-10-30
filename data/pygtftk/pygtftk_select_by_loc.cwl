cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - select_by_loc
label: pygtftk_select_by_loc
doc: "Select transcripts/gene overlapping a given locations. A transcript is defined here as the genomic region from TSS to TTS including introns. The transcript and all its associated elements (exons, utr...) are returned even if only a fraction (e.g intron) of the transcript is overlapping the feature. If --ft-type is set to 'gene' returns the gene and all its associated elements.\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: add_chr
    type:
      - 'null'
      - boolean
    doc: "Add 'chr' to chromosome names before printing output."
    inputBinding:
      position: 1
      prefix: --add-chr
  - id: ft_type
    type:
      - 'null'
      - string
    doc: "The feature of interest (transcript or gene)."
    inputBinding:
      position: 1
      prefix: --ft-type
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
    doc: "Not/invert match. Select transcript not overlapping."
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
  - id: location
    type:
      - 'null'
      - string
    doc: "List of chromosomal locations (chr:start-end[,chr:start-end]). 0-based."
    inputBinding:
      position: 1
      prefix: --location
  - id: location_file
    type:
      - 'null'
      - File
    doc: "Bed file with chromosomal location."
    inputBinding:
      position: 1
      prefix: --location-file
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

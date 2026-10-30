cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - splicing_site
label: pygtftk_splicing_site
doc: "Compute the locations of donor and acceptor splice sites. This returns a single position, which corresponds to the most 5' and/or the most 3' intronic region. If the gtf file does not contain exon numbering you can compute it using the add_exon_nb command. The score column of the bed file contains the number of the closest exon relative to the splice site.\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: add_chr
    type:
      - 'null'
      - boolean
    doc: "Add 'chr' to chromosome names before printing output."
    inputBinding:
      position: 1
      prefix: --add-chr
  - id: exon_numbering_key
    type:
      - 'null'
      - string
    doc: "The name of the key containing the exon numbering (exon_number in ensembl)."
    inputBinding:
      position: 1
      prefix: --exon-numbering-key
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
  - id: names
    type:
      - 'null'
      - string
    doc: "The key(s) that should be used as name."
    inputBinding:
      position: 1
      prefix: --names
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
    default: "out.bed"
    doc: "Output file (BED)."
    inputBinding:
      position: 1
      prefix: --outputfile
  - id: separator
    type:
      - 'null'
      - string
    doc: "The separator to be used for separating name elements."
    inputBinding:
      position: 1
      prefix: --separator
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
    doc: "Output file (BED)."
    outputBinding:
      glob: "$(inputs.outputfile)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5

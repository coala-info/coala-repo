cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - tss_numbering
label: pygtftk_tss_numbering
doc: "Add the tss number to each transcript (5'->3'). For each transcript feature add a key containing its tss number relative to the most 5'. See --add-nb-tss-to-gene to add the number of different tss to each gene feature.\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: add_chr
    type:
      - 'null'
      - boolean
    doc: "Add 'chr' to chromosome names before printing output."
    inputBinding:
      position: 1
      prefix: --add-chr
  - id: add_nb_tss_to_gene
    type:
      - 'null'
      - boolean
    doc: "Add the number of different tss to each gene."
    inputBinding:
      position: 1
      prefix: --add-nb-tss-to-gene
  - id: compute_dist
    type:
      - 'null'
      - boolean
    doc: "Add a key indicating the distance to the first tss (the most 5')."
    inputBinding:
      position: 1
      prefix: --compute-dist
  - id: gene_key
    type:
      - 'null'
      - string
    doc: "The name of the key if --add-nb-tss-to-gene is selected."
    inputBinding:
      position: 1
      prefix: --gene-key
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
  - id: key_name
    type:
      - 'null'
      - string
    doc: "The name of the new key."
    inputBinding:
      position: 1
      prefix: --key-name
  - id: key_name_dist
    type:
      - 'null'
      - string
    doc: "If --compute-dist is true a name for that key."
    inputBinding:
      position: 1
      prefix: --key-name-dist
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

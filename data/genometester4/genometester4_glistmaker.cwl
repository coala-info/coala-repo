cwlVersion: v1.2
class: CommandLineTool
baseCommand: glistmaker
label: genometester4_glistmaker
doc: "Make a list of all unique k-mers and their frequencies from FASTA or FASTQ files.\n\nTool homepage: https://github.com/bioinfo-ut/GenomeTester4"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input FASTA or FASTQ files
    inputBinding:
      position: 1
  - id: wordlength
    type:
      - 'null'
      - int
    doc: "specify index wordsize (1-32) (default 16)"
    inputBinding:
      position: 102
      prefix: --wordlength
  - id: cutoff
    type:
      - 'null'
      - int
    doc: "specify frequency cut-off (default 1)"
    inputBinding:
      position: 102
      prefix: --cutoff
  - id: output_name
    type:
      - 'null'
      - string
    default: out
    doc: "specify output name (default \"out\")"
    inputBinding:
      position: 102
      prefix: --outputname
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "number of threads the program is run on (default MIN(8, num_input_files))"
    inputBinding:
      position: 102
      prefix: --num_threads
  - id: max_tables
    type:
      - 'null'
      - int
    doc: "maximum number of temporary tables (default MAX(num_threads, 2))"
    inputBinding:
      position: 102
      prefix: --max_tables
  - id: table_size
    type:
      - 'null'
      - int
    doc: "maximum size of the temporary table (default 500000000)"
    inputBinding:
      position: 102
      prefix: --table_size
  - id: debug_level
    type:
      - 'null'
      - boolean
    doc: "increase debug level"
    inputBinding:
      position: 102
      prefix: -D
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_lists
    type:
      type: array
      items: File
    doc: Resulting k-mer list files (named after output_name, word length and cut-off)
    outputBinding:
      glob: $(inputs.output_name)*.list
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometester4:4.0--hec16e2b_4
stdout: genometester4_glistmaker.out

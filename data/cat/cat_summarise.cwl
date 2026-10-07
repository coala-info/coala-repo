cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CAT_pack
  - summarise
label: cat_summarise
doc: "Summarise a named CAT or BAT classification file.\n\nTool homepage: https://github.com/MGXlab/CAT_pack"
inputs:
  - id: input_file
    type: File
    doc: "Path to named CAT contig classification file or BAT bin classification file. Only official ranks and a single classification per contig / bin are supported. To summarise a contig classification file, supply the contigs fasta file with [-c / --contigs_fasta]."
    inputBinding:
      position: 101
      prefix: --input_file
  - id: output_file
    type: string
    doc: "Path to output file."
    inputBinding:
      position: 101
      prefix: --output_file
  - id: contigs_fasta
    type:
      - 'null'
      - File
    doc: "Path to contigs fasta file. Required if you want to summarise a contig classification file."
    inputBinding:
      position: 101
      prefix: --contigs_fasta
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Force overwrite existing files."
    inputBinding:
      position: 101
      prefix: --force
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Suppress verbosity."
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: output
    type: File
    doc: "Summary table"
    outputBinding:
      glob: "$(inputs.output_file)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cat:6.0.1--hdfd78af_1
